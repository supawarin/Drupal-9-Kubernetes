# Helm chart for drupal
Demo helm install drupal app run on kubernetes

![drupal-website-development-benefits-900dfc2f4107682ed634cb9fe1caccf8](https://user-images.githubusercontent.com/83863431/188821997-6f73d820-1311-4add-99c3-aff43c323e23.jpeg)

## 1.Clone peoject:

  git clone https://github.com/supawarin/Drupal-9-Kubernetes.git

## 2. Run app drupal and mariadb 

cd drupal_helmChart

command to run  :

  helm install testdrupal -f values-test.yaml ./ 


  helm install devdrupal -f values-dev.yaml ./ 


  helm install proddrupal -f values-prod.yaml ./ 


## Delete helm

  helm delete drupal           

## 3. Open localhost 

  kubectl get svc
  
use NodePort number , example below:

  <img width="714" alt="drupal10" src="https://user-images.githubusercontent.com/83863431/188840783-9eda466f-188c-4f8c-b0d9-0fc8b9c91627.png">

http://localhost:31978   for dev-drupal
http://localhost:31977   for test-drupal

  ![20200909-drupal-9-0-1](https://user-images.githubusercontent.com/83863431/188577221-1e91f747-9df3-44e5-ae52-fb056b0fcfc2.jpeg)
  
Follow the installation instructions from the wizard. Use the database credentials you configured earlier in the MySQL deployment.

For example, in our case, here is the data that should be specified on the Database configuration screen:

  ![Set-Drupal-Database-Settings](https://user-images.githubusercontent.com/83863431/188577312-bcd799e4-13b4-4062-8f7d-129b5940d1d7.jpeg)


Database name: drupal-database, same as MYSQL_DATABASE environment variable in the MySQL Deployment 

Database password: your_password, same as MYSQL_PASSWORD environment variable in the MySQL Deployment or secret

Host: drupal-mysql-service, same as the MySQL Service name

Port: 3306, same as the MySQL Service port


  ![installing-drupal-1](https://user-images.githubusercontent.com/83863431/188577379-47fdfd9a-39ab-46d5-a855-da931242b5dc.png)
  
  <img width="1537" alt="drupal11" src="https://user-images.githubusercontent.com/83863431/188841488-f0e552b8-ef30-4732-934f-efe66a58729c.png">

  
  
  
  
