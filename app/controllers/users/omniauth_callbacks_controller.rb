# TODO: Email confirmation should be skipped only when identity is verified
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all(auth = nil)
    @auth ||= request.env['omniauth.auth']
    @identity = Identity.find_or_create_with_omniauth(@auth)
    link_identity_with_signed_in_user || login_or_create_user_from_identity
  end

  alias :google     :all
  alias :github     :all
  alias :twitter    :all
  alias :facebook   :all
  alias :linkedin   :all
  alias :foursquare :all

  private

  def link_identity_with_signed_in_user
    return unless current_user

    if @identity.linked_with?(current_user)
      redirect_to edit_profile_path, notice: "Identity is already linked with this account!"
    elsif @identity.linked?
      redirect_to edit_profile_path, alert: "This identity is already associated with another account!"
    else
      @identity.link_with!(current_user)
      redirect_to edit_profile_path, notice: "Successfully linked the identity with this account!"
    end
  end

  def login_or_create_user_from_identity
    return if current_user

    if @identity.linked?
      message = "Signed in via #{@identity.provider.titleize}!"
      if @identity.email.present? && !@identity.user.confirmed?
        @identity.user.confirm
        message += " Confirmed email: #{@identity.email}!"
      end
      sign_in @identity.user
      redirect_to root_url, notice: message
    else
      user = User.from_omniauth(@auth)
      if user.persisted?
        @identity.link_with!(user)
        sign_in_and_redirect user, event: :authentication #this will throw if user is not activated
        set_flash_message(:notice, :success, kind: @auth.provider.titleize) if is_navigational_format?
      else
        sign_out
        session["devise.oauth_data"] = Extractor::Base.load(@auth).attributes_data
        redirect_to new_user_registration_url
      end
    end
  end
end
