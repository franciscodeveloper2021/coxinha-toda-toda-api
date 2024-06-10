# typed: true
class Product < ApplicationRecord
  extend T::Sig

  belongs_to :sector
end
