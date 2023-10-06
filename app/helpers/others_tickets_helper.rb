module OthersTicketsHelper

  def generate_confirmation_number()
    SecureRandom.urlsafe_base64(10)
  end
end
