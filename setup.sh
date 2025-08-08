#!/bin/bash
set -e

echo "🔧 Secretlint環境をセットアップします..."

# スクリプトのディレクトリを取得
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. Dockerインストール確認
if ! command -v docker &> /dev/null; then
    echo "❌ Dockerがインストールされていません"
    echo "▶︎https://docs.docker.com/get-docker/ からインストールしてください"
    exit 1
fi

# 2. secretlintイメージをプル
echo "Secretlintイメージをダウンロード中..."
docker pull secretlint/secretlint:latest

# 3. Git hooksディレクトリを作成
echo "Git hooksディレクトリを作成..."
mkdir -p ~/.git-hooks

# 4. ファイルをコピー
echo "設定ファイルをコピー..."
cp "$SCRIPT_DIR/hooks/pre-commit" ~/.git-hooks/
cp "$SCRIPT_DIR/config/secretlintrc.json" ~/.git-hooks/
chmod +x ~/.git-hooks/pre-commit

# 5. Gitのグローバル設定
echo "Gitグローバル設定を更新..."
git config --global core.hooksPath ~/.git-hooks

echo ""
echo "Welcome to Discover Credentials！"
echo "今後、すべてのGitリポジトリでコミット時に自動的にシークレットチェックが実行されます。"
