require 'twilio-ruby'

class VoicesController < ApplicationController
  # Before we allow the incoming request to connect, verify
  # that it is a Twilio request
  before_action :load_credentials, only: [:call, :connect]
  before_action :authenticate_twilio_request, only: [:connect]
  skip_before_action :verify_authenticity_token, only: [:connect]

  # Render home page
  def index
    @contact =Contact.new
    render 'index'
  end

  def call
    contact = Contact.new
    contact.sales_phone = '514-248-8681'
    contact.user_phone =  contact_params[:user_phone]

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
      format.html { redirect_to '/calling' }
      format.json { render json: @msg }
    end
  end

  def connect
    response = Twilio::TwiML::VoiceResponse.new do |r|
      r.say('Thanks for using our home room services.
             We are connecting to home room psychologist', voice: 'alice')
      r.dial do |dial|
        dial.number('514-248-8681')
      end
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
    @twilio_sid = 'askjdklsajdlksajdkls'
    @twilio_token = 'dasdksalkdjlasklasjdl'
    @twilio_number = '+29381293'
    @api_host = 'http://65ab6379.ngrok.io'
  end

  def contact_params
    params.require(:contact).permit(:user_phone)
  end
end
