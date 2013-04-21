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
end
