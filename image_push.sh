KUBE_VERSION=v1.7.2
KUBE_PAUSE_VERSION=3.0
ETCD_VERSION=3.0.17
DNS_VERSION=1.14.4

GCR_URL=gcr.io/google_containers
PUSH_URL=kingsylin


images=(kube-proxy-amd64:${KUBE_VERSION}
	kube-scheduler-amd64:${KUBE_VERSION}
	kube-controller-manager-amd64:${KUBE_VERSION}
	kube-apiserver-amd64:${KUBE_VERSION}
	pause-amd64:${KUBE_PAUSE_VERSION}
	etcd-amd64:${ETCD_VERSION}
	k8s-dns-sidecar-amd64:${DNS_VERSION}
	k8s-dns-kube-dns-amd64:${DNS_VERSION}
	k8s-dns-dnsmasq-nanny-amd64:${DNS_VERSION})


for imageName in ${images[@]} ; do
	  docker pull $GCR_URL/$imageName
	  docker tag $GCR_URL/$imageName $PUSH_URL/$imageName
	  docker push $PUSH_URL/$imageName
	  docker rmi $PUSH_URL/$imageName
done

