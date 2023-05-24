# sandpaper-docker

A (somewhat) minimal container for running the Carpentries' R based web framework.

An example command:

```
docker run \
  -p 4321:4321 \
  -v $PWD/your-site/:/siteroot/ \
  ghcr.io/uomresearchit/sandpaper:latest
```

Where:
* `-p 4321:4321` exposes the website to localhost:4321
* `-v $PWD/your-site/:/siteroot/` mounts site files into container
