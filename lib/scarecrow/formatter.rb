module Scarecrow
  module Formatter
    def self.format data
      formatted = {}
      
      data.each do |key, value|
        path = File.join('/', key.gsub(/\./, '/'))
        formatted[path] = {}
        value.each do |method, patterns|
          patterns.map! do |pattern|
            pattern.symbolize_keys!
            pattern[:request] ||= {}
            pattern[:request][:params] ||= {}
            pattern[:request][:headers] ||= {}
            pattern[:response] ||= {}
            pattern
          end
          formatted[path][method.downcase.to_sym] = patterns
        end
      end
      formatted
    end
  end
end
