# TDD要件定義・機能仕様の整理

TDD開発を始めます。以下の機能について要件を整理してください：

**【機能名】**: {{feature_name}}

## 事前準備

開発コンテキストの準備を行います：

**Taskツール実行**: `/tdd-load-context` でTDD関連ファイルの読み込みとコンテキスト準備を実行

読み込み完了後、準備されたコンテキスト情報を基にTDD要件定義の作業を開始します。

## TDD用要件整理フォーマット

**【信頼性レベル指示】**:
各項目について、元の資料（EARS要件定義書・設計文書含む）との照合状況を以下の信号でコメントしてください：

- 🟢 **青信号**: EARS要件定義書・設計文書を参考にしてほぼ推測していない場合
- 🟡 **黄信号**: EARS要件定義書・設計文書から妥当な推測の場合
- 🔴 **赤信号**: EARS要件定義書・設計文書にない推測の場合

## 1. 機能の概要（EARS要件定義書・設計文書ベース）

- 🟢🟡🔴 各項目の信頼性レベルを記載
- 何をする機能か（ユーザストーリーから抽出）
- どのような問題を解決するか（As a / So that から抽出）
- 想定されるユーザー（As a から抽出）
- システム内での位置づけ（アーキテクチャ設計から抽出）
- **参照したEARS要件**: [具体的な要件ID]
- **参照した設計文書**: [architecture.md の該当セクション]

## 2. 入力・出力の仕様（EARS機能要件・TypeScript型定義ベース）

- 🟢🟡🔴 各項目の信頼性レベルを記載
- 入力パラメータ（型、範囲、制約）- interfaces.tsから抽出
- 出力値（型、形式、例）- interfaces.tsから抽出
- 入出力の関係性
- データフロー（dataflow.mdから抽出）
- **参照したEARS要件**: [具体的なREQ-XXX]
- **参照した設計文書**: [interfaces.ts の該当インターフェース]

## 3. 制約条件（EARS非機能要件・アーキテクチャ設計ベース）

- 🟢🟡🔴 各項目の信頼性レベルを記載
- パフォーマンス要件（NFR-XXXから抽出）
- セキュリティ要件（NFR-XXXから抽出）
- 互換性要件（REQ-XXX MUSTから抽出）
- アーキテクチャ制約（architecture.mdから抽出）
- データベース制約（database-schema.sqlから抽出）
- API制約（api-endpoints.mdから抽出）
- **参照したEARS要件**: [具体的なNFR-XXX, REQ-XXX]
- **参照した設計文書**: [architecture.md, database-schema.sql等の該当セクション]

## 4. 想定される使用例（EARSEdgeケース・データフローベース）

- 🟢🟡🔴 各項目の信頼性レベルを記載
- 基本的な使用パターン（通常要件REQ-XXXから抽出）
- データフロー（dataflow.mdから抽出）
- エッジケース（EDGE-XXXから抽出）
- エラーケース（EDGE-XXXエラー処理から抽出）
- **参照したEARS要件**: [具体的なEDGE-XXX]
- **参照した設計文書**: [dataflow.md の該当フロー図]

## 5. EARS要件・設計文書との対応関係

既存のEARS要件定義書・設計文書を参照した場合、以下の対応関係を明記してください：

- **参照したユーザストーリー**: [ストーリー名]
- **参照した機能要件**: [REQ-001, REQ-002, ...]
- **参照した非機能要件**: [NFR-001, NFR-101, ...]
- **参照したEdgeケース**: [EDGE-001, EDGE-101, ...]
- **参照した受け入れ基準**: [具体的なテスト項目]
- **参照した設計文書**:
  - **アーキテクチャ**: [architecture.md の該当セクション]
  - **データフロー**: [dataflow.md の該当フロー図]
  - **型定義**: [interfaces.ts の該当インターフェース]
  - **データベース**: [database-schema.sql の該当テーブル]
  - **API仕様**: [api-endpoints.md の該当エンドポイント]

整理後、以下を実行してください：

1. 要件定義書をdoc/implementation/{feature_name}-requirements.mdに保存（既存ファイルがある場合は追記）
2. TODOステータスを更新（要件定義完了をマーク）
3. **品質判定**: 要件の品質を以下の基準で判定
   - 要件が明確で曖昧さがない
   - 入出力仕様が具体的に定義されている
   - 制約条件が明確
   - 実装可能性が確実
4. **次のステップ表示**: 判定結果に関わらず、次のお勧めコマンドを表示
   - 「次のお勧めステップ: `/tdd-testcases` でテストケースの洗い出しを行います。」

## 品質判定基準

```
✅ 高品質:
- 要件の曖昧さ: なし
- 入出力定義: 完全
- 制約条件: 明確
- 実装可能性: 確実

⚠️ 要改善:
- 要件に曖昧な部分がある
- 入出力の詳細が不明確
- 技術的制約が不明
- ユーザー意図の確認が必要
```

## TODO更新パターン

```
- 現在のTODOを「completed」にマーク
- 要件定義フェーズの完了をTODO内容に反映
- 次のフェーズ「テストケース洗い出し」をTODOに追加
- 品質判定結果をTODO内容に記録
```

次のステップ: `/tdd-testcases` でテストケースの洗い出しを行います。
