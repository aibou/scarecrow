module Scarecrow
  module Formatter
    def self.format! data
      formatted = {}
      
      data.each do |key, value|
        path = File.join('/', key.gsub(/\./, '/'))
        formatted[path] = value.symbolize_keys!
      end
      
      formatted.each_key do |path|
        formatted[path][:method] = formatted[path][:method].downcase.to_sym
        formatted[path][:patterns].map! do |pattern|
          pattern[:request] ||= {}
          pattern[:request][:params] ||= {}
          pattern[:request][:headers] ||= {}
          pattern[:response] ||= {}
          pattern
        end
      end
      formatted
    end
  end
end
