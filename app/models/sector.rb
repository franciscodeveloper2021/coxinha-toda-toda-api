# typed: true
class Sector < ApplicationRecord
  include ValidationConstants

  extend T::Sig

  sig { returns(String) }
  def name
    super
  end

  sig { params(value: String).returns(String) }
  def name=(value)
    super(value)
  end

  validates :name,
            presence: true,
            length: { minimum: MINIMUM_NAME_LENGTH, maximum: MAXIMUM_NAME_LENGTH },
            uniqueness: { case_sensitive: false }
end
