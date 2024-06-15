# typed: strict
class ProductRepository < Interfaces::RepositoryInterface
  extend T::Sig

  sig { void }
  def initialize
    @products_dtos = T.let([], T::Array[Responses::ProductResponseDto])
    initialize_products_dtos
  end

  sig { override.returns(T::Array[Responses::ProductResponseDto]) }
  def index
    @products_dtos
  end

  sig { override.params(id: Integer).returns(Responses::ProductResponseDto) }
  def show(id:)
    product_dto = @products_dtos.find { |product_dto| product_dto.id == id }

    raise ActiveRecord::RecordNotFound, I18n.t(
      "activerecord.errors.messages.record_not_found",
      attribute: "Product", key: "id", value: id
    ) if product_dto.nil?

    product_dto
  end

  sig { override.params(create_params: Requests::ProductRequestDto).returns(Responses::ProductResponseDto) }
  def create(create_params:)
    product = build_product(create_params: create_params)
    product.save!

    product_dto = generate_product_dto(product: product)
    add_product_dto_in_memory(product_dto: product_dto)

    product_dto
  end

  sig { override.params(id: Integer, update_params: Requests::ProductUpdateRequestDto).returns(Responses::ProductResponseDto) }
  def update(id:, update_params:)
    show(id: id)

    product = Product.find(id)

    update_attributes = {
      name: update_params.name,
      description: update_params.description,
      price: update_params.price,
      available: update_params.available,
      sector_id: update_params.sector_id
    }.compact

    product.update!(update_attributes)

    product_dto = generate_product_dto(product: product)
    update_product_dto_in_memory(product_dto_id: id, updated_product_dto: product_dto)

    product_dto
  end

  sig { override.params(id: Integer).void }
  def destroy(id:)
    show(id: id)

    Product.delete(id)

    destroy_product_dto_in_memory(product_id: id)
  end

  private

  sig { returns(T::Array[Responses::ProductResponseDto]) }
  def initialize_products_dtos
    @products_dtos = Product.order(:id).map do |product|
      generate_product_dto(product: product)
    end
  end

  sig { params(product: Product).returns(Responses::ProductResponseDto) }
  def generate_product_dto(product:)
    Responses::ProductResponseDto.new(
      id: T.must(product.id),
      name: product.name,
      description: product.description,
      price: product.price,
      available: product.available,
      sector_id: product.sector_id
    )
  end

  sig { params(product_dto: Responses::ProductResponseDto).void }
  def add_product_dto_in_memory(product_dto:)
    @products_dtos << product_dto
  end

  sig { params(product_dto_id: Integer, updated_product_dto: Responses::ProductResponseDto).void }
  def update_product_dto_in_memory(product_dto_id:, updated_product_dto:)
    @products_dtos.map! { |product_dto| product_dto.id == product_dto_id ? updated_product_dto : product_dto }
  end

  sig { params(product_id: Integer).void }
  def destroy_product_dto_in_memory(product_id:)
    @products_dtos.reject! { |product| product.id == product_id }
  end

  sig { params(create_params: Requests::ProductRequestDto).returns(Product) }
  def build_product(create_params:)
    Product.new(
      name: create_params.name,
      description: create_params.description,
      price: create_params.price,
      available: create_params.available,
      sector_id: create_params.sector_id
    )
  end
end
