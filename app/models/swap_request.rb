class SwapRequest < ApplicationRecord
  validates_presence_of :requesting_user_id, :timeperiod_id
  validate :valid_swap
  validates :timeperiod_id, uniqueness: true
  enum status: { submitted: 0, waiting_approval: 1 }
  belongs_to :organization

  # Define pick-up-shift method
  def pickup_shift(receiving_user_id)
    self.fulfilling_user_id = receiving_user_id
    self.status = 1
    self.save
  end

  def approve_swap
    @timeperiod = Timeperiod.find(self.timeperiod_id)
    @timeperiod.user_id = self.fulfilling_user_id
    @timeperiod.save

    self.status = 2
    self.save
  end

  def valid_swap
    if self.requesting_user_id == self.fulfilling_user_id
      self.errors.add(:ids, "can't match")
    end
  end
end
