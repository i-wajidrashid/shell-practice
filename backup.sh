#!/usr/bin/env bash
set -euo pipefail
TARGET_DIR="${1:-}"
if [[ -z "$TARGET_DIR" ]]; then
    echo "Usage: $0 <folder_to_backup>"
    exit 1
fi
if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Error: Directory '$TARGET_DIR' does not exist."
    exit 2
fi
BACKUP_DIR="$HOME/backups"
mkdir -p "$BACKUP_DIR"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"
tar -czf "$BACKUP_FILE" -C "$(dirname "$TARGET_DIR")" "$(basename "$TARGET_DIR")"
cleanup_old_backups() {
    mapfile -t backups < <(find "$BACKUP_DIR" -maxdepth 1 -type f -name "backup_*.tar.gz" | sort -r)
    if (( ${#backups[@]} > 5 )); then
        rm -f "${backups[@]:5}"
    fi
}

cleanup_old_backups

BACKUP_SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
echo "Backup complete: $BACKUP_FILE ($BACKUP_SIZE)"

