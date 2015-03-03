require 'spec_helper'

describe Scarecrow::Formatter do
  describe '.format' do
    context 'when defined only response.body' do
      subject {
        data = YAML.load <<EOYAML
/:
  GET:
    - response: 
        body: Hello, world!
EOYAML
        Scarecrow::Formatter.format data
      }
      it { should eq({'/' => { get: [request: { headers: {}, params: {}}, response: {body: "Hello, world!"} ]} }) }
    end
  end
end
