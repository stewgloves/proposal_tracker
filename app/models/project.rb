# app/models/project.rb

class Project < ApplicationRecord
  has_paper_trail

  has_many :proposals, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
