# SYNTASA Installation using HELM v3+

### Prerequisites
Please read through the prerequisites document here:

[Syntasa Prerequisites](PREREQUISITES.md)

### Cloning the repo
Clone the repo located here: https://github.com/syntasa-dev/syntasa-google-marketplace.git

Place it somewhere on your machine e.g. ~/home/<my_user>/

Once cloned or downloaded, please cd into the syntasa-google-marketplace syntasa directory

```
cd ~/home/<my_user>/syntasa-google-marketplace/chart/syntasa/
```

### Create the SYNTASA namespace using Kubectl
Create a new namespace named 'syntasa' where the syntasa installation will reside

```
kubectl create namespace syntasa
```

### Create a Kubernetes service account for SYNTASA
In order for the SYNTASA platform to have the right permissions to create namespace wide permissions, we will need to create a service account with some RBAC permissions

Please run the following command using Kubectl:

```
kubectl apply -f - <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: syntasa
  namespace: syntasa
---
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: syntasa-cluster-role
  namespace: syntasa
rules:
  - apiGroups: [""]
    resources: ["secrets", "configmaps", "services", "endpoints", "nodes", "pods"]
    verbs: ["*"]
  - apiGroups: [""]
    resources: ["events"]
    verbs: ["*"]
  - apiGroups:
      - "extensions"
    resources:
      - "ingresses"
      - "ingresses/status"
    verbs: ["*"]
---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: syntasa-role-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: syntasa-cluster-role
subjects:
  - kind: ServiceAccount
    name: syntasa
    namespace: syntasa
EOF
```

This will create a service account named: 'syntasa' and a cluster role named 'syntasa-cluster-role' and a role binding named 'syntasa-role-binding'


### Installing SYNTASA using HELM
Once in the chart/syntasa folder, run the following command (replace all values as per your prerequisite setup steps)

```
helm install --namespace syntasa syntasa ./ --set \
metastore_connection_name=<my_sql_connection_name>, \
metastore_connection_user=<mysql_connection_user>, \
metastore_connection_password=<mysql_connection_password>, \
static_ip_address=<my_external_static_ip_address>, \
infrastructure_service_account=<my_iam_service_account_email>, \
whitelist_ips=<comma_separated_list_of_ip_whitelists> \
syn_kube_service_account=syntasa, \
syn_kube_service_account_rb=syntasa-role-binding, \
syn_secret_key=<my_secret_key>, \
syn_license=<my_license>
```
---

When ready, please head to the static ip you reserved as follows: https://<my_static_ip>

Installation will take anywhere from 10 seconds to 2 minutes.
