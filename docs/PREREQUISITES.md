# SYNTASA Infrastructure Prerequisites
This document outlines the prerequisites for a successful SYNTASA installation

Please install the following required dependencies:

> Docker - [Docker install](https://docs.docker.com/install/)

> Kubectl - [Kubectl install](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

> Helm - [Helm install](https://helm.sh/docs/intro/install/)

> Tiller - *Included in the HELM installation document above*

Additionally if running on GKE, please make sure the following are installed as well:

> Google Cloud SDK - [Google Cloud SDK install](https://cloud.google.com/sdk/)

### Create a Kubernetes Cluster

Please make sure the cluster meets the following minimum requirements:
```
Minimum Cluster Requirements

Replicas - 1
CPU - 8
Memory - 52GB
```

To create a cluster using gcloud please see the documentation here:

[How to create a Kubernetes cluster using GCLOUD](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-cluster)

### Configuring Kubectl to work with a Kubernetes Cluster

Please configure Kubectl to connect to your Kubernetes Cluster, See below for documentation:

> [Kubectl Documentation for Configuration](https://kubernetes.io/docs/tasks/tools/install-kubectl/#verifying-kubectl-configuration)

If using GKE, instead you may configure the credentials directly using the following command:

```
gcloud container clusters get-credentials <your_cluster_name> --region <your_cluster_region> --project <google_project_where_cluster_resides>
```

Once configured, you should be able to see running clusters by using the following command:

```
kubectl cluster-info
```

Sample Output:
```
Kubernetes master is running at https://<your_cluster_ip>
GLBCDefaultBackend is running at https://<your_cluster_ip>/api/v1/namespaces/kube-system/services/default-http-backend:http/proxy
Heapster is running at https://<your_cluster_ip>/api/v1/namespaces/kube-system/services/heapster/proxy
KubeDNS is running at https://<your_cluster_ip>/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
Metrics-server is running at https://<your_cluster_ip>/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy
```

---

# SYNTASA Installation Prerequisites

### External Metastore
The SYNTASA platform makes use of an external metastore to store information about processed data and their table locations.
This is currently required to be a postgres instance which can be in Cloud SQL or on a standalone Compute Instance.

Minimum Requirements -

1. db-n1-standard-1 - 1 vCPU and 4GB memory (minimum)
2. db-n1-standard-2 - 2 vCPU and 8GB memory (recommended)

Please see the following documentation on how to create a Cloud SQL Postgres Instance:

> [Creating a Cloud SQL postgres Instance](https://cloud.google.com/sql/docs/postgres/create-instance)

Once create please make note of the following information:

1. Instance Connection Name
    > <my_project>:<my_cluster_region>:<my_pg_instance_name>
2. Instance username
    > default user is 'postgres'
3. Instance password 
    > the password you set when creating the database 

### External Static IP reservation (OPTIONAL)
If you wish to use your own static ip, please reserve one and note down the IP Address.

If using GCLOUD, you may reserve a Static IP using the following documentation:

> [Reserving an external static ip using Google Cloud](https://cloud.google.com/compute/docs/ip-addresses/reserve-static-external-ip-address)


### Internal Static IP reservation
SYNTASA requires that a static ip be reserved before being able to run the helm charts in order to support KAFKA services

If using GKE, please reserve an internal IP using the following gcloud command:

```
gcloud compute addresses create [ADDRESS_NAME] [[ADDRESS_NAME]..] \
    --region [REGION] --subnet [SUBNETWORK] \
    --addresses [IP_ADDRESS]
```

For more information, please see the following documentation:

> [Reserving an internal static ip using Google Cloud](https://cloud.google.com/compute/docs/ip-addresses/reserve-static-internal-ip-address)

Once created, please take note of the internal static ip.


### Google Cloud Service Account
The SYNTASA platform requires a service account created within your project in Google Cloud Platform IAM with permissions to the following:

1. BigQuery Admin
2. CloudSQL Admin
3. Compute Admin
4. Kubernetes Engine Cluster Admin
5. Kubernetes Engine Developer
6. Kubernetes Engine Service Agent
7. Dataproc Administrator
8. Dataproc Worker
9. Service Account User
10. Storage Admin

Once created in IAM, please note the email address of the IAM Service Account

Please see the following for more information on how to create an IAM service account:

> [Creating a Google Cloud IAM Service Account](https://cloud.google.com/compute/docs/access/create-enable-service-accounts-for-instances)

---

Once the above steps have been completed you should have the following information:

1. A Kubernetes Cluster created
2. An External Metastore created
3. External Static IP (optional)
4. Internal Static IP (required)
5. Google Cloud IAM Service Account
