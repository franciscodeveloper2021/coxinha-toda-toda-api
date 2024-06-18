require "rails_helper"

RSpec.describe UseCases::Product::ShowProductService do
  let(:repository) { ProductRepository.new }
  let(:subject) { described_class.new(repository) }

  let(:product_id) { 1 }
  let(:product_response_dto) do
    Responses::ProductResponseDto.new(
      id: product_id,
      name: "Coxinha de Frango",
      description: nil,
      price: 10.0,
      available: true,
      sector_id: 1
    )
  end

  let(:record_not_found_message) {
    I18n.t(
      "activerecord.errors.messages.record_not_found",
      attribute: "Product",
      key: "id",
      value: product_id
    )
  }

  describe "#initialize" do
    it "receives a repository as a dependency" do
      expect(subject.instance_variable_get(:@repository)).to eq(repository)
    end
  end

  describe "#call" do
    context "when product does not exist" do
      it "raises a ActiveRecord::RecordNotFound error" do
        allow(repository).to receive(:show).with(id: product_id).and_raise(
          ActiveRecord::RecordNotFound,
          record_not_found_message
        )

        expect { subject.call(id: product_id) }.to raise_error(
          ActiveRecord::RecordNotFound,
          record_not_found_message
        )
      end
    end

    context "when product exists" do
      it "returns the product as a ProductResponseDto" do
        allow(repository).to receive(:show).with(id: product_id).and_return(product_response_dto)

        result = subject.call(id: product_id)

        expect(result).to eq(product_response_dto)
      end
    end
  end
end
