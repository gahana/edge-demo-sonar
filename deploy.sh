#!/bin/bash
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
USAGE="Usage: deploy [all|2xx|4xx|5xx|delay|webhook]"
EDGE_ORG="apac-demo3"
EDGE_ENV="test"

if [ -z "$1" ]; then
	echo $USAGE
	exit 1
fi

set -eu

if [ "$1" = "2xx" ] || [ "$1" = "all" ]; then
	echo "deploying 2xx api"
	cd $BASEDIR/sonar-2xx-api
	mvn apigee-enterprise:deploy -Ptest -Dusername=$EDGE_USERNAME -Dpassword=$EDGE_PASSWORD -Dorg=$EDGE_ORG -Dtest=$EDGE_ENV
fi

if [ "$1" = "4xx" ] || [ "$1" = "all" ]; then
	echo "deploying 4xx api"
	cd $BASEDIR/sonar-4xx-api
	mvn apigee-enterprise:deploy -Ptest -Dusername=$EDGE_USERNAME -Dpassword=$EDGE_PASSWORD -Dorg=$EDGE_ORG -Dtest=$EDGE_ENV
fi

if [ "$1" = "5xx" ] || [ "$1" = "all" ]; then
	echo "deploying 5xx api"
	cd $BASEDIR/sonar-5xx-api
	mvn apigee-enterprise:deploy -Ptest -Dusername=$EDGE_USERNAME -Dpassword=$EDGE_PASSWORD -Dorg=$EDGE_ORG -Dtest=$EDGE_ENV
fi

if [ "$1" = "delay" ] || [ "$1" = "all" ]; then
	echo "deploying delay api"
	cd $BASEDIR/sonar-delay-api
	mvn apigee-enterprise:deploy -Ptest -Dusername=$EDGE_USERNAME -Dpassword=$EDGE_PASSWORD -Dorg=$EDGE_ORG -Dtest=$EDGE_ENV
fi

if [ "$1" = "webhook" ] || [ "$1" = "all" ]; then
	echo "deploying webhook api"
	cd $BASEDIR/sonar-webhook-api
	mvn apigee-enterprise:deploy -Ptest -Dusername=$EDGE_USERNAME -Dpassword=$EDGE_PASSWORD -Dorg=$EDGE_ORG -Dtest=$EDGE_ENV
fi


