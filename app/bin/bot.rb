require 'telegram/bot'
require_relative 'audio'
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

            audio = Audio.new
            AudioProcessor.download_audio(audio, get_file_to_download)
            AudioProcessor.earrape(audio)

            bot.api.send_audio(chat_id: message.chat.id, audio: Faraday::UploadIO.new(audio.output_file_name, 'audio/mp3'))

            AudioProcessor.delete_files(audio)
          end
        end
      end
    end
  end
end
