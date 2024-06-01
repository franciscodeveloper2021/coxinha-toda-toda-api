require "rails_helper"

RSpec.describe UseCases::Sector::UpdateSectorService do
  let(:repository) { SectorRepository.new }
  let(:subject) { described_class.new(repository) }

  let(:valid_params) { Requests::SectorRequestDto.new(name: "Combos") }
  let(:invalid_params) { Requests::SectorRequestDto.new(name: "") }

  let(:first_sector) { Responses::SectorResponseDto.new(id: 1, name: "OldName") }
  let(:updated_sector) {Responses::SectorResponseDto.new(id: first_sector.id, name: valid_params.name) }

  let(:invalid_id) { -1 }
  let(:record_not_found_message) {
    I18n.t(
      "activerecord.errors.messages.record_not_found",
      attribute: "Sector",
      key: "id",
      value: invalid_id
    )
  }

  describe "#initialize" do
    it "receives a repository as a dependency" do
      expect(subject.instance_variable_get(:@repository)).to eq(repository)
    end
  end

  describe "#call" do
    context "with invalid params" do
      it "raises an ActiveRecord::RecordNotFound error" do
        allow(repository).to receive(:update).and_raise(ActiveRecord::RecordNotFound, record_not_found_message)

        expect {
          subject.call(id: invalid_id, update_params: valid_params)
        }.to raise_error(
          ActiveRecord::RecordNotFound,
          record_not_found_message
        )
      end

      it "raises ActiveRecord::RecordInvalid" do
        allow(repository).to receive(:update).and_raise(ActiveRecord::RecordInvalid)

        expect {
          subject.call(id: first_sector.id, update_params: invalid_params)
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "with valid params" do
      let(:result) { subject.call(id: first_sector.id, update_params: valid_params) }

      before do
        allow(repository).to receive(:update).with(id: first_sector.id, update_params: valid_params).and_return(updated_sector)
      end

      it "updates the sector in the database" do
        expect(result).to eq(updated_sector)
      end

      it "returns a SectorResponseDto" do
        expect(result).to be_a(Responses::SectorResponseDto)
      end
    end
  end
end
