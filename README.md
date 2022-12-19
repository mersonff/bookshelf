# Bookshelf

[App em Prod](https://summer-breeze-8525.fly.dev)

## Instalando Bookshelf

Para instalar o projeto, siga estas etapas:

Setando o .env
```
copie o arquivo .env-example com o nome .env e modifique onde necessário
```

```
docker compose -f docker-compose.local.yml up
```

## Usando

No terminal, na pasta raiz do projeto rode o seguinte comando
```
./bookshelf-app.sh 
```

## Testes

No terminal
```
rspec
```

## Autenticação
```
A API utiliza a gem devise-token-auth, é necessário o uso de alguns headers para acessar as rotas protegidas. Na collection do Insomnia está configurado para que esses headers sejam atualizados automaticamente após a request de sign_in.
```

# Docs
```
Na pasta raiz do projeto, há os arquivos para a documentação do Swagger e a collection para ser utilizada no Insomnia
```

[Docs](https://mersonff.github.io/bookshelf-docs/)

## OBS
```
Pode ser necessário dar permissão de execução para o script.
```
