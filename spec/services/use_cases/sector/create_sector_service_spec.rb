require "rails_helper"

RSpec.describe UseCases::Sector::CreateSectorService do
  let(:repository) { SectorRepository.new }
  let(:subject) { described_class.new(repository) }
  let(:sector_id) { 1 }
  let(:sector_request_dto) { Requests::SectorRequestDto.new(name: "Fritos") }
  let(:sector_response_dto) { Responses::SectorResponseDto.new(id: sector_id, name:  sector_request_dto.name) }

  describe "#initialize" do
    it "receives a repository as a dependency" do
      expect(subject.instance_variable_get(:@repository)).to eq(repository)
    end
  end

  describe "#call" do
    context "with invalid params" do
      it "raises error" do
        invalid_params =  Requests::SectorRequestDto.new(name: " ")

        allow(repository).to receive(:create).with(create_params: invalid_params)
          .and_raise(ActiveRecord::RecordInvalid)

        expect { subject.call(create_params: invalid_params) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "with valid params" do
      it "creates sector on database" do
        allow(repository).to receive(:create).with(create_params: sector_request_dto).and_return(sector_response_dto)

        result = subject.call(create_params: sector_request_dto)

        expect(result).to eq(sector_response_dto)
      end
    end
  end
end
