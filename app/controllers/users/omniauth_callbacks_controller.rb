class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      flash[:alert] = 'Facebook sign-in failed - do you already have a login with that email address?'
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

end