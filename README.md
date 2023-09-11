# k8s-django-app

## About

This repository is a demonstration of how to deploy a Django based application in a highly availabilible and scalable kubernetes environment. Using as model the repo django-realworld-example-app by gothinkster.

___

## How to

### Requirements

- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) versioning control system installed. 
- [Docker](https://docs.docker.com/engine/install/) or other container platform of your choice installed.
- [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation) or other tool for running local Kubernetes clusters
- A local Kubernetes cluster up and running at least 2 nodes
- [kubectl](https://kubernetes.io/docs/tasks/tools/) tool for CLI interaction

### Steps

1. Clone the repository files to a local folder on your computer:
    
    ```
   git clone https://github.com/ewertao/k8s-django-app.git
    ```
    
2. Move the the main folder k8s-django-app.
    
    ```
   cd k8s-django-app
    ```
    
3. Pull the image available on my Docker hub.
    
    ```
   docker pull ewertao/k8s-django-app:latest
    ```
    
4. Apply the Kubernetes Manifests on folder k8s-config.
    
    ```
   kubectl apply -f k8s/
    ```
    
5. Perform a port-forward from the cluster IP service port 8000 to your local machine port 8000 as well.
    
    ```
   kubectl port-forward services/django-app-services 8000:8000
    ```
    
6. Access the application interface by opening your preferred browser and accessing
    
    ```
   localhost:8000/api
    ``` 
    
___

## Details

- The application must not be implemented in a production environment.
- The application uses outdated tools, such as versions of Python:3.5.2 and Django:1.10.5.
- The application has several security vulnerabilities due to the use of outdated versions. Such as [CVE-2019-19844 (classified as Critical)](https://nvd.nist.gov/vuln/detail/CVE-2019-19844) that allows a account takeover.
The full list of 37 vulnerabilities can be found in the [vulnerabilityscan.txt](https://github.com/ewertao/k8s-django-app/blob/main/vulnerabilityscan.txt) file
- The python-alpine base image was chosen because it is a known stable and lean image, allowing for a smaller final image and also more secure.
```
REPOSITORY               TAG            IMAGE ID       CREATED        SIZE
ewertao/k8s-django-app   latest         e48be40356c4   13 hours ago   138MB
python                   3.5.2          432d0c6d4d9a   6 years ago    687MB
python                   3.5.2-slim     783dcbbe2366   6 years ago    198MB
python                   3.5.2-alpine   e70a322afafb   6 years ago    88.1MB
```
- The `ewertao/k8s-django-app:latest` image was signed using the cosign tool to guarantee its authenticity.
- Fault tolerance can be easily proven by trying to delete any of the running pods.
- CPU-based scalability can be tested using Metric Server and a stress testing application such as Apache Benchmark.
- The scalability option selected in Kubernetes for the simulation in the controlled local environment was IP Cluster.
- In the case of a Django application like this one in a productive environment in a Cloud Provider, the Load Balance services option would be the best, as it ensures the inclusion of nodes through services such as the AWS ASG.
- It was not possible to register a superuser for the Django application when building the image or deploying the pods. Such configuration can be included in a future version through some python or bash script that works to include email, user and password via secret.
- Such configurations in the local test scenario could be passed through the kubectl exec command, but for the production environment it is not recommended.
- In the secrets.yaml file are simulations of credentials and database string that can be passed in the deployment of the pods.

___
## Conclusion

Django applications are easily applicable to the world of containers and Kubernetes. Dispensing with the use of a python virtual environment and enabling the specific version selection when building the image.

Security issues and vulnerabilities are points that can be easily corrected using the updated versions of the tools, which even makes it possible to use a distroless base image, which guarantees even more security by using only the elements necessary to run the application.

In a productive scenario, such an application would be able to scale horizontally effectively, using the scalability of pods and even nodes. Ensuring resilience and reliability for application administrators and users.
