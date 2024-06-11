require "rails_helper"

RSpec.describe Sector, type: :model do
  let!(:sector) { build(:sector) }
  let(:attribute_name) { Sector.human_attribute_name(:name) }

  describe "#associations" do
    context "products" do
      it "has many products" do
        product1 = create(:product, sector: sector)
        product2 = create(:product, sector: sector)

        expect(sector.products).to include(product1, product2)
      end

      it "can have no products associated" do
        expect(sector.products).to be_empty
      end
    end
  end

  describe "#before_validation" do
    context "when name has leading or trailing spaces" do
      it "removes leading and trailing spaces from the name attribute" do
        sector.name = "  Combos  "
        sector.valid?

        expect(sector.name).to eq("Combos")
      end
    end

    context "when name doesn't have leading or trailing spaces" do
      it "does not modify the name attribute" do
        expect(sector.name).to eq(sector.name)
      end
    end
  end

  describe "#validates" do
    context "with invalid attributes" do
      context "when name attribute is invalid" do
        context "when sector's name is not present" do
          context "with empty string value" do
            it "receives an ActiveModel blank error" do
              sector.name = ""
              sector.valid?

              expect(sector.errors.full_messages)
                .to include(
                  I18n.t("activerecord.errors.full_messages.blank", attribute: attribute_name)
                )
            end
          end
        end

        context "when sector's name length is not valid" do
          context "with too short name" do
            it "receives an ActiveModel too short error" do
              below_minimum_length_name = ValidationConstants::MINIMUM_NAME_LENGTH - 1

              sector.name = sector.name.slice!(below_minimum_length_name..)
              sector.valid?

              expect(sector.errors.full_messages)
                .to include(
                  I18n.t("activerecord.errors.full_messages.too_short",
                    attribute: attribute_name,
                    count: ValidationConstants::MINIMUM_NAME_LENGTH
                  )
                )
            end
          end
          context "with too long name" do
            it "receives an ActiveModel too long error" do
              name_above_maximum_length = sector.name.slice!(1..) * (ValidationConstants::MAXIMUM_NAME_LENGTH + 1)

              sector.name = name_above_maximum_length
              sector.valid?

              expect(sector.errors.full_messages)
                .to include(
                  I18n.t("activerecord.errors.full_messages.too_long",
                    attribute: attribute_name,
                    count: ValidationConstants::MAXIMUM_NAME_LENGTH
                  )
                )
            end
          end
        end

        context "when sector's name has been already taken" do
          before do
            create(:sector, name: "Bebidas")
          end

          context "with the same string case" do
            it "receives an ActiveModel taken error" do
              invalid_sector = build(:sector, name: "Bebidas")
              invalid_sector.valid?

              expect(invalid_sector.errors.full_messages)
                .to include(
                  I18n.t("activerecord.errors.full_messages.taken", attribute: attribute_name)
                )
            end
          end

          context "with different string case" do
            it "receives an ActiveModel taken error" do
              invalid_sector = build(:sector, name: "bebidas")
              invalid_sector.valid?

              expect(invalid_sector.errors.full_messages)
                .to include(
                  I18n.t("activerecord.errors.full_messages.taken", attribute: attribute_name)
                )
            end
          end
        end
      end
    end

    context "with valid attributes" do
      it "allows sector to be created on database" do
        expect(sector.valid?).to be(true)
      end
    end
  end
end
