require 'yaml'

class DbReader
  def read_file(file_name)

    YAML.load_file(file_name)
  end
end
