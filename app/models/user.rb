class User < ActiveRecord::Base
	devise :database_authenticatable, :registerable, :validatable
	has_many :contacts

	def serializable_hash( *args )
		{
			id: id,
			email: email
		}
	end
end
