class Api::V1::UsersController < Api::V1::BaseController
	def show
		expose user
	end

	protected

	def user
		error! :forbidden unless params[ :id ] == 'me' or params[ :id ].to_i == current_user_id
		User.find current_user_id
	end
end
