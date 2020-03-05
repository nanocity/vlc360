require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Resource' do
  describe '.valid?' do

    context 'when it has no erros' do
      subject { VLC360::Resource.new.valid? }

      it { is_expected.to be_truthy }
    end

    context 'when it does have errors' do
      it 'should be falsy' do
        resource = VLC360::Resource.new
        resource.instance_variable_set(:@errors, ['Some Error'])
        expect(resource.valid?).to be_falsy
      end
    end
  end
end
