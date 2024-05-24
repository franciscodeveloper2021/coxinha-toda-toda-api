require "rails_helper"

RSpec.describe UseCases::Sector::ShowSectorService do
  let(:repository) { SectorRepository.new }
  let(:subject) { described_class.new(repository) }
  let(:sector_id) { 1 }
  let(:sector) { Responses::SectorResponseDto.new(id: sector_id, name: 'Bebidas') }
  let(:record_not_found_message) {
    I18n.t(
      "activerecord.errors.messages.record_not_found",
      attribute: "Sector",
      key: "id",
      value: sector_id
    )
  }

  describe "#initialize" do
    it "receives a repository as a dependency" do
      expect(subject.instance_variable_get(:@repository)).to eq(repository)
    end
  end

  describe "#call" do
    context "when sector does not exist" do
      it "raises a ActiveRecord::RecordNotFound error" do
        allow(repository).to receive(:show).with(id: sector_id).and_raise(
          ActiveRecord::RecordNotFound,
          record_not_found_message
        )

        expect { subject.call(id: sector_id) }.to raise_error(
          ActiveRecord::RecordNotFound,
          record_not_found_message
        )
      end
    end

    context "when sector exists" do
      it "returns the sector as a SectorResponseDto" do
        allow(repository).to receive(:show).with(id: sector_id).and_return(sector)

        result = subject.call(id: sector_id)

        expect(result).to eq(sector)
      end
    end
  end
end
