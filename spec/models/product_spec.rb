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

        context "when product's name length is not valid" do
          context "with too long name" do
            it "receives an ActiveModel too long error" do
              description_above_maximum_length = product.name.slice!(1..) * (ValidationConstants::MAXIMUM_NAME_LENGTH + 1)

              product.name = description_above_maximum_length
              product.valid?

              expect(product.errors.full_messages)
                .to include(
                  I18n.t("activerecord.errors.full_messages.too_long",
                    attribute: attribute_name,
                    count: ValidationConstants::MAXIMUM_NAME_LENGTH
                  )
                )
            end
          end
        end

        context "when name has been already taken" do
          before do
            create(:product, name: "Coxinha")
          end

          context "with the same string case" do
            it "receives an ActiveModel taken error" do
              invalid_product = build(:product, name: "Coxinha")
              invalid_product.valid?

              expect(invalid_product.errors.full_messages)
                .to include(
                  I18n.t("activerecord.errors.full_messages.taken", attribute: attribute_name)
                )
            end
          end

          context "with different string case" do
            it "receives an ActiveModel taken error" do
              invalid_product = build(:product, name: "coxinha")
              invalid_product.valid?

              expect(invalid_product.errors.full_messages)
                .to include(
                  I18n.t("activerecord.errors.full_messages.taken", attribute: attribute_name)
                )
            end
          end
        end
      end

      context "description" do
        let(:attribute_descritpion) { Sector.human_attribute_name(:description) }

        context "with too long descritpion" do
          it "receives an ActiveModel too long error" do
            description_above_maximum_length = product.description.slice!(1..) * (ValidationConstants::MAXIMUM_DESCRIPTION_LENGTH + 1)

            product.description = description_above_maximum_length
            product.valid?

            expect(product.errors.full_messages)
              .to include(
                I18n.t("activerecord.errors.full_messages.too_long",
                  attribute: attribute_descritpion,
                  count: ValidationConstants::MAXIMUM_DESCRIPTION_LENGTH
                )
              )
          end
        end
      end

      context "price" do
        let(:attribute_price) { Sector.human_attribute_name(:price) }

        context "when price is not present" do
          it "receives an ActiveModel blank error" do
            product.price = nil
            product.valid?

            expect(product.errors.full_messages)
              .to include(
                I18n.t("activerecord.errors.full_messages.blank", attribute: attribute_price)
            )
          end
        end
      end

      context "available" do
        let(:attribute_available) { Sector.human_attribute_name(:available) }

        context "when available is not boolean" do
          it "receives an ActiveModel blank error" do
            product.available = nil
            product.valid?

            expect(product.errors.full_messages)
              .to include(
                I18n.t("activerecord.errors.full_messages.inclusion", attribute: attribute_available)
            )
          end
        end
      end
    end

    context "with valid attributes" do
      it "allows product to be created on database" do
        expect(product.valid?).to be(true)
      end
    end
  end
end
