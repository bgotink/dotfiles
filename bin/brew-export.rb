require "utils/json"
require "tab"
require "formula"

module BrewPort
  class << self
    def bin
      "brew export"
    end
    
    def export
      case ARGV.named.length
      when 0
        file = nil
      when 1
        file = Pathname.new(ARGV.named.first)
      else
        raise "Usage: #{bin} [options] [file]"
      end
      
      export_info = Hash.new
      Formula.installed.each do |f|
        export = export_formula(f)
        
        if f.tap?
          export_info["#{f.tap}/#{f.name}"] = export
        else
          export_info[f.name] = export
        end
      end
      
      result = Utils::JSON.dump(export_info)
      
      if file.nil?
        puts result
      else
        file.atomic_write result
      end
    end

    def export_formula formula
      tab = Tab.for_formula formula
      result = Hash.new
  
      options = tab.used_options | formula.build.used_options
      result['options'] = options.as_flags
      
      result['build_bottle'] = tab.build_bottle?
      
      result
    end
  end
end

BrewPort.export