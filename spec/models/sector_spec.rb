require 'rails_helper'

RSpec.describe Sector, type: :model do
  let!(:sector) { build(:sector) }
  let(:attribute_name) { Sector.human_attribute_name(:name) }

  describe "validates" do
    context "when name attribute is not valid" do

      context "when sector's name is not present" do
        context "with nil string value" do
          it "raises an ActiveModel blank error" do
            sector.name = nil
            sector.valid?

            expect(sector.errors.full_messages)
              .to include(
                I18n.t("activerecord.errors.full_messages.blank", attribute: attribute_name)
              )
          end
        end
        context "with empty string value" do
          it "raises an ActiveModel blank error" do
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
          it "raises an ActiveModel too short error" do
            below_minimum_length_name = Sector::MINIMUM_NAME_LENGTH - 1

            sector.name = sector.name.slice!(below_minimum_length_name..)
            sector.valid?

            expect(sector.errors.full_messages)
              .to include(
                I18n.t("activerecord.errors.full_messages.too_short", attribute: attribute_name, count: Sector::MINIMUM_NAME_LENGTH)
              )
          end
        end
        context "with too long name" do
          it "raises an ActiveModel too long error" do
            name_above_maximum_length = sector.name.slice!(1..) * (Sector::MAXIMUM_NAME_LENGTH + 1)

            sector.name = name_above_maximum_length
            sector.valid?

            expect(sector.errors.full_messages)
              .to include(
                I18n.t("activerecord.errors.full_messages.too_long", attribute: attribute_name, count: Sector::MAXIMUM_NAME_LENGTH)
              )
          end
        end
      end

      context "when sector's name has been already taken" do
        context "with the same string case" do
          let(:valid_sector) { create(:sector, name: "Bebidas") }
          let(:invalid_sector) { described_class.new(name: "Bebidas") }

          it "raises an ActiveModel taken error" do
            invalid_sector.valid?

            expect(invalid_sector.errors.full_messages)
              .to include(
                I18n.t("activerecord.errors.full_messages.taken", attribute: attribute_name)
              )
          end
        end
        context "with different string case" do
          let(:valid_sector) { create(:sector, name: "Bebidas") }
          let(:invalid_sector) { described_class.new(name: "bebidas") }

          it "raises an ActiveModel taken error" do
            invalid_sector.valid?

            expect(invalid_sector.errors.full_messages)
              .to include(
                I18n.t("activerecord.errors.full_messages.taken", attribute: attribute_name)
              )
          end
        end
      end
    end

    context "when name attribute is valid" do

      context "with no errors before being saved" do
        it "is allowed to be persisted on the database" do
          expect(sector.valid?).to be(true)
        end
      end

      context "with no errors after it has been saved" do
        it "is persisted on the database" do
          expect(sector.save!).to be(true)
        end
      end
    end
  end
end
