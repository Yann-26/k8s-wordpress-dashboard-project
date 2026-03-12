kubectl apply -f namespace.yaml

kubectl apply -f mysql-secret.yaml
kubectl apply -f mysql-deployment.yaml
kubectl apply -f mysql-service.yaml

kubectl apply -f wordpress-configmap.yaml

kubectl apply -f pv.yaml
kubectl apply -f pvc.yaml

kubectl apply -f wordpress-deployment.yaml
kubectl apply -f wordpress-service.yaml