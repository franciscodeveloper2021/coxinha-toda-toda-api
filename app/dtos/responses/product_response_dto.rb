# typed: strict
module Responses
  class ProductResponseDto
    extend T::Sig

    sig { returns(Integer) }
    attr_reader :id

    sig { returns(String) }
    attr_reader :name

    sig { returns(String) }
    attr_reader :description

    sig { returns(Float) }
    attr_reader :price

    sig { returns(T::Boolean) }
    attr_reader :available

    sig { returns(T.nilable(Integer)) }
    attr_reader :sector_id

    sig { params(id: Integer, name: String, description: String, price: Float, available: T::Boolean, sector_id: T.nilable(Integer)).void }
    def initialize(id:, name:, description:, price:, available:, sector_id:)
      @id = T.let(id, Integer)
      @name = T.let(name.strip, String)
      @description = T.let(description.strip, String)
      @price = T.let(price, Float)
      @available = T.let(available, T::Boolean)
      @sector_id = T.let(sector_id, T.nilable(Integer))
    end
  end
end
