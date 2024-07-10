require "rails_helper"

RSpec.describe ImageRepository, type: :repository do
  let(:subject) { described_class.new }

  let(:product) { create(:product) }
  let(:image_request_dto) do
    Requests::ImageRequestDto.new(
      description: "Coxinha Toda Toda logo",
      content: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test.png'), 'image/png')
    )
  end

  describe "#attache_image_to_imageable" do
    context "with valid params" do
      before do
        subject.attach_image_to_imageable(image_request_dto: image_request_dto, imageable: product)
        @image = Image.last
      end

      it "creates an image record" do
        expect(Image.count).to eq(1)
      end

      it "sets the description correctly" do
        expect(@image.description).to eq(image_request_dto.description)
      end

      it "associates the image with the correct imageable" do
        expect(@image.imageable).to eq(product)
      end

      it "attaches the content" do
        expect(@image.content).to be_attached
      end

      it "sets the correct filename for the attached content" do
        expect(@image.content.blob.filename).to eq('test.png')
      end
    end
  end
end
