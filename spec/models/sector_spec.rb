require 'rails_helper'

RSpec.describe Sector, type: :model do
  let!(:sector) { build(:sector) }
  let(:attribute_name) { Sector.human_attribute_name(:name) }

  describe "validates" do
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
  end
end
