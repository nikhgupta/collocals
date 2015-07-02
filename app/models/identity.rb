# This class holds the database model for various social network identities for
# a given User.
class Identity < ActiveRecord::Base
  belongs_to :user, dependent: :destroy

  # validates :user_id, presence: true
  validates :user, associated: true, presence: true
  validates :token, presence: true
  validates :uid, uniqueness: {
    scope: :provider,
    message: 'already exists for this provider'
  }

  def self.find_with_omniauth(auth)
    find_by Extractor::Base.load(auth).signature
  end

  def self.create_with_omniauth(auth)
    data = Extractor::Base.load(auth).attributes_data
    create data.merge(user: User.find_by(email: data[:email]))
  end

  def self.find_or_create_with_omniauth(auth)
    identity = find_with_omniauth auth
    return identity if identity.present?
    create_with_omniauth auth
  end

  def linked?
    user.present?
  end

  def linked_with?(user)
    linked? && self.user == user
  end

  def link_with(user)
    return false if linked?
    self.user = user
    save
  end

  def link_with!(user)
    self.user = nil
    link_with user
  end
end
