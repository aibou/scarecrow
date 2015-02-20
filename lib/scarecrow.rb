require 'sinatra/base'

require 'scarecrow/version'

module Scarecrow
  def self.run
    # eat yaml file
    app = Sinatra.new do
      get '/' do
        'hello, world'
      end
    end

    # setup definition
    # run sinatra
    app.run! port: 7874
  end
end
