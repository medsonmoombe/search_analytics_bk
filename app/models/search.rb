class Search < ApplicationRecord
    validates :query, presence: true, length: { minimum:3,  maximum: 255 }

    def self.track_final_search(query, ip)
      return unless query.present?
      clean_query = query.to_s.strip
      create!(query: clean_query, ip_address: ip)
    end

    def self.popular_searches(time_window = 1.day.ago)
        Rails.cache.fetch("popular_searches/#{time_window}", expires_in: 5.minutes) do
         where('created_at >= ?', time_window)
        .group(:query)
        .select('query, COUNT(DISTINCT ip_address) as unique_ips')
        .order('unique_ips DESC')
        .limit(10)
        .map { |s| { query: s.query, count: s.unique_ips } }
      end
    end
end