# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, :description, presence:true
  validates :sex, inclusion: { in: ['F', 'M'] }

  has_many(
    :rental_requests,
    class_name: :CatRentalRequest,
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy
  )
end
