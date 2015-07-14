class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, :description, presence:true
end
