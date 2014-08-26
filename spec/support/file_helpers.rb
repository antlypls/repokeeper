require 'fileutils'

module SpecHelpers
  module FileHelpers
    def with_file(file_path, content)
      file_path = File.expand_path(file_path)

      before(:all) do
        File.open(file_path, 'w') do |file|
          file.puts content
        end
      end

      after(:all) do
        File.delete(file_path)
      end
    end
  end
end
