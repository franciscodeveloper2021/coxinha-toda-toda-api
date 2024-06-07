# typed: true
class Sector < ApplicationRecord
  include ValidationConstants
  include ValidationMethods

  extend T::Sig

  sig { returns(String) }
  def name
    read_attribute(:name)
  end

  sig { params(value: String).void }
  def name=(value)
    write_attribute(:name, value)
  end

  before_validation do
    strip_whitespace_for_attributes
  end

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
