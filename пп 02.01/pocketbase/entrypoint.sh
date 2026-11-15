#!/bin/sh
set -e

# upsert admin user
pb/pocketbase superuser upsert \
    "$ADMIN_EMAIL" \
    "$ADMIN_PASSWORD" \
    --dir="$PB_DATA_DIR"

# start PocketBase and setup project dir
exec pb/pocketbase serve \
    --http=0.0.0.0:8080 \
    --dir="$PB_DATA_DIR" --dev
