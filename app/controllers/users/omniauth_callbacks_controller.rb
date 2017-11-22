class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def gitlab
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      byebug
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      flash[:unauthenticated] = true
      flash[:alert] = I18n.t("devise.registrations.already_signup")
      redirect_to root_path
    end
  end

  def failure
    redirect_to root_path
  end
end
