require 'sinatra/base'

require 'scarecrow/version'

module Scarecrow
  def self.run
    # eat yaml file
    hash = {
      "hello" => {
        "method" => "GET",
        "patterns" => [
          {
            "request" => {
            },
            "response" => {
              "body" => "hello, Tom!"
            }
          }
        ]
      }
    }
    
    # validate hash

    # setup definition
    app = Sinatra.new do
      hash.each_key do |path|
        # switch methods from hash[path][method]
        get File.join("/", path) do
          hash[path]["patterns"].each do |pattern|
            conds = []
            if conds.all?
              status pattern["response"]["status"] || 200
              headers pattern["response"]["header"] || {}
              return body pattern["response"]["body"]
            end
          end

          # default
          status 404
          headers({ "X-Scarecrow-Status" => "No such pattern" })
          body "No such pattern"
        end
      end
    end

    # run sinatra
    app.run! port: 7874
  end
end
