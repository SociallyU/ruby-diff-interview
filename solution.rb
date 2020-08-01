require_relative "lib/diff"

file1 = Diff::FileSource.read("./file1.txt")
file2 = Diff::FileSource.read("./file2.txt")

diff =  file1.diff_with(file2)

File.write("solution.txt", diff.join("\n"))
