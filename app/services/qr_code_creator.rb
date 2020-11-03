class QrCodeCreator
  def initialize(package, host)
    @package = package
    @host = host
  end

  def call
    qr_code = QrCode.new(package_id: @package.id)

    qr_code.save && attach_blob(qr_code)
  end

  private

  def attach_blob(qr_code)
    blob = ActiveStorage::Blob.create_after_upload!(
      io: StringIO.new((Base64.decode64(png.to_data_url))),
      filename: "#{@host}/packages/#{@package.id}.png",
      content_type: 'image/png'
    )

    qr_code.image.attach(blob)
  end

  def qr_code_object
    @qr_code_object ||= RQRCode::QRCode.new("#{@host}/packages/#{@package.id}")
  end

  def png
    qr_code_object.as_png(
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
  end
end
