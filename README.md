# Drupal-9-Kubernetes
![drupal-website-development-benefits-900dfc2f4107682ed634cb9fe1caccf8](https://user-images.githubusercontent.com/83863431/188564079-81374945-b4a1-4dab-828b-34a6072c0bc6.jpeg)

create drupal-9 run on  kubernetes
How to easily deploy a Drupal instance on Kubernetes
Drupal is quite a popular CMS with a big community. It is especially popular among large enterprises and for complex websites. In fact, some of the most visited sites in the world like NBC, The Economist, Cisco, RedHat or Tesla use Drupal as their corporate website CMS.


Prerequisites
We will assume that you have an up and running Kubernetes cluster and that kubectl is already installed in your workstation with the right credentials to execute commands in your cluster. Additionally, we will assume that you have a deployed volume provisioner.

Preparing the data persistence infrastructure
Since Kubernetes containers are not data-persistent, it is necessary to use volumes in order to preserve the data. Otherwise, all the changes written to the database or to any directory will be lost after the container restarts.

In Kubernetes it is recommended to use the PersistentVolume object to retain the data. A PersistentVolume is a representation of persistent storage. It supports many underlying technologies and storage services: NFS, Cinder, Gluster, Ceph, AWS EBS, Google Persistent Disk,…


#### 1.The way to do that is to create a PersistentVolumeClaim. Create drupal-pvc.yaml ####

  In this case we request two volumes of 3Gi each that will be provided automatically through a persistent volume. The first will be used for the website files, and the second one for the database.
  
     1.1 create mysql-pvc.yaml file below :
   <img width="550" alt="drupal1" src="https://user-images.githubusercontent.com/83863431/188566077-8e16a492-90d4-4943-875b-2f67f6271834.png">

     Run the command: kubectl apply -f mysql-pvc.yaml
     
     1.2 create drupal-pvc.yaml file below :
   <img width="617" alt="drupal2" src="https://user-images.githubusercontent.com/83863431/188566579-8fd00093-ba39-4755-892a-1a6395b84dae.png">

     Run the command: kubectl apply -f drupal-pvc.yaml
     
After a few seconds, check that your volumes have been provided. If everything is fine, you should see that the PersistentVolumes has been provisioned and the PersistentVolumeClaims have been bound to it. 

     Run the command: kubectl get pvc
     
     
#### 2.Deploying a MySQL  ####

To deploy the MySQL instance we will use a Deployment and a Service. Note that we run MySQL from root. When you run it in production, use custom credentials. 
     2.1 Create mysql-secret.yaml file below :
     <img width="774" alt="drupal7" src="https://user-images.githubusercontent.com/83863431/188572279-87e47bad-ccf3-44e2-872c-bf224e835947.png">
     
     Run the command : kubectl apply -f mysql-secret.yaml
     
     Then check that the secret is running: kubectl get secret
     
     2.2 Create drupal-mysql.yaml file below : ( mysql-service + mysql-deployment )
     
   <img width="488" alt="drupal3" src="https://user-images.githubusercontent.com/83863431/188569883-b0ee5e6e-c3a2-458e-9308-4803fcee8bb2.png">
   <img width="622" alt="drupal4" src="https://user-images.githubusercontent.com/83863431/188570166-14e63a23-1dd4-49bd-8f1c-644c525dc4ef.png">
   <img width="600" alt="drupal5" src="https://user-images.githubusercontent.com/83863431/188570339-725f8b79-2282-4b5e-9048-bb5e8ac20ba6.png">

     Run the command : kubectl apply -f drupal-mysql.yaml
     
     Then check that the pod is running: kubectl get svc and kubectl get pods
     
     
#### 3.Deploying Drupal ####

The Deployment will be based on a container with a Drupal image from Docker Hub repository. In addition, we will also use a temporary container (InitContainer) whose mission will be to pre-populate the persistent storage with the data used by Drupal. 

     3.1 Create drupal9.yaml file below : ( drupal-service + drupal-deployment )
     
   <img width="459" alt="drupal6" src="https://user-images.githubusercontent.com/83863431/188571707-30908289-f820-478d-a550-8341d2f37705.png">
   <img width="812" alt="drupal8" src="https://user-images.githubusercontent.com/83863431/188573373-70a971ea-724f-4c89-9688-ec62f2e23066.png">
   <img width="665" alt="drupal9" src="https://user-images.githubusercontent.com/83863431/188573571-14e2e178-b225-46eb-9ab4-cb492e325d4e.png">


     Run the command: kubectl apply -f drupal9.yaml
     
     Then check it : kubectl get svc  and kubectl get  pods

Installing Drupal
Now that the infrastructure has been deployed, let’s install Drupal. You have just to navigate to the IP address and port you got in the previous step OR if you do not use cloud provider’s load balancer and have an external IP for your machine, navigate to external_IP:port.
If use minikube must run command kubectl port-forward svc/drupal9-service 32355:80    {example}

Follow the installation instructions from the wizard. Use the database credentials you configured earlier in the MySQL deployment.

For example, in our case, here is the data that should be specified on the Database configuration screen:

Database name: drupal-database, same as MYSQL_DATABASE environment variable in the MySQL Deployment 

Database password: your_password, same as MYSQL_PASSWORD environment variable in the MySQL Deployment or secret

Host: drupal-mysql-service, same as the MySQL Service name

Port: 3306, same as the MySQL Service port
![Drupal_7_screenshot](https://user-images.githubusercontent.com/83863431/188574107-f0729429-a45e-4c47-9b15-e45635ec4e9a.png)


And that’s it! You have a working Drupal instance now, deployed in less than 10 minutes. Congratulations!

