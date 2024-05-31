require "rails_helper"

RSpec.describe UseCases::Sector::UpdateSectorService do
  let(:repository) { SectorRepository.new }
  let(:subject) { described_class.new(repository) }

  describe "#initialize" do
    it "receives a repository as a dependency" do
      expect(subject.instance_variable_get(:@repository)).to eq(repository)
    end
  end

  describe "#call" do
    context "with invalid params" do
    end

    context "with valid params" do
    end
  end
end