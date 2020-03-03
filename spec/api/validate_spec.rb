require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Experience' do
  describe '.validate' do

    subject { ExperiencesSpain::Experience.find(1234) }

    context 'when experience is not valid' do
      stub_experiences_api(:experience, :find, :porposal)
      stub_experiences_api(:experience, :validate, :invalid)

      it 'returns a new Validation invalid object' do
        validation = subject.validate
        expect(validation).not_to be_valid
      end
    end

    context 'when the experience is valid' do
      stub_experiences_api(:experience, :find, :porposal)
      stub_experiences_api(:experience, :validate, :valid)

      it 'returns a new Validation valid object' do
        validation = subject.validate
        expect(validation).to be_valid
      end
    end
  end
end
