# typed: stricts

MINIMUM_NAME_LENGTH = T.let(5, Integer)
MAXIMUM_NAME_LENGTH = T.let(50, Integer)

module Domain
  module Products
    module Entities
      class Product
        extend T::Sig

        sig { returns(String) }
        attr_reader :name

        sig { returns(String) }
        attr_reader :description

        sig { returns(Float) }
        attr_reader :price

        sig { returns(Boolean) }
        attr_reader :available

        sig { params(name: String, description: String, price: Float, available: Boolean) }
        def initialize(name, description, price, available)
          @name = T.let(name, String)
          @description = T.let(description, String)
          @price = T.let(price, Float)
          @available = T.let(available, Boolean)
        end

        sig { returns(Boolean) }
        def valid_name?
          name.length >= MINIMUM_NAME_LENGTH && name.length <= MAXIMUM_NAME_LENGTH
        end

        sig { returns(Boolean) }
        def valid_description?
          description.length <= MAXIMUM_DESCRIPTION_LENGTH
        end
      end
    end
  end
end