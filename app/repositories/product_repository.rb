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

  private

  sig { returns(T::Array[Responses::ProductResponseDto]) }
  def initialize_products_dtos
    @products_dtos = Product.order(:id).map do |product|
      Responses::ProductResponseDto.new(
        id: T.must(product.id),
        name: product.name,
        description: product.description,
        price: product.price,
        available: product.available,
        sector_id: product.sector_id
      )
    end
  end
end
