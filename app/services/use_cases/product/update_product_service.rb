# typed: strict
module UseCases
  module Product
    class UpdateProductService
      extend T::Sig

      sig { params(product_repository: ProductRepository).void }
      def initialize(product_repository = ProductRepository.new)
        @repository = product_repository
      end

      sig { params(id: Integer, update_params: Requests::ProductUpdateRequestDto).returns(Responses::ProductResponseDto) }
      def call(id:, update_params:)
        @repository.update(id: id, update_params: update_params)
      end
    end
  end
end
