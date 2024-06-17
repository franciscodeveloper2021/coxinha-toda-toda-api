# typed: strict
class ProductsController < ApplicationController
  extend T::Sig

  sig { void }
  def initialize
    super()

    @index_service = T.let(UseCases::Product::IndexProductsService.new, UseCases::Product::IndexProductsService)
  end

  sig { void }
  def index
    products_dtos = T.let(@index_service.call, T::Array[Responses::ProductResponseDto])

    render json: products_dtos, status: :ok
  end
end
