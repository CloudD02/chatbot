
module Chatbot
  module Commands
    class W < SlackRubyBot::Commands::Base
      command 'w' do |client, data, _match|
        splited = data.text.split(' ')
        indx = 3
        search = splited[2]
        copy = ''
        while indx < splited.length  do
          search = "#{search} #{splited[indx]}"
          indx +=1
        end
        search = search.capitalize
        copy[0]= search[0]
        indx = 1
        while indx < search.length  do
           if search[indx] == ' '
             copy[indx] = '_'
             copy[indx+1] = search[indx+1].upcase
             indx +=1
          else
              copy[indx] = search[indx].downcase
           end
           indx +=1
        end
        client.say(channel: data.channel, text: "https://es.wikipedia.org/wiki/#{copy}")
      end
    end
  end
end
