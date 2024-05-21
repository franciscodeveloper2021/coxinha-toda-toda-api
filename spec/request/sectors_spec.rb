# spec/requests/sectors_spec.rb
require "rails_helper"

RSpec.describe "/sectors", type: :request do
  let(:index_service_instance) { UseCases::Sector::IndexSectorsService.new }

  describe "initialize" do
    it "initializes the IndexSectorsService" do
      controller = SectorsController.new

      expect(controller.instance_variable_get(:@index_service)).to eq(index_service_instance)
    end
  end
end
