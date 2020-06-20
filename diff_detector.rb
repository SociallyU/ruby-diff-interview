# Comparison class takes in two files and prints out what is in the first file
# but not in the second file
class Comparison
  def initialize(file1, file2)
    @file1 = file1
    @file2 = file2
  end

  def self.print_difference(file1, file2)
    puts new(file1, file2).difference
  end

  def difference
    read_file(@file1).delete_if { |line| read_file(@file2).include? line }
  end

  def read_file(file)
    File.readlines(file).map(&:chomp)
  end
end

Comparison.print_difference('file1.txt', 'file2.txt')
