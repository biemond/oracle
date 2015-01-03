# encoding: UTF-8
newproperty(:default_tablespace_extent_management) do
  include EasyType

  desc 'Use this setting to specify the extent management for tablespaces.'

  newvalues(:local, :dictionary)  

  #
  # TODO: Add the other options of local management
  # 

  to_translate_to_resource do | raw_resource|
    # raw_resource.column_data('default_tablespace_extent_management')
  end

   on_apply do | command_builder | 
   "extent management #{value}"
  end
  
end