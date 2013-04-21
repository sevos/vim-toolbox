class SessionsController < ApplicationController
  def create
    auth_params = request.env['omniauth.auth']
    Session.create(auth_params, session)
    redirect_to plugins_path
  end
end
