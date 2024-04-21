# frozen_string_literal: true

require_relative 'base_job'

class EarrapeAudioJob < BaseJob
  def perform(audio_id)
    AudioProcessor.earrape(audio_id)
  end
end
