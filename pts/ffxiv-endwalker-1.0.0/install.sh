#!/bin/bash
set -o errexit -o pipefail -o nounset -o noclobber

mkdir -p ffxiv-endwalker-bench
unzip ffxiv-endwalker-bench.zip -d ffxiv-endwalker-bench
rm -r ffxiv-endwalker-bench/screenshots # Prevent benchmark from automatically taking screenshots
cp "$(dirname -- "${BASH_SOURCE[0]}")/run.sh" ffxiv-endwalker
chmod +x ffxiv-endwalker
rm ffxiv-endwalker-bench.zip
