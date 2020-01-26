# SYNTASA Installation using Google Marketplace Toolkit (mpdev)

### Prerequisites
Please read through the prerequisites document here:

[Syntasa Prerequisites](PREREQUISITES.md)

### Installing the Google Marketplace Toolkit

Once Docker is installed, extract the mpdev toolkit to simulate a Marketplace like deployment environment

Pull the MPDEV docker image:
```
sudo docker pull gcr.io/cloud-marketplace-tools/k8s/dev
```

Install MPDEV tools:
```
BIN_FILE="$HOME/bin/mpdev"
docker run \
  gcr.io/cloud-marketplace-tools/k8s/dev \
  cat /scripts/dev > "$BIN_FILE"
chmod +x "$BIN_FILE"
```

### Verify Installation of the Google Marketplace Toolkit

Run the following to diagonose and correctl setup your environment:
```
mpdev /scripts/doctor.py
```

### Install CRD

To run this kind of app, k8s needs CRD installed

to apply CRD from the google marketplace k8s toolkit:
```
git clone https://github.com/GoogleCloudPlatform/marketplace-k8s-app-tools.git
cd marketplace-k8s-app-tools/crd
kubectl apply -f app-crd.yaml
```
or you can apply configuration directly:
```
kubectl apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/marketplace-k8s-app-tools/master/crd/app-crd.yaml
```
---
#

### Cloning the repo
Clone the repo located here: https://github.com/syntasa-dev/syntasa-google-marketplace.git

Place it somewhere on your machine e.g. ~/home/<my_user>/

Once cloned or downloaded, please cd into the syntasa-google-marketplace directory

```
cd ~/home/<my_user>/syntasa-google-marketplace
```

Make the Deployer file executable
```
chmod +x deploy.sh
```

Export the Registry env variables
```
export REGISTRY=gcr.io/syntasa-public
export DEPLOYER_TAG=5.0.2
export TAG=latest
export APP_NAME=syntasa
```

### Gathering the required properties
When running the MPDEV installation, the following properties must be set

```
{
	"metastore_connection_name": "postgres_connection_name",
	"metastore_connection_user": "postgres_user_name",
	"metastore_connection_password": "postgre_password",
	"cluster_name": "cluster_name",
	"static_ip_address": "external_static_ip",
	"internal_static_ip_address": "internal_static_ip",
	"syn_secret_key": "syntasa_secret_key",
	"infrastructure_service_account": "iam_service_account_email",
	"syn_license": "my_license",
	"namespace": "default",
	"name": "syntasa-application",
	"whitelist_ips": "ips_to_whitelist"
}
```

### Running the MPDEV Installation
To run the Install type:
```
mpdev install --deployer=$REGISTRY/$APP_NAME/deployer:$DEPLOYER_TAG --parameters='{"metastore_connection_name" : "postgres_connection_name","metastore_connection_user" : "postgres_user_name","metastore_connection_password" : "postgre_password","cluster_name" : "cluster_name","static_ip_address" : "external_static_ip","internal_static_ip_address" : "internal_static_ip","syn_secret_key" : "syntasa_secret_key","infrastructure_service_account" : "iam_service_account_email","syn_license": "my_license","certificate": "{\"private_key\":\"my_key_as_String",\"certificate\":\"my_certificate_as_string"}","namespace": "default","name": "syntasa-application","whitelist_ips": "ips_to_whitelist "}'
```


### Deploying your changes
Please see the deploy script located here: 
> [SYNTASA Deploy Script](../deploy.sh)
---


When ready, please head to the static ip you reserved as follows: https://<my_static_ip>

Installation will take anywhere from 10 seconds to 2 minutes.

