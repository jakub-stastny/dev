require 'json'
require 'time'

DATE = Time.now.iso8601

def build_metadata
  {
    git_commit: `git rev-parse HEAD`.chomp,
    date: DATE
  }
end

desc "Build the image"
task :build do
  sh "docker pull ubuntu"
  sh "git commit -a -m 'Automated commit on #{DATE}' 2> /dev/null"
  puts "Build metadata: #{build_metadata.inspect}"
  sh "docker build . -t jakubstastny/dev --build-arg 'BUILD_METADATA=#{JSON.generate(build_metadata)}'"
end

desc "Push the image to Dockerhub"
task :push do
  sh "docker push jakubstastny/dev"
end
