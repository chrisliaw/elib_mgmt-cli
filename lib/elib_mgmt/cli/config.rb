
require 'yaml'
require 'toolrack'

module ElibMgmt
  module Cli
    class ConfigError < StandardError; end
    class Config
      include TR::CondUtils

      def self.load(conf)
        raise ConfigError, "Config file given is null" if is_empty?(conf) 
        raise ConfigError, "Config file '#{conf}' not found" if not File.exist?(conf)

        Config.new(YAML.load(File.read(conf)))

      end

      def initialize(existing = {  })
        @rec = existing || {  }
      end

      def matching_spec(outdir, spec)
        @rec[:sort_spec]
      end

    end
  end
end
