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
  log = File.open(LOG, 'w')
  commands = [
    ['docker', 'pull', 'ubuntu'],
    ['git', 'commit', '-a', '-m', "Automated commit on #{DATE}"],
    ['echo', build_metadata.inspect],
    ['docker', 'build', '.', '-t', IMAGE, '--build-arg', "BUILD_METADATA=#{JSON.generate(build_metadata)}"]
  ]
  # sh "docker pull ubuntu"
  # sh "git commit -a -m 'Automated commit on #{DATE}' 2> /dev/null; true"
  # puts "Build metadata: #{build_metadata.inspect}"

  # docker_build_args = [
  #   'docker', 'build', '.', '-t', IMAGE, '--build-arg', "BUILD_METADATA=#{JSON.generate(build_metadata)}"
  # ]

  commands.each do |command_args|
    Open3.popen3(*command_args) do |stdin, stdout, stderr, status_thread|
      [stdout, stderr].each do |stream|
        stream.each_line do |line|
          puts line
          # TODO: Also log
        end
      end

     raise "Error" unless status_thread.value.success?
    end
  end
rescue Interrupt
  puts
ensure
  log.close
end

desc "Push the image to Dockerhub"
task :push do
  sh "docker push jakubstastny/dev"
end
