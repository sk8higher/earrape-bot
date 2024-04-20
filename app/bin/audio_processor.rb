require 'open-uri'

class AudioProcessor
  attr_reader :input_file_name, :output_file_name
  def initialize
    @file_id = generate_file_id
    @input_file_name = "in-#{@file_id}.mp3"
    @output_file_name = "out-#{@file_id}.mp3"
  end
    def earrape
      cmd = ['ffmpeg',
             '-i', @input_file_name,
             '-map', '0:a?',
             '-af', 'equalizer=f=15:width_type=o:w=1:g=15,volume=15',
             '-vn',
             '-c:a', 'libmp3lame',
             @output_file_name]

      system(cmd.join(' '))
    end

    def download_audio(get_file_to_download)
      download_link = "https://api.telegram.org/file/bot#{ENV['TELEGRAM_BOT_TOKEN']}/#{get_file_to_download.file_path}"

      download_audio = URI.open(download_link)
      IO.copy_stream(download_audio, @input_file_name)
    end

    def delete_files
      File.delete(@input_file_name, @output_file_name)
    end

    private
    def generate_file_id
      SecureRandom.hex(10)
    end
end