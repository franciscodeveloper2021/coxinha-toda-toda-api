# typed: strict

module Domain
  module Products
    module Dtos
      class CreateProductRequestDto < T::Struct
        const :name, String
        const :description, T.nilable(String)
        const :price, Float
        const :available, T::Boolean
      end
    end
  end
end