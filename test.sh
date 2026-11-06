#!/usr/bin/env bash
set -euo pipefail

TEST_DIR=$(mktemp -d)
echo "test" > "$TEST_DIR/sample.txt"

OUTPUT=$(./backup.sh "$TEST_DIR")
echo "$OUTPUT"

CREATED_FILE=$(echo "$OUTPUT" | awk '{print $3}')

if [[ -f "$CREATED_FILE" ]]; then
    echo "Test passed: $CREATED_FILE was created."
else
    echo "Test failed: Backup file not found."
    rm -rf "$TEST_DIR"
    exit 1
fi

rm -rf "$TEST_DIR"

