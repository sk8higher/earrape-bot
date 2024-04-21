# frozen_string_literal: true

require_relative 'base_job'

class DownloadAudioJob < BaseJob
  def perform(audio_file_id, get_file_to_download)
    AudioProcessor.download_audio(audio_file_id, get_file_to_download)
  end
end
