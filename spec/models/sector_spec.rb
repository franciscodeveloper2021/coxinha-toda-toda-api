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
          minimum_length_name = 5
          below_minimum_length_name = 4

          sector.name.slice!(below_minimum_length_name..)
          sector.valid?

          expect(sector.errors.full_messages)
            .to include(I18n.t("activerecord.errors.full_messages.too_short", attribute: attribute_name, count: minimum_length_name))
        end
      end
      context "when sector's name is too long" do
        it "raises an ActiveRecord too long error" do
          maximum_length_name = 50
          name_above_maximum_length = sector.name.slice!(1..) * (maximum_length_name + 1)

          sector.name = name_above_maximum_length
          sector.valid?

          expect(sector.errors.full_messages)
            .to include(I18n.t("activerecord.errors.full_messages.too_long", attribute: attribute_name, count: maximum_length_name))
        end
      end
    end
  end
end
