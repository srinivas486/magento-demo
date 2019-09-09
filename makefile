# Set the context to Minikube and build MAgento Base Container
eval $(minikube docker-env)
docker build  -t magento-test containers/base/

# Create a storage class -- standard local disk pv with retain on release
kubectl apply -f manifests/storageClass.yml

# Create a Mysql statefulset for backend storage
kubectl apply -f manifests/mysql.yml

# Create an Ingress with customer1 and customer2 details
kubectl apply -f manifests/ingress.yml

# Deploy customer1 and customer2 Magento pods attached to a sommon disk
kubectl apply -f manifests/magento/magento-customer1.yml
kubectl apply -f manifests/magento/magento-customer2.yml

# Display the services to connect to
minikube service list

