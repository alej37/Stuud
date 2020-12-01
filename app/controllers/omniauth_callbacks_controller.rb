class OmniauthCallbacksController < ApplicationController
  def stripe_connect
    stripe = request.env['omniauth.auth']
    current_user.provider = stripe.provider
    current_user.uid = stripe.uid
    current_user.access_code = stripe.credentials.token
    current_user.publishable_key = stripe.info.stripe_publishable_key
    current_user.save
    redirect_to edit_user_path(current_user), notice: "Successfully connected!"
  end

  def failure
    redirect_to root_path
  end
end