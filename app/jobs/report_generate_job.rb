class ReportGenerateJob < ActiveJob::Base
  queue_as :default

  def perform(report)
    report.generate
  end
end
