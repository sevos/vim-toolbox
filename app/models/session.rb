class Session
  def self.create(auth_params, controller_session)
    session = Session.new(controller_session)
    user = session.sign_in(auth_params) || session.sign_up(auth_params)
    controller_session[:user_id] = user.id
    user
  end

  def initialize(controller_session)
    @controller_session = controller_session
  end

  def sign_in(auth_params)
    User.by_auth(*auth_params.values_at(:provider, :uid)).first
  end

  def sign_up(auth_params)
    User.create!(provider: auth_params[:provider],
                 uid: auth_params[:uid],
                 email: auth_params[:info][:email],
                 nickname: auth_params[:info][:nickname],
                 avatar_url: auth_params[:info][:image]
                )
  end
end
