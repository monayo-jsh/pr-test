#!/usr/bin/env bash
set -euo pipefail

# gitleaks CLI로 시크릿(API 키, 비밀번호, 토큰 등) 노출 여부를 검사합니다.
# 필수(required) 체크이므로 실패 시 PR 머지가 차단됩니다.
#
# 버전은 필요 시 최신으로 올리세요: https://github.com/gitleaks/gitleaks/releases
GITLEAKS_VERSION="8.21.2"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

curl -sSL \
  "https://github.com/gitleaks/gitleaks/releases/download/v${GITLEAKS_VERSION}/gitleaks_${GITLEAKS_VERSION}_linux_x64.tar.gz" \
  -o "${TMP_DIR}/gitleaks.tar.gz"

tar -xzf "${TMP_DIR}/gitleaks.tar.gz" -C "${TMP_DIR}" gitleaks

# --no-git: actions/checkout 기본값(shallow clone)이라 git 히스토리 전체를 훑지 않고
#           현재 작업 트리 파일 내용만 검사합니다.
# --redact: 실제 발견된 시크릿 값이 CI 로그에 그대로 찍히지 않도록 마스킹합니다.
"${TMP_DIR}/gitleaks" detect \
  --source . \
  --no-git \
  --redact \
  --verbose
