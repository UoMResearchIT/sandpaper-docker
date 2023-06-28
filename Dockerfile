FROM ghcr.io/r-hub/r-minimal/r-minimal:4.4

# Check https://carpentries.r-universe.dev/builds for latest versions of sandpaper, tinkr, pegboard and varnish
ARG sandpaper_version=0.12.4
ARG varnish_version=0.2.17
RUN <<SANDPAPER
    installr -c
    installr -a "curl-dev linux-headers libxml2-dev fontconfig-dev harfbuzz-dev fribidi-dev freetype-dev tiff-dev jpeg-dev libgit2-dev libxslt-dev"
    installr url::https://carpentries.r-universe.dev/src/contrib/sandpaper_${sandpaper_version}.tar.gz
    installr url::https://carpentries.r-universe.dev/src/contrib/varnish_${varnish_version}.tar.gz
SANDPAPER

ARG pandoc_version=2.19.2
RUN <<PANDOC
    wget https://github.com/jgm/pandoc/releases/download/${pandoc_version}/pandoc-${pandoc_version}-linux-amd64.tar.gz
    tar xzvf pandoc-${pandoc_version}-linux-amd64.tar.gz
    cp pandoc-${pandoc_version}/bin/pandoc /bin/pandoc
    rm -r pandoc*
PANDOC

RUN <<GIT
    apk add git
    git config --global --add safe.directory /siteroot/
GIT

WORKDIR /siteroot/

CMD Rscript -e "sandpaper::serve(host = '0.0.0.0', port = '4321')"

