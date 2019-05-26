#https://app.pluralsight.com/player?course=kubernetes-installation-configuration-fundamentals&author=anthony-nocentino
#Setup

swapoff -a

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo bash -c 'cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF'

sudo apt-get update

sudo apt-get install -y docker.io kubelet kubeadm kubectl
sudo apt-mark hold docker.io kubelet kubeadm kubectl

sudo systemctl enable kubelet.service
sudo systemctl enable docker.service
