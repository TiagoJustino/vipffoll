require 'bigdecimal'

class SubtitlesEntry

  attr_accessor :range, :text
  
  def initialize str
    arr = str.split("\n")
    seq = arr.delete_at 0
    rangestr = arr.delete_at 0
    @text = arr.join("\n")
    @range = parse_range rangestr
  end

  def parse_range rangestr
    times = rangestr.split(" --> ").collect{ |timestr| parse_time timestr }
    times.first..times.last
  end

  def parse_time timestr
    hour, min, sec, milli = timestr.split(/[:,]/)
    hour.to_i * 3600 + min.to_i * 60 + sec.to_i + (BigDecimal(milli) / 1000)
  end

  def to_time time
    hour = (time/3600).to_i
    min = (time/60 - hour * 60).to_i
    sec = sec = (time - (min * 60 + hour * 3600))
    milli = ((time - time.floor).to_f * 1000).to_i
    "%02d:%02d:%02d,%03d" % [hour, min, sec, milli]
  end

  def to_s
    "#{to_time @range.begin} --> #{to_time @range.end}"
    "#{to_time @range.begin} --> #{to_time @range.end}\n#{@text}"
  end
end
