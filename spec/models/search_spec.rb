require 'rails_helper'

RSpec.describe Search, type: :model do
    describe 'popular_searches' do
        let!(:ip1) {' 192.168.1.1 '}
        let!(:ip2) {'192.168.1.216'}
        let!(:old_search) { create(:search, query: 'old post', ip_address: ip1, created_at: 2.days.ago) }

        before do
            # Recent searches from same IP (should count as 1)
            3.times { create(:search, query: 'ruby', ip_address: ip1) }
            2.times { create(:search, query: 'rails', ip_address: ip1) }

            # Recent searches from different IP (should count as 1)
            2.times { create(:search, query: 'ruby', ip_address: ip2) }
            3.times { create(:search, query: 'javascript', ip_address: ip2) }
        end
        it 'counts unique ips per query' do
           results = Search.popular_searches
           ruby_results = results.find { |r| r[:query] == 'ruby' }
           rails_results = results.find { |r| r[:query] == 'rails' }

           expect(ruby_results[:count]).to eq(2) 
           expect(rails_results[:count]).to eq(1) 
        end 

        it 'limits to 10 results' do
            15.times { |i| create(:search, query: "query#{i}", ip_address: "ip#{i}") }
            expect(Search.popular_searches.count).to eq(10)
          end

        it 'ignores searches older than time window' do
            results = Search.popular_searches
            old_search_results = results.find { |r| r[:query] == 'old post' }
            expect(old_search_results).to be_nil 
        end

        it 'orders by most unique IPs first' do
            results = Search.popular_searches
            expect(results[0][:query]).to eq('ruby') 
            expect(results[1][:query]).to eq('javascript') 
            expect(results[2][:query]).to eq('rails') 
        end

        it 'uses caching' do
            expect(Rails.cache).to receive(:fetch).with(/popular_searches/, expires_in: 5.minutes)
            Search.popular_searches
        end
    end
end