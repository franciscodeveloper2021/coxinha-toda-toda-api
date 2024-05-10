require 'rails_helper'

RSpec.describe Sector, type: :model do
  let!(:sector) { build(:sector) }
  let(:attribute_name) { Sector.human_attribute_name(:name) }

  describe "validates" do
    context "when name attribute is not valid" do
      context "when sector's name is blank" do
        it "raises an ActiveRecord blank error" do
          sector.name = nil
          sector.valid?

          expect(sector.errors.full_messages)
            .to include(I18n.t("activerecord.errors.full_messages.blank", attribute: attribute_name))
        end
      end
      context "when sectors's name is too short" do
        it "raises an ActiveRecord too short error" do
          below_minimum_length_name = Sector::MINIMUM_NAME_LENGTH - 1

          sector.name = sector.name.slice!(below_minimum_length_name..)
          sector.valid?

          expect(sector.errors.full_messages)
            .to include(
              I18n.t("activerecord.errors.full_messages.too_short", attribute: attribute_name, count: Sector::MINIMUM_NAME_LENGTH)
            )
        end
      end
      context "when sector's name is too long" do
        it "raises an ActiveRecord too long error" do
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
  end
end
