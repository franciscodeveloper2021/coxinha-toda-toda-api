require "rails_helper"

RSpec.describe ValidationConstants do

  MIN_NAME_LENGTH = ValidationConstants::MINIMUM_NAME_LENGTH
  MAX_NAME_LENGTH = ValidationConstants::MAXIMUM_NAME_LENGTH

  describe "constants" do
    context "with sorbet static type checking" do
      it "ensures sorbet type checking for MINIMUM_NAME_LENGTH" do
        T.assert_type!(MIN_NAME_LENGTH, Integer)
      end

      it "ensures sorbet type checking for MAXIMUM_NAME_LENGTH" do
        T.assert_type!(MAX_NAME_LENGTH, Integer)
      end
    end

    context "with ruby dynamic type checking" do
      it "ensures ruby dynamic type checking for MINIMUM_NAME_LENGTH" do
        expect(MIN_NAME_LENGTH).to be_a(Integer)
      end

      it "ensures ruby dynamic type checking for MAXIMUM_NAME_LENGTH" do
        expect(MAX_NAME_LENGTH).to be_a(Integer)
      end
    end
  end
end
