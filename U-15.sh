#!/bin/bash

REPORT="U15_report_$(date +%Y%m%d_%H%M).txt"

echo "===== U-15 보안 점검 시작 =====" | tee "$REPORT"
echo "" | tee -a "$REPORT"

echo "[1] /etc/passwd 권한" | tee -a "$REPORT"
ls -l /etc/passwd | tee -a "$REPORT"

echo "" | tee -a "$REPORT"

echo "[2] /etc/shadow 권한" | tee -a "$REPORT"
ls -l /etc/shadow | tee -a "$REPORT"

echo "" | tee -a "$REPORT"

echo "[3] root 계정 확인" | tee -a "$REPORT"
grep "^root" /etc/passwd | tee a "$REPORT"

echo "" | tee -a "$REPORT"

echo "===== U-15 점검 완료 =====" | tee -a "$REPORT"

echo "결과 파일: $REPORT"
