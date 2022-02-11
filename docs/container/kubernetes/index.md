# Modelos básicos
  Criei esse repositório para armazenar templates que acabo usando no dia a dia ou para estudo.

## Kubernetes  
  1. [Wordpress](modelos/wordpress/index.md)  
    Modelo de wordpress utilizando:  
      * Banco de dados externo.  
      * HPA (Horizontal Pod Autoscalling).  
      * Armazenamento com Longhorn e AzureFils.  
      * CronJob para cópia diária dos dados.  
      * Ingress.
  1. [NGINX LB para RKE2](modelos/NGINX/index.md)  
    Modelo cria 5 regras, que foram usadas para balancear tráfego entre os nós de um cluster RKE2.  
    As regras são:  
    * Redirecionamento das requisições HTTP para HTTPS usando HTTPCODE 301.
    * Nós control-plane porta 6443 # Porta usada para requisições à Kube-API.
    * Nós control-plane porta 443  # Porta usada para tráfego HTTPS.
    * Nós control-plane porta 9345 # Porta usada para join dos nós ao cluster.
    * Nós workers porta 443 # Trafego para as requisições HTTPS.
