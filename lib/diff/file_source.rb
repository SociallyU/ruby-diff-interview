module Diff
  class FileSource
    def self.read(path)
      new(File.read(path))
    end

    attr_reader :content

    def initialize(content)
      @content = content
    end
    

    def diff_with(other_file_source)
      unique_lines - other_file_source.unique_lines
    end

    def unique_lines
      content.split("\n").uniq
    end
  end
end
