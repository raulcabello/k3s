#/bin/sh

set -e 

if [ -n ${DEBUG} ]; then
    set -x
fi

. ./scripts/version.sh

# skipping image scan for s390x since trivy doesn't support s390x arch yet
if [ "${ARCH}" == "s390x" ]; then
    exit 0
fi

if [ -z $1 ]; then
    echo "error: image name required as argument. exiting..."
    exit 1
fi

IMAGE=$1
SEVERITIES="HIGH,CRITICAL"

trivy --quiet image --severity ${SEVERITIES}  --no-progress --ignore-unfixed ${IMAGE}

exit 0
