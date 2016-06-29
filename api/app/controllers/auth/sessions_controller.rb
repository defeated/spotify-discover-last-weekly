class Auth::SessionsController < ApplicationController
  def create
    sso = SingleSignOnService.new request.env['omniauth.auth']
    user = sso.connect!

    GetPlaylistForUserJob.perform_later user

    redirect_to '/', notice: t('.notice')
  end

  def destroy
    reset_session
    redirect_to '/', notice: t('.notice')
  end
end
