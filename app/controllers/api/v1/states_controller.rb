class Api::V1::StatesController < Api::V1::BaseController
	def index
		paginated country.states
	end

	protected

	def country
		@country ||= Country.find country_id
	end

	def country_id
		params[ :country_id ].to_i
	end
end
