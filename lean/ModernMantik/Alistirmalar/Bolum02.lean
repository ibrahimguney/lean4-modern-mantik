/-
  Lean 4 ile Modern Mantık
  Bölüm 2 — Alıştırmalar

  Her `sorry`'yi kendi ispatınızla değiştirin.
  Zorluk:  ★ temel   ★★ orta   ★★★ ileri
  Çözümler: ModernMantik/Cozumler/Bolum02.lean
-/

namespace Alistirma02

variable (P Q R : Prop)

-- 2.1 ★  Ve'nin sol bileşeni
theorem a2_1 : P ∧ Q → P := by
  sorry

-- 2.2 ★  Veya'ya giriş
theorem a2_2 : P → P ∨ Q := by
  sorry

-- 2.3 ★  İki sonucu birleştirmek
theorem a2_3 : (P → Q) → (P → R) → P → Q ∧ R := by
  sorry

-- 2.4 ★★  Ve'nin birleşme özelliği
theorem a2_4 : P ∧ (Q ∧ R) → (P ∧ Q) ∧ R := by
  sorry

-- 2.5 ★★  Veya'nın birleşme özelliği
theorem a2_5 : P ∨ (Q ∨ R) → (P ∨ Q) ∨ R := by
  sorry

-- 2.6 ★★  Durum ayırma ilkesi
theorem a2_6 : (P → R) → (Q → R) → P ∨ Q → R := by
  sorry

-- 2.7 ★★  Dağılmanın tersi
theorem a2_7 : (P ∧ Q) ∨ (P ∧ R) → P ∧ (Q ∨ R) := by
  sorry

-- 2.8 ★★  S kombinatörü
theorem a2_8 : (P → Q → R) → (P → Q) → P → R := by
  sorry

-- 2.9 ★★  Veya'nın ve üzerine dağılması
theorem a2_9 : P ∨ (Q ∧ R) → (P ∨ Q) ∧ (P ∨ R) := by
  sorry

-- 2.10 ★★★  2.9'un tersi
theorem a2_10 : (P ∨ Q) ∧ (P ∨ R) → P ∨ (Q ∧ R) := by
  sorry

/-
  2.11 ★★★  (Kâğıt-kalem) `ve_veya_dagilma` teoreminin doğal çıkarım
             ağacını çizin. Hangi varsayım hangi kuralda kapanıyor?

  2.12 ★★★  Peirce yasası:  ((P → Q) → P) → P
             Bu önermeyi yalnızca bu bölümün araçlarıyla ispatlamayı
             deneyin. Nerede takıldığınızı not edin. Neden takıldığınızı
             Bölüm 4'te göreceğiz.

             theorem peirce : ((P → Q) → P) → P := by
               sorry
-/

end Alistirma02
