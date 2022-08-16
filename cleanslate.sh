#!/bin/bash

set -x

kubectl delete all --all
kubectl delete pvc --all

kubectl delete -f mysql-secret.yaml
kubectl delete -f mysql-pvc.yaml
kubectl delete -f drupal-pvc.yaml
kubectl delete -f drupal-mysql.yaml
kubectl delete -f drupal9.yaml

kubectl apply -f mysql-secret.yaml
kubectl apply -f mysql-pvc.yaml
kubectl apply -f drupal-pvc.yaml
kubectl apply -f drupal-mysql.yaml
kubectl apply -f drupal9.yaml