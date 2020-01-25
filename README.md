# SYNTASA Data Analytics and ML Platform for Google Marketplace
This Repository contains the SYNTASA Google Marketplace deployment scripts using HELM and the google development toolkit located here:

https://github.com/GoogleCloudPlatform/marketplace-k8s-app-tools

To get started please Install Docker/Helm/KubeCtl and any other dependeices required for the above dependencies


## Development Image Setup

Once Docker is installed, extract the mpdev toolkit to simulate a Marketplace like deployment environment
```
BIN_FILE="$HOME/bin/mpdev"
docker run \
  gcr.io/cloud-marketplace-tools/k8s/dev \
  cat /scripts/dev > "$BIN_FILE"
chmod +x "$BIN_FILE"
```

## Run the doctor tool

Run the following to diagonose and correctl setup your environment:
```
mpdev /scripts/doctor.py
```

## Install CRD

To run this kind of apps, k8s needs installed CRD.

```
git clone https://github.com/GoogleCloudPlatform/marketplace-k8s-app-tools.git
cd marketplace-k8s-app-tools/crd
kubectl apply -f app-crd.yaml
```
or you can apply configuration directly:
```
kubectl apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/marketplace-k8s-app-tools/master/crd/app-crd.yaml
```

## Installing the SYNTASA microservice stack

---TBD---