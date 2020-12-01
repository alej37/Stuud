Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
StripeEvent.signing_secret = Rails.application.credentials.dig(:stripe, :webhook_secret)

# StripeEvent.configure do |config|
#   config.subscribe 'checkout.session.completed' do |event|
#     SubscribeService.call(event)
#   end
end