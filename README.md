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

## Create new collection using skeleton

1. Clone this repo

2. Create a feature branch in the repository where you want to create the new collection
   ```
   git checkout -b feature/new-collection-$collection_name
   ```

3. From the directory/repository where you want to create the new collection, launch next command changing the value of **iaac_environment_path** to create new collection:
   ```
   ansible-galaxy collection init $collection_namespace.$collection_name --collection-skeleton ${iaac_environment_path}/ansible-collection-skeleton
   ```

4. A new folder ```$collection_namespace/$collection_name``` will be created where the new collection playbooks, roles, etc. will be generated.

5. Once the new collection has been tested in feature branch, consider to merge to the main branch.

