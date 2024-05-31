require "rails_helper"

RSpec.describe SectorRepository, type: :repository do
  let!(:sectors) { create_list(:sector, 5) }
  let(:first_sector) { sectors.first }
  let(:subject) { described_class.new }

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

    describe "#private" do
      context "initialize_sectors_dtos" do
        before do
          subject.send(:initialize_sectors_dtos)
        end

        it "fills @sectors_dtos with correct objects" do
          expect(subject.instance_variable_get(:@sectors_dtos)).to all(be_a(Responses::SectorResponseDto))
        end

        it "fills @sectors_dtos with correct data" do
          sectors_from_database = Sector.all
          sectors_dtos = subject.instance_variable_get(:@sectors_dtos)

          expect(sectors_dtos.map(&:id)).to match_array(sectors_from_database.pluck(:id))
          expect(sectors_dtos.map(&:name)).to match_array(sectors_from_database.pluck(:name))
        end
      end

      context "add_sector_dto_in_memory" do
        let(:new_sector_dto) { Responses::SectorResponseDto.new(id: 999, name: "New Sector") }

        it "adds the new sector DTO to @sectors_dtos" do
          subject.send(:add_sector_dto_in_memory, sector_dto: new_sector_dto)
          sectors_dtos = subject.instance_variable_get(:@sectors_dtos)

          expect(sectors_dtos).to include(new_sector_dto)
        end
      end

      context "updates_sector_dto_in_memory" do
        let(:existing_sector_dto) { subject.instance_variable_get(:@sectors_dtos).first }
        let(:updated_sector_dto) { Responses::SectorResponseDto.new(id: existing_sector_dto.id, name: "Updated Name") }

        it "updates the existing sector DTO in @sectors_dtos" do
          subject.send(:update_sector_dto_in_memory, dto_id: existing_sector_dto.id, updated_sector_dto: updated_sector_dto)

          sectors_dtos = subject.instance_variable_get(:@sectors_dtos)
          updated_dto = sectors_dtos.find { |dto| dto.id == updated_sector_dto.id }

          expect(updated_dto.id).to eq(updated_sector_dto.id)
          expect(updated_dto.name).to eq(updated_sector_dto.name)
        end
      end
    end
  end

  describe "#index" do
    context "when there are no sectors" do
      it "returns an empty array" do
        allow(Sector).to receive(:all).and_return([])

        expect(subject.index).to eq([])
      end
    end

    context "when there are registered sectors" do
      let(:retrieved_sectors) { subject.index }
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
    context "when id is not an Integer" do
      it "raises a TypeError" do
        invalid_id = "id"

        expect { subject.show(id: invalid_id) }.to raise_error(TypeError)
      end
    end

    context "when sector does not exist" do
      it "raises an ActiveRecord::RecordNotFound error" do
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

      it "creates sector DTO in memory" do
        sector_dto = subject.create(create_params: valid_params)
        found_sector_dto = subject.show(id: sector_dto.id)

        expect(sector_dto.id).to eq(found_sector_dto.id)
        expect(sector_dto.name).to eq(found_sector_dto.name)
      end

      it "returns a SectorResponseDTO" do
        sector_dto = subject.create(create_params: valid_params)
        expect(sector_dto).to be_a(Responses::SectorResponseDto)
      end
    end
  end

  describe "#update" do
    let(:valid_params) { Requests::SectorRequestDto.new(name: "Combos") }

    context "with invalid params" do
      let(:invalid_id) { -1 }

      it "raises an ActiveRecord::RecordNotFound error" do
        expect {
          subject.update(id: invalid_id, update_params: valid_params)
        }.to raise_error(
            ActiveRecord::RecordNotFound,
            I18n.t("activerecord.errors.messages.record_not_found", attribute: "Sector", key: "id", value: invalid_id)
          )
      end

      it "raises ActiveRecord::RecordInvalid" do
        invalid_params = Requests::SectorRequestDto.new(name: "")

        expect { subject.update(id: first_sector.id, update_params: invalid_params) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "with valid params" do
      it "updates the sector in the database" do
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
end
