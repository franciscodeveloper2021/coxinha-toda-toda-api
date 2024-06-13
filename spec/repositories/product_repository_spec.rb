require "rails_helper"

RSpec.describe ProductRepository, type: :repository do
  let(:subject) { described_class.new }

  let!(:products) { create_list(:product, 5)}

  describe "#initialize" do
    context "type checking" do
      context "with sorbet static type checking" do
        it "has @products_dtos as instance variable of type ProductResponseDto Array" do
          T.assert_type!(subject.instance_variable_get(:@products_dtos), T::Array[Responses::ProductResponseDto])
        end
      end

      context "with ruby dynamic type checking" do
        it "has @products_dtos as instance variable of type Array" do
          expect(subject.instance_variable_get(:@products_dtos)).to be_a(Array)
        end

        it "has @products_dtos with elements of type ProductResponseDto" do
          expect(subject.instance_variable_get(:@products_dtos)).to all(be_a(Responses::ProductResponseDto))
        end
      end
    end
  end

  describe "#index" do
    context "when there are no products" do
      it "returns an empty array" do
        allow(Product).to receive(:all).and_return(Product.none)

        expect(subject.index).to eq([])
      end
    end

    context "when there are registered products" do
      let(:retrieved_products) { subject.index }

      it "retrieves all registered products" do
        products_ids = products.pluck(:id)
        retrieved_products_ids = retrieved_products.map(&:id)

        expect(retrieved_products_ids).to match_array(products_ids)
      end
    end
  end
end
