class Contact < ActiveRecord::Base
	belongs_to :user
	belongs_to :state

	has_attached_file :avatar

	validates :name, :state, presence: true
	validates :name, length: { minimum: 3 }
	validates :email, format: { with: /\A[-\w.+]+@[\w.]+\z/, message: 'invalid format' }, allow_nil: true
	validates :phone1, :phone2, format: { with: /\A[0-9.()+-]+\z/, message: 'only allow numbers and "() .-+"' }, allow_nil: true
	validates_attachment :avatar,
		content_type: {
			content_type: /\Aimage\/.*\z/,
			message: 'should be an image'
		},
		size: {
			in: 0..2.megabytes
		}
	validate :birthdate_format
	validate :contact_is_not_probably_dead


	scope :filter, ->( filter ) {
		filter = filter.downcase
		where(
			'LOWER(name) LIKE :name OR LOWER(email) LIKE :email',
			name: "%#{filter}%",
			email: "%#{filter}%"
		)
	}

	def serializable_hash( *args )
		{
			id: id,
			name: name,
			email: email,
			phone1: phone1,
			phone2: phone2,
			birthdate: birthdate,
			address: address,
			state: {
				id: state.id,
				name: state.name
			},
			country: {
				id: state.country.id,
				name: state.country.name
			},
			avatar: avatar_url
		}
	end

	def avatar_url
		avatar.url unless avatar.blank?
	end

	def birthdate_format
		str = birthdate_before_type_cast
		return if str.nil? or not str.kind_of?( String )

		begin
			year, month, day = str.split( '-' ).map( &:to_i )
			raise ArgumentError if year.nil? or month.nil? or day.nil?
			Date.new year, month, day
		rescue ArgumentError
			errors.add :birthdate, 'invalid format, should be YYYY-MM-DD, example: 1987-11-01'
		end
	end

	def contact_is_not_probably_dead
		return if birthdate.nil?
		if (Time.now.utc - birthdate.to_time) > 150.years
			errors.add :birthdate, 'too old, shouldn\'t have more than 150 years'
		end
	end
end
