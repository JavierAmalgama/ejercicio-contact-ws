class Api::V1::CountriesController < Api::V1::BaseController
	def index
		paginated Country.all
	end
end
