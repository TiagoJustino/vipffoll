load 'subtitles_entry.rb'

class Subtitles
  attr_accessor :entries
  def self.parse filename
    Subtitles.new File.open(filename).read.gsub("\r\n", "\n").split("\n").collect{ |l| l.strip }.join("\n").gsub(/\n\n+/, "\n\n").split("\n\n").collect{ |e| SubtitlesEntry.new e}.sort{ |a, b| a.range.begin <=> b.range.begin }
  end

  def initialize entries
    @entries = entries
  end

  def [] index
    @entries[index]
  end

  def []= index, entry
    raise ArgumentError, 'Argument is not SubtitlesEntry' unless entry.is_a? SubtitlesEntry
    @entries[index] = entry
  end

  def to_s
    str = ""
    @entries.each_index do |i|
      str = str + "#{i + 1}\n#{@entries[i].to_s}\n\n"
    end
    str.chomp.gsub("\n", "\r\n")
  end
end

if __FILE__ == $0
  puts Subtitles.parse ARGV[0]
end
