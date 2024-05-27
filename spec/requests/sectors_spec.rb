require 'rails_helper'

RSpec.describe "Sectors", type: :request do
  let(:subject)  { SectorsController.new }
  let(:index_sectors_service) { UseCases::Sector::IndexSectorsService }
  let(:show_sector_service) { UseCases::Sector::ShowSectorService }
  let(:create_sector_service) { UseCases::Sector::CreateSectorService }

  describe "initialize" do
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

  describe "GET /sectors" do
    it "returns a success response" do
      get sectors_path

      expect(response).to have_http_status(:ok)
    end
  end
end
