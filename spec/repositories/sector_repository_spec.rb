require "rails_helper"

RSpec.describe SectorRepository, type: :repository do
  let!(:sectors) { create_list(:sector, 5) }
  let(:first_sector) { sectors.first }
  let(:subject) { described_class.new }

  describe "#index" do
    let(:retrieved_sectors) { subject.index }
    context "when there are no sectors" do
      it "returns an empty array" do
        allow(Sector).to receive(:all).and_return([])

        expect(retrieved_sectors).to eq([])
      end
    end

    context "when there are registered sectors" do
      it "retrieves all registerd sectors with correct IDs" do
        sectors_ids = sectors.pluck(:id)
        retrieved_sectors_ids = retrieved_sectors.map(&:id)

        expect(retrieved_sectors_ids).to match_array(sectors_ids)
      end

      it "retrieves all registerd sectors with correct names" do
        sectors_names = sectors.pluck(:name)
        retrieved_sectors_names = retrieved_sectors.map(&:name)

        expect(retrieved_sectors_names).to match_array(sectors_names)
      end
    end
  end

  describe "#show" do
    context "when the id is not an Integer" do
      it "raises an ArgumentError" do
        invalid_id = "id"

        expect { subject.show(id: invalid_id) }.to raise_error(TypeError)
      end
    end

    context "when sector does not exist" do
      it "raises a ActiveRecord::RecordNotFound error" do
        invalid_id = -1

        expect {
          subject.show(id: invalid_id)
        }.to raise_error(
            ActiveRecord::RecordNotFound,
            I18n.t("activerecord.errors.messages.record_not_found", attribute: "Sector", key: "id", value: invalid_id)
          )
      end
    end

    context "when sector exists" do
      it "returns the sector as a SectorResponseDto" do
        valid_id = first_sector.id
        sector_dto = subject.show(id: valid_id)

        expect(sector_dto).to be_a(Responses::SectorResponseDto)
      end
    end
  end

  describe "#create" do
    
  end
end
