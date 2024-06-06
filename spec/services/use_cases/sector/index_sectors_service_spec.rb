require "rails_helper"

RSpec.describe UseCases::Sector::IndexSectorsService do
  let(:repository) { SectorRepository.new }
  let(:subject) { described_class.new(repository) }

  describe "#initialize" do
    it "receives a repository as a dependency" do
      expect(subject.instance_variable_get(:@repository)).to eq(repository)
    end
  end

  describe "#call" do
    it "calls the index method on the repository" do
      allow(repository).to receive(:index)

      subject.call

      expect(repository).to have_received(:index)
    end
  end
end
