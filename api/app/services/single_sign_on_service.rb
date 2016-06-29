# create or update user and oauth tokens
class SingleSignOnService
  def initialize(oauth_params)
    @oauth_params = oauth_params
    @user_params = @oauth_params.fetch 'info'
    @token_params = @oauth_params.fetch 'credentials'
  end

  def connect!
    User.transaction do
      sync_user
      sync_auth_token
    end
    user
  end

  private

  attr_reader :oauth_params, :user_params, :token_params

  def user
    @user ||= User.find_or_initialize_by email: user_params[:email]
  end

  def sync_user
    user.update! name: user_params[:display_name], image: user_params[:image]
  end

  def auth_token
    @auth_token ||= user.auth_token || user.build_auth_token
  end

  def sync_auth_token
    auth_token.attributes = {
      provider: oauth_params[:provider],
      uid: oauth_params[:uid],
      access_token: token_params[:token],
      refresh_token: token_params[:refresh_token],
      expires_at: token_params[:expires_at]
    }
    auth_token.save!
  end
end
