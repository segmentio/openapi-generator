#!/bin/bash
set -exo pipefail

cd "$(dirname ${BASH_SOURCE})"

maven_cache_repo="${HOME}/.m2/repository"

mkdir -p "${maven_cache_repo}"

input_compose_yml_file="${PWD}/modules/openapi-generator/src/test/resources/3_0/papi/typescript-node-npm-papi.yaml" # or you can use #"YOUR_LOCAL_COMPOSE_FILE"
input_openapi_json_file="${PWD}/modules/openapi-generator/src/test/resources/3_0/papi/open-api.json" # or you can use "YOUR_LOCAL_API_JSON_FILE"

# !! The -u option below needs to be defined so we don't write to a user's bound ~/.m2/repository as root.
# !! but using this also means we either need to setup a user with the same id, or we execute without a username and home directory.
# !! This means we can't bind the .m2 directory to any user's directory (like /root/.m2).
# !! We _must_ define $MAVEN_CONFIG explicitly as a location that is not /root/.m2; the user executing this may not have access to the container's user's directory.
docker run --rm -it \
        -w /gen \
        -e GEN_DIR=/gen \
        -e MAVEN_CONFIG=/var/maven/.m2 \
        -e API_FILE=/input/api.json \
        -e MAVEN_OPTS="-Dhttps.protocols=TLSv1.2 -Dmaven.repo.local=/var/maven/.m2/repository -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=WARN -Dorg.slf4j.simpleLogger.showDateTime=true -Djava.awt.headless=true -Djacoco.skip=true" \
        -u "$(id -u):$(id -g)" \
        -v "${PWD}:/gen" \
        -v "${PWD}/CI/run-in-docker-settings.xml:/var/maven/.m2/settings.xml" \
        -v "${maven_cache_repo}:/var/maven/.m2/repository" \
        -v "${input_compose_yml_file}:/gen/input/tsnode-papi.yaml" \
        -v "${input_openapi_json_file}:/gen/input/api.json" \
        --entrypoint /gen/docker-entrypoint.sh \
        maven:3-jdk-8 "$@"
