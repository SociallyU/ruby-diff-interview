class DiffFinder


    ## Finds diffs between two files in case of an unsorted file. 
    ## O(N^2) because txt2 must be iterated through each atttempt
    def self.find_unsorted_diffs(txt1, txt2, new_file_name)
        diff_arr = []
        File.foreach(txt1) { |line| !File.read(txt2).include?(line) ? diff_arr.push(line) : nil }
        File.write(new_file_name, diff_arr.join(""))
    end

end

DiffFinder.find_unsorted_diffs("file1.txt", "file2.txt", "new_file.txt")