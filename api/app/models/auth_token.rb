class AuthToken < ActiveRecord::Base
  belongs_to :user

  validates :provider, presence: true
  validates :uid, presence: true
  validates :access_token, presence: true
  validates :refresh_token, presence: true
  validates :expires_at, presence: true
end
