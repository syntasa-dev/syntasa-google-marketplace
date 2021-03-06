## SYNTASA Google Cloud Marketplace Configuration Options

When configuring the SYNTASA App in Google Marketplace, you will need to enter the below fields.  Please see the descriptions for what each
field is and why it is required.

*Before beginning, please make sure that your Google Cloud Platform IAM user has the necessary Kubernetes Engine Admin Permissions.  This is required
to create Kubernetes Service resources.*

**Namespace**

>Namespace is by default set to the default namespace.  If required, please choose a namespace of your liking, most common
entries for this field is something like 'syntasa'

**App Instance Name**

> For this field, please feel free to select any name you wish to use for the deployment.  Default is usually something 
along the lines of 'syntasa'

**License Key**

> SYNTASA is a Bring-Your-Own-License solution, therefore you must get a license from SYNTASA before proceeding to continue
with the installation.  Please see: [`SYN_LICENSE_INFO.md`](/docs/SYN_LICENSE_INFO.md)

**Secret Key**

> SYNTASA uses a secret key in conjunction with the license key to provide database encryption mechanisms.  Please see the
following document for more information.  [`SYN_LICENSE_INFO.md`](/docs/SYN_LICENSE_INFO.md)

**IP Address of Reserved External IP**

> If you wish to use your own External IP Address, please provide the IP address here (such as a GKE reserved external static IP), for
more information about how to setup a external IP, please see the documentation located here: [`Prerequisites - External Static IP Reservation`](https://github.com/syntasa-dev/syntasa-google-marketplace/blob/master/docs/PREREQUISITES.md#external-static-ip-reservation-optional)

**Source IP Address Filter**

> This field denotes what IP addresses the SYNTASA Application UI will be open to.  The default value is 0.0.0.0/0 which means
it will be open to the entire world.  This is not recommended.  Please find the IP address to either your office or wherever
you wish to access the application from to limit exposure.  This field takes CIDR Notation IP Address values in a comma separated
list, e.g. 10.10.0.1/32,10.10.1.1/32.

**External Metastore Connection Name**

> SYNTASA uses an External Cloud SQL metastore to store state information about the platform.  It is recommended to have this
in an external Cloud SQL instance as documented in the prerequisite documentation located here: [`Prerequisites - External Metastore`](https://github.com/syntasa-dev/syntasa-google-marketplace/blob/master/docs/PREREQUISITES.md#external-metastore)

**External Metastore Connection Username**

> The username to use to connect to the external metastore listed previously.  For Postgres databases, this user is usually 'postgres'

**External Metastore Password**

> The password you chose when creating your external metastore above.

**GCP IAM Role for Infrastructure Services**

> SYNTASA requires a GCP IAM role to be present when creating the Application.  This IAM role will need to be created
ahead of time in the GCP IAM Console.  Please see the prerequisites document for more information: [`Prerequisites - Google Cloud Service Account`](https://github.com/syntasa-dev/syntasa-google-marketplace/blob/master/docs/PREREQUISITES.md#google-cloud-service-account)

**Syntasa Service Account Agent**

> In order to be able to install all the necessary cluster permissions, a Service account will need to be created to 
allow the SYNTASA deployer platform to install all the necessary Kubernetes Cluster services.  Please allow the app to create
a new Kubernetes Service Account

**Storage Class**

> This is the persistent volume where the SYNTASA app will store some application metadata.  Please allow the app to create
a new storage class.

**Storage size for persistent volumes**

> Each container within the Kubernetes cluster (for SYNTASA) requires a volume to use for frontend/backend/platform services,
The default size of 20Gi is usually sufficient.


## Accessing the SYNTASA Application UI

Once you hit the "Deploy button" in the Google Marketplace SYNTASA Application, please allow a few minutes for all services
to be deployed and ready.  To access the SYNTASA Application UI, please follow the below guidance:

1. If you specified a static IP in the 'IP Address of Reserved External IP' field, then your application URL link will be as follows:
> https://<your_static_ip>

2. If you allowed the default empty value to remain, then the SYNTASA application will choose an ephemeral IP to use and your URL link will need to be 
gathered by:
> 1. Navigate to the Services & Ingresses page
> 2. Locate the 'syntasa-ingress' load balancer 
> 3. Copy the IP address and navigate to it in a new browser tab.
> 4. Your IP will be in the format https://<some_ephemeral_ip>

For any further questions or help, please contact `info@syntasa.com` or `help@syntasa.com`
