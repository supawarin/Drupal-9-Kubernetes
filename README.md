# Drupal-9-Kubernetes
create drupal-9 run on minikube (kubernetes)
How to easily deploy a Drupal instance on Kubernetes
Drupal is quite a popular CMS with a big community. It is especially popular among large enterprises and for complex websites. In fact, some of the most visited sites in the world like NBC, The Economist, Cisco, RedHat or Tesla use Drupal as their corporate website CMS.

In this article I will explain how to easily deploy a working instance of Drupal and MySQL on Kubernetes. You will notice that it will take you more time to read this tutorial than to deploy the instance. It’s the magic of Kubernetes!

Prerequisites
We will assume that you have an up and running Kubernetes cluster and that kubectl is already installed in your workstation with the right credentials to execute commands in your cluster. Additionally, we will assume that you have a deployed volume provisioner.

Preparing the data persistence infrastructure
Since Kubernetes containers are not data-persistent, it is necessary to use volumes in order to preserve the data. Otherwise, all the changes written to the database or to any directory will be lost after the container restarts.

In Kubernetes it is recommended to use the PersistentVolume object to retain the data. A PersistentVolume is a representation of persistent storage. It supports many underlying technologies and storage services: NFS, Cinder, Gluster, Ceph, AWS EBS, Google Persistent Disk,…

It is possible to create a PersistentVolume either statically or dynamically. In this article we chose a dynamically-created PersistentVolume since it is easier to manage.

1.The way to do that is to create a PersistentVolumeClaim. Create drupal-pvc.yaml
  In this case we request two volumes of 5GB each that will be provided automatically through a persistent volume. The first will be used for the website files, and the second one for the database.
  1.1 Run the command: kubectl apply -f drupal-pvc.yaml
  After a few seconds, check that your volumes have been provided. If everything is fine, you should see that the PersistentVolumes has been provisioned and the PersistentVolumeClaims have been bound to it. Run the command: kubectl get pvc
2.Deploying a MySQL instance
To deploy the MySQL instance we will use a Deployment and a Service. Note that we run MySQL from root. When you run it in production, use custom credentials. Create drupal-mysql.yaml 
  2.1 Run the command : kubectl apply -f drupal-mysql.yaml
  2.2 Then check that the pod is running: kubectl get pods
3.Deploying Drupal
The Deployment will be based on a container with a Drupal image from Docker Hub repository. In addition, we will also use a temporary container (InitContainer) whose mission will be to pre-populate the persistent storage with the data used by Drupal. Create drupal9.yaml
  3.1 Rum the command: kubectl apply -f drupal.yaml
  3.2 Then check it : kubectl get svc

Installing Drupal
Now that the infrastructure has been deployed, let’s install Drupal. You have just to navigate to the IP address and port you got in the previous step OR if you do not use cloud provider’s load balancer and have an external IP for your machine, navigate to external_IP:port.
If use minikube must run command kubectl port-forward svc/drupal9-service 32355:80    {example}

Follow the installation instructions from the wizard. Use the database credentials you configured earlier in the MySQL deployment.

For example, in our case, here is the data that should be specified on the Database configuration screen:

Database name: drupal-database, same as MYSQL_DATABASE environment variable in the MySQL Deployment
Database password: your_password, same as MYSQL_PASSWORD environment variable in the MySQL Deployment
Host: drupal-mysql-service, same as the MySQL Service name
Port: 3306, same as the MySQL Service port
And that’s it! You have a working Drupal instance now, deployed in less than 10 minutes. Congratulations!

