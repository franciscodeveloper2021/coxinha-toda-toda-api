# typed: strict
module Requests
  class ProductRequestDto
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

    sig { returns(Integer) }
    attr_reader :sector_id

    sig { params(name: String, description: String, price: Float, available: T::Boolean, sector_id: Integer).void }
    def initialize(name:, description:, price:, available:, sector_id:)
      @name = T.let(name.strip, String)
      @description = T.let(description.strip, String)
      @price = T.let(price, Float)
      @available = T.let(available, T::Boolean)
      @sector_id = T.let(sector_id, Integer)
    end
  end
end
