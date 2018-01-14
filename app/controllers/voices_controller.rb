require 'twilio-ruby'
require 'pry'

class VoicesController < ApplicationController
  # Before we allow the incoming request to connect, verify
  # that it is a Twilio request
  before_action :load_credentials, only: [:call, :connect]
  before_action :authenticate_twilio_request, only: [:connect]

  # Render home page
  def index
    render 'index'
  end

  def call
    contact = Contact.new
    contact.user_phone = params[:userPhone]
    contact.sales_phone = params[:salesPhone]

    # Validate contact
    if contact.valid?
      @client = Twilio::REST::Client.new @twilio_sid, @twilio_token
      # Connect an outbound call to the number submitted
      @call = @client.calls.create(
          to: contact.user_phone,
          from: @twilio_number,
          url: "#{@api_host}/connect/#{contact.encoded_sales_phone}" # Fetch instructions from this URL when the call connects
      )
      @msg = { message: 'Phone call incoming!', status: 'ok' }
    else
      @msg = { message: contact.errors.full_messages, status: 'ok' }
    end

    respond_to do |format|
      format.json { render json: @msg }
    end
  end

  def connect
    response = Twilio::TwiML::VoiceResponse.new do |r|
      r.say('Thanks for contacting our sales department. Our '\
        'next available representative will take your call.', voice: 'alice')
      r.dial number: params[:sales_number]
    end


    render xml: response.to_s
  end

  private

  def authenticate_twilio_request
    if twilio_req?
      return true
    else
      response = Twilio::TwiML::VoiceResponse.new do |r|
        r.hangup
      end

      render xml: response.to_s, status: :unauthorized
      false
    end
  end

  def twilio_req?
    # Helper from twilio-ruby to validate requests.
    validator = Twilio::Security::RequestValidator.new(@twilio_token)

    post_vars = params.reject { |k, _| k.downcase == k }
    twilio_signature = request.headers['HTTP_X_TWILIO_SIGNATURE']

    validator.validate(request.url, post_vars, twilio_signature)
  end

  def load_credentials
    @twilio_sid = ENV['TWILIO_ACCOUNT_SID']
    @twilio_token = ENV['TWILIO_AUTH_TOKEN']
    @twilio_number = ENV['TWILIO_NUMBER']
    @api_host = ENV['API_HOST']
  end
end
