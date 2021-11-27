require 'yaml'

class DbAccer
  def read_file(file_name)

    YAML.load_file(file_name)
  end

  def write_file(statistic, file)
    File.open(file, 'w') { |f| f.write(statistic.to_yaml) }
  end
end
