docker build `
  -f .\docker\http\apache+php\apache-php.dev.dockerfile `
  -t apachetest `
  --build-arg SERVER_NAME=moodle.asir `
  --build-arg SERVER_PORT=8081 `
  .
