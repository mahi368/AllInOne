class SessionsController < Devise::SessionsController
	def create
		user = User.find_by_user_name(params[:user][:user_name])
		if user 
			if  user.valid_password?(params[:user][:password])
				flash[:notice] = "-------------------You signed in successfully-------------------"
				sign_in(user)
				redirect_to root_path
			else
				flash[:alert] = "-------------------Invalid password-------------------"
				redirect_to new_user_session_path
			end
		else
			flash[:alert] = "-------------------User not found-------------------"
			redirect_to new_user_session_path
		end
	end
end
