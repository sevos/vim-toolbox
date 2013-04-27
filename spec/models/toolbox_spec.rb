require 'spec_helper'

describe Toolbox do
  let(:user) { double }
  subject(:toolbox) { Toolbox.for(user) }

  describe ".for" do

    it { should be_a Toolbox }

    context "when user is nil" do
      let(:user) { nil }

      it { should be_nil }
    end
  end

  describe "#install" do
    let(:user) { double(plugins: double) }
    let(:plugin) { double }
    subject { toolbox.install(plugin) }

    it 'creates association between user and plugin' do
      user.plugins.should_receive(:<<).
        with(plugin)

      subject
    end
  end

  describe "#to_partial_path" do
    subject { toolbox.to_partial_path }
    it { should eq("toolbox") }
  end

  describe "#plugins" do
    subject { toolbox.plugins }
    let(:user_plugins_list) { double }
    let(:user) { double(plugins: user_plugins_list) }

    it "returns user's plugins" do
      expect(subject).to eq(user_plugins_list)
    end
  end
end
