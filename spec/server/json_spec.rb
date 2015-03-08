require 'spec_helper'
require 'rack/test'


describe Scarecrow::Server do
  include Rack::Test::Methods
  
  def app
    hash = YAML.load <<EOYAML
/:
  GET:
    - response:
        body: 
          name: john
          age: 20
EOYAML
    Scarecrow::Server.define(hash)
  end
  
  context 'define "GET /" and it returns json' do
    describe 'GET /' do
      let(:response) { get '/'; last_response }
      describe 'response' do 
        subject { response }
        it { should be_ok }
        its(:headers) { should include({ 'Content-Type' => 'application/json' }) }
      end

      describe 'response.body' do
        subject { JSON.parse(response.body) }
        its(['name']) { should eq 'john' }
        its(['age']) { should eq 20 }
      end
    end
  end
end
