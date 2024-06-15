require "rails_helper"

RSpec.describe ProductRepository, type: :repository do
  let(:subject) { described_class.new }

  let!(:products) { create_list(:product, 5)}
  let(:first_product) { products.first }

  let(:invalid_id) { -1 }
  let(:record_not_found_message) do
    I18n.t("activerecord.errors.messages.record_not_found", attribute: "Product", key: "id", value: invalid_id)
  end

  describe "#initialize" do
    context "type checking" do
      it "has @products_dtos as instance variable of type ProductResponseDto Array" do
        T.assert_type!(subject.instance_variable_get(:@products_dtos), T::Array[Responses::ProductResponseDto])
      end
    end
  end

  describe "#index" do
    context "when there are no products" do
      it "returns an empty array" do
        allow(Product).to receive(:all).and_return(Product.none)

        expect(subject.index).to eq([])
      end
    end

    context "when there are registered products" do
      let(:retrieved_products) { subject.index }

      it "retrieves all registered products" do
        products_ids = products.pluck(:id)
        retrieved_products_ids = retrieved_products.map(&:id)

        expect(retrieved_products_ids).to match_array(products_ids)
      end
    end
  end

  describe "#show" do
    context "when id is not an Integer" do
      it "raises a TypeError" do
        invalid_id_type = "id"

        expect { subject.show(id: invalid_id_type) }.to raise_error(TypeError)
      end
    end

    context "when product does not exist" do
      it "raises an ActiveRecord::RecordNotFound error" do
        expect {
          subject.show(id: invalid_id)
        }.to raise_error(
            ActiveRecord::RecordNotFound,
            record_not_found_message
          )
      end
    end

    context "when product exists" do
      it "returns a PoductResponseDto" do
        valid_id = first_product.id
        product_dto = subject.show(id: valid_id)

        expect(product_dto).to be_a(Responses::ProductResponseDto)
      end
    end
  end

  describe "#create" do
    let(:product) { create(:sector) }
    context "with invalid params" do
      let(:invalid_params) do
        Requests::ProductRequestDto.new(
          name: '',
          description: '',
          price: -1.0,
          available: true,
          sector_id: sector.id
        )
      end

      it "raises ActiveRecord::RecordInvalid" do
        expect { subject.create(create_params: invalid_params) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "with valid params" do
      let(:valid_params) do
        Requests::ProductRequestDto.new(
          name: 'Coca-Cola',
          description: 'Refrigerante de cola',
          price: 5.99,
          available: true,
          sector_id: sector.id
        )
      end

      it "saves product on database" do
        expect { subject.create(create_params: valid_params) }
          .to change { Product.count }.by(1)
      end

      it "adds product DTO in memory" do
        product = subject.create(create_params: valid_params)
        found_product_dto = subject.show(id: product.id)

        expect(product.id).to eq(found_product_dto.id)
        expect(product.name).to eq(found_product_dto.name)
      end

      it "returns a ProductResponseDto" do
        product = subject.create(create_params: valid_params)

        expect(product).to be_a(Responses::ProductResponseDto)
      end
    end
  end

  describe "#update" do
    let(:valid_params) do
      Requests::ProductRequestDto.new(
        name: "Bolo doce",
        description: "Um gostoso bole doce"
      )
    end

    let(:invalid_params) do
      Requests::ProductRequestDto.new(
        name: "",
        price: -1
      )
    end

    context "with invalid params" do
      it "raises an ActiveRecord::RecordNotFound error" do
        expect {
          subject.update(id: invalid_id, update_params: valid_params)
        }.to raise_error(
            ActiveRecord::RecordNotFound,
            record_not_found_message
          )
      end

      it "raises ActiveRecord::RecordInvalid" do
        expect { subject.update(id: first_product.id, update_params: invalid_params) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "with valid params" do
      it "updates product on database" do
        subject.update(id: first_product.id, update_params: valid_params)
        first_product.reload

        expect(first_product.name).to eq(valid_params.name)
        expect(first_product.description).to eq(valid_params.description)
      end

      it "updates product DTO in memory" do
        subject.update(id: first_product.id, update_params: valid_params)
        product_dto = subject.show(id: first_product.id)

        expect(product_dto.name).to eq(valid_params.name)
      end

      it "returns a ProductResponseDto" do
        product_dto = subject.update(id: first_product.id, update_params: valid_params)

        expect(product_dto).to be_a(Responses::ProductResponseDto)
      end
    end
  end

  describe "#destroy" do
    context "with invalid params" do
      it "raises an ActiveRecord::RecordNotFound error" do
        expect {
          subject.destroy(id: invalid_id)
        }.to raise_error(
            ActiveRecord::RecordNotFound,
            record_not_found_message
          )
      end
    end

    context "with valid params" do
      let(:last_product) { products.last }

      before do
        subject.destroy(id: last_product.id)
      end

      it "deletes product on database" do
        products = Product.all

        expect(products).not_to include(last_product)
      end

      it "deletes product DTO in memory" do
        subject.send(:initialize_products_dtos)

        products_dtos = subject.instance_variable_get(:@products_dtos)

        expect(products_dtos.map(&:id)).not_to include(last_product.id)
      end
    end
  end
end
