class Api::V1::Invoices::SearchController < ApplicationController

  def show
    invoice = Invoice.find_by(request.query_parameters)

    render json: InvoiceSerializer.new(invoice)
  end

  def index
    if params[:customer_id]
      invoices = Invoice.order_invoices.where(request.query_parameters)

      render json: InvoiceSerializer.new(invoices)
    elsif
      invoices = Invoice.where(request.query_parameters)

      render json: InvoiceSerializer.new(invoices)
    end
  end
end
