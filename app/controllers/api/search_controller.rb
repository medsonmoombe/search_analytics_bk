module Api
  class SearchController < ApplicationController
    def track
      query = params[:query] || params.dig(:search, :query)
      Rails.logger.debug "Received query: #{query.inspect}"

      if query.present? && query.length >= 3
        if Search.track_final_search(query, request.remote_ip)
          render json: { message: "Search tracked successfully" }, status: :ok
        else
          render json: { error: "Failed to track search" }, status: :unprocessable_entity
        end
      else
        render json: { error: "Query too short or missing" }, status: :unprocessable_entity
      end
    end

    def analytics
      popular_searches = Search.popular_searches
      render json: popular_searches || []
    end
  end
end