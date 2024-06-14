Rails.application.routes.draw do
	use_doorkeeper
	api version: 1, allow_prefix: 'v', module: 'api/v1' do
		resources :users, onle: [ :show ] do
			resources :contacts
		end
		resources :countries, only: [ :index ] do
			resources :states, only: [ :index ]
		end
	end
end
