docker build -t codixir/multi-client:latest -t codixir/multi-client:$SHA -f ./client/Docekrfile ./client
docker build -t codixir/multi-server:latest -t codixir/multi-server:$SHA -f ./server/Docekrfile ./server
docker build -t codixir/multi-worker:latest -t codixir/multi-worker:$SHA -f ./worker/Docekrfile ./worker
docker push codixir/multi-client:latest 
docker push codixir/multi-server:latest 
docker push codixir/multi-worker:latest

docker push codixir/multi-client:$SHA 
docker push codixir/multi-server:$SHA 
docker push codixir/multi-worker:$SHA 

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=codixir/multi-server:$SHA
kubectl set image deployments/client-deployment client=codixir/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=codixir/multi-worker:$SHA