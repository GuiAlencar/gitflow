.DEFAULT_GOAL := create

pre:
	@kubectl apply -f manifests/
	@kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.8/config/manifests/metallb-native.yaml
	@kubectl wait --namespace metallb-system \
		--for=condition=ready pod \
		--selector=app=metallb \
		--timeout=300s
	
create:
	@kind create cluster --config config.yaml

up:	create pre

destroy:
	@kind delete cluster

