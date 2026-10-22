/-
  Lean 4 ile Modern Mantık
  Bölüm 5 — Alıştırmalar

  Her `sorry`'yi kendi ispatınızla değiştirin. Klasik mantık gerekmez.
  Zorluk:  ★ temel   ★★ orta   ★★★ ileri
  Çözümler: ModernMantik/Cozumler/Bolum05.lean
-/

namespace Alistirma05

variable (P Q R S : Prop)

-- 5.1 ★  Varsayımların sırasını değiştirmek
theorem a5_1 : (P → Q → R) → (Q → P → R) := by
  sorry

-- 5.2 ★  Yalnızca `have` ve `exact` kullanarak (ileriye doğru) ispatlayın
theorem a5_2 (h : P ∧ Q → R) (hp : P) (hq : Q) : R := by
  sorry

-- 5.3 ★  Aynı teoremi yalnızca `apply` ve `exact` ile (geriye doğru) ispatlayın
theorem a5_3 (h : P ∧ Q → R) (hp : P) (hq : Q) : R := by
  sorry

-- 5.4 ★★  İmplikasyon ve'ye dağılır
theorem a5_4 : (P → Q ∧ R) ↔ (P → Q) ∧ (P → R) := by
  sorry

-- 5.5 ★★  Durum ayırma, tek hipotezde
theorem a5_5 : (P ∨ Q) ∧ (P → R) ∧ (Q → R) → R := by
  sorry

-- 5.6 ★★  `refine` ve `<;>` ile tek satırda bitirin (rcases'ten sonra)
theorem a5_6 : P ∧ Q ∧ R → R ∧ Q ∧ P := by
  sorry

-- 5.7 ★★  Dört halkalı zincir: önce geriye, sonra ileriye doğru yazın
theorem a5_7 : (P → Q) → (Q → R) → (R → S) → P → S := by
  sorry

-- 5.8 ★★★  Durum ayırmanın değillemesi
theorem a5_8 : (P ∨ Q → R) → ¬R → ¬P ∧ ¬Q := by
  sorry

-- 5.9 ★★★  İç içe durum ayırma
theorem a5_9 : (P ∨ Q) ∧ (R ∨ S) → (P ∧ R) ∨ (P ∧ S) ∨ (Q ∧ R) ∨ (Q ∧ S) := by
  sorry

end Alistirma05
