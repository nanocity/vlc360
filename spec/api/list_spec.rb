require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Experience' do
  describe '::list' do
    subject { ExperiencesSpain::Experience.list }

    context 'when there is no experiences' do
      stub_experiences_api(:experience, :list, :empty)

      it { is_expected.to be_empty }
      it { is_expected.to be_kind_of(Array) }
    end

    context 'when there is one or more experiences' do
      stub_experiences_api(:experience, :list, :not_empty)

      it { is_expected.not_to be_empty }
      it { is_expected.to be_kind_of(Array) }
      it 'should be a kind of Array of Experience objects' do
        subject.each { |element| expect(element).to be_kind_of(ExperiencesSpain::Experience) }
      end
    end
  end
end
