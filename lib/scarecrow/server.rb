require 'sinatra/base'

module Scarecrow
  module Server
    def self.define hash
      app = Sinatra.new
      formatted = Scarecrow::Formatter.format hash
      formatted.each do |path, data|
        data.each do |method, patterns|
          app.send(method, path) do
            patterns.each do |pattern|
              conds = []

              pattern[:request][:params].each do |name, value|
                conds.push params[name] === value
              end

              pattern[:request][:headers].each do |name, value|
                conds.push request.env["HTTP_#{name.upcase}"] === value
              end
              
              if conds.all?
                status pattern[:response][:status] || 200
                headers pattern[:response][:headers] || {}
                body pattern[:response][:body] || ''
                return
              end
            end
            
            # default
            status 404
            headers({ 'X-Scarecrow-Status' => 'No such pattern' })
            body 'No such pattern'
          end
        end
      end
      app
    end
  end
end
