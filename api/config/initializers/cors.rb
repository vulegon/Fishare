Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins Rails.configuration.x.cors.origin

    resource "*",
      headers: :any,
      expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
end
