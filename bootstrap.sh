#!/bin/bash

# Create '~/.kube/config' file.
# kubectl can work with mounted serviceaccount information under /var/run/secrets/kubernetes.io.
# however stern does not read it and require ~/.kube/config
mkdir -p ~/.kube

SERVER=https://kubernetes.default.svc
CA=`cat /var/run/secrets/kubernetes.io/serviceaccount/ca.crt | base64 -w 0`
TOKEN=`cat /var/run/secrets/kubernetes.io/serviceaccount/token`
NAMESPACE=`cat /var/run/secrets/kubernetes.io/serviceaccount/namespace`

echo "
apiVersion: v1
kind: Config
clusters:
- name: default-cluster
  cluster:
    certificate-authority-data: ${CA}
    server: ${SERVER}
contexts:
- name: default-context
  context:
    cluster: default-cluster
    namespace: ${NAMESPACE}
    user: default
current-context: default-context
users:
- name: default
  user:
    token: ${TOKEN}
" > ~/.kube/config
