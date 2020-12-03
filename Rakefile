require 'json'
require 'time'
require 'open3'

DATE  = Time.now.iso8601
IMAGE = 'jakubstastny/dev'

LOG, LOG_PREV = 'build.log', 'prev_build.log'
STDERR_LOG, STDERR_LOG_PREV = 'build.stderr.log', 'prev_build.stderr.log'

def build_metadata
  {
    git_commit: `git rev-parse HEAD`.chomp,
    date: DATE
  }
end

def run(command_args, log, &block)
  command = command_args.reduce do |buffer, chunk|
    [buffer, chunk.match(/ /) ? "'#{chunk}'" : chunk].join(' ')
  end

  puts "\n#{`tput setaf 1`}# #{`tput setaf 7`}#{command}#{`tput sgr0`}"
  log.puts("\n$ #{command}")
  Open3.popen3(*command_args) do |_, stdout, stderr, status_thread|
    block.call(stdout, stderr, status_thread)
  end
end

desc "Build the image"
task :build do
  commands = [
    ['docker', 'pull', 'ubuntu'],
    ['git', 'commit', '-a', '-m', "Automated commit on #{DATE}"],
  ]

  docker_build_command = [
    'docker', 'build', '.', '-t', IMAGE, '--build-arg', "BUILD_METADATA=#{JSON.generate(build_metadata)}"
  ]

  File.rename(LOG, LOG_PREV) if File.exist?(LOG)
  File.rename(STDERR_LOG, STDERR_LOG_PREV) if File.exist?(STDERR_LOG)

  File.open(LOG, 'w') do |log|
    commands.each do |command_args|
      run(command_args, log) do |stdout, stderr, status_thread|
        [stdout, stderr].each do |stream|
          stream.each_line do |line|
            puts line; log.puts(line)
          end
        end
      end
    end

    puts "\n#{`tput setaf 2`}~#{`tput sgr0`} Metadata: #{`tput setaf 7`}#{build_metadata.to_json}#{`tput sgr0`}"
    log.puts "\n~ Metadata: #{build_metadata.to_json}"

    File.open(STDERR_LOG, 'w') do |stderr_log|
      run(docker_build_command, log) do |stdout, stderr, status_thread|
        stdout.each_line do |line|
          puts line; log.puts(line)
        end

        stderr.each_line do |line|
          puts line; log.puts(line); stderr.puts(line)
        end

        if !can_fail && !status_thread.value.success?
          abort "Something failed during docker build"
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
