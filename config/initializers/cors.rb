Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Replace this with your client's URL in production
    resource '*', headers: :any, methods: [:get, :post, :options, :delete, :put, :patch, :head] # Replace this with your client's URL in production
  end
end
