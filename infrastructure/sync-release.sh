#!/usr/bin/env bash
set -euo pipefail

DEST="${1}"
SRC="https://github.com/actions/virtual-environments/archive/ubuntu18/20210219.1.tar.gz"

TMP=$(mktemp -d)
pushd "${TMP}"
wget "${SRC}"

rsync -av "${TMP}/virtual-environments/images/linux/" "${DEST}"
popd