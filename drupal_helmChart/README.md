# Helm chart for drupal
Demo helm install drupal app run on kubernetes

![drupal-website-development-benefits-900dfc2f4107682ed634cb9fe1caccf8](https://user-images.githubusercontent.com/83863431/188821997-6f73d820-1311-4add-99c3-aff43c323e23.jpeg)



## Run app drupal and mariadb 

helm install testdrupal -f values-test.yaml ./ 

helm install devdrupal -f values-dev.yaml ./ 

helm install proddrupal -f values-prod.yaml ./ 

## Delete all

helm delete drupal           

