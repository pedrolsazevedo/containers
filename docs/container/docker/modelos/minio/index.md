## Descrição
Muitas aplicações, como Longhorn, necessitam de um endpoit S3 para armazenamento em bloco. Até o momento a azure não oferece isso de forma nativa no serviço.  
Uma opção para atender essa necessidade é utilizar o **`Minio Azure Gateway`**, este modelo de `docker compose` necessita que voce possua uma `Storage Account` já criada.

```yaml
version: '3.9'
services:
  minio-azr-s3:
    container_name: azure-s3
    image: quay.io/minio/minio
    ports:
      - '9000:9000'
      - '9001:9001'
    volumes:
      - '/opt/minio/data:/data'
    environment:
      # MINIO_ROOT_USER: Usuário administrador para acessar o Minio. 
      - "MINIO_ROOT_USER=minio_admin_CHANGEME"
      # MINIO_ROOT_PASSWORD: Senha para o administrador.
      - "MINIO_ROOT_PASSWORD=minio_admin_password_CHANGEME"
      # AZURE_STORAGE_ACCOUNT: Nome da StorageAccount que você criou.
      - "AZURE_STORAGE_ACCOUNT=storage_account_name"
      # AZURE_STORAGE_KEY: Chave de acesso da StorageAccount.
      - "AZURE_STORAGE_KEY=storage_account_key" 
    command: gateway azure --console-address ":9001"
    deploy:
      restart_policy:
        condition: on-failure
        max_attempts: 3
```

## Documentação Oficial

[Minio](https://docs.min.io/minio/baremetal/introduction/minio-overview.html)  

Mini Azure Gateway [doc: 1](https://docs.min.io/docs/minio-gateway-for-azure.html) [doc: 2](https://docs.min.io/minio/baremetal/reference/minio-server/minio-gateway.html)