require 'spec_helper'

describe Session do
  describe ".create" do
    let(:session) { double("session") }
    let(:auth_params) { double("auth_params") }
    let(:controller_session) { Hash.new{} }
    subject { Session.create(auth_params, controller_session) }

    before { Session.stub(new: session) }

    it 'signs in existing user' do
      session.should_receive(:sign_in).with(auth_params).
        and_return(user = double(id: 1))
      expect(subject).to eq(user)
      expect(controller_session[:user_id]).to eq(1)
    end

    it 'signs up new user' do
      session.stub(sign_in: nil)
      session.should_receive(:sign_up).with(auth_params).
        and_return(user = double(id: 1))
      expect(subject).to eq(user)
      expect(controller_session[:user_id]).to eq(1)
    end
  end

  describe ".destroy" do
    it 'signs out user' do
      controller_session = {user_id: 1, other: "key"}
      Session.destroy controller_session
      expect(controller_session).to eq({other: "key"})
    end
  end

  describe "#sign_in" do
    let(:controller_session) { Hash.new }
    let(:session) { Session.new(controller_session) }
    let(:auth_params) {
      { provider: 'github', uid: '12345' }
    }
    subject { session.sign_in(auth_params) }

    it 'finds user by provider and uid' do
      User.should_receive(:by_auth).
        with('github', '12345')
        .and_return(double(first: user = double))
      expect(subject).to eq(user)
    end

    it 'returns nil when user is not registered yet' do
      User.stub(by_auth: [])
      expect(subject).to be_nil
    end
  end

  describe "#sign_up" do
    let(:controller_session) { Hash.new }
    let(:session) { Session.new(controller_session) }
    let(:auth_params) {
      {
        provider: 'github', uid: '12345',
        info: {
          nickname: 'sevos',
          email: 'artur.roszczyk@gmail.com',
          image: 'http://example.com/image.gif'
        }
      }
    }
    subject { session.sign_up(auth_params) }

    it 'creates new user' do
      User.should_receive(:create!).with({
        provider: 'github', uid: '12345',
        email: 'artur.roszczyk@gmail.com',
        nickname: 'sevos', avatar_url: 'http://example.com/image.gif'
      }).and_return(user = double)

      expect(subject).to eq(user)
    end
  end
end
