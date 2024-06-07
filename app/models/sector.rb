# typed: true
class Sector < ApplicationRecord
  include ValidationConstants
  include ValidationMethods

  extend T::Sig

  before_validation do
    strip_whitespace_for_attributes
  end

  sig { returns(String) }
  def name
    T.unsafe(self).read_attribute(:name)
  end

  sig { params(value: String).returns(String) }
  def name=(value)
    T.unsafe(self).write_attribute(:name, value)
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
