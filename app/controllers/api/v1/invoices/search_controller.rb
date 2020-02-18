class Api::V1::Invoices::SearchController < ApplicationController

  def show
    invoice = Invoice.find_by(invoices_params)

    render json: InvoiceSerializer.new(invoice)
  end

  def index
    if params[:customer_id]
      invoices = Invoice.order_invoices.where(invoices_params)

      render json: InvoiceSerializer.new(invoices)
    elsif
      invoices = Invoice.where(invoices_params)

      render json: InvoiceSerializer.new(invoices)
    end
  end

  private

  def invoices_params
    params.permit(:id, :status, :merchant_id, :customer_id, :created_at, :updated_at)
  end
end
