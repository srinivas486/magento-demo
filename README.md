# magento-demo
Demo Repository For Magento K8s Demo

# Note:
mane needs make, gettext 
in mac do, 
brew install gettext
brew link --force gettext 
Magento-CE-2.3.2-2019-06-13-03-23-52.tar.gz file needs to be added to container/payload folder post cloing the repo.

hyperkit uses uuid to generate macid's so you will always get the same ip for minikube
minikube start --vm-driver hyperkit --insecure-registry "10.0.0.0/24" --uuid 00000000-0000-0000-0000-000000000001 --cpus 4 --memory 8000

Enable minikube registry addon
Add minikube ip:5000  to docker insecure registries list

make build


echo "CREATE DATABASE IF NOT EXISTS magento_customer1;" | mysql -h mysql.mysql -P 3306 -u root -proot