docker build -t yashar1691/multi-client:latest -t yashar1691/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yashar1691/multi-server:latest -t yashar1691/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yashar1691/multi-worker:latest -t yashar1691/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yashar1691/multi-client:latest
docker push yashar1691/multi-server:latest
docker push yashar1691/multi-worker:latest

docker push yashar1691/multi-client:$SHA
docker push yashar1691/multi-server:$SHA
docker push yashar1691/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yashar1691/multi-server:$SHA
kubectl set image deployments/client-deployment client=yashar1691/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yashar1691/multi-worker:$SHA