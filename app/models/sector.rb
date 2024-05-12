# typed: strict
class Sector < ApplicationRecord
  include ValidationConstants

  extend T::Sig

  sig { returns(String) }
  attr_accessor :name

  validates :name,
            presence: true,
            length: { minimum: MINIMUM_NAME_LENGTH, maximum: MAXIMUM_NAME_LENGTH },
            uniqueness: { case_sensitive: false }
end
