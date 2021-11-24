require 'yaml'

class DbWriter
  def write_file(new_data)
    file_name = "#{File.dirname(__FILE__)}/cars_manager/db/searches.yml"

    #nil unless File.exist?(file_name)

    File.write('file_name', new_data.to_yaml)
  end
end

