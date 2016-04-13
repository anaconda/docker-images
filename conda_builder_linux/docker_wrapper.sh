#!/usr/bin/env bash

# this script accepts arbitrary arguments.  It tries to split the ```docker run``` commands from those that should be
#    passed into the container itself.  This allows people to simply use our run script for base functionality without
#    knowing about the docker run options, while also allowing them to add volumes or environment variables if they do
#    know how to tweak docker run

# parse options and pick off docker-run options
DOCKER_ARGS=()
IMAGE="continuumio/conda_builder_linux:latest"
while [[ $# > 0 ]]
do
    key="$1"

    case $key in
	-I|--image)
	    IMAGE="$2"
	    shift # past argument
	    ;;
        -d)
            # start in detached mode
            DETACHED=1
            ;;
	--)
	    # End of docker options.
	    # Anything beyond this point is part of the docker command.
	    shift
	    break
	    ;;
        *)
            # pass through unknown options
            DOCKER_ARGS+=("$1")
            ;;
    esac
    shift # past argument or value
done
# build up the docker run command string with each of the options
docker_run_string="run "

if [[ ! -z "${DETACHED}" ]]; then
    docker_run_string+="-d "
else
    docker_run_string+="-it "
fi

# try to map gitconfig and ssh private key for convenience
user=$(id -u -n)
home=$(eval echo "~${user}")

docker_run_string+="-e USER=${user} "

if [ -e $home/.ssh/id_rsa ]; then
    docker_run_string+="-v $home/.ssh/id_rsa:/id_rsa:ro "
fi

if [ -e $home/.gitconfig ]; then
    docker_run_string+="-v $home/.gitconfig:/home/dev/.gitconfig:ro "
fi

docker_run_string+="${DOCKER_ARGS[@]} "
# these two need to come last: the image, and the command to run.
docker_run_string+="$IMAGE "
docker_run_string+="bash /opt/share/internal_startup.sh $@"

docker ${docker_run_string}
