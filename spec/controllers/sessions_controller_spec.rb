require 'spec_helper'

describe SessionsController do
  describe "POST create" do
    subject { post :create }

    before do
      request.env['omniauth.auth'] = auth_params
      Session.stub(create: true)
    end

    let(:auth_params) { double }

    it 'creates session' do
      Session.should_receive(:create).with(auth_params, session).
        and_return(true)
      subject
    end

    it 'redirects to plugins path' do
      subject
      expect(response).to redirect_to plugins_path
    end
  end
end
