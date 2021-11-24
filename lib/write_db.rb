require 'yaml'

class DbWriter
  def write_file(searches)

    File.open('C:\Users\Vetal\RubymineProjects\cars_manager\db\searches.yml', 'w') do |file|
      file.write(searches.to_yaml)
    end
  end
end
