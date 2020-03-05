require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Work' do
  describe '.persisted?' do
    context 'when work has no ID' do
      subject { VLC360::Work.new.persisted? }

      it { is_expected.to be_falsy }
    end

    context 'when work has ID' do
      subject { VLC360::Work.new.tap(&:save).persisted? }
      stub_works_api(:work, :save, :valid)

      it { is_expected.to be_truthy }
    end
  end
end
