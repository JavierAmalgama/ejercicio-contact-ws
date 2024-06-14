class Api::V1::BaseController < RocketPants::Base
	include Doorkeeper::Rails::Helpers

	version 1
	before_action :doorkeeper_authorize!

	protected

	def current_user_id
		doorkeeper_token.resource_owner_id
	end

	def current_page
		params.fetch( :page, 1 ).to_i
	end

	def elements_per_page
		per = params.fetch( :per, 10 ).to_i
		case
			when per <= 10 then 10
			when per <= 25 then 25
			when per <= 50 then 50
			else 100
		end
	end

	def paginated( model )
		super filtered( model ).page( current_page ).per( elements_per_page )
	end

	def filtered( model )
		if params.key? :filter
			model.filter params[ :filter ]
		else
			model
		end
	end
end
