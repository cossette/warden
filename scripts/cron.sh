#!/bin/bash

function usage
{
    echo "usage: ../scripts/cron.sh @ENV [--new-only] | [-h]"
    echo "@ENV is the environment, e.g. @dev, @test or @prod"
    echo "--new-only (optional) use to ONLY update sites that have recently been registered."
}

NEWONLY=""
ENV=""

while [ "$1" != "" ]; do
    case $1 in
        --new-only )   NEWONLY="--import-new"
                       ;;
        -h | --help )  usage
                       exit
                       ;;
        * )            ENV=$1
    esac
    shift
done

if [[ -z "${ENV}" ]]; then
  echo "Error: No environment variable provided!"
  usage
  exit 1;
fi

if [[ -n "$NEWONLY" ]]; then
  echo "Only import newly registered sites....."
else
  echo "Run full update....."
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OUTPUT=""

php bin/console deeson:warden:warden-cron --env=${ENV:1} ${NEWONLY}
