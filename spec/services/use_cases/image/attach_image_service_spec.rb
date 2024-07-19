require "rails_helper"

RSpec.describe UseCases::Image::AttachImageService do
  let(:repository) { ImageRepository.new }
  let(:subject) { described_class.new(image_repository: repository) }

  describe "#initialize" do
    it "receives a repository as a dependency" do
      expect(subject.instance_variable_get(:@repository)).to eq(repository)
    end
  end
end
