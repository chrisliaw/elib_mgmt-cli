
require 'toolrack'
require 'teLogger'

module ElibMgmt
  module Cli
    class FileFilter
      include TR::CondUtils

      SPat = "[-,_,.,\\s]"
      SPat2 = "[\(,\),-,_,.,\\s]"
      SPatL = "[\(,-,_,.,\\s]"
      SPatR = "[\),-,_,.,\\s]"

      attr_reader :base_path
      def initialize(base)
        @base_path  = base
        @logger = TeLogger::Tlogger.new(STDOUT)
        @logger.tag = :ffilter
      end

      def filter(name, pattern = "**/**", opts = {})
        if is_empty?(name)
          []
        else

          spec = []
          #if name.include?("*")

          #  found = Dir.glob(File.join(@base_path, pattern)).reject { |f| File.directory?(f) }.select { |v| 

          #    vv = File.basename(v, File.extname(v)).downcase
          #    spec = name.downcase.gsub("*","\\w*")

          #    # beginning
          #    # exact match
          #    vv =~ /^#{spec}\z/i or
          #    # match starting with keyword
          #    vv =~ /^#{spec}[-,.,_,\s]/i or

          #    # middle
          #    vv =~ /[-,.,_,|,\s,\W]#{spec}[-,.,_,|,\s,\W]/i or
          #    #vv =~ /[-,.,_,\s]#{spec}[-,.,_,\s]/i or

          #    # ending
          #    vv =~ /[-,.,_,\s]#{spec}\z/i or
          #    vv =~ /[-,.,_,\s,\[,\(]#{spec}[\],\)]/i 
          #    #vv =~ /[-,.,_,\s]#{spec}\z/i

          #  }

          #elsif name.include?(" ")
          if name.include?(" ")

            pname = name.split(" ").map { |v| "#{v.downcase}" }
            spec = pname.join("[-,.,_,|,\s,\W]")
            
            found = Dir.glob(File.join(@base_path, pattern)).reject { |f| File.directory?(f) }.select { |v| 

              vv = File.basename(v, File.extname(v)).downcase

              # beginning
              # exact match
              vv =~ /^#{spec}\z/i or
              # match starting with keyword
              vv =~ /^#{spec}[-,.,_,\s\W]/i or

              # middle
              vv =~ /[-,.,_,|,\s,\W]#{spec}[-,.,_,|,\s,\W]/i or
              #vv =~ /[-,.,_,\s]#{spec}[-,.,_,\s]/i or
             
              # ending
              vv =~ /[-,.,_,\s]#{spec}\z/i or
              #vv =~ /[-,.,_,\s,\[,\(]#{spec}[\],\)]/i 
              vv =~ /[-,.,_,|,\s,\W]#{spec}[-,.,_,|,\s,\W]\z/i 

            }


          else

            # single word
            found = Dir.glob(File.join(@base_path, pattern)).reject { |f| File.directory?(f) }.select { |v| 

              spec = name.downcase
              vv = File.basename(v, File.extname(v)).downcase

              # beginning
              # exact match
              vv =~ /^#{spec}\z/i or
              # match starting with keyword
              vv =~ /^#{spec}[-,.,_,\s,\W]/i or
              
              # middle
              vv =~ /[-,.,_,|,\s,\W]#{spec}[-,.,_,|,\s,\W]/i or
              #vv =~ /[-,.,_,\s]#{name}[-,.,_,\s]/i or
              
              # ending
              vv =~ /[-,.,_,\s,\W]#{spec}\z/i or
              #vv =~ /[-,.,_,\s,\[,\(]#{name}[\],\)]/i 
              vv =~ /[-,.,_,|,\s,\W]#{spec}[-,.,_,|,\s,\W]\z/i 

            }

          end

          found
        end

      end


    end
  end
end
