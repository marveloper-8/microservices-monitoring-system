minikube start

minikube addons enable ingress

kubectl apply -f k8s/prometheus/
kubectl apply -f k8s/grafana/
kubectl apply -f k8s/nginx-ingress/
kubectl apply -f k8s/sample-app/

eval $(minikube docker-env)
docker build -t sample-app:latest sample-app/
kubectl rollout restart deployment sample-app

kubectl wait --for=condition=ready pod -l app=prometheus --timeout=300s
kubectl wait --for=condition=ready pod -l app=grafana --timeout=300s
kubectl wait --for=condition=ready pod -l app=jaeger --timeout=300s
kubectl wait --for=condition=ready pod -l app=sample-app --timeout=300s

echo "Prometheus: $(minikube service prometheus --url)"
echo "Grafana: $(minikube service grafana --url)"
echo "Jaeger: $(minikube service jaeger-query --url)"
echo "Sample App: $(minikube service sample-app --url)"