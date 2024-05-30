require "rails_helper"

RSpec.describe SectorRepository, type: :repository do
  let!(:sectors) { create_list(:sector, 5) }
  let(:first_sector) { sectors.first }
  let(:subject) { described_class.new }

  describe "#initialize" do
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
        subject.instance_variable_get(:@sectors_dtos).each do |sector_dto|
          expect(sector_dto).to be_a(Responses::SectorResponseDto)
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
      it "raises ActiveRecord::RecordInvalid" do
        invalid_params = Requests::SectorRequestDto.new(name: "")

        expect { subject.create(create_params: invalid_params) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "with valid params" do
      it "saves sector on database" do
        valid_params = Requests::SectorRequestDto.new(name: "Salgados")

        expect { subject.create(create_params: valid_params) }
          .to change { Sector.count }.by(1)
      end

      it "saves sector DTO in memory" do
        valid_params = Requests::SectorRequestDto.new(name: "Salgados")

        sector_dto = subject.create(create_params: valid_params)
        found_sector_dto = subject.show(id: sector_dto.id)

        expect(sector_dto.id).to eq(found_sector_dto.id)
        expect(sector_dto.name).to eq(found_sector_dto.name)
      end


      it "returns a SectorResponseDTO" do
        valid_params = Requests::SectorRequestDto.new(name: "Congelados")

        sector_dto = subject.create(create_params: valid_params)

        expect(sector_dto).to be_a(Responses::SectorResponseDto)
      end
    end
  end

  describe "#update" do
    context "with invalid params" do
      it "raises an ActiveRecord::RecordNotFound error if id is not present" do
        invalid_id = -1
        valid_params = Requests::SectorRequestDto.new(name: "Combos")

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
        valid_params = Requests::SectorRequestDto.new(name: "Brioco")

        subject.update(id: first_sector.id, update_params: valid_params)
        first_sector.reload

        expect(first_sector.name).to eq(valid_params.name)
      end

      it "updates the sector DTO in memory" do
        valid_params = Requests::SectorRequestDto.new(name: "Brioco")

        subject.update(id: first_sector.id, update_params: valid_params)
        sector_dto = subject.show(id: first_sector.id)

        expect(sector_dto.name).to eq(valid_params.name)
      end

      it "returns a SectorResponseDto" do
        valid_params = Requests::SectorRequestDto.new(name: "Brioco")

        sector_dto = subject.update(id: first_sector.id, update_params: valid_params)

        expect(sector_dto).to be_a(Responses::SectorResponseDto)
      end
    end
  end
end
