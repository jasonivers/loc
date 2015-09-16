class ChargeInterestJob < ActiveJob::Base
  queue_as :default
  after_perform {self.class.set(wait_until: Date.tomorrow.midnight).perform_later if Delayed::Job.where("handler like '%job_class: ChargeInterestJob%' and run_at > ?", Time.now).blank?}

  def perform(*args)
    Account.where("payment_due = ?", Time.now.utc.to_date).each {|account| account.calculate_interest}
  end
end
