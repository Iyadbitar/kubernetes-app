docker build -t iyadbitar/multi-client:latest -t iyadbitar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t iyadbitar/multi-server:latest -t iyadbitar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t iyadbitar/multi-worker:latest -t iyadbitar/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push multi-client:latest
docker push multi-server:latest
docker push multi-worker:latest

docker push multi-client:$SHA
docker push multi-server:$SHA
docker push multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=iyadbitar/multi-client:$SHA
kubectl set image deployments/server-deployment server=iyadbitar/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=iyadbitar/multi-worker:$SHA