class PopularSearch < ApplicationRecord
    validates :query, presence: true
    validates: unique_ips, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
