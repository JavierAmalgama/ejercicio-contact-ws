class Api::V1::ContactsController < Api::V1::BaseController
	def index
		paginated user.contacts
	end

	def show
		expose contact
	end

	def create
		expose user.contacts.create! contact_parameters
	end

	def update
		contact.update_attributes contact_parameters
		expose contact
	end

	def destroy
		contact.destroy!
	end

	protected

	def contact
		@contact ||= user.contacts.find params[:id].to_i
	end

	def user
		error! :forbidden if params[:user_id].to_i != current_user_id
		@user ||= User.find params[:user_id].to_i
	end

	def contact_parameters
		params.permit( :name, :email, :phone1, :phone2, :birthdate, :address, :state_id, :avatar )
	end
end
