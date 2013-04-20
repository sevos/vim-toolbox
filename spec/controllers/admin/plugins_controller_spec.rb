require 'spec_helper'

describe Admin::PluginsController do

  describe "GET index" do
    before do
      Plugin.stub(all: [@plugin = double])
      get :index
    end

    it { expect(response).to be_success }
    it { expect(assigns(:plugins)).to be_an_array_of(PluginPresenter) }
  end
end
