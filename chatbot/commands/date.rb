module Chatbot
  module Commands
    class Date < SlackRubyBot::Commands::Base
      command 'date' do |client, data, _match|
        time = Time.new
        client.say(channel: data.channel, text: time.strftime("%Y %B %A %H:%M:%S")  )
      end
    end
  end
end
