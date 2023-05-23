# sandpaper-docker

A (somewhat) minimal container for running the Carpentries' R based web framework.

An example command:

```
docker run \
  --network host 
  -v $PWD/your-site/:/siteroot/
  -u ${UID}:${GID} 
  ghcr.io/uomresearchit/sandpaper:latest
```

Where:
* `--network host` make the container accessible over the host network
* `-v $PWD/your-site/:/siteroot/` mounts site files into container
* `-u ${UID}:${GID}` mimics host user
