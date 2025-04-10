class UpdatePopularSearchesJob < ApplicationJob
  queue_as :low_priority

  def perform
    PopularSearch.upsert_all(
      Search.popular_searches(1.day.ago).map do |search|
        {
          query: search[:query],
          unique_ips: search[:count],
          last_updated_at: Time.current,
        },
      end,
      unique_by: [:query],
    )
  end
end
