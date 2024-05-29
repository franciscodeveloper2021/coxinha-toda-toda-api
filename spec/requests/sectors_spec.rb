require 'rails_helper'

RSpec.describe "Sectors", type: :request do
  let(:subject)  { SectorsController.new }
  let(:index_sectors_service) { UseCases::Sector::IndexSectorsService }
  let(:show_sector_service) { UseCases::Sector::ShowSectorService }
  let(:create_sector_service) { UseCases::Sector::CreateSectorService }

  describe "#initialize" do
    it "initializes the IndexSectorsService" do
      expect(subject.instance_variable_get(:@index_service)).to be_a(index_sectors_service)
    end
    it "initializes the ShowSectorService" do
      expect(subject.instance_variable_get(:@show_service)).to be_a(show_sector_service)
    end
    it "initializes the ShowSectorService" do
      expect(subject.instance_variable_get(:@create_service)).to be_a(create_sector_service)
    end
  end

  describe "#index" do
    it "returns a success response" do
      get sectors_path

      expect(response).to have_http_status(:ok)
    end

    it "returns in JSON format" do
      get sectors_path

      expect(response.content_type).to eq "application/json; charset=utf-8"
    end

    it "returns all sectors when sectors are present" do
      sectors = Sector.all

      get sectors_path

      json_response = JSON.parse(response.body)

      expect(json_response.count).to eq(sectors.count)
    end

    it "returns an empty array when sectors are not present" do
      Sector.delete_all

      get sectors_path

      json_response = JSON.parse(response.body)

      expect(json_response).to be_empty
    end
  end

  describe "#show" do
    let(:sector) { create(:sector) }

    it "returns a success response" do
      get sector_path(sector.id)

      expect(response).to have_http_status(:ok)
    end

    it "returns in JSON format" do
      get sector_path(sector.id)

      expect(response.content_type).to eq "application/json; charset=utf-8"
    end

    it "returns the requested sector" do
      get sector_path(sector.id)

      json_response = JSON.parse(response.body)

      expect(json_response["id"]).to eq(sector.id)
      expect(json_response["name"]).to eq(sector.name)
    end

    it "returns a not found response if sector is not found" do
      get sector_path(-1)

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "#create" do
    let(:attributes) { { sector: { name: "Combos" } } }

    before do
      post sectors_path, params: attributes
    end

    it "returns a created response" do
      expect(response).to have_http_status(:created)
    end

    it "returns in JSON format" do
      expect(response.content_type).to eq "application/json; charset=utf-8"
    end

    it "returns the created sector" do
      json_response = JSON.parse(response.body)

      expect(json_response["name"]).to eq(attributes[:sector][:name])
    end
  end
end
