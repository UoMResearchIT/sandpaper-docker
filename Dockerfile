FROM ghcr.io/r-hub/r-minimal/r-minimal:4.4

RUN <<SANDPAPER
    installr -c
    installr -a "curl-dev linux-headers libxml2-dev fontconfig-dev harfbuzz-dev fribidi-dev freetype-dev tiff-dev jpeg-dev libgit2-dev libxslt-dev"
    installr url::https://carpentries.r-universe.dev/src/contrib/sandpaper_0.12.0.tar.gz
    installr url::https://carpentries.r-universe.dev/src/contrib/tinkr_0.2.0.tar.gz
    installr url::https://carpentries.r-universe.dev/src/contrib/pegboard_0.5.2.tar.gz
    installr url::https://carpentries.r-universe.dev/src/contrib/varnish_0.2.16.tar.gz
SANDPAPER

RUN <<PANDOC
    wget https://github.com/jgm/pandoc/releases/download/3.1.2/pandoc-3.1.2-linux-amd64.tar.gz
    tar xzvf pandoc-3.1.2-linux-amd64.tar.gz
    cp pandoc-3.1.2/bin/pandoc /bin/pandoc
    rm -r pandoc*
PANDOC

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /siteroot/

