# GOOGLE Marketplace Pre-setup

For a successful deployment from the Google Cloud Console Marketplace, please follow the following steps befor attempting
to install from the Marketplace.

> Before beginning, please make sure you have at least Project Editor access to the Project in which you wish to install the SYNTASA application from the marketplace.  If you are unsure about your accesses, please contact your Cloud Devops or IT administrator.

### Obtaining a license

Please see the following document to obtain a license for the SYNTASA platform.

### Enabling API's

To use all the services required by the SYNTASA application, please enable a few of the API's to get started.

1. Launch the Google Cloud Console - [GCP Console]()https://console.cloud.google.com/)
2. Make sure you're logged into the console with the correct credentials (to change, click the profile icon on the top right of the screen)
3. Navigate to the correct project by clicking on the project drop-down menu in the top bar (next to the text that says 'Google Cloud Platform')
4. Using the hamburger icon on the top left of the console, navigate to the 'APIs & Services' tab
5. Click the 'Enable APIs and Services' button on the top bar
6. In the search bar, please search for the 'Kubernetes Engine API'
7. Click 'Enable'
8. Repeat Steps 5 through 7 for 'Cloud SQL Admin'

[`SYNTASA License Information`](SYN_LICENSE_INFO.md)

### Create an IAM Account

In order to ensure the Kubernetes cluster we create has the correct permissions, please create a IAM Service Account

1. Using the Hamburger icon on the top left of the Console, navigate to the 'IAM & Admin' page.
2. Click on 'Service Accounts' tab
3. Click the 'Create Service Account' button on the top menu bar
4. Fill in the 'Service Account Name' field with a name of your choice, e.g. 'syntasa-application-serviceacc'
5. Fill in the 'Service Account Description' field with a descripton of your choice, e.g. 'Service Account for SYNTASA Deployment'
6. Click the 'Create' button at the bottom to continue to the next page.
7. On the 'Service Account Permissions' page please add the following roles to the service account

To Add a role, click on the 'Select role' field and type one of the following roles into the search box that appears.
To continue adding roles, click on 'Add Another Role' and continue until all roles have been added.

> BigQuery Admin

> Cloud SQL Admin

> Compute Admin

> Kubernetes Engine Cluster Admin

> Kubernetes Engine Developer

> Kubernetes Engine Service Agent

> Dataproc Administrator

> Dataproc Worker

> Service Account User

> Storage Admin

8. Once all roles have been added, click the 'Continue' button
9. Leave the 'Service Account users role' and 'Service account admins role' blank.
10. (OPTIONAL) if you wish to create a JSON key, please click the 'Create Key' button
11. Click the 'Done' button and note down the email address of your service account (you will need this when creating the kubernetes cluster later).  The email will look something like this: 
```$xslt
'syntasa-application-serviceacc@<my_project>.iam.gserviceaccount.com'
```


### Create an External Metastore

SYNTASA uses an external Metastore to save metadata and state information, please create one using the steps below.

1. Click the hamburger icon on the left and navigate to the 'SQL' tab
2. Click on 'Create Instance' on the top menu bar
3. On the next screen, pick a Database Type, please pick 'Choose PostgreSQL'
4. Fill in the following fields

> Instance ID - Please choose a name for the metastore e.g. 'syntasa-metastore-pg'

> Default User Password - Please pick a password that is sufficiently complex e.g. 'mySup3erP@$$'

> Location - Please pick a Region and Zone for your Metastore to be hosted in.  Please note that it is very important to pick a region and zone that will be the same region as the Kubernetes cluster you will create later.

> Database Version - Please pick PostgreSQL 9.6

5. Once filled out, please click the 'show configuration options' link on the bottom of the page
6. After the new sub-menu opens up, click the 'Flags' section to open that section up.
7. Click 'Add Item'
8. Click the 'Choose one' drop-down box
9. Search for a flag named 'max_connections'
10. Once selected, please enter a value of 100 in the max_connections field.
11. Click 'Close'
12. Click the 'Create' button at the bottom.
13. Once your Metastore has finished creating (this might take anywhere from 2-10 minutes), please note down the 'Instance Connection Name' which should look like the following:
```
    <my_project>:<my_region>:syntasa-metastore-pg
```

### Reserve a Static External IP

Although a Static IP is not required, it is highly preferred to use a static ip.  Please follow the steps below to create an external static ip reservation.

1. Click the hamburger icon on the left and navigate to the 'VPC' tab
2. Once in the VPC Section, please select 'External IP Addresses' on the left hand menu.
3. Click the 'Reserve Static Address' button on the top toolbar menu
4. On the 'Reserve Static address' screen, please fill in the following fields

> Name - Please pick any name, e.g. 'syntasa-application-static-ip'

> Description - Please fill in a short description e.g. 'Reservation for Syntasa Application'

> Network Service Tier - Pleasee select Premium

> IP Version - Please select IPv4

> Type - Please select Regional

> Region - Please select a region that is in line with the metastore region you selected above.

> Attaced To - Please leave as default 'None'

5. Once filled in, please click the 'Reserve' button and take note of the Name you provided for the Static IP Name.

### Creating a Kubernetes Cluster

In order to deploy the SYNTASA application from the Google Cloud Marketplace, we will need to create a cluste first.

1. Click the hamburger icon on the top left and click on 'Kubernetes Engine'
2. On the Clusters tab, click the 'Create Cluster' button
3. On the left hand radio button list, please select 'standard cluster'
4. In the Name field, please type a name for your cluster e.g. 'syntasa-app-cluster'
5. In the Zone field, please select the Zone that corresponds to the region and zone you selected for the metastore above.
6. For the 'Master Version' please leave as default.
7. For Number of Nodes (under node-pools), please select 3
8. For Machine type, please select n1-highmem-4
9. Click the 'More Options' button under the node-pools section
10. Under Security -- Service Account, please select the service account we created above in the service accounts section.
11. Under 'Management' please uncheck the 'Enable auto-upgrade' option.
12. Click 'Save'
13. Click 'Create'
14. Cluster creation will take somewhere between 5-10 minutes.


### Deploying the SYNTASA application

Once all the steps above are complete, we can head to the Google Marketplace to deploy the SYNTASA application.

1. Click the hamburger icon and head to 'Marketplace'
2. In the search box that appears, please type 'syntasa' and hit enter.
3. Select the SYNTASA application in the result list.
4. Click the 'Configure' Icon
5. Under the Cluster option, please make sure the cluster we created above is selected.
6. Please follow the steps located here for a field descriptions.

[`SYNTASA Marketplace Configuration Options`](MARKETPLACE_CONFIG_OPTIONS.md)

For any further questions or help, please contact info@syntasa.com or help@syntasa.com