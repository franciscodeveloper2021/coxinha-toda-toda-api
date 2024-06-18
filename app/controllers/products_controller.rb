# typed: strict
class ProductsController < ApplicationController
  extend T::Sig

  sig { void }
  def initialize
    super()

    @index_service = T.let(UseCases::Product::IndexProductsService.new, UseCases::Product::IndexProductsService)
    @show_service = T.let(UseCases::Product::ShowProductService.new, UseCases::Product::ShowProductService)
    @create_service = T.let(UseCases::Product::CreateProductService.new, UseCases::Product::CreateProductService)

    @destroy_service = T.let(UseCases::Product::DestroyProductService.new, UseCases::Product::DestroyProductService)
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

  sig { void }
  def create
    product_dto = T.let(@create_service.call(create_params: product_create_params), Responses::ProductResponseDto)

    render json: product_dto, status: :created
  end

  sig { void }
  def update
  end

  sig { void }
  def destroy
    @destroy_service.call(id: params[:id].to_i)

    render json: { message: I18n.t('messages.record_deleted', record: 'Product') }, status: :ok
  end

  private

  sig { returns(Requests::ProductRequestDto) }
  def product_create_params
    permitted_params = params.require(:product).permit(:name, :description, :price, :available, :sector_id)

    available_value = permitted_params[:available].nil? ? true : ActiveModel::Type::Boolean.new.cast(permitted_params[:available])

    Requests::ProductRequestDto.new(
      name: permitted_params[:name],
      description: permitted_params[:description],
      price: permitted_params[:price].to_f,
      available: available_value,
      sector_id: permitted_params[:sector_id]&.to_i
    )
  end
end
