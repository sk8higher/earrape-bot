require 'telegram/bot'
require_relative 'audio_processor'
class Bot
  def initialize
    token = ENV['TELEGRAM_BOT_TOKEN']

    Telegram::Bot::Client.run(token) do |bot|
      bot.listen do |message|
        case message.text
        when '/start'
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name} welcome to Earrape Bot. Send audio to make it loud.")
        else
          if message.audio
            bot.api.send_message(chat_id: message.chat.id, text: 'Processing audio, wait...')

            get_file_to_download = bot.api.getFile(file_id: message.audio.file_id)

            audio_processor = AudioProcessor.new
            audio_processor.download_audio(get_file_to_download)
            audio_processor.earrape

            bot.api.send_audio(chat_id: message.chat.id, audio: Faraday::UploadIO.new(audio_processor.output_file_name, 'audio/mp3'))

            audio_processor.delete_files
          end
        end
      end
    end
  end
end
