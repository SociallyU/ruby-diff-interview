class CompareFiles
    def initialize(file1, file2)
        @file1 = file1
        @file2 = file2
    end

    def create_arrays_from_files
        @array1 = File.read(@file1).split
        @array2 = File.read(@file2).split
    end

    def find_unique_lines
        create_arrays_from_files
        @new_array = @array1.select { |array1_line| 
            @array2.none? { |array2_line| array2_line == array1_line} 
        }
    end

    def print
        @new_array.each { |line| pp line }
    end
    
end

compare = CompareFiles.new("file1.txt", "file2.txt")
compare.find_unique_lines
compare.print

