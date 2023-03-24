
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

          defOpts = {
            mode: :relax
          }

          sOpts = defOpts.merge(opts)

          spec = []
          if name.include?("*")

            found = Dir.glob(File.join(@base_path, pattern)).reject { |f| File.directory?(f) }.select { |v| 

              vv = File.basename(v)
              spec = name.gsub("*","\\w*")
              case sOpts[:mode]
              when :strict
                #@logger.odebug "Word with '*' '#{name}' strict mode"
                vv =~ /[\(,-,_,.,\s]#{spec}[\),-,_,.,\s]/i or
                vv =~ /^#{spec}#{SPat}/i or
                vv =~ /#{SPat}#{spec}\z/i 
              else
                #@logger.odebug "Word with '*' '#{name}' relax mode"
                vv =~ /#{SPat}#{spec}#{SPat}/i or
                  vv =~ /#{SPat}#{spec}/i or
                  vv =~ /#{spec}#{SPat}/i
              end

            }

          elsif name.include?(" ")

            pname = name.split(" ").map { |v| "#{v}" }
            spec = pname.join(SPat)
            
            found = Dir.glob(File.join(@base_path, pattern)).reject { |f| File.directory?(f) }.select { |v| 

              vv = File.basename(v)
              case sOpts[:mode]
              when :strict
                #@logger.odebug "Word with space '#{name}' strict mode"
                vv =~ /#{SPat}#{spec}#{SPat}/i or
                  vv =~ /^#{spec}#{SPat}/i or
                  vv =~ /#{SPat}#{spec}\z/i 
              else
                #@logger.odebug "Word with space '#{name}' relax mode"
                vv =~ /#{SPat}#{spec}#{SPat}/i or
                  vv =~ /#{SPat}#{spec}/i or
                  vv =~ /#{spec}#{SPat}/i
              end

            }


          else

            # single word
            found = Dir.glob(File.join(@base_path, pattern)).reject { |f| File.directory?(f) }.select { |v| 

              vv = File.basename(v)
              case sOpts[:mode]
              when :strict
                #@logger.debug "Single word '#{name}' strict mode"
                  vv =~ /^#{name}[-,_,.,\s]/i or vv =~ /[-,_,.,\s]#{name}[-,_,.,\s]/i or vv =~ /[-,_,.,\s]#{name}\z/i 
              else
                #@logger.debug "Single word '#{name}' relex mode"
                vv =~ /[-,_,.,\s]#{name}[-,_,.,\s]/i or
                  vv =~ /[-,_,.,\s]#{name}/i or
                  vv =~ /#{name}[-,_,.,\s]/i
              end

            }

          end

          #if name.include?(" ")

          #  ["-","_","."].each do |c|
          #    key = name.downcase.split(" ")
          #    res = Dir.glob(File.join(@base_path, pattern)).reject { |f| File.directory?(f) }.select { |v| 
          #      n = File.basename(v, File.extname(v)).downcase
          #      (key - n.split(" ").map(&:strip)).empty? || (key - n.split("-").map(&:strip)).empty? || (key - n.split("_").map(&:strip)).empty? || (key - n.split(".").map(&:strip)).empty?
          #    }
          #    found += res
          #  end

          #else

          #  key = name.downcase
          #  res = Dir.glob(File.join(@base_path, pattern)).reject { |f| File.directory?(f) }.select { |v| 
          #    n = File.basename(v, File.extname(v)).downcase
          #    n.split(" ").map(&:strip).include?(key) || n.split("-").map(&:strip).include?(key) || n.split("_").map(&:strip).include?(key) || n.split(".").map(&:strip).include?(key)
          #  }
          #  found += res

          #end

          #found.uniq
          found
        end

      end

      private
      def const_pattern(val)
        [
          "#{SPat}#{val}#{SPat}",
          "#{SPat}#{val}",
          "#{val}#{SPat}"
        ]
      end


    end
  end
end
