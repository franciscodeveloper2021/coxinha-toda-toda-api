require "rails_helper"

RSpec.describe Image, type: :model do
  let!(:product) { create(:product) }
  let(:image) { build(:image, imageable: product) }

  describe "validates" do
    context "with invalid attributes" do
      context "with invalid description" do
        let(:attribute_description) { Image.human_attribute_name(:description) }

        context "when description is not present" do
          it "receives an ActiveModel blank error" do
            image.description = nil
            image.valid?

            expect(image.errors.full_messages)
              .to include(
                I18n.t("activerecord.errors.full_messages.blank", attribute: attribute_description)
              )
          end
        end

        context "when description's length is not valid" do
          context "with too long description" do
            it "receives an ActiveModel too long error" do
              description_above_maximum_length = image.description.slice!(1..) * (ValidationConstants::MAXIMUM_DESCRIPTION_LENGTH + 1)

              image.description = description_above_maximum_length
              image.valid?

              expect(image.errors.full_messages)
                .to include(
                  I18n.t("activerecord.errors.full_messages.too_long",
                    attribute: attribute_description,
                    count: ValidationConstants::MAXIMUM_DESCRIPTION_LENGTH
                  )
                )
            end
          end
        end
      end

      context "with invalid content" do
      end
    end

    context "with valid attributes" do
      context "when content is not present" do
        let(:attribute_content) { Image.human_attribute_name(:content) }

        it "receives an ActiveModel blank error" do
          image.content = nil
          image.valid?

          expect(image.errors.full_messages)
            .to include(
              I18n.t("activerecord.errors.full_messages.blank", attribute: attribute_content)
            )
        end
      end

      context "when content type is not allowed" do
      end
    end
  end
end
