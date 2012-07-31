require 'cora'
require 'siri_objects'

class SiriProxy::Plugin::TempFiles < SiriProxy::Plugin

  def initialize(config)
  end
    
  def getClient()
    my2 = Mysql2::Client.new(:host => "#{$APP_CONFIG.db_host}", :username => "#{$APP_CONFIG.db_user}", :password => "#{$APP_CONFIG.db_pass}", :database => "#{$APP_CONFIG.db_database}")
    # TODO: Prevent SQL injection
    client = []
    my2.query("SELECT * FROM `siri`.`clients` ORDER BY `last_login` ASC LIMIT 1", :as => :array).each do |rows|
      client << {:fname => rows[1],
                 :nickname => rows[2],
                 :appleDBid => rows[3],
                 :appleAccountid => rows[4],
                 :valid => rows[5],
                 :devicetype => rows[6],
                 :deviceOS => rows[7],
                 :date_added => rows[8],
                 :last_login => rows[9],
                 :last_ip => rows[10]}
    end
    return client
  end
  
  listen_for /Temporary file/i do
    current = getClient()
    Dir.mkdir("/.siriproxyTMP/#{current.fname}") unless Dir::exists?("/.siriproxyTMP/#{current.fname}")
    if File::exists?("/.siriproxyTMP/#{current.fname}/tmp.txt") == false
      @whichFile = x
      tempfile = File.new("/.siriproxyTMP/#{current.fname}/tmp.txt", "w+")
      tempfile.syswrite("This is a temporary file.")
      tempfile.close
      say "OK. I made a temporary file for you."
    else
      File.open("/.siriproxyTMP/#{current.fname}/tmp.txt", "w+") do |tempfile|
        tempfile.syswrite("This is a new line in that temporary file.")
      end
    end
    request_completed
  end
  
  listen_for /Read file/i do
    current = getClient()
    Dir.mkdir("/.siriproxyTMP/#{current.fname}") unless Dir::exists?("/.siriproxyTMP/#{current.fname}")
    if File::exists?("/.siriproxyTMP/#{current.fname}/tmp.txt") == false
      say "I'm sorry but there is no temporary file to read."
    else
      lines = []
      IO.foreach("/.siriproxyTMP/#{current.fname}/tmp.txt"){|line| lines << line}
      say "#{lines}", spoken: ""
    end
    request_completed
  end
  
  listen_for /(Erase|Delete) file/i do
    current = getClient()
    Dir.mkdir("/.siriproxyTMP/#{current.fname}") unless Dir::exists?("/.siriproxyTMP/#{current.fname}")
    if File::exists?("/.siriproxyTMP/#{current.fname}/tmp.txt") == false
      say "I'm sorry but there is no temporary file to delete."
    else
      File.delete("/.siriproxyTMP/#{current.fname}/tmp.txt")
      say "File erased"
    end
    request_completed
  end
end
