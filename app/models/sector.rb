class Sector < ApplicationRecord
  MINIMUM_NAME_LENGTH = 5
  MAXIMUM_NAME_LENGTH = 50

  validates :name,
            presence: true,
            length: { minimum: MINIMUM_NAME_LENGTH, maximum: MAXIMUM_NAME_LENGTH },
            uniqueness: { case_sensitive: false }
end
