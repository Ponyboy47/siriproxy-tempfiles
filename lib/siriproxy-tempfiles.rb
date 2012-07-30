require 'cora'
require 'siri_objects'

class SiriProxy::Plugin::TempFiles < SiriProxy::Plugin

  def initialize(config)
  end
  
  listen_for /Write (this|it) down/i do
    wtw = ask "What would you like for me to write down?"
    Dir.mkdir("/.siriproxyTMP/") unless Dir::exists?("/.siriproxyTMP/")
    tempfile = File.new("/.siriproxyTMP/tmp.txt", "w+")
    tempfile.syswrite(wtw)
    tempfile.close
    say "OK. I wrote that down. Ask me \"What did I write\" when you want to know what you just said."
    request_completed
  end
  
  listen_for /What did (I|you) write/i do
    if File::exists?("/.siriproxyTMP/tmp.txt")
      fileLines = IO.readlines("/.siriproxyTMP/tmp.txt")
        for x in (0..fileLines.length) do
          say "#{fileLines[x]}"
        end
    else
      say "You have to write something first! Try say \"Write this down\"."
    end
    File.delete("/.siriproxyTMP/tmp.txt") if File::exists?("./siriproxyTMP/tmp.txt")
    Dir.delete("/.siriproxyTMP/") if Dir::exists?("./siriproxyTMP/")
    request_completed
  end
end
