# typed: true
class Sector < ApplicationRecord
  include ValidationConstants

  extend T::Sig

  before_validation :strip_whitespace

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

  def strip_whitespace
    self.name = name.strip if name.present?
  end
end
