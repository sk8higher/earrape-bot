# frozen_string_literal: true

# This module used to generate input/output filenames using Audio object's file_id.
module FileNameGenerator
  def input_file_name(audio_id)
    "in-#{audio_id}.mp3"
  end

  def output_file_name(audio_id)
    "out-#{audio_id}.mp3"
  end
end
