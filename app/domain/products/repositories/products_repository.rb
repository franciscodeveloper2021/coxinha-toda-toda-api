# typed: stricts

module Domain
  module Products
    module Repositories
      class ProductsRepository
        extend T::Sig
        extend T::Helpers

        abstract!

        sig { abstract.params(product: Domain::Products::Entities::Product).void) }
        def create(product); end

        sig { abstract.params(description: String).returns(product: Domain::Products::Entities::Product) }
        def find_by_description(description); end
      end
    end
  end
end