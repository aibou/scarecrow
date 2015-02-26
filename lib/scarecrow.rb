require 'scarecrow/version'
require 'scarecrow/server'
require 'scarecrow/formatter'
require 'scarecrow/option_parser'

require 'yaml'
require 'hashie'

class Hash
  include Hashie::Extensions::SymbolizeKeys
end

module Scarecrow
  def self.run
    options = Scarecrow::OptionParser.parse_option
    options[:file_name] ||= 'scarecrow.yml'
        
    raise FileNotFoundException.new "#{options[:file_name]} is not found." unless File.exists? options[:file_name]
    hash = YAML.load_file options[:file_name]
    # validate hash

    Scarecrow::Server.define(hash).run! port: options[:port] || 7874
  end
end
