require 'open-uri'

class Audio
  attr_reader :file_id, :input_file_name, :output_file_name

  def initialize
    @file_id = generate_file_id
    @input_file_name = "in-#{@file_id}.mp3"
    @output_file_name = "out-#{@file_id}.mp3"
  end

  private

  def generate_file_id
    SecureRandom.hex(10)
  end
end