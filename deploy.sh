docker build -t borissoto/multi-client:latest -t borissoto/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t borissoto/multi-server:latest -t borissoto/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t borissoto/multi-worker:latest -t borissoto/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push borissoto/multi-client:latest
docker push borissoto/multi-server:latest
docker push borissoto/multi-worker:latest

docker push borissoto/multi-client:$SHA
docker push borissoto/multi-server:$SHA
docker push borissoto/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=borissoto/multi-server:$SHA
kubectl set image deployments/client-deployment client=borissoto/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=borissoto/multi-worker:$SHA