require 'sinatra/base'

module Scarecrow
  module Server
    def self.run hash
      app = Sinatra.new
      hash.each_key do |path|
        # switch methods from hash[path][method]
        app.get File.join("/", path) do
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
      app
    end
  end
end
