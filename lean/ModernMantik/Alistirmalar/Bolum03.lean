/-
  Lean 4 ile Modern Mantık
  Bölüm 3 — Alıştırmalar

  Her `sorry`'yi kendi ispatınızla değiştirin.
  Bu bölümün alıştırmalarının HİÇBİRİ klasik mantık gerektirmez:
  `Classical.em` ya da `Classical.byContradiction` kullanmayın.
  Zorluk:  ★ temel   ★★ orta   ★★★ ileri
  Çözümler: ModernMantik/Cozumler/Bolum03.lean
-/

namespace Alistirma03

variable (P Q R : Prop)

-- 3.1 ★  ¬False
theorem a3_1 : ¬False := by
  sorry

-- 3.2 ★  True'dan bir şey çıkmaz, ama True her şeyden çıkar
theorem a3_2 : P → True := by
  sorry

-- 3.3 ★  Değillemeyi uygulamak
theorem a3_3 : P → ¬P → Q := by
  sorry

-- 3.4 ★  Denkliğin yansıma özelliği
theorem a3_4 : P ↔ P := by
  sorry

-- 3.5 ★★  Denkliğin simetrisi
theorem a3_5 : (P ↔ Q) → (Q ↔ P) := by
  sorry

-- 3.6 ★★  Denkliğin geçişliliği
theorem a3_6 : (P ↔ Q) → (Q ↔ R) → (P ↔ R) := by
  sorry

-- 3.7 ★★  Veya'nın değillemeyle elemesi (disjunktif kıyas)
theorem a3_7 : P ∨ Q → ¬P → Q := by
  sorry

-- 3.8 ★★  Bir önerme kendi değillemesine denk olamaz
theorem a3_8 : ¬(P ↔ ¬P) := by
  sorry

-- 3.9 ★★  İmplikasyonun değillemesinden
theorem a3_9 : ¬(P → Q) → ¬Q := by
  sorry

-- 3.10 ★★  Çift değilleme implikasyona dağılır
theorem a3_10 : ¬¬(P → Q) → ¬¬P → ¬¬Q := by
  sorry

-- 3.11 ★★★  Çift değilleme altında De Morgan'ın "zor" yönü
theorem a3_11 : ¬(P ∧ Q) → ¬¬(¬P ∨ ¬Q) := by
  sorry

-- 3.12 ★★★  Çift değilleme altında Peirce yasası
theorem a3_12 : ¬¬(((P → Q) → P) → P) := by
  sorry

end Alistirma03
