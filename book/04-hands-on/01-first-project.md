# 4.1 最初のAITDDプロジェクト

## 学習目標

この章では、AITDDの基本的な流れを体験できる初回プロジェクトを通じて以下を身につけます：

- AITDDプロセス全体の流れを理解する
- TODO作成から実装完了までの一連の手順を実践する
- AI支援と人力レビューの適切なバランスを体験する
- 小規模な機能でAITDDの効果を実感する

## プロジェクトの選択基準

### 最初のプロジェクトに適した特徴

**実装範囲**：
- 30分〜1時間程度で完成する小規模機能
- 単一の責任を持つシンプルな処理
- 外部依存が少ない独立性の高い機能

**技術的複雑さ**：
- 慣れ親しんだ技術スタックを使用
- 実装方法がイメージできる内容
- デバッグが比較的簡単な処理

**学習効果**：
- AITDDの各ステップを体験できる
- 成功体験を得やすい内容
- 後から拡張可能な基盤となる機能

### 推奨プロジェクト例

**1. 簡単な計算機能**
```
例：税込価格計算機
- 入力：商品価格、税率
- 出力：税込価格、税額
- 処理：基本的な数値計算
```

**2. データ変換機能**
```
例：CSVデータのフォーマット変換
- 入力：CSV文字列
- 出力：JSON形式データ
- 処理：パースと変換ロジック
```

**3. バリデーション機能**
```
例：メールアドレス検証
- 入力：文字列
- 出力：検証結果（真偽値）
- 処理：正規表現による形式チェック
```

## 実践ハンズオン：税込価格計算機

この例では、税込価格計算機の実装を通じてAITDDプロセスを学習します。

### ステップ1：TODO作成

プロジェクト内にtodo.mdファイルを作成し、実装する機能を明確化します。

```markdown
# TODO: 税込価格計算機の実装

## 実装する機能
- [ ] 商品価格と税率から税込価格を計算する関数
- [ ] 税額を計算する関数  
- [ ] 入力値のバリデーション
- [ ] エラーハンドリング（負の値、null値等）

## 完了基準
- 正常な値での計算が正しく動作する
- 異常値に対して適切なエラーハンドリングができる
- テストカバレッジ100%を達成する
```

**ポイント**：
- 機能を具体的に分解する
- 完了基準を明確にする
- 30分〜1時間で完成する粒度に調整する

### ステップ2：仕様作成

TODOを基に詳細な仕様をAIと協力して作成します。

**AIへのプロンプト例**：
```
以下のTODOから詳細な仕様書を作成してください：

[todo.mdの内容を貼り付け]

仕様書には以下を含めてください：
- 関数の署名（引数、戻り値）
- 入力値の制約
- エラー条件と対応
- 計算ロジックの詳細
```

**期待される仕様書（例）**：
```markdown
# 税込価格計算機 仕様書

## 関数仕様

### calculateTaxIncludedPrice(price: number, taxRate: number): number
- 商品価格と税率から税込価格を計算
- 引数：
  - price: 商品価格（0以上の数値）
  - taxRate: 税率（0以上1以下の小数、例：0.1 = 10%）
- 戻り値：税込価格（小数第一位で四捨五入）

### calculateTax(price: number, taxRate: number): number  
- 税額を計算
- 引数・戻り値は上記と同様
- 戻り値：税額（小数第一位で四捨五入）

## エラー処理
- 負の価格：Error("価格は0以上である必要があります")
- 税率が範囲外：Error("税率は0以上1以下である必要があります")
- null/undefined：Error("有効な数値を入力してください")
```

**人力レビューのチェックポイント**：
- [ ] TODOの意図が正しく反映されているか
- [ ] 関数の責任範囲が適切か
- [ ] エラー条件が網羅されているか
- [ ] 実装可能な内容か

### ステップ3：テストケース作成

仕様書を基にテストケースをAIに作成させます。

**AIへのプロンプト例**：
```
以下の仕様書に基づいて包括的なテストケースを作成してください：

[仕様書の内容を貼り付け]

以下の観点でテストケースを作成してください：
- 正常系：一般的な値での動作確認
- 境界値：0、1などの境界での動作確認  
- 異常系：エラー条件の動作確認
- テストフレームワーク：Jest を使用
```

**生成されたテストケース例**：
```typescript
import { calculateTaxIncludedPrice, calculateTax } from './taxCalculator';

describe('税込価格計算機', () => {
  describe('calculateTaxIncludedPrice', () => {
    // 正常系
    test('一般的な税込価格計算', () => {
      expect(calculateTaxIncludedPrice(1000, 0.1)).toBe(1100);
      expect(calculateTaxIncludedPrice(150, 0.08)).toBe(162);
    });

    // 境界値
    test('価格0の場合', () => {
      expect(calculateTaxIncludedPrice(0, 0.1)).toBe(0);
    });

    test('税率0の場合', () => {
      expect(calculateTaxIncludedPrice(1000, 0)).toBe(1000);
    });

    // 異常系
    test('負の価格でエラー', () => {
      expect(() => calculateTaxIncludedPrice(-100, 0.1))
        .toThrow('価格は0以上である必要があります');
    });

    test('税率が範囲外でエラー', () => {
      expect(() => calculateTaxIncludedPrice(1000, -0.1))
        .toThrow('税率は0以上1以下である必要があります');
      expect(() => calculateTaxIncludedPrice(1000, 1.1))
        .toThrow('税率は0以上1以下である必要があります');
    });
  });

  describe('calculateTax', () => {
    test('税額計算', () => {
      expect(calculateTax(1000, 0.1)).toBe(100);
      expect(calculateTax(150, 0.08)).toBe(12);
    });
  });
});
```

