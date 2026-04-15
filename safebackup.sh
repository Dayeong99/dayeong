#!/bin/bash

TARGET_DIR=${1:-"."}
DAYS=${2:-30}
BACKUP_ROOT="$HOME/backup_archive"

# 백업 폴더 생성
if [ ! -d "$BACKUP_ROOT" ]; then
    mkdir -p "$BACKUP_ROOT"
    echo "백업 디렉토리를 생성했습니다: $BACKUP_ROOT"
fi

# 대상 디렉토리 확인
if [ ! -d "$TARGET_DIR" ]; then
    echo "에러: 대상 디렉토리 '$TARGET_DIR'가 존재하지 않습니다."
    exit 1
fi

TIMESTAMP=$(date +%Y%m%d_%H%M)
BACKUP_FILE="$BACKUP_ROOT/backup_$TIMESTAMP.tar.gz"

echo "대상: $TARGET_DIR | 기준일: $DAYS일"

echo "백업 대상 파일 목록:"
find "$TARGET_DIR" -type f -mtime +"$DAYS"

# 👉 사용자 확인
echo ""
read -p "위 파일들을 압축하고 삭제하시겠습니까? (y/n): " ANSWER

if [[ "$ANSWER" != "y" && "$ANSWER" != "Y" ]]; then
    echo "작업 취소됨"
    exit 0
fi

# 압축 진행
echo "압축 중..."
find "$TARGET_DIR" -type f -mtime +"$DAYS" -print0 | \
tar --null -cvzf "$BACKUP_FILE" --files-from -

if [ $? -eq 0 ]; then
    echo "압축 완료: $BACKUP_FILE"

    # 👉 삭제 전 한 번 더 확인 (이중 안전)
    read -p "정말 삭제하시겠습니까? (y/n): " DELETE_CONFIRM

    if [[ "$DELETE_CONFIRM" == "y" || "$DELETE_CONFIRM" == "Y" ]]; then
        find "$TARGET_DIR" -type f -mtime +"$DAYS" -print0 | xargs -0 rm -f
        echo "삭제 완료"
    else
        echo "삭제 취소됨 (압축만 완료)"
    fi

else
    echo "오류: 압축 실패 → 삭제 안 함"
    exit 1
fi#!/bin/bash

TARGET_DIR=${1:-"."}
DAYS=${2:-30}
BACKUP_ROOT="$HOME/backup_archive"

# 백업 폴더 생성
if [ ! -d "$BACKUP_ROOT" ]; then
    mkdir -p "$BACKUP_ROOT"
    echo "백업 디렉토리를 생성했습니다: $BACKUP_ROOT"
fi

# 대상 디렉토리 확인
if [ ! -d "$TARGET_DIR" ]; then
    echo "에러: 대상 디렉토리 '$TARGET_DIR'가 존재하지 않습니다."
    exit 1
fi

TIMESTAMP=$(date +%Y%m%d_%H%M)
BACKUP_FILE="$BACKUP_ROOT/backup_$TIMESTAMP.tar.gz"

echo "대상: $TARGET_DIR | 기준일: $DAYS일"

echo "백업 대상 파일 목록:"
find "$TARGET_DIR" -type f -mtime +"$DAYS"

# 👉 사용자 확인
echo ""
read -p "위 파일들을 압축하고 삭제하시겠습니까? (y/n): " ANSWER

if [[ "$ANSWER" != "y" && "$ANSWER" != "Y" ]]; then
    echo "작업 취소됨"
    exit 0
fi

# 압축 진행
echo "압축 중..."
find "$TARGET_DIR" -type f -mtime +"$DAYS" -print0 | \
tar --null -cvzf "$BACKUP_FILE" --files-from -

if [ $? -eq 0 ]; then
    echo "압축 완료: $BACKUP_FILE"

    # 👉 삭제 전 한 번 더 확인 (이중 안전)
    read -p "정말 삭제하시겠습니까? (y/n): " DELETE_CONFIRM

    if [[ "$DELETE_CONFIRM" == "y" || "$DELETE_CONFIRM" == "Y" ]]; then
        find "$TARGET_DIR" -type f -mtime +"$DAYS" -print0 | xargs -0 rm -f
        echo "삭제 완료"
    else
        echo "삭제 취소됨 (압축만 완료)"
    fi

else
    echo "오류: 압축 실패 → 삭제 안 함"
    exit 1
fi
