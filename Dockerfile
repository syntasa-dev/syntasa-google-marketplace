FROM launcher.gcr.io/google/debian9 AS build

#### Update the debian environment
RUN apt-get update \
    && apt-get install -y --no-install-recommends gettext

#### Copy the Syntasa Helm Charts
ADD chart/syntasa /tmp/chart
RUN cd /tmp && tar -czvf /tmp/syntasa.tar.gz chart

#### Copy Tester Charts
ADD apptest/deployer/syntasa /tmp/test/chart
RUN cd /tmp/test && tar -czvf /tmp/test/syntasa.tar.gz chart/

#### Add the Schema.yaml to the container
ADD schema.yaml /tmp/schema.yaml

#### Replace the parameters in the schema.yaml with the passed in arguments
ARG REGISTRY
ARG APP_NAME
ARG TAG

RUN cat /tmp/schema.yaml \
    | env -i "REGISTRY=$REGISTRY" "APP_NAME=$APP_NAME" "TAG=$TAG" envsubst \
    > /tmp/schema.yaml.new \
    && mv /tmp/schema.yaml.new /tmp/schema.yaml


ADD apptest/deployer/schema.yaml /tmp/apptest/schema.yaml

RUN cat /tmp/apptest/schema.yaml \
    | env -i "REGISTRY=$REGISTRY" "APP_NAME=$APP_NAME" "TAG=$TAG" envsubst \
    > /tmp/apptest/schema.yaml.new \
    && mv /tmp/apptest/schema.yaml.new /tmp/apptest/schema.yaml


#### Use the Helm Deployer from Google
FROM gcr.io/cloud-marketplace-tools/k8s/deployer_helm

#### Copy the Syntasa Charts into the HELM Deployer Image
COPY --from=build /tmp/syntasa.tar.gz /data/chart/
COPY --from=build /tmp/schema.yaml /data/

#### Copy the Syntasa Test Chart into the HELM Deployer Image
COPY --from=build /tmp/test/syntasa.tar.gz /data-test/chart/
COPY --from=build /tmp/apptest/schema.yaml /data-test/

