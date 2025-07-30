#!/bin/bash

# ユーザーからの要件概要を引数で受け取る
REQUIREMENTS_SUMMARY=$1

# kairo-requirements.mdの内容を読み込む
PROMPT_TEMPLATE=$(cat commands/kairo-requirements.md)

# gemini-cliにプロンプトと要件概要を渡して実行
# （注意：gemini-cliの具体的な呼び出し方は仮のものです）
gemini-cli --prompt "$PROMPT_TEMPLATE" --input "$REQUIREMENTS_SUMMARY" > docs/spec/requirements.md

echo "要件定義書を docs/spec/requirements.md に生成しました。"
