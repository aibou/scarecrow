require 'yaml'

require 'scarecrow/version'
require 'scarecrow/server'
require 'scarecrow/validator'
require 'scarecrow/parser'

module Scarecrow
  def self.run
    options = Scarecrow::Parser.parse_option
    options[:file_name] ||= 'scarecrow.yml'
        
    raise FileNotFoundException.new "#{options[:file_name]} is not found." unless File.exists? options[:file_name]
    hash = YAML.load_file options[:file_name]
    # validate hash

    Scarecrow::Server.run hash, options
  end
end
