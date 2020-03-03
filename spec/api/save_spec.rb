require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Experience' do
  describe '.save' do

    subject { ExperiencesSpain::Experience.find(1234) }

    context 'when experience is not valid' do
      stub_experiences_api(:experience, :find, :porposal)
      stub_experiences_api(:experience, :save, :invalid)

      it 'should be falsy' do
        expect(subject.save).to be_falsy
      end

      it 'turns the experience invalid' do
        expect(subject).to be_valid
        subject.save
        expect(subject).not_to be_valid
      end
    end

    context 'when the experience is valid' do
      stub_experiences_api(:experience, :find, :porposal)
      stub_experiences_api(:experience, :save, :valid)

      it 'should be truthy' do
        expect(subject.save).to be_truthy
      end

      it 'turns the experience valid' do
        expect(subject).to be_valid
        subject.save
        expect(subject).to be_valid
      end
    end
  end
end
