class Plugin < ActiveRecord::Base

  scope :waiting, -> { where(approved_at: nil) }
  scope :approved, -> { where.not(approved_at: nil) }

  def approve
    self.approved_at = Time.now
    save
  end
end
