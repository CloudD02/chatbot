module WatsonApi
  class Service
    include HTTParty
    include Singleton
    base_uri 'https://gateway.watsonplatform.net/conversation/api/v1'

    def initialize
      auth = { username: ENV['b9fce86a-fa49-459d-8644-68bd252fc55f'], password: ENV['eVKTa5v4Kkph'] }
      headers = { 'Content-Type' => 'application/json' }
      @version = ENV['4faef49d-970c-44d3-8ab8-aae304463243']
      @options = {}.merge!({ basic_auth: auth, headers: headers })
    end

    def workspaces
      return parse(self.class.get("/workspaces?version=#{@version}", @options), __method__)
    end

    def message(ws_id, msg, conv_id)
      body = { input: { text: msg } }
      body.merge!({ context: { conversation_id: conv_id } }) if conv_id
      @options.merge!({ body: body.to_json })
      $logger.info "WatsonApi :: #{__method__} _> #{@options.inspect}"
      return parse(self.class.post("/workspaces/#{ws_id}/message?version=#{@version}", @options), __method__)
    end

    private

      def parse response, fn
        code = response.code
        $logger.info "WatsonApi :: #{fn} _> (#{code}) #{response.body}"

        result = errors = nil
        if (200..201).include? code
          body = JSON.parse(response.body)
          result = Hashie::Mash.new(body)
        else
          errors = "error!"
        end
        return result
      end
  end
end
