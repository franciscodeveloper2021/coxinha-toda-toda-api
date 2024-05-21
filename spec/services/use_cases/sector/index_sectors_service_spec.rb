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
    context "when there are no sectors" do
      it "returns an empty array" do
        allow(repository).to receive(:index).and_return([])

        expect(subject.call).to eq([])
      end
    end

    context "when there are sectors" do
      let(:sectors) do
        [
          Responses::SectorResponseDto.new(id: 1, name: 'Bebidas'),
          Responses::SectorResponseDto.new(id: 2, name: 'Coxinhas')
        ]
      end
      it "returns an array of sectors" do
        allow(repository).to receive(:index).and_return(sectors)

        expect(subject.call).to eq(sectors)
      end
    end
  end
end
