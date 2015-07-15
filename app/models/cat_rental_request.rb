class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: ["APPROVED", "DENIED", "PENDING"] }
  validate :not_already_rented

  belongs_to(
    :cat,
    class_name: :Cat,
    foreign_key: :cat_id,
    primary_key: :id
  )

  after_initialize { status ||= "PENDING"}

  def overlapping_requests
    CatRentalRequest.where("id != ?", self.id)
                    .where(cat_id: self.cat_id)
                    .where("? <= end_date", self.start_date)
                    .where("start_date <= ?", self.end_date)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end

  def overlapping_pending_requests
    overlapping_requests.where(status:'PENDING')
  end

  def approve!
    transaction do
      self.status = "APPROVED"
      save!
      overlapping_pending_requests.each { |req| req.deny! }
    end
  end

  def deny!
    self.status = "DENIED"
    save
  end

  def pending?
    self.status == "PENDING"
  end

  private

  def not_already_rented
    unless overlapping_approved_requests.empty?
      errors[:cat_id] << "overlapping approvals"
    end
  end
end
