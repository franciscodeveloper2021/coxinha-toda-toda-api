# typed: true
class Product < ApplicationRecord
  include ValidationConstants
  include ValidationMethods

  extend T::Sig

  belongs_to :sector

  before_validation :strip_whitespace_for_attributes

  validates :name,
            presence: true,
            length: { maximum: MAXIMUM_NAME_LENGTH },
            uniqueness: { case_sensitive: false }

  validates :description,
            length: { maximum: MAXIMUM_DESCRIPTION_LENGTH }

  validates :price,
            presence: true

  validates :available,
            inclusion: { in: [true, false] }
  private

  sig { void }
  def strip_whitespace_for_attributes
    strip_whitespace(:name)
    strip_whitespace(:description)
  end
end
