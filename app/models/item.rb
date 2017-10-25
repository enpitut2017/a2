class Item < ApplicationRecord

  belongs_to :genre, optional: true
  belongs_to :place, optional: true
  belongs_to :department, optional: true
  
end
