module ApplicationHelper

    def stripe_url
      connect_client_id = Rails.application.credentials.dig(:stripe, :connect_client_id)
      "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=#{connect_client_id}&scope=read_write"
    end
end
