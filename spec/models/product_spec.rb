require "rails_helper"

RSpec.describe Product, type: :model do
  let!(:product) { build(:product) }

  describe "#before_validation" do
    context "when attribute has leading or trailing spaces" do
      it "removes leading and trailing spaces from name attribute" do
        product.name = " Coxinha "
        product.valid?

        expect(product.name).to eq("Coxinha")
      end

      it "removes leading and trailing spaces from description attribute" do
        product.description = " That's a description of coxinha... "
        product.valid?

        expect(product.description).to eq("That's a description of coxinha...")
      end
    end

    context "when attribute doesn't have leading or trailing spaces" do
      it "does not modify name attribute" do
        expect(product.name).to eq(product.name)
      end

      it "does not modify description attribute" do
        expect(product.description).to eq(product.description)
      end
    end
  end

  describe "#validates" do
    context "with invalid attributes" do
      context "name" do
        let(:attribute_name) { Sector.human_attribute_name(:name) }

        context "when name is not present" do
          it "receives an ActiveModel blank error" do
            product.name = " "
            product.valid?

            expect(product.errors.full_messages)
              .to include(
                I18n.t("activerecord.errors.full_messages.blank", attribute: attribute_name)
            )
          end
        end
      end
    end
  end
end
