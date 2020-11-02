class QrCodeCreator
  def initialize(package, host)
    @package = package
    @host = host
  end

  def call
    qr_code = QrCode.new(code: qr_code_string, package_id: @package.id)

    if qr_code.save
      create_temp_file
      true
    else
      false
    end
  end

  private

  def qr_code_string
    result = ''

    qr_code_object.qrcode.modules.each do |row|
      row.each do |col|
        result << (col ? 'X' : 'O')
      end

      result << "\n"
    end

    result
  end

  def qr_code_object
    @qr_code_object ||= RQRCode::QRCode.new("#{@host}/pachages/#{@package.id}")
  end

  def create_temp_file
    File.open("public/qr_codes/qr-code-for-package-#{@package.id}.png", 'wb') do |output|
      output.write png
    end
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
