# frozen_string_literal: true

# class for Packages Controller
class PackagesController < ApplicationController
  def index
    @packages = Package.all
  end

  def show
    @package = Package.find(params[:id])

    qrcode = RQRCode::QRCode.new("#{request.host}/pachages/#{@package.id}")

    png = qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: 'black',
      file: nil,
      fill: 'white',
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 120
    )

    @qr_code_url = IO.binwrite("/tmp/package-#{@package.id}-qr-code.png", png.to_s)
  end

  def new
    @orders_list = Order.all.map { |order| [order.title, order.id] }
    @package = Package.new
  end

  def create
    @package = Package.new(package_params)

    if @package.save && create_qr_code(@package)
      redirect_to packages_path, notice: 'package created'
    else
      flash.error = 'Package is not created'
      render 'new'
    end
  end

  def edit
    @package = Package.find(params[:id])
  end

  def update
    @package = Package.find(params[:id])

    if @package.update_attributes(package_params)
      redirect_to packages_path, notice: 'package updated'
    else
      render 'edit'
    end
  end

  def destroy
    @package = Package.find(params[:id])

    if @package.destroy
      redirect_to packages_path, notice: 'package deleted'
    else
      redirect_to packages_path, notice: 'package not deleted'
    end
  end

  private

  def package_params
    params.require(:package).permit(:size, :info, :order_id)
  end

  def create_qr_code(package)
    QrCodeCreator.new(package, request.host).call
  end
end
