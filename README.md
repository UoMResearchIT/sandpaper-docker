# sandpaper-docker

A (somewhat) minimal container for running the Carpentries' R based web framework.

An example command, executed from the base directory of your lesson:

```
docker run --rm --name sandpaper -p 4321:4321 -v $PWD:/siteroot/ ghcr.io/uomresearchit/sandpaper:latest
```

Where:
* `-p 4321:4321` exposes the website to localhost:4321
* `-v $PWD:/siteroot/` mounts the lesson files into the container

If you are not running the container from the base directory of the lesson,
replace `$PWD` with the full path to the lesson directory.

**Note:** If you are running the container on mac, and are having permission problems,
make sure you have all the necessary directories before running the container:
```
mkdir -p instructors/{data,fig,files} learners/{data,fig,files} profiles/{data,fig,files}
```

## Contributing

If the sandpaper or varnish versions are out of date,
replace the `sandpaper_xxx.tar.gz` and `varnish_xxx.tar.gz` files with the updated versions
(which can be downloaded from the [Carpentries R universe](https://carpentries.r-universe.dev/builds))
and update the `Dockerfile` versions accordingly.

Commit the changes and create a pull request.
