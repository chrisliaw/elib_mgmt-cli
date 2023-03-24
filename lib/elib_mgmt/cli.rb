# frozen_string_literal: true

require 'toolrack'
require 'teLogger'

require_relative "cli/version"
require_relative 'cli/file_filter'

module ElibMgmt
  module Cli
    class Error < StandardError; end
    # Your code goes here...

    include TR::CondUtils

    def udebug(msg)
      logger.tdebug(:elib, msg) if is_user_debug_on?
    end
    def self.logger
      if @_logger.nil?
        @_logger = TeLogger::Tlogger.new
      end
      @_logger
    end

    def self.is_user_debug_on?
      val = ENV["ELIBMGMT_DEBUG"]
      (not_empty?(val) and val == "true")
    end

    def self.move_to_int_bin(root, file)
      if @_bin.nil?
        @_bin = File.join(root, ".elBin") 
        FileUtils.mkdir_p(@_bin) if not File.exist?(@_bin)
      end

      FileUtils.mv(file, File.join(@_bin, File.basename(file)))
    end

  end
end
