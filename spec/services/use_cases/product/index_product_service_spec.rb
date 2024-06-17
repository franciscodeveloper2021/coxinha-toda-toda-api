require "rails_helper"

RSpec.describe UseCases::Product::IndexProductsService do
  let(:repository) { ProductRepository.new }
  let(:subject) { described_class.new(repository) }

  describe "#initialize" do
    it "receives a repository as a dependency" do
      expect(subject.instance_variable_get(:@repository)).to eq(repository)
    end
  end

  describe "#call" do
    context "when there are no products" do
      it "returns an empty array" do
        allow(repository).to receive(:index).and_return([])

        expect(subject.call).to eq([])
      end
    end

    context "when there are products" do
      let(:products_dtos) do
        [
          Responses::ProductResponseDto.new(
            id: 1,
            name: "Coca-cola 500 ml",
            description: "Coca-cola ks de 500 ml",
            price: 10.0,
            available: true,
            sector_id: nil
          ),
          Responses::ProductResponseDto.new(
            id: 1,
            name: "Coxinha de Frango",
            description: nil,
            price: 10.0,
            available: true,
            sector_id: 1
          ),
        ]
      end
      it "returns an array of products dtos" do
        allow(repository).to receive(:index).and_return(products_dtos)

        expect(subject.call).to eq(products_dtos)
      end
    end
  end
end
