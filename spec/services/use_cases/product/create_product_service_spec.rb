require "rails_helper"

RSpec.describe UseCases::Product::CreateProductService do
  let(:repository) { ProductRepository.new }
  let(:subject) { described_class.new(repository) }
  let(:product_id) { 1 }
  let(:product_request_dto) do
    Requests::ProductRequestDto.new(
      name: 'Coca-Cola',
      description: 'Refrigerante de cola',
      price: 5.99,
      available: true,
      sector_id: product_id
    )
  end
  let(:product_response_dto) do
    Responses::ProductResponseDto.new(
      id: product_id,
      name: product_request_dto.name,
      description: product_request_dto.description,
      price: product_request_dto.price,
      available: product_request_dto.available,
      sector_id: product_request_dto.sector_id
    )
  end

  describe "#initialize" do
    it "receives a repository as a dependency" do
      expect(subject.instance_variable_get(:@repository)).to eq(repository)
    end
  end

  describe "#call" do
    context "with invalid params" do
      let(:invalid_params) do
        Requests::ProductRequestDto.new(
          name: '',
          description: '',
          price: -1.0,
          available: true,
          sector_id: 1
        )
      end
      it "raises error" do
        allow(repository).to receive(:create).with(create_params: invalid_params)
          .and_raise(ActiveRecord::RecordInvalid)

        expect { subject.call(create_params: invalid_params) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "with valid params" do
      it "creates product on database" do
        allow(repository).to receive(:create).with(create_params: product_request_dto).and_return(product_response_dto)

        result = subject.call(create_params: product_request_dto)

        expect(result).to eq(product_response_dto)
      end
    end
  end
end
