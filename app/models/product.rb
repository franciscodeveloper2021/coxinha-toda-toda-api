# typed: true
class Product < ApplicationRecord
  include ValidationMethods

  extend T::Sig

  belongs_to :sector

  before_validation :strip_whitespace_for_attributes

  private

  sig { void }
  def strip_whitespace_for_attributes
    strip_whitespace(:photo_url)
    strip_whitespace(:name)
    strip_whitespace(:description)
  end
end
