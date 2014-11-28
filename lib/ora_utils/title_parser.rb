require 'ora_utils/oracle_access'

module OraUtils
  module TitleParser
    include OracleAccess

    def parse_sid
      # Chopping of @ end using length of 16 because max length of SID is 16
      lambda { |sid_name| sid_name.nil? ? default_sid : sid_name[1..17]} 
    end


    def parse_name
      lambda do |name|
        result      = name.scan(/^((@?.*?)?(\@.*?)?)$/)
        groups      = result[0]
        sid         = parse_sid.call(groups.last)
        object_name = groups[1].upcase
        "#{object_name}@#{sid}"
      end
    end


    def map_title_to_sid(*attributes, &proc)
      all_attributes = [[:name, parse_name]] + attributes + [[:sid, parse_sid]]
      map_title_to_attributes(*all_attributes, &proc)
    end

    # Retrieve the default sid on this system
    def default_sid
      oratab = OraUtils::OraTab.new
      oratab.default_sid
    rescue
      ''
    end
  end
end



