# typed: strict
module UseCases
  module Product
    class IndexProductsService
      extend T::Sig

      sig { params(product_repository: ProductRepository).void }
      def initialize(product_repository = ProductRepository.new)
        @repository = product_repository
      end

      sig { returns(T::Array[Responses::ProductResponseDto]) }
      def call
        @repository.index
      end
    end
  end
end
