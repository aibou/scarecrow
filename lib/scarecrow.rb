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
              "params" => {
                "name" => "Tom"
              }
            },
            "response" => {
              "body" => "hello, Tom!"
            }
          },
          {
            "request" => {
              "params" => {
                "name" => "Bob"
              }
            },
            "response" => {
              "body" => "Who are you? I don't know such name"
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

            pattern["request"]["params"].each do |name, value|
              conds << params[name].eql?(value)
            end unless pattern["request"]["params"].nil?

            pattern["request"]["headers"].each do |name, value|
              conds << request.env["HTTP_#{name.upcase}"].eql?(value)
            end unless pattern["request"]["headers"].nil?
            
            if conds.all?
              status pattern["response"]["status"] || 200
              headers pattern["response"]["header"] || {}
              return body pattern["response"]["body"] || ""
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
