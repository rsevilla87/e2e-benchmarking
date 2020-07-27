

NS_BASENAME=http-perf
ROUTE_TYPES="mix plain edge passthrough reencrypt"
NUM_NS=${NUM_NS:-10}
ROUTES_PER_NS=${ROUTES_PER_NS:-10}
export NODE_SELECTOR='node-role.kubernetes.io/worker: ""'
export HTTP_SERVER_IMAGE="quay.io/openshift-scale/nginx"

# Receives the route type as argument
create_apps(){
  if [[ $1 == "mix" ]]; then
    echo mix
    return 0
  fi
  for ns in $(seq ${NUM_NS}); do
    export NS=${NS_BASENAME}-${1}-${ns}
    cat ns.yml | envsubst | kubectl apply -f -
    for app in $(seq ${ROUTES_PER_NS}); do
      export ID=$app
      cat deployment.yml | envsubst | kubectl apply -f -
    done
  done
}

