#!/bin/bash
set -e

echo "🔧 Secretlint環境をセットアップします..."

# GitHubの設定
GITHUB_USER="matsuura-tomoya"
GITHUB_REPO="secretlint-setup"
GITHUB_BRANCH="main"
BASE_URL="https://raw.githubusercontent.com/${GITHUB_USER}/${GITHUB_REPO}/${GITHUB_BRANCH}"


# スクリプトのディレクトリを取得
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. Dockerインストール確認
if ! command -v docker &> /dev/null; then
    echo "❌ Dockerがインストールされていません"
    echo "▶ https://docs.docker.com/get-docker/ からインストールして再実行してください"
    exit 1
fi

# 2. secretlintイメージをプル
echo "Secretlintイメージをダウンロード中..."
docker pull secretlint/secretlint:latest

# 3. Git hooksディレクトリを作成
echo "Git hooksディレクトリを作成..."
mkdir -p ~/.git-hooks

# 4. 必要なファイルをGitHubからダウンロード
echo "設定ファイルをダウンロード中..."
curl -sSL "${BASE_URL}/hooks/pre-commit" -o ~/.git-hooks/pre-commit
curl -sSL "${BASE_URL}/config/secretlintrc.json" -o ~/.git-hooks/secretlintrc.json

# 実行権限を付与
chmod +x ~/.git-hooks/pre-commit

# 5. Gitのグローバル設定
echo "Gitグローバル設定を更新..."
git config --global core.hooksPath ~/.git-hooks

echo "✅ Welcome to Discover Credentials!"
echo "今後、すべてのGitリポジトリでコミット時に自動的にシークレットチェックが実行されます。"
echo "削除したい場合は unistall.sh を実行してください"
