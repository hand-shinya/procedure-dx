[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.17090460.svg)](https://doi.org/10.5281/zenodo.17090460)
# Procedure DX Platform — Template (JustForm × Shonin)

- 公開: `docs/` と `src/` の“公開版”のみ（Zenodo連携でDOI）
- 非公開: `legal/SEALED/`（.gitignoreで除外）
- 封印保全: `scripts/seal_private.sh`（SHA256 + OpenTimestamps）

## 初期化
export GITHUB_ORG="your-org-or-user"
export REPO_NAME="procedure-dx"
export AUTHOR_NAME="Your Name"
export AUTHOR_EMAIL="you@example.com"
chmod +x scripts/bootstrap.sh
./scripts/bootstrap.sh

## 封印（未公開原本を legal/SEALED/raw に入れた後）
chmod +x scripts/seal_private.sh
./scripts/seal_private.sh
