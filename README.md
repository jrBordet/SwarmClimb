# SwarmClimb

### Application run

```
vapor build
vapor run
```

### Generate XCode project

```
vapor xcode -y
```

#### Hello

```
http://localhost:8080/hello
```

#### Devlopment

```
docker run --name swarm \
-e POSTGRES_DB=swarm \
-e POSTGRES_USER=swarm \
-e POSTGRES_PASSWORD=password \
-p 5432:5432 -d postgres

docker ps --all

docker container stop <container>
docker container rm <container>
```

#### Testing

```
docker run --name swarm-test \
-e POSTGRES_DB=swarm-test \
-e POSTGRES_USER=swarm \
-e POSTGRES_PASSWORD=password \
-p 5433:5432 -d postgres

docker ps --all

docker container stop <container>
docker container rm <container>
```


## Author

Jean Raphael Bordet, jr.bordet@gmail.com

