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
end
