module ReedheinUtils
  VERSION = "0.1.0"
  require 'singleton'
  require 'find'
  require 'ap'
  class << self
    attr_accessor :environment
    attr_accessor :limiter
  end

  def past_midnight?
    @tomorrow ||= Date.tomorrow.beginning_of_day
    Time.now.to_i > @tomorrow.to_i
  end

  def fifteen_minute_interlude?
    if Time.now.to_i % 900 == 0
      puts 'fifteen minute interlude'
      true
    else
      false
    end
  end

  def two_hour_interlude?
    Time.now.to_i % 60*60*2 == 0
  end

  def work_hours?
      puts "work hours = #{17 < Time.now.hour && Time.now.hour > 9}"
      17 < Time.now.hour && Time.now.hour > 9
  end

  def hold_process
    @tomorrow ||= Date.tomorrow.beginning_of_day
    seconds_left = @tomorrow.to_i - Time.now.to_i
    puts "#{seconds_left} seconds until zoho api limits reset"
    sleep 60
  end

  path = File.dirname(File.absolute_path(__FILE__) )
  begin
    require path + '/reedhein_utils/inspector'
    Dir.glob(path + '/reedhein_utils/*').delete_if{ |file| File.directory?(file) }.each{ |file| require file }
  rescue => e
    ap e.backtrace
    binding.pry
  end
end

