# direct-verify

## 目的

DIRECTタスクで実行した設定作業の動作確認とテストを行います。設定が正しく適用され、システムが期待通りに動作することを確認します。

## 前提条件

- `direct-setup.md` が実行済み
- タスクIDが提供されている
- 設定作業の記録が存在する

## 実行内容

1. **設定の確認**
   - 環境変数の確認
   - 設定ファイルの内容確認
   - 依存関係のインストール状況確認
   - サービスの起動状況確認

2. **動作テストの実行**
   - 基本的な動作確認
   - 接続テスト
   - 権限の確認
   - エラーケースの確認

3. **品質チェック**
   - セキュリティ設定の確認
   - パフォーマンス基準の確認
   - ログの確認

## 出力先

確認記録は `docs/implements/{TASK-ID}/` ディレクトリに以下のファイルとして作成されます：
- `verify-report.md`: 設定確認・動作テスト記録

## 出力フォーマット例

````markdown
# {TASK-ID} 設定確認・動作テスト

## 確認概要

- **タスクID**: {TASK-ID}
- **確認内容**: {設定確認の概要}
- **実行日時**: {実行日時}
- **実行者**: {実行者}

## 設定確認結果

### 1. 環境変数の確認

```bash
# 実行したコマンド
echo $NODE_ENV
echo $DATABASE_URL
```
````

**確認結果**:

- [x] NODE_ENV: development (期待値: development)
- [x] DATABASE_URL: postgresql://localhost:5432/mydb (期待値: 正しいDB URL)

### 2. 設定ファイルの確認

**確認ファイル**: `config/database.json`

```bash
# 実行したコマンド
cat config/database.json | jq .
```

**確認結果**:

- [x] ファイルが存在する
- [x] JSON形式が正しい
- [x] 必要な設定項目が含まれている

### 3. 依存関係の確認

```bash
# 実行したコマンド
npm list express pg
```

**確認結果**:

- [x] express: インストール済み
- [x] pg: インストール済み

### 4. データベース接続テスト

```bash
# 実行したコマンド
psql -d mydb -c "SELECT 1;"
```

**確認結果**:

- [x] データベース接続成功
- [x] クエリ実行成功

## 動作テスト結果

### 1. 基本動作テスト

```bash
# 実行したテストコマンド
node -e "console.log('Hello, World!');"
```

**テスト結果**:

- [x] Node.js実行環境: 正常
- [x] 基本的なJavaScript実行: 正常

### 2. データベース接続テスト

```javascript
// テストスクリプト
const { Pool } = require('pg');
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

pool.query('SELECT NOW()', (err, res) => {
  if (err) {
    console.error('Error:', err);
  } else {
    console.log('Connected:', res.rows[0]);
  }
  pool.end();
});
```

**テスト結果**:

- [x] データベース接続: 正常
- [x] クエリ実行: 正常
- [x] 接続終了: 正常

### 3. セキュリティ設定テスト

```bash
# 実行したコマンド
ls -la config/
ps aux | grep node
```

**テスト結果**:

- [x] 設定ファイルの権限: 適切
- [x] プロセスの実行権限: 適切
- [x] 機密情報の保護: 適切

## 品質チェック結果

### パフォーマンス確認

- [x] 起動時間: 2秒以内
- [x] メモリ使用量: 256MB以内
- [x] CPU使用率: 10%以内

### ログ確認

- [x] エラーログ: 異常なし
- [x] 警告ログ: 問題なし
- [x] 情報ログ: 適切に出力

## 全体的な確認結果

- [x] 設定作業が正しく完了している
- [x] 全ての動作テストが成功している
- [x] 品質基準を満たしている
- [x] 次のタスクに進む準備が整っている

## 発見された問題

### 問題1: {問題があれば記載}

- **問題内容**: {問題の詳細}
- **重要度**: {高/中/低}
- **対処法**: {対処方法}
- **ステータス**: {解決済み/対応中/未対応}

## 推奨事項

- {改善提案があれば記載}
- {最適化の提案があれば記載}

## 次のステップ

- タスクの完了報告
- 関連するタスクの開始準備
- 必要に応じて設定の微調整

````

## 実行後の確認
- `docs/implements/{TASK-ID}/verify-report.md` ファイルが作成されていることを確認
- 全ての確認項目が完了していることを確認
- 問題が発見された場合は適切に対処されていることを確認
- タスクの完了条件を満たしていることを確認
- 次のタスクに進む準備が整っていることを確認

## ディレクトリ確認

`docs/implements/{TASK-ID}/` ディレクトリが存在することを確認してください（direct-setupで作成済みのはず）

## タスクの完了マーキング
品質チェックが十分で、全ての確認項目がクリアされた場合は、tasksディレクトリの該当するタスクファイルに完了マークを付けてください。

### 完了条件
以下の条件を全て満たす場合にタスクを完了とマークします：
- [ ] 全ての設定確認項目がクリア
- [ ] 全ての動作テストが成功
- [ ] 品質チェック項目が基準を満たしている
- [ ] 発見された問題が適切に対処されている
- [ ] セキュリティ設定が適切
- [ ] パフォーマンス基準を満たしている

### 完了マークの付け方
1. ユーザが指定したタスクファイルを確認
2. ファイル内の該当セクションまたはタスク項目に `✅ 完了` または `[COMPLETED]` マークを追加
3. 完了日時と確認者を記録

## README.mdの更新
タスクが完了した場合、プロジェクトのルートディレクトリの `README.md` を作成または更新してください。

### 更新内容
1. **現在のREADME.mdの確認**: 既存のREADME.mdがある場合は内容を確認
2. **完了したタスクの情報を追加**:
   - 実装した機能の概要
   - 設定手順
   - 動作確認方法
   - 使用方法
3. **プロジェクト全体の情報を更新**:
   - セットアップ手順
   - 依存関係
   - 環境要件
   - 開発・運用手順

### README.md更新フォーマット例

```markdown
# プロジェクト名

## 概要
{プロジェクトの概要}

## 完了した機能
### {TASK-ID}: {タスク名}
- **実装日**: {実装日}
- **概要**: {機能の概要}
- **設定内容**: {設定した内容}
- **動作確認**: {動作確認の結果}

## セットアップ手順
### 前提条件
- {必要な環境・ツール}

### インストール
```bash
# 依存関係のインストール
{インストールコマンド}

# 環境変数の設定
{環境変数設定}
````

### 起動方法

```bash
# 開発サーバーの起動
{起動コマンド}
```

## 設定

### 環境変数

- `{環境変数名}`: {説明}

### 設定ファイル

- `{設定ファイルパス}`: {説明}

## 使用方法

{使用方法の説明}

## 開発

### 開発環境の準備

{開発環境の準備手順}

### テスト

{テストの実行方法}

## トラブルシューティング

### よくある問題

- **問題**: {問題の内容}
- **解決方法**: {解決方法}

## 更新履歴

- {日付}: {TASK-ID} {変更内容}

```

### 実行手順
1. 現在のREADME.mdを確認（存在しない場合は新規作成）
2. 完了したタスクの情報を追加
3. 必要に応じて他のセクションも更新
4. 変更内容をコミット
```
