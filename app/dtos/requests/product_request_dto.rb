# typed: strict
module Requests
  class ProductRequestDto < T::Struct
    const :name, String
    const :description, T.nilable(String)
    const :price, Float
    const :available, T::Boolean
    const :sector_id, T.nilable(Integer)
  end
end

