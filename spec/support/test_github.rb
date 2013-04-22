require 'webmock'
OmniAuth.config.test_mode = true

class TestGithub
  include WebMock::API

  attr_reader :nickname

  def initialize(nickname: "test_user", info: {})
    @nickname = nickname
    @info = info
  end

  def uid
    @uid ||= Digest::SHA2.hexdigest(@nickname).to_i(16) % 20000
  end

  def authorize
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github',
      uid: uid,
      info: @info.reverse_merge(nickname: @nickname,
                                email: "#{@nickname}@example.com",
                                image: 'http://example.com/image.gif')
    })
    self
  end

  def has_repository(repository, with_description: "description")
    stub_request(:get, "https://api.github.com/repos/#{repository}").
         to_return(:status => 200,
                   :body => {description: with_description}.to_json,
                   :headers => {})
  end
end
