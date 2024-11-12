#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <sploit_script> <farm_url> <farm_token> <period=60> [-r <requirements_file>]"
    exit 1
fi

if [ -z "$2" ]; then
    
fi

if [ "$2" == "-r" ]; then
    if [ -z "$3" ]; then
        echo "Usage: $0 <sploit_script> -r <requirements_file>"
        exit 1
    fi
    requirements_file=$3
fi

sploit_script=$1



echo "Building $sploit_script.Dockerfile"
echo "FROM python:3.12-alpine" > $sploit_script.Dockerfile
echo "COPY $sploit_script /app/$sploit_script" >> $sploit_script.Dockerfile
if [ -n "$requirements_file" ]; then
    echo "RUN pip install -r $requirements_file" >> $sploit_script.Dockerfile
fi
echo "CMD [\"python\", \"/app/$sploit_script\"]" >> $sploit_script.Dockerfile

echo "Dockerfile created: $sploit_script.Dockerfile"

docker build -t $sploit_script $sploit_script.Dockerfile
docker run -it $sploit_script --rm`