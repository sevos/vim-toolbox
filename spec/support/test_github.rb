OmniAuth.config.test_mode = true

class TestGithub

  def initialize(nickname: "test_user", info: {})
    @nickname = nickname
    @info = info
  end

  def uid
    @uid ||= Digest::SHA2.hexdigest(@nickname).to_i(16) % 20000
  end

  def authorize
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: 'github',
      uid: uid,
      info: @info.reverse_merge(nickname: @nickname,
                                email: "#{@nickname}@example.com",
                                image: 'http://example.com/image.gif')
    })
    self
  end
end
