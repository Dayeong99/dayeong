#!/bin/bash

REPORT="U25_report_$(date +%Y%m%d_%H%M).txt"

echo "===== U-25 보안 점검 시작 =====" | tee "$REPORT"
echo "" | tee -a "$REPORT"

echo "[1] 최근 로그인 기록" | tee -a "$REPORT"
last | head -n 10 | tee -a "$REPORT"

echo "" | tee -a "$REPORT"

echo "[2] sudo 권한 사용자" | tee -a "$REPORT"
getent group sudo | tee -a "$REPORT"

echo "" | tee -a "$REPORT"

echo "[3] 로그인 실패 기록" | tee -a "$REPORT"
grep "Failed password" /var/log/auth.log 2>/dev/null | tail -n 10 || echo "기록 없음" | tee -a "$REPORT"

echo "" | tee -a "$REPORT"

echo "===== U-25 점검 완료 =====" | tee -a "$REPORT"

echo "결과 파일: $REPORT"
