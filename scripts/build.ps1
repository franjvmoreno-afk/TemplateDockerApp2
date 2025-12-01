docker build `
  -f .\docker\http\apache+php\apache-php.dev.dockerfile `
  -t apachetest `
  --build-arg SERVER_NAME=moodle.asir `
  --build-arg SERVER_PORT=8081 `
  .

docker run -d -p 8081:8081 --name moodle-app apachetest
