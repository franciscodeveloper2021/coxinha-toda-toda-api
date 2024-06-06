require "rails_helper"

RSpec.describe UseCases::Sector::DestroySectorService do
  let(:repository) { SectorRepository.new }
  let(:subject) { described_class.new(repository) }

  describe "#initialize" do
    it "receives a repository as a dependency" do
      expect(subject.instance_variable_get(:@repository)).to eq(repository)
    end
  end

  describe "#call" do
    it "calls destroy method on repository" do
      allow(repository).to receive(:destroy)

      subject.call(id: 1)

      expect(repository).to have_received(:destroy)
    end
  end
end
