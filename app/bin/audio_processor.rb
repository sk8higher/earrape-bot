require 'open-uri'

class AudioProcessor
  class << self

    def earrape(input_file_path)
      cmd = ['ffmpeg',
             '-i', "#{input_file_path}",
             '-map', '0:a?',
             '-af', 'equalizer=f=15:width_type=o:w=1:g=15,volume=15',
             '-vn',
             '-c:a', 'libmp3lame',
             'output.mp3']

      system(cmd.join(' '))
    end

    def download_audio(get_file_to_download)
      download_link = "https://api.telegram.org/file/bot#{ENV['TELEGRAM_BOT_TOKEN']}/#{get_file_to_download.file_path}"

      download_audio = URI.open(download_link)
      IO.copy_stream(download_audio, "./in.mp3")
    end

    def delete_files
      File.delete('in.mp3', 'output.mp3')
    end
  end
end