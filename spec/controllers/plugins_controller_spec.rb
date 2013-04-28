require 'spec_helper'

describe PluginsController do
  describe 'GET new' do
    subject { get :new }

    before { subject }

    it { expect(response).to render_template("new") }

    it 'assigns plugin' do
      expect(assigns(:plugin)).to be_a_new(Plugin)
    end
  end

  describe "POST create" do
    subject(:create) { post :create, plugin: params }
    let(:params) { {"repository" => "user/repo"} }

    it 'adds plugin' do
      Plugin.should_receive(:new).
        with(params).and_return(plugin = double)
      plugin.should_receive(:save)
      subject
    end

    describe "response" do
      subject { response }
      before { Plugin.stub(new: plugin) and create }

      context "when creating plugin succeeds" do
        let(:plugin) { double(save: true) }

        it { should redirect_to(plugins_path) }
      end

      context "when creating plugin fails" do
        let(:plugin) { double(save: false) }

        it { should render_template("new") }
        it 'assigns plugin' do
          expect(assigns(:plugin)).to eq(plugin)
        end
      end
    end

  end

  describe "GET index" do
    before do
      Plugin.stub(approved: [double])
      get :index
    end

    it { expect(response).to be_success }
    it { expect(assigns(:plugins)).to be_an_array_of(PluginPresenter) }
  end

  describe "POST install" do
    subject { post :install, id: 1 }
    let(:plugin) { double }
    let(:toolbox) { double(install: nil) }

    it "redirects to authentication" do
      subject
      expect(response).to redirect_to("/auth/github")
    end

    context 'when logged in' do
      let(:user) { double }

      before do
        controller.stub(current_user: user)
        Plugin.stub(find: plugin)
        Toolbox.stub(for: toolbox)
      end

      it 'finds plugin' do
        Plugin.should_receive(:find).
          with("1").and_return(plugin)
        subject
      end

      it 'installs plugin in toolbox' do
        toolbox.should_receive(:install).with(plugin)
        subject
      end

      it 'redirects to plugin list' do
        subject
        expect(response).to redirect_to(plugins_path)
      end

    end
  end

  describe "DELETE uninstall" do
    subject { delete :uninstall, id: 1 }
    let(:plugin) { double }
    let(:toolbox) { double(uninstall: nil) }

    it "redirects to authentication" do
      subject
      expect(response).to redirect_to("/auth/github")
    end

    context 'when logged in' do
      let(:user) { double }

      before do
        controller.stub(current_user: user)
        Plugin.stub(find: plugin)
        Toolbox.stub(for: toolbox)
      end

      it 'finds plugin' do
        Plugin.should_receive(:find).
          with("1").and_return(plugin)
        subject
      end

      it 'uninstalls plugin from toolbox' do
        toolbox.should_receive(:uninstall).with(plugin)
        subject
      end

      it 'redirects to plugin list' do
        subject
        expect(response).to redirect_to(plugins_path)
      end

    end


  end
end
