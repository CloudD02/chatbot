require 'sinatra/base'

module ChatbotRuby
  class Web < Sinatra::Base
    get '/' do
      'Hi, Miss Ivot is up 😌!'
    end
  end
end
