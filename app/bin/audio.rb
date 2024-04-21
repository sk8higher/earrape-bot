require 'open-uri'
require_relative 'file_name_generator'

class Audio
  attr_reader :file_id

  def initialize
    @file_id = generate_file_id
  end

  private

  def generate_file_id
    SecureRandom.hex(10)
  end
end