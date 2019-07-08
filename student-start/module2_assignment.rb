class LineAnalyzer
  attr_accessor :highest_wf_count, :highest_wf_words, :content, :line_number
  def initialize(content, line_number)
    self.line_number = line_number
    self.content = content
    self.calculate_word_frequency(content)
  end

  def calculate_word_frequency(content)
    words = content.split
    word_count = (words.each_with_object(Hash.new(0)) {|word, counts| counts[word] += 1})
    self.highest_wf_words = []
    max = word_count.values.max
    word_count.select do |k, v|
      if v == max
        self.highest_wf_words << k
      end
    end
    self.highest_wf_count = word_count.each_value.max
  end
end

class Solution
  attr_accessor :analyzers, :highest_count_across_lines, :highest_count_words_across_lines
  def initialize()
    self.analyzers = []
  end

  def analyze_file()
    File.open('test.txt', "r") do |file|
      @line = 0
      file.each_line do |line|
        self.analyzers << LineAnalyzer.new(line.downcase.chomp(), @line += 1)
      end
    end
  end

  def calculate_line_with_highest_frequency()
    highest_wf_count = 0
    self.highest_count_words_across_lines = []
    self.analyzers.each do |analyzer|
      hwf_count = LineAnalyzer.new(analyzer.content, analyzer.line_number).highest_wf_count
      highest_wf_count = hwf_count >= highest_wf_count ? hwf_count : highest_wf_count
    end
    self.highest_count_across_lines = highest_wf_count
    self.analyzers.each do |analyzer|
      if LineAnalyzer.new(analyzer.content, analyzer.line_number).highest_wf_count >= self.highest_count_across_lines
        self.highest_count_words_across_lines << LineAnalyzer.new(analyzer.content, analyzer.line_number)
      end
    end
  end

  def print_highest_word_frequency_across_lines()
    print "The following words have the highest word frequency per line:\n"
    self.analyzers.each do |analyzer|
      LineAnalyzer.new(analyzer.content, analyzer.line_number).highest_wf_words
      words = LineAnalyzer.new(analyzer.content, analyzer.line_number).highest_wf_words
      line = analyzer.line_number
      print "#{words} (appears in line #{line})\n"
    end
  end
end
