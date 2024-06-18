# typed: strict
module UseCases
  module Product
    class DestroyProductService
      extend T::Sig

      sig { params(product_repository: ProductRepository).void }
      def initialize(product_repository = ProductRepository.new)
        @repository = product_repository
      end

      sig { params(id: Integer).void }
      def call(id:)
        @repository.destroy(id: id)
      end
    end
  end
end
