require 'rails_helper'

RSpec.describe "Images", type: :request do
  let(:subject)  { ImagesController.new }
  let(:attach_image_service) { UseCases::Image::AttachImageService }

  describe "#initialize" do
    it "initializes AttachImageService" do
      expect(subject.instance_variable_get(:@attach_image_service)).to be_an(attach_image_service)
    end
  end

  describe "#create" do
  end
end
