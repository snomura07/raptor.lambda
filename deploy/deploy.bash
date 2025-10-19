#!/bin/bash
set -e
export AWS_PAGER=""

# 引数チェック
if [ -z "$1" ]; then
  echo "❌ 関数名を引数で指定してください"
  echo "Usage: bash deploy.bash RaptorLoggerLambda ※※function name※※"
  exit 1
fi

FUNCTION_NAME="$1"
SOURCE_PATH="/app/src/${FUNCTION_NAME}/lambda_function.py"
ZIP_PATH="/tmp/lambda.zip"

# ファイル存在チェック
if [ ! -f "$SOURCE_PATH" ]; then
  echo "❌ ファイルが見つかりません: ${SOURCE_PATH}"
  exit 1
fi

echo "📦 zip 化: ${SOURCE_PATH} → ${ZIP_PATH}"
zip -j "${ZIP_PATH}" "${SOURCE_PATH}"

echo "🚀 Lambda にデプロイ中: ${FUNCTION_NAME}"
aws lambda update-function-code \
  --function-name "${FUNCTION_NAME}" \
  --zip-file "fileb://${ZIP_PATH}" \
  --region "${AWS_DEFAULT_REGION}"

echo "✅ デプロイ完了: ${FUNCTION_NAME}"
rm "${ZIP_PATH}"
