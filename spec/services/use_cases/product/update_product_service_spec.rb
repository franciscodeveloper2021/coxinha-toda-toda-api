require "rails_helper"

RSpec.describe UseCases::Product::UpdateProductService do
  let(:repository) { ProductRepository.new }
  let(:subject) { described_class.new(repository) }

  let(:valid_params) do
    Requests::ProductUpdateRequestDto.new(
      name: "Updated Product",
      description: "Updated description",
      price: 19.99, available: true,
      sector_id: 2
    )
  end
  let(:invalid_params) { Requests::ProductUpdateRequestDto.new(name: nil) }

  let(:first_product) do
    Responses::ProductResponseDto.new(
      id: 1,
      name: "Old Product",
      description: "Old description",
      price: 10.0,
      available: false,
      sector_id: 1
    )
  end
  let(:updated_product) do
    Responses::ProductResponseDto.new(
      id: first_product.id,
      name: valid_params.name,
      description: valid_params.description,
      price: valid_params.price,
      available: valid_params.available,
      sector_id: valid_params.sector_id
    )
  end

  let(:invalid_id) { -1 }
  let(:record_not_found_message) {
    I18n.t(
      "activerecord.errors.messages.record_not_found",
      attribute: "Product",
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
          subject.call(id: first_product.id, update_params: invalid_params)
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "with valid params" do
      let(:result) { subject.call(id: first_product.id, update_params: valid_params) }

      before do
        allow(repository).to receive(:update).with(id: first_product.id, update_params: valid_params).and_return(updated_product)
      end

      it "updates the product in the database" do
        expect(result).to eq(updated_product)
      end

      it "returns a ProductResponseDto" do
        expect(result).to be_a(Responses::ProductResponseDto)
      end
    end
  end
end
