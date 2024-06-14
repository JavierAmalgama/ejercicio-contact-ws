class Country < ActiveRecord::Base
	has_many :states

	scope :filter, ->( name ) { where( 'LOWER(name) LIKE :name', name: "%#{name.downcase}%" ) }

	def serializable_hash( *args )
		{
			id: id,
			name: name
		}
	end
end
