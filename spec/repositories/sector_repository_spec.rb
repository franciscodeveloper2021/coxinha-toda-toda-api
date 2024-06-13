require "rails_helper"

RSpec.describe SectorRepository, type: :repository do
  let(:subject) { described_class.new }

  let!(:sectors) { create_list(:sector, 5) }
  let(:first_sector) { sectors.first }

  let(:invalid_id) { -1 }

  let(:record_not_found_message) do
    I18n.t("activerecord.errors.messages.record_not_found", attribute: "Sector", key: "id", value: invalid_id)
  end

  describe "#initialize" do
    context "type checking" do
      context "with sorbet static type checking" do
        it "has @sectors_dtos as instance variable of type SectorResponseDto Array" do
          T.assert_type!(subject.instance_variable_get(:@sectors_dtos), T::Array[Responses::SectorResponseDto])
        end
      end

      context "with ruby dynamic type checking" do
        it "has @sectors_dtos as instance variable of type Array" do
          expect(subject.instance_variable_get(:@sectors_dtos)).to be_a(Array)
        end

        it "has @sectors_dtos with elements of type SectorResponseDto" do
          expect(subject.instance_variable_get(:@sectors_dtos)).to all(be_a(Responses::SectorResponseDto))
        end
      end
    end
  end

  describe "#index" do
    context "when there are no sectors" do
      it "returns an empty array" do
        allow(Sector).to receive(:all).and_return(Sector.none)

        expect(subject.index).to eq([])
      end
    end

    context "when there are registered sectors" do
      let(:retrieved_sectors) { subject.index }

      it "retrieves all registered sectors" do
        sectors_ids = sectors.pluck(:id)
        retrieved_sectors_ids = retrieved_sectors.map(&:id)

        expect(retrieved_sectors_ids).to match_array(sectors_ids)
      end
    end
  end

  describe "#show" do
    context "when id is not an Integer" do
      it "raises a TypeError" do
        invalid_id = "id"

        expect { subject.show(id: invalid_id) }.to raise_error(TypeError)
      end
    end

    context "when sector does not exist" do
      it "raises an ActiveRecord::RecordNotFound error" do
        expect {
          subject.show(id: invalid_id)
        }.to raise_error(
            ActiveRecord::RecordNotFound,
            record_not_found_message
          )
      end
    end

    context "when sector exists" do
      it "returns a SectorResponseDto" do
        valid_id = first_sector.id
        sector_dto = subject.show(id: valid_id)

        expect(sector_dto).to be_a(Responses::SectorResponseDto)
      end
    end
  end

  describe "#create" do
    context "with invalid params" do
      let(:invalid_params) { Requests::SectorRequestDto.new(name: "") }

      it "raises ActiveRecord::RecordInvalid" do
        expect { subject.create(create_params: invalid_params) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "with valid params" do
      let(:valid_params) { Requests::SectorRequestDto.new(name: "Salgados") }

      it "saves sector on database" do
        expect { subject.create(create_params: valid_params) }
          .to change { Sector.count }.by(1)
      end

      it "adds sector DTO in memory" do
        sector_dto = subject.create(create_params: valid_params)
        found_sector_dto = subject.show(id: sector_dto.id)

        expect(sector_dto.id).to eq(found_sector_dto.id)
        expect(sector_dto.name).to eq(found_sector_dto.name)
      end

      it "returns a SectorResponseDto" do
        sector_dto = subject.create(create_params: valid_params)

        expect(sector_dto).to be_a(Responses::SectorResponseDto)
      end
    end
  end

  describe "#update" do
    let(:valid_params) { Requests::SectorRequestDto.new(name: "Combos") }

    context "with invalid params" do
      it "raises an ActiveRecord::RecordNotFound error" do
        expect {
          subject.update(id: invalid_id, update_params: valid_params)
        }.to raise_error(
            ActiveRecord::RecordNotFound,
            record_not_found_message
          )
      end

      it "raises ActiveRecord::RecordInvalid" do
        invalid_params = Requests::SectorRequestDto.new(name: "")

        expect { subject.update(id: first_sector.id, update_params: invalid_params) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "with valid params" do
      it "updates sector on database" do
        subject.update(id: first_sector.id, update_params: valid_params)
        first_sector.reload

        expect(first_sector.name).to eq(valid_params.name)
      end

      it "updates sector DTO in memory" do
        subject.update(id: first_sector.id, update_params: valid_params)
        sector_dto = subject.show(id: first_sector.id)

        expect(sector_dto.name).to eq(valid_params.name)
      end

      it "returns a SectorResponseDto" do
        sector_dto = subject.update(id: first_sector.id, update_params: valid_params)

        expect(sector_dto).to be_a(Responses::SectorResponseDto)
      end
    end
  end

  describe "#destroy" do
    context "with invalid params" do
      it "raises an ActiveRecord::RecordNotFound error" do
        expect {
          subject.destroy(id: invalid_id)
        }.to raise_error(
            ActiveRecord::RecordNotFound,
            record_not_found_message
          )
      end
    end

    context "with valid params" do
      let(:last_sector) { sectors.last }

      before do
        subject.destroy(id: last_sector.id)
      end

      it "deletes sector on database" do
        sectors = Sector.all

        expect(sectors).not_to include(last_sector)
      end

      it "deletes sector DTO in memory" do
        subject.send(:initialize_sectors_dtos)

        sectors_dtos = subject.instance_variable_get(:@sectors_dtos)

        expect(sectors_dtos.map(&:id)).not_to include(last_sector.id)
      end
    end
  end
end
