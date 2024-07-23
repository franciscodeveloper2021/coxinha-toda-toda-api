# Coxinha Toda Toda API

Bem-vindo à Coxinha Toda Toda API! Este README irá guiá-lo através dos passos necessários para configurar e executar a API utilizando Docker.

## Pré-requisitos

Certifique-se de ter o Docker e o Docker Compose instalados na sua máquina. Você pode baixá-los nos links abaixo:

- [Docker](https://www.docker.com/products/docker-desktop)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Passos para Configurar e Executar a API

1. **Clone o repositório**

   ```bash
   git clone https://github.com/franciscodeveloper2021/coxinha-toda-toda-api.git
   cd coxinha-toda-toda-api

2. **Construir e subir os containers**

   Execute o comando abaixo para construir e subir os containers do Docker:

   ```bash
   docker compose up --build

3. **Entrar no bash do container da API**

   Para acessar o bash do container da API, execute o comando:

   ```bash
   docker exec -it rails bash

4. **Instalar as dependências do Ruby**

   Uma vez dentro do bash do container, execute o comando abaixo para instalar as dependências do Ruby:

   ```bash
   bundle install


