#!/usr/bin/env bash
set -euo pipefail

DEST="${1}"

TMP=$(mktemp -d)
pushd "${TMP}"
git clone https://github.com/actions/virtual-environments.git
rsync -av "${TMP}/virtual-environments/images/linux/" "${DEST}"
popd