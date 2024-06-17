require 'rails_helper'

RSpec.describe "Products", type: :request do
  let(:subject)  { ProductsController.new }
  let(:index_products_service) { UseCases::Product::IndexProductsService }
  let(:show_product_service) { UseCases::Product::ShowProductService }

  describe "#initialize" do
    it "initializes IndexProductsService" do
      expect(subject.instance_variable_get(:@index_service)).to be_a(index_products_service)
    end

    it "initializes ShowProductService" do
      expect(subject.instance_variable_get(:@show_service)).to be_a(show_product_service)
    end
  end

  describe "#index" do
    before do
      get products_path
    end

    context "when products are not present" do
      it "returns an empty array" do
        Product.delete_all

        get products_path

        json_response = JSON.parse(response.body)

        expect(json_response).to be_empty
      end
    end

    context "when products are present" do
      it "returns a success response" do
        expect(response).to have_http_status(:ok)
      end

      it "returns in JSON format" do
        expect(response.content_type).to eq "application/json; charset=utf-8"
      end

      it "returns all products" do
        products = Product.all

        get products_path

        json_response = JSON.parse(response.body)

        expect(json_response.count).to eq(products.count)
      end
    end
  end

  describe "#show" do
    context "when product does not exist" do
      it "returns a not found response" do
        get product_path(-1)

        expect(response).to have_http_status(:not_found)
      end
    end

    context "when product exists" do
      let(:product) { create(:product) }

      before do
        get product_path(product.id)
      end

      it "returns a success response" do
        expect(response).to have_http_status(:ok)
      end

      it "returns in JSON format" do
        expect(response.content_type).to eq "application/json; charset=utf-8"
      end

      it "returns the requested product" do
        json_response = JSON.parse(response.body)

        expect(json_response["id"]).to eq(product.id)
      end
    end
  end
end
