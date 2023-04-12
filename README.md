## Commands to start work environment

1. Docker image creation:
```
docker build -t iaac_environment .
```

2. Create container and synchronize with the workspace. It should be executed from the workspace:

```
docker run -d -it --name iaac_tools --mount type=bind,source="$(pwd)",target=/app iaac_environment
```

3. Access to the IaaC environment to be able to use the tools:
```
docker exec -it iaac_tools bash
```