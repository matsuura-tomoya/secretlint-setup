#!/bin/bash
echo "Secretlint環境を削除します..."

# Git設定を削除
git config --global --unset core.hooksPath

# ファイルを削除
rm -rf ~/.git-hooks

echo "✅ アンインストール完了"
