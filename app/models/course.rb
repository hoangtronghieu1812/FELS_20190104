class Course < ApplicationRecord
  has_many :words
  has_many :lessons, dependent: :destroy
end
