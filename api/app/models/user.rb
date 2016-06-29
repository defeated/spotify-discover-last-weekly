class User < ActiveRecord::Base
  has_one :auth_token, dependent: :destroy
  has_one :playlist, dependent: :destroy

  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
end
