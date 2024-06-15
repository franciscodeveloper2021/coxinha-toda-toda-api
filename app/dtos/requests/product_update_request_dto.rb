# typed: strict
module Requests
  class ProductUpdateRequestDto
    extend T::Sig

    sig { returns(T.nilable(String)) }
    attr_reader :name

    sig { returns(T.nilable(String)) }
    attr_reader :description

    sig { returns(T.nilable(Float)) }
    attr_reader :price

    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :available

    sig { returns(T.nilable(Integer)) }
    attr_reader :sector_id

    sig { params(name: T.nilable(String), description: T.nilable(String), price: T.nilable(Float), available: T.nilable(T::Boolean), sector_id: T.nilable(Integer)).void }
    def initialize(name:, description:, price:, available:, sector_id:)
      @name = T.let(name&.strip, T.nilable(String))
      @description = T.let(description&.strip, T.nilable(String))
      @price = T.let(price, T.nilable(Float))
      @available = T.let(available, T.nilable(T::Boolean))
      @sector_id = T.let(sector_id, T.nilable(Integer))
    end
  end
end
