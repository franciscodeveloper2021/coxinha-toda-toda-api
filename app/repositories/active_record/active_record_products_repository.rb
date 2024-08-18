module Repositories
  module ActiveRecord
    class ActiveRecordProductsRepository < Domain::Products::Repositories::ProductsRepository
      extend T::Sig

      sig { override.params(product: Domain::Products::Entities::Product) }
      def create(product)
        Product.save(
          name: product.name,
          description: product.description,
          price: product.price,
          available: product.available,
        )
      end

      sig { override.params(id: Integer).returns(product: Domain::Products::Entities::Product) }
      def find_by_id(description)
        Product.find_by(description:)
      end
    end
  end
end