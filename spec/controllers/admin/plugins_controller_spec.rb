require 'spec_helper'

describe Admin::PluginsController do

  describe "GET index", "returns only waiting plugins" do
    before do
      Plugin.stub(waiting: [@plugin = double])
      get :index
    end

    it { expect(response).to be_success }
    it { expect(assigns(:plugins)).to be_an_array_of(PluginPresenter) }
  end

  describe "PUT approve" do
    let(:plugin) { double(id: 1, approve: true, sync: true) }

    before do
      Plugin.stub(find: plugin)
    end

    subject { put :approve, id: 1 }

    it 'finds correct plugin' do
      Plugin.should_receive(:find).with("1").and_return(plugin)
      subject
    end

    it 'approves plugin' do
      plugin.should_receive :approve
      subject
    end

    it "syncs plugin with github" do
      plugin.should_receive :sync
      subject
    end

    it "redirects back to admin's plugin list" do
      subject
      expect(response).to redirect_to(admin_plugins_path)
    end

  end
end
