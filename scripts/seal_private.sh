#!/usr/bin/env bash
set -euo pipefail
TODAY=$(date +%F)
ARCHIVE="legal/private-archive-${TODAY}.tgz"
SEALED_DIR="legal/SEALED"

tar czf "${ARCHIVE}" "${SEALED_DIR}"
sha256sum "${ARCHIVE}" | tee "${ARCHIVE}.SHA256"

if command -v ots >/dev/null 2>&1; then
  ots stamp "${ARCHIVE}"
else
  echo "OpenTimestamps(ots) が未導入。Linux: sudo apt-get install -y opentimestamps-client"
fi

git add "${ARCHIVE}.SHA256" || true
[ -f "${ARCHIVE}.ots" ] && git add "${ARCHIVE}.ots" || true
git commit -m "legal: sealed private archive hash & timestamp (${TODAY})" || true
echo "Sealed."
