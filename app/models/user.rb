class User < ActiveRecord::Base
  has_many :identities
  validates :name, presence: true

  devise :database_authenticatable, :registerable, :omniauthable,
    :recoverable, :rememberable, :trackable, :validatable,
    :confirmable, omniauth_providers: [
      :facebook, :twitter, :google, :github, :linkedin, :foursquare
    ]

  def self.from_omniauth(auth)
    auth = Extractor::Base.load(auth)
    user = new name: auth.name, email: auth.email, password: Devise.friendly_token[0,20]
    user.skip_confirmation! if user.email.present?
    user.save
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      auth = session["devise.oauth_data"]
      if auth.present?
        auth = Hash[auth.map{|k,v| [k.to_s,v]}]
        user.email = auth["email"] if user.email.blank?
        user.name  = auth["name"]  if user.name.blank?
        user.image = auth["image"] if user.image.blank?
        user.gender = auth["gender"] if user.gender.blank?
        user.timezone_offset = auth["timezone_offset"] if user.timezone_offset.blank?
        user.language = auth["language"] if user.language.blank?
        user.identities.build auth
      end
    end
  end
end
