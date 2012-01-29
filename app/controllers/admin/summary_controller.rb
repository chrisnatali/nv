class Admin::SummaryController < AdminAreaController

  def index

    #get statistics from the log
    @total_hits = 0
    @total_uniq_hits = 0
    @days_hits = {}
    ips = {}
    days_ips = {}
    log_file = File.open("log/#{RAILS_ENV}.log")
    log_file.each { |record|
      if record =~ /(\d+\.\d+\.\d+\.\d+) at (\d+-\d+-\d+)/
        @total_hits += 1
        day = $2
        ip = $1
        ips[ip] = 1
        days_ips[day] = {:ips => {}, :ct => 0} if !days_ips[day]
        days_ips[day][:ips][ip] = 1
        days_ips[day][:ct] += 1
      end
    } 
    @total_uniq_hits = ips.size
    days_ips.each{ |d, h| 
      @days_hits[d] = {:uniq_ct => h[:ips].size, :ct => h[:ct]}
    }
  end
end
