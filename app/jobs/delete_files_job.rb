# frozen_string_literal: true
require_relative 'base_job'

class DeleteFilesJob < BaseJob
  def perform(audio_file_id)
    AudioProcessor.delete_files(AudioProcessor.input_file_name(audio_file_id), AudioProcessor.output_file_name(audio_file_id))
  end
end
