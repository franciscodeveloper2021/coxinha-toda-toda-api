require "rails_helper"

RSpec.describe SectorRepository, type: :repository do
  let!(:sectors) { create_list(:sector, 5) }
  let(:subject) { described_class.new }

  describe "#index" do
    let(:retrieved_sectors) { subject.index }

    context "when there is no sector" do
      it "returns" do
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
end
