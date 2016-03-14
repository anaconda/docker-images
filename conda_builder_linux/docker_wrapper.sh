#!/usr/bin/env bash

# this script accepts arbitrary arguments.  It tries to split the ```docker run``` commands from those that should be
#    passed into the container itself.  This allows people to simply use our run script for base functionality without
#    knowing about the docker run options, while also allowing them to add volumes or environment variables if they do
#    know how to tweak docker run

# parse options and pick off docker-run options
ENV_VARS=()
VOLUMES=()
LEFTOVERS=()
while [[ $# > 0 ]]
do
    key="$1"

    case $key in
        -e)
            ENV_VARS+=("$2")
            shift # past argument
            ;;
        --rm)
            RM=1
            ;;
        -d)
            DETACHED=1
            # start in detached mode
            ;;
        --log-driver)
            # TODO: Docker specifies this with an = sign, not sure if bash parsing will split on = by default.
            LOG_DRIVER="$2"
            shift # past argument
            ;;
        -v|--volume)
            VOLUMES+=("$2")
            shift # past argument
            ;;
        *)
            # pass through for unknown options
            LEFTOVERS+=("$1")
            ;;
    esac
    shift # past argument or value
done

# build up the docker run command string with each of the options
docker_run_string="run "

if [[ ! -z "${RM}" ]]; then
    docker_run_string+="--rm "
fi

if [[ ! -z "${DETACHED}" ]]; then
    docker_run_string+="-d "
else
    docker_run_string+="-it "
fi

if [[ ! -z "${LOG_DRIVER}" ]]; then
    docker_run_string+="--log-driver=${LOG_DRIVER} "
fi

for var in "${ENV_VARS[@]}"
do
    docker_run_string+="-e $var "
done

for var in "${VOLUMES[@]}"
do
    docker_run_string+="-v $var "
done

# try to map gitconfig and ssh private key for convenience
user=$(id -u -n)
home=$(eval echo "~${user}")

if [ -e $home/.ssh/id_rsa ]; then
    docker_run_string+="-v $home/.ssh/id_rsa:/id_rsa:ro "
fi

if [ -e $home/.gitconfig ]; then
    docker_run_string+="-v $home/.gitconfig:/home/dev/.gitconfig:ro "
fi

# these two need to come last: the image, and the command to run.
docker_run_string+="msarahan/conda_builder_linux:latest "
docker_run_string+="bash /opt/share/internal_startup.sh ${LEFTOVERS[@]}"

docker ${docker_run_string}
