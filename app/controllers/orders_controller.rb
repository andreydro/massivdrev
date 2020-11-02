# frozen_string_literal: true

# class for Orders Controller
class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to orders_path, notice: 'Order created'
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
      redirect_to orders_path, notice: 'Order updated'
    else
      render 'edit'
    end
  end

  def destroy
    @order = Order.find(params[:id])

    if @order.destroy
      redirect_to orders_path, notice: 'Order deleted'
    else
      redirect_to orders_path, notice: 'Order not deleted'
    end
  end

  private

  def order_params
    params.require(:order).permit(:title, :customer_info, :order_info)
  end
end
