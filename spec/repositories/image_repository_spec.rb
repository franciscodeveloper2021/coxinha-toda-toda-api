require "rails_helper"

RSpec.describe ImageRepository, type: :repository do
  let!(:product) { create(:product) }
  let(:subject) { described_class.new }
  let(:image_request_dto) do
    Requests::ImageRequestDto.new(
      description: "Coxinha Toda Toda logo",
      imageable: product,
      content: ActionDispatch::Http::UploadedFile.new(
        tempfile: Rails.root.join('spec/fixtures/files/test.png'),
        filename: 'test.png',
        type: 'image/png'
      )
    )
  end

  describe "#attach_image" do
    context "with valid params" do
      before do
        subject.attach_image(image_request_dto: image_request_dto)
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

    context "with invalid params" do
      let(:invalid_image_request_dto) do
        Requests::ImageRequestDto.new(
          description: nil,
          imageable: nil,
          content: nil
        )
      end

      it "does not create an image record" do
        expect {
          subject.attach_image(image_request_dto: invalid_image_request_dto)
        }.to raise_error(TypeError)

        expect(Image.count).to eq(0)
      end
    end
  end
end
