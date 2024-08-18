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

          raise "Invalid params" if !valid_params?

          already_existent_product = @repository.find_by_description(product.description)

          raise "Product with description #{product.description} already exists" if already_existent_product.present?

          @repository.create(product)
        end

        private

        sig { params(product: Domain::Products::Entities::Product) }
        def valid_params?(product)
          product.valid_name? && product.valid_description?
        end
      end
    end
  end
end