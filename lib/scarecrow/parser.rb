require 'optparse'

module Scarecrow
  module Parser
    def self.parse_option
      options = {}
      opts = OptionParser.new
      
      opts.on '-f', '--file FILE_NAME', 'To load' do |file_name|
        options[:file_name] = file_name
      end

      opts.on '-p', '--port NUMBER', Integer, 'listen port' do |port|
        options[:port] = port
      end
      
      opts.parse!(ARGV)
      options
    end
  end
end
