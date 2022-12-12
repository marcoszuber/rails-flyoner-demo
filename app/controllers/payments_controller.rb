class PaymentsController < ApplicationController
  #protect_from_forgery with: :null_session
  #protect_from_forgery prepend: true
  skip_before_action :verify_authenticity_token


=begin
  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end
=end

  require 'mercadopago'
  def index
    @payments = Payment.all
  end

  def new
    @booking = Booking.find(params[:booking_id])
    @payment = Payment.new
  end
  def process_payment
    require 'mercadopago'
    sdk = Mercadopago::SDK.new(ENV['MP_TOKEN'])


    payment_data = {
      transaction_amount: params[:transaction_amount].to_f,
      token: params[:token],
      description: params[:description],
      installments: params[:installments].to_i,
      payment_method_id: params[:payment_method_id],
      payer: {
        email: params["payer"]["email"],
        identification: {
          type: params[:identificationType],
          number: params[:identificationNumber]
        },
        first_name: params[:cardholderName]
      }
    }

    payment_response = sdk.payment.create(payment_data)
    payment = payment_response[:response]
    resultado = JSON.parse(payment.to_json)



    #result = JSON.parse(request.raw_post)
    #result = JSON.parse(request.body.string)
    #pp "#############################################"
    #pp result
    #pp "#############################################"

    #pp "*********************************************"
    #pp payment
    #pp "*********************************************"

    pp "+++++++++++++++++++++++++++++++++++++++++++++"
    pp resultado
    pp "+++++++++++++++++++++++++++++++++++++++++++++"
    #pp "-----------------"
    #pp payment_response
    #pp "-----------------"

    #pp "............................................."
    #pp payment_data
    # pp "............................................."

    pp params


    @payment = Payment.new
    @payment.mp_id = resultado["id"].to_i
    @payment.status = resultado["status"]
    @payment.status_detail = resultado["status_detail"]
    if @payment.save
      redirect_to payment_path(@payment)
    else
      redirect_to root_path, alert: "Algo salio mal"
    end

  end

  def show
    @payment = Payment.find(params[:id])
  end

end
