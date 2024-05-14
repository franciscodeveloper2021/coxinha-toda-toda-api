require 'rails_helper'

RSpec.describe Sector, type: :model do
  let!(:sector) { build(:sector) }
  let(:attribute_name) { Sector.human_attribute_name(:name) }

  describe "type checking" do
    context "with invalid attributes type" do
      context "when name attribute is not a String" do
        it "raises a TypeError" do
          sector.name = 123

          expect { T.assert_type!(sector.name, String) }.to raise_error(TypeError)
        end
      end
    end

    context "with valid attributes type" do
      context "when name attribute is a String" do
        it "ensures sorbet type checking for the name attribute" do
          T.assert_type!(sector.name, String)
        end

        it "ensures ruby dynamic type checking for the name attribute" do
          expect(sector.name).to be_a(String)
        end

        it "does not raise a type error" do
          expect { T.assert_type!(sector.name, String) }.not_to raise_error
        end
      end
    end
  end

  describe "validates" do
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
                    attribute: attribute_name, count: ValidationConstants::MINIMUM_NAME_LENGTH
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
          context "with the same string case" do
            let(:valid_sector) { create(:sector, name: "Bebidas") }
            let(:invalid_sector) {  build(:sector, name: "Bebidas") }

            it "receives an ActiveModel taken error" do
              invalid_sector.valid?

              expect(invalid_sector.errors.full_messages)
                .to include(
                  I18n.t("activerecord.errors.full_messages.taken", attribute: attribute_name)
                )
            end
          end
          context "with different string case" do
            let(:valid_sector) { create(:sector, name: "Bebidas") }
            let(:invalid_sector) { build(:sector, name: "bebidas") }

            it "receives an ActiveModel taken error" do
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
      context "when name attribute is valid" do
        it "is allowed to be persisted on the database" do
          expect(sector.valid?).to be(true)
        end
      end
    end
  end
end
