# frozen_string_literal: true

# class for Orders Controller
class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to orders_path, notice: I18n.t('orders.created')
    else
      render 'new'
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])

    if @order.update_attributes(order_params)
      redirect_to orders_path, notice: I18n.t('orders.updated')
    else
      render 'edit'
    end
  end

  def destroy
    @order = Order.find(params[:id])

    if @order.destroy
      redirect_to orders_path, notice: I18n.t('orders.deleted')
    else
      redirect_to orders_path, notice: I18n.t('orders.is_not_deleted')
    end
  end

  private

  def order_params
    params.require(:order).permit(:title, :customer_info, :order_info,
                                  packages_attributes: %i[id size info order_id _destroy])
  end
end
