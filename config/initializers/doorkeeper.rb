Doorkeeper.configure do
	orm :active_record

	resource_owner_authenticator do
		current_user
	end

	resource_owner_from_credentials do
		user = User.find_by_email params[ :username ]
		user if user and user.valid_password? params[ :password ]
	end

	authorization_code_expires_in 10.minutes
	access_token_expires_in 2.hours
	access_token_methods :from_bearer_authorization
	realm 'Contacts'
	grant_flows %w[ password ]
end
