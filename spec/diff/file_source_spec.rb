require "spec_helper"

RSpec.describe Diff::FileSource do
  describe ".read" do
    it "returns file source with content of file at given path" do
      file_source = Diff::FileSource.read("./file1.txt")

      expect(file_source.content).to start_with("4b86be185695ac60889684496017a922")
    end
  end

  describe "#diff_with" do
    it "returns content lines not found in given file source" do
      file_source_a = Diff::FileSource.new("a\nb\nc")
      file_source_b = Diff::FileSource.new("b")

      result = file_source_a.diff_with(file_source_b)

      expect(result).to contain_exactly("a", "c")
    end

    it "does not return lines only in given file source" do
      file_source_a = Diff::FileSource.new("a")
      file_source_b = Diff::FileSource.new("a\nb")

      result = file_source_a.diff_with(file_source_b)

      expect(result).to be_empty
    end
  end

  describe "#unique_lines" do
    it "returns unique set of given content lines" do
      file_source = Diff::FileSource.new("a\nb\na\nc")

      result = file_source.unique_lines

      expect(result).to contain_exactly("a", "b", "c")
    end
  end
end
