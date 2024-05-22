require "rails_helper"

RSpec.describe SectorsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/sectors").to route_to("sectors#index")
    end
  end
end