**人力レビューのチェックポイント**：
- [ ] 仕様の要件を全てカバーしているか
- [ ] 異常系のテストが適切か
- [ ] テストの期待値が正しいか
- [ ] 追加すべきテストケースはないか

### ステップ4：Red-Green-Refactor-Validationサイクル

#### 4.1 Red（テスト失敗）

テストを実行して期待する失敗を確認します。

```bash
npm test
```

期待される出力：
```
FAIL  src/taxCalculator.test.ts
  ✕ calculateTaxIncludedPrice is not defined
  ✕ calculateTax is not defined
```

#### 4.2 Green（最小実装）

AIに最小限の実装を依頼します。

**AIへのプロンプト例**：
```
以下のテストケースを通る最小限の実装を作成してください：

[テストケースを貼り付け]

要件：
- テストを通すことを最優先
- 過度に複雑にしない
- エラーハンドリングを適切に実装
```

**生成された実装例**：
```typescript
export function calculateTaxIncludedPrice(price: number, taxRate: number): number {
  validateInputs(price, taxRate);
  const tax = calculateTax(price, taxRate);
  return Math.round((price + tax) * 10) / 10;
}

export function calculateTax(price: number, taxRate: number): number {
  validateInputs(price, taxRate);
  return Math.round((price * taxRate) * 10) / 10;
}

function validateInputs(price: number, taxRate: number): void {
  if (price < 0) {
    throw new Error('価格は0以上である必要があります');
  }
  if (taxRate < 0 || taxRate > 1) {
    throw new Error('税率は0以上1以下である必要があります');
  }
}
```

テスト実行：
```bash
npm test
# 全てのテストがパスすることを確認
```

#### 4.3 Refactor（リファクタリング）

AIにコード改善を依頼します。

**AIへのプロンプト例**：
```
以下のコードをリファクタリングしてください：

[実装コードを貼り付け]

改善点：
- コードの可読性向上
- 関数の責任分割
- パフォーマンス最適化
- TypeScriptの型安全性向上
```

#### 4.4 Validation（検証）

AIに実装の妥当性を検証させます。

**AIへのプロンプト例**：
```
以下の実装について包括的に検証してください：

[リファクタリング後のコードを貼り付け]
[テストケースも貼り付け]

検証観点：
- 仕様要件との整合性
- コード品質（可読性、保守性）
- テストカバレッジの妥当性
- 潜在的な問題点
- パフォーマンス上の懸念
```

### ステップ5：最終レビュー

**人力レビューのチェックポイント**：

**機能面**：
- [ ] 全てのテストがパスしている
- [ ] 仕様要件が満たされている
- [ ] エラーハンドリングが適切

**コード品質**：
- [ ] 可読性が高い
- [ ] 適切な関数分割がされている
- [ ] 命名規約に従っている
- [ ] TypeScriptの型定義が適切

**保守性**：
- [ ] 拡張しやすい構造
- [ ] テストが保守しやすい
- [ ] ドキュメントが適切

## 振り返りと学習のポイント

### 成功のパターン

**プロセス遵守**：
- 各ステップを飛ばさずに実行する
- 人力レビューを確実に行う
- AI出力を鵜呑みにしない

**適切なAI活用**：
- 明確で具体的なプロンプトを使う
- コンテキストを十分に提供する
- 期待する出力形式を指定する

### よくある失敗パターンと対策

**失敗1：プロンプトが曖昧**
```
❌ 悪い例：「税計算の関数を作って」
✅ 良い例：「商品価格と税率から税込価格を計算する関数を、以下の仕様に従って作成してください：[詳細仕様]」
```

**失敗2：人力レビューを省略**
```
❌ 問題：AIの出力をそのまま使用
✅ 対策：必ず仕様との整合性を確認する
```

**失敗3：テスト設計が不十分**
```
❌ 問題：正常系のテストのみ
✅ 対策：境界値、異常系を含む包括的なテスト
```

### 次のステップへの準備

この初回プロジェクトで習得すべき感覚：
- AIとの協調開発のリズム
- 品質管理の重要性
- プロンプト設計の基本
- レビューポイントの理解

次章では、より複雑なCRUD操作の実装を通じて、AITDDの応用力を身につけます。

## まとめ

最初のAITDDプロジェクトでは以下を重視します：

1. **成功体験の獲得**：小規模でも完全なプロセスを体験
2. **基本習慣の確立**：各ステップの重要性を理解
3. **AI活用の感覚**：適切なプロンプト設計の基礎
4. **品質意識の醸成**：人力レビューの価値を実感

これらの基盤があることで、より複雑なプロジェクトでもAITDDを効果的に活用できるようになります。
