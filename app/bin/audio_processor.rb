# frozen_string_literal: true
require_relative 'file_name_generator'

class AudioProcessor
  extend FileNameGenerator
  class << self
    def earrape(audio_id)
      cmd = ['ffmpeg',
             '-i', input_file_name(audio_id),
             '-map', '0:a?',
             '-af', 'equalizer=f=15:width_type=o:w=1:g=15,volume=15',
             '-vn',
             '-c:a', 'libmp3lame',
             output_file_name(audio_id)]

      system(cmd.join(' '))
    end

    def download_audio(audio_id, get_file_to_download)
      download_link = "https://api.telegram.org/file/bot#{ENV['TELEGRAM_BOT_TOKEN']}/#{get_file_to_download.file_path}"

      download_audio = URI.open(download_link)
      IO.copy_stream(download_audio, input_file_name(audio_id))
    end

    def delete_files(*files)
      File.delete(*files)
    end
  end
end