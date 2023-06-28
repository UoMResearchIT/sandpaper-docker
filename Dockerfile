FROM ghcr.io/r-hub/r-minimal/r-minimal:4.4

# Check https://carpentries.r-universe.dev/builds for latest versions of sandpaper, tinkr, pegboard and varnish
RUN <<SANDPAPER
    installr -c
    installr -a "curl-dev linux-headers libxml2-dev fontconfig-dev harfbuzz-dev fribidi-dev freetype-dev tiff-dev jpeg-dev libgit2-dev libxslt-dev"
    installr url::https://carpentries.r-universe.dev/src/contrib/sandpaper_0.12.4.tar.gz
    installr url::https://carpentries.r-universe.dev/src/contrib/tinkr_0.2.0.tar.gz
    installr url::https://carpentries.r-universe.dev/src/contrib/pegboard_0.5.2.tar.gz
    installr url::https://carpentries.r-universe.dev/src/contrib/varnish_0.2.17.tar.gz
SANDPAPER

RUN <<PANDOC
    wget https://github.com/jgm/pandoc/releases/download/3.1.2/pandoc-3.1.2-linux-amd64.tar.gz
    tar xzvf pandoc-3.1.2-linux-amd64.tar.gz
    cp pandoc-3.1.2/bin/pandoc /bin/pandoc
    rm -r pandoc*
PANDOC

RUN <<GIT
    apk add git
    git config --global --add safe.directory /siteroot/
GIT

WORKDIR /siteroot/

CMD Rscript -e "sandpaper::serve(host = '0.0.0.0', port = '4321')"

