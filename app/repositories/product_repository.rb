# typed: strict
class ProductRepository < Interfaces::RepositoryInterface
  extend T::Sig

  sig { void }
  def initialize
    @products_dtos = T.let([], T::Array[Responses::ProductResponseDto])
    initialize_products_dtos
  end

  private

  sig { returns(T::Array[Responses::ProductResponseDto]) }
  def initialize_products_dtos
    @products_dtos = Product.order(:id).map { |product| Responses::ProductResponseDto.new }
  end
end
