#!/bin/bash

TARGET_DIR=${1:-"."}
DAYS=${2:-30}
BACKUP_ROOT="$HOME/backup_archive"

if [ ! -d "$BACKUP_ROOT" ]; then
    mkdir -p "$BACKUP_ROOT"
    echo "백업 디렉토리를 생성했습니다: $BACKUP_ROOT"
fi

if [ ! -d "$TARGET_DIR" ]; then
    echo "ERROR: 대상 디렉토리 '$TARGET_DIR'가 존재하지 않습니다."
    exit 1
fi

TIMESTAMP=$(date +%Y%m%d_%H%M)
BACKUP_FILE="$BACKUP_ROOT/backup_$TIMESTAMP.tar.gz"

echo "대상: $TARGET_DIR | 기준일: $DAYS일"

echo "파일 검색 및 압축 중..."
FILES=$(find "$TARGET_DIR" -type f -mtime +"$DAYS")

if [ -z "$FILES" ]; then
    echo "백업할 파일이 없습니다."
    exit 0
fi

echo "$FILES" | tar -cvzf "$BACKUP_FILE" -T -

if [ $? -eq 0 ]; then
    echo "압축 완료: $BACKUP_FILE"
    echo "원본 파일 삭제 중..."
    find "$TARGET_DIR" -type f -mtime +"$DAYS" -print0 | xargs -0 rm -f
    echo "작업 완료"
else
    echo "ERROR: 압축 실패로 원본파일 보존"
    exit 1
fi
