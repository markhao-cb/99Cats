class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: ["APPROVED", "DENIED", "PENDING"] }
  validate :not_already_rented

  def overlapping_requests
    CatRentalRequest.where(cat_id: self.cat_id)
                    .and("? <= end_date", self.start_date)
                    .and("start_date <= ?", self.end_date)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end

  private

  def not_already_rented
    unless overlapping_approved_requests.empty?
      errors[:cat_id] << "Can't approved because cat is rented"
    end
  end
end
