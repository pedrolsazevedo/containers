## Wordpress
My first template in this repo is a model for a deployment of Wordpress CMS.
It relies on Ngingx Ingress, Longhorn and Azure Files storage class.

1. Description
    1.1 **`00-wp-namespace.yaml`**
    [Namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)
    This file create the namespace to host all the artifacts created

    1.2  **`01-wp-pvc.yaml`**
    [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
    This file creates the volume following volume claim:

    - **`wp-pvc-longhorn-claim`**
    Size: 5Gi
    StorageClass: longhorn
    ReadMode: ReadWriteMany (Allows all pods to claim the volume)

    - **`wp-pvc-azurefiles-claim`**
    Size: 15Gi
    StorageClass: azurefile
    ReadMode: ReadWriteOnce (The volume is claimed only once per day.)

    1.3 **`02-wp-configmap-secrets.yaml`**
    [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/)  
    [Secret](https://kubernetes.io/docs/concepts/configuration/secret/)
    This files creates a configmap with the .htaccess file and a secret with the database credentials.

    - **`wp-cm-htaccess`**
    I've created the .htaccess in a secret so I can manage the upload more easily

    - **`wp-cm-dbcred`**
      Convert the text all credentials to base64 and change in each string.

    1.4 **`03-wp-deployment.yaml`**
    [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
    This is the "main" file, it will create a deployment that will create a replicaset that allows the application to run on the nodes
    **`image:`** wordpress:php8.0-apache
    **`resources:`**
        **`cpu:`** 
            **`requests:`** 100mi (Value requested on a pod is created)
            **`limit:`** 200mi (Total that a pod can request)
        **`memory:`**
            **`requests:`** 256Mi (Value requested on a pod is created)
            **`limit:`** 512Mi (Total that a pod can request)
    1.5 **`04-wp-hpa.yaml`**
    [Horizontal Pod Autoscaling](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)
    This file will create the configuration for autoscaling your deployment, it will ensure that you have a amount of pods between your minimum and maximum replicas.
    With the monitoring in your cluster, when the pods keeps a load average equal or bigger than what's defined in this file,  the control plane will create more pods to delivery divide the load between them.
    **`minReplicas:`** 1 (Minimum replicas that will run)
    **`maxReplicas:`** 6 (Max replicas that the scheduling will create)
    **`resources:`**
    	**`cpu:`** 
    	  **`targetAverageUtilization:`** 80 (The raw value will be converted to percentage of resource usage)
        **`memory:`**
          **`targetAverageUtilization:`** 80 (The raw value will be converted to percentage of resource usage)
    1.6 **`05-wp-backupfile-cronjob.yaml`**
    
    ​	This file creates a **`CronJob`** that will run everyday at 01:01 and run a copy from the longhorn PVC to the azure PVC
