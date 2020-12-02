require 'json'
require 'time'

def build_metadata
  {
    git_commit: `git rev-parse HEAD`.chomp,
    date: Time.now.iso8601
  }
end

desc "Build the image"
task :build do
  sh "docker pull ubuntu"
  puts "Build metadata: #{build_metadata.inspect}"
  sh "docker build . -t jakubstastny/dev --build-arg 'BUILD_METADATA=#{JSON.generate(build_metadata)}'"
end

desc "Push the image to Dockerhub"
task :push do
  sh "docker push jakubstastny/dev"
end
