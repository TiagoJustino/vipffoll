#!/usr/bin/env ruby

load 'subtitles.rb'
require './gtkmplayerembed'

class Demo < Gtk::Window
  def initialize
    super
    set_title('Gtk::MPlayerEmbed Demo')
    set_default_size(400, 300)
    signal_connect('delete-event') do
      @mplayer.kill_thread
      Gtk.main_quit
    end

    vbox = Gtk::VBox.new
    self << vbox

    @mplayer = Gtk::MPlayerEmbed.new(nil, "-noautosub")
    @mplayer.fullscreen_size = [ 1024, 768 ]
    @mplayer.signal_connect('fullscreen_toggled') do |mplayer, fullscreen|
      vbox.reorder_child(@mplayer, 0) if not fullscreen
    end

    @mplayer.signal_connect('realize') do
      @mplayer.play(ARGV[0])
    end
    vbox << @mplayer

    # subt = EncoderTools::Subtitles::Parser.new(File.open(ARGV[1]).read.gsub("\r\n", "\n")).parse
    subt = Subtitles.parse(ARGV[1])

    hbox = Gtk::HBox.new(false, 4)
    hbox.border_width = 6
    vbox.pack_start(hbox, false)

    tb = Gtk::TextBuffer.new
    tv = Gtk::TextView.new(tb)
    tv.editable = false
    tv.cursor_visible = false
    tb.text = subt[0].text.downcase.gsub(/[a-z]/, '_')
    
    tv.signal_connect('key-press-event') do |wdg, event|
      begin
        check event.keyval
        str = tb.text
        if subt[0].text[str.index('_')].downcase == event.keyval.chr.downcase
          puts "if"
          str[str.index('_')] = event.keyval.chr.downcase
        else
          puts "else"
        end
        tb.text = str
      rescue Exception => e
        puts "rescue"
        puts e
      end
    end

    hbox << tv

    puts "creating button"

    show_all
  end
end

Demo.new
Gtk.main

