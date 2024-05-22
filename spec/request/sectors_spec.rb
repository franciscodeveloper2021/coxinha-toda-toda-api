require "rails_helper"

RSpec.describe "/sectors", type: :request do
  let(:subject)  { SectorsController.new }
  let(:index_service_class) { UseCases::Sector::IndexSectorsService }

  describe "initialize" do
    it "initializes the IndexSectorsService" do
      expect(subject.instance_variable_get(:@index_service)).to be_a(index_service_class)
    end
  end
end
