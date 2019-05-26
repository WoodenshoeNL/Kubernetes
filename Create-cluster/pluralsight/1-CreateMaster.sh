

wget https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/hosted/rbac-kdd.yaml
wget https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/hosted/kubernetes-datastore/calico-networking/1.7/calico.yaml

vim calico.yaml
#pas cidr aan

sudo kubeadm init --pod-network-cidr=10.241.0.0/16 --ignore-preflight-errors=NumCPU

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f rbac-kdd.yaml
kubectl apply -f calico.yaml

kubectl get pods --all-namespaces

kubectl get nodes


