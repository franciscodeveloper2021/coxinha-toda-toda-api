# typed: strict
module Responses
  class ProductResponseDto < T::Struct
    const :id, Integer
    const :name, String
    const :description, T.nilable(String)
    const :price, Float
    const :available, T::Boolean
    const :sector_id, T.nilable(Integer)
  end
end
