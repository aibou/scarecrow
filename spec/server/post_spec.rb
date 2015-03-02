require 'spec_helper'
require 'rack/test'


describe Scarecrow::Server do
  include Rack::Test::Methods
  
  def app
    hash = YAML.load <<EOYAML
"/":
  POST:
    - response:
        body: "Hello, world!"
EOYAML
    Scarecrow::Server.define(hash)
  end
  
  context 'define "POST /" and it returns "Hello, world!"' do
    context 'POST /' do
      subject { post '/'; last_response }
      it { should be_ok }
      its(:body) { should eq 'Hello, world!' }
    end

    context 'GET /' do
      subject { get '/'; last_response }
      it { should be_not_found }
    end
  end
end
