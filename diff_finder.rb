class DiffFinder

    ## Finds diffs between two files in case of an unsorted file. 
    ## O(N^2) because txt2 must be iterated through each atttempt.
    ##
    ## This method creates a new array to hold the diffs, then iterates
    ## through the first given file. For each line of the first file,
    ## the method looks through the every line of the second file to see
    ## if it finds a match. If it is not found, then it pushes the line
    ## into the diff array. Finally, A new file is created with all diffs
    ## found in the first file

    def self.find_unsorted_diffs(txt1, txt2, new_file_name)
        diff_arr = []
        File.foreach(txt1) { |line| !File.read(txt2).include?(line) ? diff_arr.push(line) : nil }
        File.write(new_file_name, diff_arr.join(""))
    end

    ## Finds diffs between two files in case of a sorted file.
    ## Close to O(N) because each file must be iterated through once
    ##
    ## NOTE: the example texts given are not sorted. Therefore, this method
    ## will not work on those files. 

    def self.find_sorted_diffs(txt1, txt2, new_file_name)
        first_file_array = File.read(txt1).split("\n")
        second_file_array = File.read(txt2).split("\n")
        diffs = self.compare_sorted_arrays(first_file_array, second_file_array)
        File.write(new_file_name, diffs)
    end

    ## Finds diffs between two files that are unsorted BY sorting
    ## Between O(N log N) and O(N^2) - Ruby defaults to using quicksort,
    ## which is O(N log N) in most cases, then the 
    ## algorithm must iterate through each array once more
    ## 
    ## This method differs from self.find_sorted_diffs only in that
    ## it first sorts the file arrays. It is a moderate time complexity
    ## improvement over self.find_unsorted_diffs
    ##

    def self.find_unsorted_diffs_with_sort(txt1, txt2, new_file_name)
        first_file_array = File.read(txt1).split("\n").sort
        second_file_array = File.read(txt2).split("\n").sort
        diffs = self.compare_sorted_arrays(first_file_array, second_file_array)
        File.write(new_file_name, diffs)
    end

    ## This method compares two sorted arrays to find their diffs.
    ## Close to O(N) because each file must be iterated through once
    ## 
    ## Several variables are declared to start. A diff_arr to hold the
    ## lines contained in the first file but not in the second, two arrays
    ## to hold the contents of the files, and two iterators to keep
    ## track of the location within the files. We then iterate through
    ## each line of the first file. If the line is found in the second
    ## file, we advance both iterators. If the line is found in the first
    ## file, and the line is considered greater than the second file,
    ## we add this to the diff_arr and advance the first file. Otherwise, 
    ## we continue to advance location within the second file until we find
    ## a value equal to or greater than the current line in the first file.

    def self.compare_sorted_arrays(first_file_array, second_file_array)
        diff_arr = []
        i = 0
        j = 0
        while i < first_file_array.length
            if second_file_array[j] == nil
                diff_arr.push(first_file_array.slice(i, first_file_array.length-i))
                i = first_file_array.length
            elsif first_file_array[i] == second_file_array[j]
                i += 1
                j += 1
            elsif first_file_array[i] < second_file_array[j]
                diff_arr.push(first_file_array[i])
                i += 1
            else
                j += 1
            end
        end
        return diff_arr.join("\n")
    end

    ## O(N) because each txt file is iterated through only once. By far the most
    ## efficient solution
    ##
    ## This solution takes a different approach compares to the above solutions.
    ## Here, a memo hash is declared. Each line of thte second txt file is 
    ## entered as a key in that hash. Then, for each line in the first txt
    ## file not found in that hash, a line is pushed into the diff_arr.
    def self.find_diffs_with_hash(txt1, txt2, new_file_name)
        memo = {}
        diff_arr = []
        File.foreach(txt2) {|line| memo[line] = true}
        File.foreach(txt1) {|line| memo[line] ? nil : diff_arr.push(line)}
        File.write(new_file_name, diff_arr.join(""))
    end


end

DiffFinder.find_unsorted_diffs("file1.txt", "file2.txt", "new_file.txt")