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
