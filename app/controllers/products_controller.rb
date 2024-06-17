# typed: strict
class ProductsController < ApplicationController
  extend T::Sig

  sig { void }
  def initialize
    super()

    @index_service = T.let(UseCases::Product::IndexProductsService.new, UseCases::Product::IndexProductsService)
    @show_service = T.let(UseCases::Product::ShowProductService.new, UseCases::Product::ShowProductService)
  end

  sig { void }
  def index
    products_dtos = T.let(@index_service.call, T::Array[Responses::ProductResponseDto])

    render json: products_dtos, status: :ok
  end

  sig { void }
  def show
    product_dto = T.let(@show_service.call(id: params[:id].to_i), Responses::ProductResponseDto)

    render json: product_dto, status: :ok
  end
end
