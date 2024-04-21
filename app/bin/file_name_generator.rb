# frozen_string_literal: true

module FileNameGenerator
  def input_file_name(audio_id)
    "in-#{audio_id}.mp3"
  end

  def output_file_name(audio_id)
    "out-#{audio_id}.mp3"
  end
end
