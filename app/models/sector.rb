# typed: true
class Sector < ApplicationRecord
  include ValidationConstants
  include ValidationMethods

  extend T::Sig

  has_many :products

  before_validation :strip_whitespace_for_attributes

  validates :name,
            presence: true,
            length: { minimum: MINIMUM_NAME_LENGTH, maximum: MAXIMUM_NAME_LENGTH },
            uniqueness: { case_sensitive: false }

  private

  sig { void }
  def strip_whitespace_for_attributes
    strip_whitespace(:name)
  end
end
