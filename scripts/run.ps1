if (docker ps -a --filter "name=ApachePHPContainer" --quiet) {
    docker rm -f ApachePHPContainer
}
docker run -d `
    --name ApachePHPContainer `
    -p 8081:8081 `
    -v .\src:/var/www/moodle.asir `
    -v .\logs:/var/log/apache2 `
    --env-file .\env\dev.env `
    --add-host=moodle.asir:127.0.0.1 `
    apachetest:dev