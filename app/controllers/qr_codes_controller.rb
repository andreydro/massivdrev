# frozen_string_literal: true

# class for Orders Controller
class QrCodesController < ApplicationController
  def index; end

  def scan
    
    binding.pry
    
  end

  private

  def qr_codes_params
    params.require(:qr_code).permit(:link)
  end
end
