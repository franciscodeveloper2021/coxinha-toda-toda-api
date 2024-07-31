module Domain
  module Products
    module Services
      class CreateProductService
        extend T::Sig

        sig { params(product_repository: Domain::Products::Repositories::ProductRepository).void }
        def initialize(product_repository = Domain::Products::Repositories::ProductRepository.new)
          @repository = product_repository
        end

        sig { params(create_product_dto: Domain::Products::Dtos::CreateProductRequestDto).void }
        def call(create_product_dto)
          product = Domain::Products::Entities::Product.new(create_product_dto.name, create_product_dto.description, create_product_dto.price, create_product_dto.available)

          @repository.create(product)
        end
      end
    end
  end
end