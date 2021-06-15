#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

set -euxo pipefail

python3 -m venv venv
source venv/bin/activate

pip install -r requirements.txt
python generate_docker_quickstart.py ../docker-compose.yml ../docker-compose.override.yml temp.quickstart.yml

if cmp docker-compose.quickstart.yml temp.quickstart.yml; then
    printf 'docker-compose.quickstart.yml is up to date.'
    exit 0
else
    printf 'docker-compose.quickstart.yml is out of date.'
    exit 1
fi