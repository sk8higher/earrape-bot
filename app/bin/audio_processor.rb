# frozen_string_literal: true

class AudioProcessor
  class << self
    def earrape(audio_obj)
      cmd = ['ffmpeg',
             '-i', audio_obj.input_file_name,
             '-map', '0:a?',
             '-af', 'equalizer=f=15:width_type=o:w=1:g=15,volume=15',
             '-vn',
             '-c:a', 'libmp3lame',
             audio_obj.output_file_name]

      system(cmd.join(' '))
    end

    def download_audio(audio_obj, get_file_to_download)
      download_link = "https://api.telegram.org/file/bot#{ENV['TELEGRAM_BOT_TOKEN']}/#{get_file_to_download.file_path}"

      download_audio = URI.open(download_link)
      IO.copy_stream(download_audio, audio_obj.input_file_name)
    end

    def delete_files(audio_obj)
      File.delete(audio_obj.input_file_name, audio_obj.output_file_name)
    end
  end
end