require "rails_helper"

RSpec.describe ImageSerializer, type: :serializer do
  let!(:product) { create(:product) }
  let(:image) { create(:image, imageable: product) }
  let(:serializer) { described_class.new(image) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer).as_json }

  describe "attributes" do
    it "should include id, description, image_url and imageable" do
      expect(serialization.keys).to contain_exactly(:id, :description, :image_url, :imageable)
    end

    it "should correctly serialize id" do
      expect(serialization[:id]).to eq(image.id)
    end

    it "should correctly serialize description" do
      expect(serialization[:description]).to eq(image.description)
    end

    it "should correctly serialize image_url" do
      expect(serialization[:image_url]).to eq(Rails.application.routes.url_helpers.rails_blob_url(image.content))
    end

    it "should correctly serialize imageable" do
      expect(serialization[:imageable]).to eq(image.imageable)
    end
  end
end
