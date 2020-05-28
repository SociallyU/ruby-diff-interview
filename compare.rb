def create_array_from_file(file_name)
    File.read(file_name).split
end

def find_unique_lines(array1, array2)
    new_array = array1.select { |array1_line| 
        array2.none? { |array2_line| array2_line == array1_line} 
    }
    return new_array
end

def print(array)
    array.each { |line| pp line }
end

array1 = create_array_from_file("file1.txt")
array2 = create_array_from_file("file2.txt")
new_array = find_unique_lines(array1, array2)
print(new_array)