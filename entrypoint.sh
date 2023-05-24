#!/bin/bash
set -e

chown -R $UID:$GID /siteroot/
exec Rscript -e "sandpaper::serve(host = '0.0.0.0', port = '4321')"