require 'spork'
require 'spork/runner'
# Let's fork spork and put in the background and forget about it.
# You can start|stop|restart spork using this rake task
#
# Examples
#
#   rake spork:start
#   # => starts spork and detaches the process
#
#   rake spork:stop
#   # => kills the spork process based on the pid stored in tmp/spork.pid
#
#   rake spork:restart
#   # => stops then starts spork
#
namespace :spork do
  desc "Starts spork server"
  task :start do
    begin
      print "Starting spork..."
      
      pid = fork do
        # Swallows spork's notifications. I don't want it spewing all over my terminal from the background.
        $stdout = File.new('/dev/null', 'w')
        # If you want to change the default config you can
        # specify the command line options here
        # For example to change the port:
        # options = ["--port", "7443"]
        options = []
        begin
          Spork::Runner.run(options, $stderr, $stderr)
        rescue => e
          $stderr.puts
          $stderr.puts "#{e.class} => #{e.message}"
          $stderr.puts e.backtrace.join("\n")
        end
        # TODO maybe swallow stderr now... will that work?
        # It should b/c its in the same process... or does spork hijack it?
        # $stderr = File.new('/dev/null', 'w')
      end
     
      # Detach the pid, keep track of the pid, and wait for Rails to start.
     
      Process.detach(pid)
      File.open("#{tmp_dir}/spork.pid", "w"){|f| f.write pid}
     
      seconds = 5
     
      puts  "\033[35m[Giving Rails #{seconds} seconds to start]\033[0m\n"
      puts "\033[36mYou can change the wait time in lib/tasks/spork.rake \nif Rails is taking longer than #{seconds} seconds to load\033[0m\n"
     
      sleep seconds
      
      # See if the process actually started
      if process_running?(pid)
        puts  "\033[32m[Sporkified!]\033[0m\n"
      else
        puts  "\033[31m[Spork failed to start]\033[0m\n"
      end
    rescue StandardError => e
      puts e.inspect
      puts  "\033[31m[Spork failed to start]\033[0m\n"
      
    end
  end
  
  desc "Stops the spork server"
  task :stop do
    print "Stopping spork..."
    if File.exist?("#{tmp_dir}/spork.pid")
      pid = File.read("#{tmp_dir}/spork.pid").to_i
      begin
        Process.kill("INT", pid)
        print "\033[32m[OK]\033[0m\n"
        sleep 1
      rescue Errno::ESRCH => e
        print "\033[33m[not running]\033[0m\n"
      rescue StandardError => e
        print "\033[31m[FAILED]\033[0m\n"
        puts e.inspect
      end
    else
      print "\033[33m[not running]\033[0m\n"
    end
    print "\033[30mis it a spoon? is it a fork?\033[0m\n"
  end
  
  desc "Restart the spork server"
  task :restart => [:stop, :start]
  
  def tmp_dir
    File.expand_path('../../../tmp', __FILE__)
  end
  
  def process_running?(pid=nil)
    unless pid
      return unless File.exist?("#{tmp_dir}/spork.pid")
      pid = File.read("#{tmp_dir}/spork.pid").to_i
    end
    begin
      Process.kill(0, pid)
    rescue Errno::ESRCH => e
      return false
    end
  end
  
end
