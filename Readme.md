# Dead Man's Switch

A docker container to monitor other docker containers based on the dead man's
switch priciple.

Some containers are neither able to self-recover nor self-terminate when they
run into trouble.

If you have a container that you expect regular logging output from, and long
periods of no output are unexpected; then this container can restart containers
that have been silent for longer than a predetrmined time.

## Usage

    docker run -d --rm -v /var/run/docker.sock:/var/run/docker.sock ijmacd/dms <monitored_container>

## Inception

This container produces regular output so its possible to put a dead man's
switch on the dead man's switch.

    docker run -d --rm -v /var/run/docker.sock:/var/run/docker.sock --name one ijmacd/dms <monitored_container>
    docker run -d --rm -v /var/run/docker.sock:/var/run/docker.sock --name two ijmacd/dms one
    docker run -d --rm -v /var/run/docker.sock:/var/run/docker.sock --name three ijmacd/dms two
