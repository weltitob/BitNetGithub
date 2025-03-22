#!/bin/bash
# Script to fix placeholder types in Arabic locale file

ARB_FILE="../intl/intl_ar.arb"

# Make a backup of the original file
cp "$ARB_FILE" "${ARB_FILE}.bak"

# Replace all instances of '"username": {}' with '"username": {"type": "Object"}'
sed -i 's/"username": {}/"username": {"type": "Object"}/g' "$ARB_FILE"

# Also fix other placeholders with empty definitions
sed -i 's/"min": {}/"min": {"type": "Object"}/g' "$ARB_FILE"
sed -i 's/"targetName": {}/"targetName": {"type": "Object"}/g' "$ARB_FILE"
sed -i 's/"description": {}/"description": {"type": "Object"}/g' "$ARB_FILE"
sed -i 's/"chatname": {}/"chatname": {"type": "Object"}/g' "$ARB_FILE"
sed -i 's/"displayname": {}/"displayname": {"type": "Object"}/g' "$ARB_FILE"
sed -i 's/"rules": {}/"rules": {"type": "Object"}/g' "$ARB_FILE"
sed -i 's/"count": {}/"count": {"type": "Object"}/g' "$ARB_FILE"
sed -i 's/"content": {}/"content": {"type": "Object"}/g' "$ARB_FILE"
sed -i 's/"user": {}/"user": {"type": "Object"}/g' "$ARB_FILE"
sed -i 's/"date": {}/"date": {"type": "Object"}/g' "$ARB_FILE"
sed -i 's/"hours": {}/"hours": {"type": "Object"}/g' "$ARB_FILE"
sed -i 's/"minutes": {}/"minutes": {"type": "Object"}/g' "$ARB_FILE"
sed -i 's/"seconds": {}/"seconds": {"type": "Object"}/g' "$ARB_FILE"

echo "Placeholder types in $ARB_FILE have been updated."