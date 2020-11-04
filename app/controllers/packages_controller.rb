# frozen_string_literal: true

# class for Packages Controller
class PackagesController < ApplicationController
  def index
    @packages = Package.paginate(page: params[:page], per_page: 10)
  end

  def show
    @package = Package.find(params[:id])
  end

  def new
    @orders_list = Order.all.map { |order| [order.title, order.id] }
    @package = Package.new
  end

  def create
    @package = Package.new(package_params)

    if @package.save && create_qr_code(@package)
      redirect_to packages_path, notice: I18n.t('packages.created')
    else
      # flash[:error] = I18n.t('packages.is_not_created')
      render 'new'
    end
  end

  def edit
    @package = Package.find(params[:id])
  end

  def update
    @package = Package.find(params[:id])

    if @package.update_attributes(package_params)
      redirect_to packages_path, notice: I18n.t('packages.updated')
    else
      render 'edit'
    end
  end

  def destroy
    @package = Package.find(params[:id])

    if @package.destroy
      redirect_to packages_path, notice: I18n.t('packages.deleted')
    else
      redirect_to packages_path, notice: I18n.t('packages.is_not_deleted')
    end
  end

  private

  def package_params
    params.require(:package).permit(:size, :info, :order_id, :status)
  end

  def create_qr_code(package)
    QrCodeCreator.new(package, request.host).call
  end
end
