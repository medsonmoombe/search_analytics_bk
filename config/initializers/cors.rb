Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*' # or restrict to frontend app domains
  
      resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        expose: ['Authorization'] # allow token headers, if needed
    end
  end
  