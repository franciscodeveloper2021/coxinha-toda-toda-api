require "rails_helper"

RSpec.describe ProductRepository, type: :repository do
  let(:subject) { described_class.new }

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
end
