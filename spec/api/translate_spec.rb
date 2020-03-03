require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Experience' do
  describe '.translate' do

    subject { ExperiencesSpain::Experience.find(1234) }

    context 'when experience is not valid' do
      stub_experiences_api(:experience, :find, :porposal)
      stub_experiences_api(:experience, :translate, :invalid)

      it 'returns an invalid experience' do
        translated = subject.translate('en_US', { title: 'Some English' })
        expect(translated).not_to be_valid
      end

      it 'keep original experience unaltered' do
        expect(subject).to be_valid
        subject.translate('en_US', { title: 'Some English' })
        expect(subject).to be_valid
      end
    end

    context 'when the experience is valid' do
      stub_experiences_api(:experience, :find, :porposal)
      stub_experiences_api(:experience, :translate, :valid)

      it 'returns a valid experience' do
        translated = subject.translate('en_US', { title: 'Some English' })
        expect(translated).to be_valid
      end
    end
  end
end
