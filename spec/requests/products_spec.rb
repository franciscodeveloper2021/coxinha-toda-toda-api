require 'rails_helper'

RSpec.describe "Products", type: :request do
  let(:subject)  { ProductsController.new }
  let(:index_products_service) { UseCases::Product::IndexProductsService }
  let(:show_product_service) { UseCases::Product::ShowProductService }
  let(:create_product_service) { UseCases::Product::CreateProductService }
  let(:destroy_product_service) { UseCases::Product::DestroyProductService }

  describe "#initialize" do
    it "initializes IndexProductsService" do
      expect(subject.instance_variable_get(:@index_service)).to be_a(index_products_service)
    end

    it "initializes ShowProductService" do
      expect(subject.instance_variable_get(:@show_service)).to be_a(show_product_service)
    end

    it "initializes CreateProductService" do
      expect(subject.instance_variable_get(:@create_service)).to be_a(create_product_service)
    end

    it "initializes CreateProductService" do
      expect(subject.instance_variable_get(:@destroy_service)).to be_a(destroy_product_service)
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

  describe "#create" do
    context "with invalid attributes" do
      it "returns an unprocessable entity response" do
        post products_path, params: { product: { name: "", description: "", price: 10, sector_id: nil } }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with valid attributes" do
      let(:attributes) { { product: {  name: "Banoffe", description: "A delicious bananoffe", price: 10.0, sector_id: nil } } }

      before do
        post products_path, params: attributes
      end

      it "returns a created response" do
        expect(response).to have_http_status(:created)
      end

      it "returns in JSON format" do
        expect(response.content_type).to eq "application/json; charset=utf-8"
      end

      it "returns the created product" do
        json_response = JSON.parse(response.body)

        expect(json_response["name"]).to eq(attributes[:product][:name])
      end
    end
  end

  describe "#destroy" do
    let!(:product) { create(:product) }

    context "when the product does not exist" do
      it "returns a not found response" do
        delete product_path(-1)

        expect(response).to have_http_status(:not_found)
      end
    end

    context "when the product exists" do
      it "returns a success response" do
        delete product_path(product.id)

        expect(response).to have_http_status(:ok)
      end

      it "returns a descriptive JSON message" do
        delete product_path(product.id)

        json_response = JSON.parse(response.body)

        expect(json_response["message"]).to eq(I18n.t('messages.record_deleted', record: 'Product'))
      end
    end
  end
end
