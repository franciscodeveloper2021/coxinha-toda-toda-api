# typed: strict
module UseCases
  module Product
    class CreateProductService
      extend T::Sig

      sig { params(product_repository: ProductRepository).void }
      def initialize(product_repository = ProductRepository.new)
        @repository = product_repository
      end

      sig { params(create_params: Requests::ProductRequestDto).returns(Responses::ProductResponseDto) }
      def call(create_params:)
        @repository.create(create_params: create_params)
      end
    end
  end
end
