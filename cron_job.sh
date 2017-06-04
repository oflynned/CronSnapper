#!/bin/bash
echo "*/30 * * * * $(pwd)/main.sh" | crontab -
