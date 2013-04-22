require 'spec_helper'

describe Plugin do
  subject(:plugin) do
    Plugin.new.tap { |p| p.stub(save: true) }
  end

  describe '.waiting' do
    subject { Plugin.waiting }

    it 'returns only not approved plugins' do
      waiting_plugin  = Plugin.create!(repository: 'a/b')
      approved_plugin = Plugin.create!(repository: 'c/d', approved_at: Time.now)

      expect(subject).to include(waiting_plugin)
      expect(subject).to_not include(approved_plugin)
    end
  end

  describe '.approved' do
    subject { Plugin.approved }

    it 'returns only approved plugins' do
      waiting_plugin  = Plugin.create!(repository: 'a/b')
      approved_plugin = Plugin.create!(repository: 'c/d', approved_at: Time.now)

      expect(subject).to include(approved_plugin)
      expect(subject).to_not include(waiting_plugin)
    end

  end

  describe '#approve' do
    subject { plugin.approve }

    it 'sets approved_at to current time' do
      Time.stub(now: time = Time.now)
      subject
      expect(plugin.approved_at).to eq(time)
    end

    it 'persists plugin and returns true if success' do
      plugin.should_receive(:save).and_return(save_result = double)
      expect(subject).to eq(save_result)
    end
  end

  describe "#sync" do
    let(:github_repo) { double(description: "Description") }
    let(:github_repos) { double }
    let(:github_api) { double(repos: github_repos) }

    subject { plugin.sync(github_api: github_api) }

    before do
      plugin.repository = "user/superplugin"
      github_repos.should_receive(:get).with(user: "user", repo: "superplugin").
        and_return(github_repo)
    end

    it "updates description" do
      subject
      expect(plugin.description).to eq("Description")
    end

    it "saves plugin" do
      plugin.should_receive(:save)
      subject
    end

  end
end
