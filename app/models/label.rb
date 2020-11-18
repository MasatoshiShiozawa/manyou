class Label < ApplicationRecord
  has_many :tasklabels, dependent: :destroy
  has_many :tasks, through: :tasklabels
end
