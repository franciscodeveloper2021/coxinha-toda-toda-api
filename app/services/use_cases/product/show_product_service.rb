# typed: strict
module UseCases
  module Product
    class ShowProductService
      extend T::Sig

      sig { params(product_repository: ProductRepository).void }
      def initialize(product_repository = ProductRepository.new)
        @repository = product_repository
      end

      sig { params(id: Integer).returns(Responses::ProductResponseDto) }
      def call(id:)
        @repository.show(id: id)
      end
    end
  end
end
