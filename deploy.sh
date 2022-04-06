docker build -t shahabejaz/multi-client:latest -t shahabejaz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shahabejaz/multi-server:latest -t shahabejaz/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shahabejaz/multi-worker:latest -t shahabejaz/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shahabejaz/multi-client:latest
docker push shahabejaz/multi-server:latest
docker push shahabejaz/multi-worker:latest

docker push shahabejaz/multi-client:$SHA
docker push shahabejaz/multi-server:$SHA
docker push shahabejaz/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=shahabejaz/multi-server:$SHA
kubectl set image deployments/client-deployment server=shahabejaz/multi-client:$SHA
kubectl set image deployments/worker-deployment server=shahabejaz/multi-worker:$SHA