require 'spec_helper'

describe Toolbox do
  subject(:toolbox) { Toolbox.for(user) }

  describe ".for" do
    let(:user) { double }

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
end
