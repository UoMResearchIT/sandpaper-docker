FROM ghcr.io/r-hub/r-minimal/r-minimal:4.4

# Check https://carpentries.r-universe.dev/builds for latest versions of sandpaper, tinkr, pegboard and varnish
ARG sandpaper_version=0.16.9
ARG varnish_version=1.0.4
COPY sandpaper_${sandpaper_version}.tar.gz /
COPY varnish_${varnish_version}.tar.gz /
RUN <<SANDPAPER
    installr -c
    installr -a "curl-dev linux-headers libxml2-dev fontconfig-dev harfbuzz-dev fribidi-dev freetype-dev tiff-dev jpeg-dev libgit2-dev libxslt-dev"
    installr /sandpaper_${sandpaper_version}.tar.gz
    installr /varnish_${varnish_version}.tar.gz
SANDPAPER

# Check https://github.com/jgm/pandoc/releases/latest for latest version of pandoc
ARG pandoc_version=3.5
COPY pandoc-${pandoc_version}-linux-amd64.tar.gz /
COPY pandoc-${pandoc_version}-linux-arm64.tar.gz /
RUN <<PANDOC
    os_arch=$(if [ "$(arch)" = "aarch64" ]; then echo "arm"; else echo "amd"; fi)
    tar xzvf /pandoc-${pandoc_version}-linux-${os_arch}64.tar.gz
    cp pandoc-${pandoc_version}/bin/pandoc /bin/pandoc
    rm -r pandoc*
PANDOC

RUN rm /*.tar.gz

RUN <<GIT
    apk add git
    git config --global --add safe.directory /siteroot/
GIT

WORKDIR /siteroot/

CMD SANDPAPER_SITE=$(mktemp -d) Rscript -e "sandpaper::serve(host = '0.0.0.0', port = '4321')"

