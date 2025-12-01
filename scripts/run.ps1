docker run -d `
    --name ApachePHPContainer `
    -p 8081:8081 `
    -v .\src:/var/www/moodle.asir `
    --env-file .\env\dev.env `
    --add-host=moodle.asir:127.0.0.1 `
    apachetest:dev