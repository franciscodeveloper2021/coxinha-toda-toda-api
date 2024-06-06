require "rails_helper"

RSpec.describe ValidationMethods do

  describe "#strip_whitespace" do
    let(:dummy_object) do
      Object.new.tap do |object|
        object.extend(ValidationMethods)
        object.instance_variable_set(:@name, nil)
        object.class.send(:attr_accessor, :name)
      end
    end

    context "with invalid param" do
      context "when attribute param is not a symbol" do
        it "raises a TypeError" do
          expect { dummy_object.strip_whitespace(123) }.to raise_error(TypeError)
        end
      end

      context "when param is not present" do
        it "raises an ArgumentError" do
          expect { dummy_object.strip_whitespace() }.to raise_error(ArgumentError)
        end
      end
    end

    context "with valid param" do
      context "when attribute has leading or trailing spaces" do
        it "removes leading and trailing spaces from attribute" do
          dummy_object.name = "   John Doe  "
          dummy_object.strip_whitespace(:name)

          expect(dummy_object.instance_variable_get(:@name)).to eq("John Doe")
        end
      end

      context "when attribute doesn't have leading or trailing spaces" do
        it "does not modify attribute" do
          dummy_object.name = "John Doe"
          dummy_object.strip_whitespace(:name)

          expect(dummy_object.instance_variable_get(:@name)).to eq("John Doe")
        end
      end
    end
  end
end
