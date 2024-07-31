# typed: strict
class ProductsController < ApplicationController
  extend T::Sig

  sig { void }
  def initialize
    super()

    @create_service = T.let(::Domain::Products::Services::CreateProductService.new, Domain::Products::Services::CreateProductService)
  end


  sig { void }
  def create
    product_dto = T.let(@create_service.call(create_product_dto: product_create_params), Responses::ProductResponseDto)

    render json: product_dto, status: :created
  end

  private

  sig { returns(ActionController::Parameters) }
  def permitted_params
    params.require(:product).permit(:name, :description, :price, :available, :sector_id)
  end

  sig { returns(Domain::Products::Dtos::CreateProductRequestDto) }
  def product_create_params
    permitted = permitted_params

    available_value = permitted[:available].nil? ? true : ActiveModel::Type::Boolean.new.cast(permitted[:available])

    Domain::Products::Dtos::CreateProductRequestDto.new(
      name: permitted[:name],
      description: permitted[:description],
      price: permitted[:price].to_f,
      available: available_value,
      sector_id: permitted[:sector_id]&.to_i
    )
  end
end