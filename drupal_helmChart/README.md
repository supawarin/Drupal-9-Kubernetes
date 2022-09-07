# Helm chart for drupal
Demo helm install drupal app run on kubernetes


## Run app drupal , mariadb and phpmyadmin

helm install drupal -f values-test.yaml ./ 

helm install drupal -f values-dev.yaml ./ 

helm install drupal -f values-prod.yaml ./ 

## Delete all

helm delete drupal           
