class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :send_email, :destroy]
  layout 'invoice', only: :show

  def index
    @invoices = Invoice.where(user: current_user)
  end

  def show
  end

  def set_client
    @clients = Client.all
  end

  def new
    @client = Client.find(params[:client])
    @events = @client.events
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(invoices_params)
    @invoice.client = Client.find(params[:invoice][:client_id])
    @invoice.event = Event.find (params[:invoice][:event_id])
    @invoice.user = current_user
    if @invoice.save
      redirect_to invoices_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @invoice.client = Client.find(params[:invoice][:client_id])
    @invoice.event = Event.find(params[:invoice][:event_id])
    @invoice.user = current_user
    if @invoice.update(invoices_params)
      redirect_to invoice_path(@invoice)
    else
      render :edit
    end
  end

  def send_email
    mail = EventMailer.with(invoice: @invoice).invoice_pdf(@invoice.id)
    mail.deliver_later
    redirect_to request.referrer
    flash[:notice] = "Email sent"
  end

  def destroy
    @client = @invoice.client
    @event = @invoice.event
    @invoice.destroy
    redirect_to invoices_path(@invoice)
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoices_params
    params.require(:invoice).permit(:event_id, :client_id, :user)
  end

  def event_params
    params.require(:event).permit(:event, :client, :user)
  end
end
