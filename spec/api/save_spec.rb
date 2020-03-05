require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Work' do
  describe '.save' do

    subject { VLC360::Work.new }

    context 'when work is not valid' do
      stub_works_api(:work, :save, :invalid)

      it 'should be falsy' do
        expect(subject.save).to be_falsy
      end

      it 'turns the work invalid' do
        expect(subject).to be_valid
        subject.save
        expect(subject).not_to be_valid
      end
    end

    context 'when the work is valid' do
      stub_works_api(:work, :save, :valid)

      it 'should be truthy' do
        expect(subject.save).to be_truthy
      end

      it 'turns the work valid' do
        expect(subject).to be_valid
        subject.save
        expect(subject).to be_valid
      end
    end
  end
end
