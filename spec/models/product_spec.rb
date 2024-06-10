require "rails_helper"

RSpec.describe Product, type: :model do
  let!(:product) { build(:product) }

  describe "#before_validation" do
    context "when attribute has leading or trailing spaces" do
      it "removes leading and trailing spaces from photo_url attribute" do
        product.photo_url = " https://photo_url.com "
        product.valid?

        expect(product.photo_url).to eq("https://photo_url.com")
      end

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
      it "does not modify photo_url attribute" do
        expect(product.photo_url).to eq(product.photo_url)
      end

      it "does not modify name attribute" do
        expect(product.name).to eq(product.name)
      end

      it "does not modify description attribute" do
        expect(product.description).to eq(product.description)
      end
    end
  end
end
