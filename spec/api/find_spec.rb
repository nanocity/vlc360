require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Experience' do
  describe '::find' do

    subject { ExperiencesSpain::Experience.find(1234) }

    context 'when no experience is found by id' do
      stub_experiences_api(:experience, :find, :not_found)

      it 'raise ExperienceNotFound exception' do
        expect {
          ExperiencesSpain::Experience.find(1234)
        }.to raise_error(ExperiencesSpain::ExperienceNotFound)
      end
    end

    context 'when there is one a experiences with that ID' do
      stub_experiences_api(:experience, :find, :porposal)

      it { is_expected.to be_kind_of(ExperiencesSpain::Experience) }
      it { is_expected.to be_valid }
    end
  end
end
