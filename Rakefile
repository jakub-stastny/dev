require 'json'
require 'time'
require 'open3'

DATE  = Time.now.iso8601
LOG   = 'build.log'
IMAGE = 'jakubstastny/dev'

def build_metadata
  {
    git_commit: `git rev-parse HEAD`.chomp,
    date: DATE
  }
end

desc "Build the image"
task :build do
  commands = [
    [['docker', 'pull', 'ubuntu'], true],
    [['git', 'commit', '-a', '-m', "Automated commit on #{DATE}"], true],
    [['echo', build_metadata.inspect], true],
    [['docker', 'build', '.', '-t', IMAGE, '--build-arg', "BUILD_METADATA=#{JSON.generate(build_metadata)}"], false]
  ]

  File.open(LOG, 'w') do |log|
    commands.each do |(command_args, can_fail)|
      command = "$ #{command_args.join(' ')}"
      puts command; log.puts(command)
      Open3.popen3(*command_args) do |stdin, stdout, stderr, status_thread|
        [stdout, stderr].each do |stream|
          stream.each_line do |line|
            puts line; log.puts(line)
          end
        end

        if !can_fail && !status_thread.value.success?
          abort "Something failed running command: #{command}"
        end
      end
    end
  end
rescue Interrupt
  puts
end

desc "Push the image to Dockerhub"
task :push do
  sh "docker push jakubstastny/dev"
end
