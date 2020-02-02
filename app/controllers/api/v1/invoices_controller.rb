class Api::V1::InvoicesController < ApplicationController
  def show
    invoice = Invoice.find(params[:id])

    render json: InvoiceSerializer.new(invoice)
  end

  def index
    invoices = Invoice.all

    render json: InvoiceSerializer.new(invoices)
  end
end
