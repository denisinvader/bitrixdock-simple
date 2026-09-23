#!/bin/sh
set -eu

site_path="${1:-./www}"

mkdir -p "$site_path"
curl -fsSL https://www.1c-bitrix.ru/download/scripts/bitrixsetup.php -o "$site_path/bitrixsetup.php"

echo "Downloaded Bitrix installer to $site_path/bitrixsetup.php"
