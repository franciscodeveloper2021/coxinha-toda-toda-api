require 'rails_helper'

RSpec.describe Sector, type: :model do
  let(:sector) { build(:sector) }

  describe "validates" do
    context "when sector's name is not present" do
      it "raises an ActiveRecord error when sector's name is blank" do
        sector.name = nil
        sector.valid?

        expect(sector.errors.full_messages).to include(I18n.t("activerecord.errors.full_messages.blank", attribute: Sector.human_attribute_name(:name)))
      end
    end
  end
end
