# typed: strict
module Requests
  class ProductUpdateRequestDto < T::Struct
    const :name, T.nilable(String)
    const :description, T.nilable(String)
    const :price, T.nilable(Float)
    const :available, T.nilable(T::Boolean)
    const :sector_id, T.nilable(Integer)
  end
end
