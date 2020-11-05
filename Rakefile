desc "Build the image"
task :build do
  sh "docker pull ubuntu"
  sh "docker build . -t jakubstastny/dev"
end

desc "Push the image to Dockerhub"
task :push do
  sh "docker push jakubstastny/dev"
end
