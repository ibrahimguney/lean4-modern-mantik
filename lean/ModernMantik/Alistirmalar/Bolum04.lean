/-
  Lean 4 ile Modern Mantık
  Bölüm 4 — Alıştırmalar

  Her `sorry`'yi kendi ispatınızla değiştirin.
  Bir alıştırmanın başında (YAPICI) yazıyorsa klasik mantık KULLANMAYIN;
  `#print axioms` ile denetleyin. (KLASİK) yazıyorsa Classical.em ya da
  Classical.byContradiction kullanabilirsiniz.
  Zorluk:  ★ temel   ★★ orta   ★★★ ileri
  Çözümler: ModernMantik/Cozumler/Bolum04.lean
-/

namespace Alistirma04

variable (P Q R : Prop)

-- 4.1 ★  (KLASİK) İmplikasyonu veya ile ifade etmek
theorem a4_1 : (P → Q) → ¬P ∨ Q := by
  sorry

-- 4.2 ★  (YAPICI) Ters yön yapıcıdır
theorem a4_2 : ¬P ∨ Q → (P → Q) := by
  sorry

-- 4.3 ★★  (KLASİK) İmplikasyonun değillemesi
theorem a4_3 : ¬(P → Q) → P ∧ ¬Q := by
  sorry

-- 4.4 ★★  (KLASİK) Kontrapozisyonun tersi, terim modunda
theorem a4_4 : (¬Q → ¬P) → (P → Q) :=
  sorry

-- 4.5 ★★  (KLASİK) Dummett'in doğrusallık ilkesi
theorem a4_5 : (P → Q) ∨ (Q → P) := by
  sorry

-- 4.6 ★★  (YAPICI) Karar verilebilir önermeler için De Morgan
theorem a4_6 [Decidable P] : ¬(P ∧ Q) → ¬P ∨ ¬Q := by
  sorry

-- 4.7 ★★★  (YAPICI) Glivenko'nun bir örneği
theorem a4_7 : ¬¬((P → Q) ∨ (Q → P)) := by
  sorry

-- 4.8 ★★★  (YAPICI) DNE, kendi başına EM'yi verir
--   Yani: her önerme için ¬¬P → P biliyorsak, P ∨ ¬P'yi de biliriz.
theorem a4_8 (dne : ∀ X : Prop, ¬¬X → X) : P ∨ ¬P := by
  sorry

end Alistirma04
