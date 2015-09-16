Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.max_attempts = 5

ChargeInterestJob.set(wait_until: Date.tomorrow.midnight).perform_later if Delayed::Job.where("handler like '%job_class: ChargeInterestJob%' and run_at > ?", Time.now).blank?