# frozen_string_literal: true

# class for Orders Controller
class QrCodesController < ApplicationController
  def index; end

  def scan
    qr_code = QrCode.find_by(base64_string: uploaded_image)

    if qr_code && qr_code.base64_string == uploaded_image
      # return someting to veiw
    end
    # problem we are not sure that user will comeback the same image
    # more relevant usege of new photo
  end

  private

  def uploaded_image
    Base64.encode64(File.read(params[:qr_code][:link].path)).split.join('')
  end

  def qr_codes_params
    params.require(:qr_code).permit(:link)
  end
end
