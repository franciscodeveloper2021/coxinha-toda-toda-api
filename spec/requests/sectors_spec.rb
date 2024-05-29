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

    it "initializes the CreateSectorService" do
      expect(subject.instance_variable_get(:@create_service)).to be_a(create_sector_service)
    end
  end

  describe "#index" do
    before do
      get sectors_path
    end

    context "when sectors are present" do
      it "returns a success response" do
        expect(response).to have_http_status(:ok)
      end

      it "returns in JSON format" do
        expect(response.content_type).to eq "application/json; charset=utf-8"
      end

      it "returns all sectors" do
        sectors = Sector.all

        get sectors_path

        json_response = JSON.parse(response.body)

        expect(json_response.count).to eq(sectors.count)
      end
    end

    context "when sectors are not present" do
      it "returns an empty array" do
        Sector.delete_all

        get sectors_path

        json_response = JSON.parse(response.body)

        expect(json_response).to be_empty
      end
    end
  end

  describe "#show" do
    context "when sector exists" do
      let(:sector) { create(:sector) }

      before do
        get sector_path(sector.id)
      end

      it "returns a success response" do
        expect(response).to have_http_status(:ok)
      end

      it "returns in JSON format" do
        expect(response.content_type).to eq "application/json; charset=utf-8"
      end

      it "returns the requested sector" do
        json_response = JSON.parse(response.body)

        expect(json_response["id"]).to eq(sector.id)
        expect(json_response["name"]).to eq(sector.name)
      end
    end

    context "when sector does not exist" do
      it "returns a not found response" do
        get sector_path(-1)

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "#create" do
    context "with valid attributes" do
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

    context "with invalid attributes" do
      it "returns an unprocessable entity response" do
        post sectors_path, params: { sector: { name: "" } }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
