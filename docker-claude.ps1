param(
    [Parameter(Position=0)]
    [ValidateSet('build', 'run', 'stop', 'shell', 'restart', 'clean', 'logs', 'status')]
    [string]$Command
)

$DOCKER_IMAGE_NAME = "claude"
$DOCKER_CONTAINER_NAME = "claude"

switch ($Command) {
    'build' {
        docker build -f Dockerfile -t $DOCKER_IMAGE_NAME .
    }
    'run' {
        docker run -d `
            --name $DOCKER_CONTAINER_NAME `
            -v "${PWD}:/workspace" `
            -it `
            $DOCKER_IMAGE_NAME
        Write-Host "Container started. Use '.\docker-claude.ps1 shell' to access it"
    }
    'stop' {
        docker stop $DOCKER_CONTAINER_NAME 2>$null
        docker rm $DOCKER_CONTAINER_NAME 2>$null
    }
    'shell' {
        docker exec -it $DOCKER_CONTAINER_NAME bash
    }
    'restart' {
        & $PSCommandPath stop
        & $PSCommandPath run
    }
    'clean' {
        & $PSCommandPath stop
        docker rmi $DOCKER_IMAGE_NAME 2>$null
    }
    'logs' {
        docker logs -f $DOCKER_CONTAINER_NAME
    }
    'status' {
        docker ps -a --filter "name=$DOCKER_CONTAINER_NAME"
    }
    default {
        Write-Host "Uso: .\docker-claude.ps1 <comando>"
        Write-Host "Comandos disponibles: build, run, stop, shell, restart, clean, logs, status"
    }
}