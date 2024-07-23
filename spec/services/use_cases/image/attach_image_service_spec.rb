require "rails_helper"

RSpec.describe UseCases::Image::AttachImageService do
  let(:repository) { ImageRepository.new }
  let(:subject) { described_class.new(image_repository: repository) }
  let!(:product) { build_stubbed(:product) }
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

  describe "#initialize" do
    it "receives a repository as a dependency" do
      expect(subject.instance_variable_get(:@repository)).to eq(repository)
    end
  end

  describe "#call" do
    it "calls method attach_image from repository" do
      expect(repository).to receive(:attach_image).with(image_request_dto: )
      subject.call(image_request_dto: image_request_dto)
    end
  end
end
