class Toy < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :image
end
