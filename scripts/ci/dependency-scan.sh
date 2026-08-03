#!/usr/bin/env bash
set -euo pipefail

# 의존성 라이브러리의 알려진 취약점(CVE)을 검사합니다.
# 정보 확인용(non-required) 체크입니다 — 실패해도 PR 머지는 막히지 않고 결과만 남습니다.
# (오탐이 잦아 팀이 충분히 익숙해지면 setup-branch-protection.sh의 REQUIRED_CHECKS에 추가해 필수로 전환하세요.)
#
# 예) Java/Spring Boot (OWASP Dependency-Check Gradle plugin):
#   ./gradlew dependencyCheckAnalyze
#
# 예) Python:
#   pip-audit

echo "dependency scan 실행 자리"
