/-
  Lean 4 ile Modern Mantık
  Bölüm 6 — Alıştırmalar

  Her `sorry`'yi kendi ispatınızla değiştirin.
  (KLASİK) işaretli alıştırmalar dışında klasik mantık kullanmayın.
  Zorluk:  ★ temel   ★★ orta   ★★★ ileri
  Çözümler: ModernMantik/Cozumler/Bolum06.lean
-/

namespace Alistirma06

variable (α : Type) (P Q : α → Prop) (R : α → α → Prop)

-- 6.1 ★
theorem a6_1 : (∀ x, P x ∧ Q x) → ∀ x, P x := by
  sorry

-- 6.2 ★
theorem a6_2 : (∀ x, P x) → (∀ x, Q x) → ∀ x, P x ∧ Q x := by
  sorry

-- 6.3 ★
theorem a6_3 : (∃ x, P x ∧ Q x) → ∃ x, P x := by
  sorry

-- 6.4 ★★  ∀, ∧ üzerine dağılır
theorem a6_4 : (∀ x, P x ∧ Q x) ↔ (∀ x, P x) ∧ (∀ x, Q x) := by
  sorry

-- 6.5 ★★  ∃, ∨ üzerine dağılır
theorem a6_5 : (∃ x, P x ∨ Q x) ↔ (∃ x, P x) ∨ (∃ x, Q x) := by
  sorry

-- 6.6 ★★  Bu yönün tersi neden yanlıştır?
theorem a6_6 : (∃ x, P x ∧ Q x) → (∃ x, P x) ∧ (∃ x, Q x) := by
  sorry

-- 6.7 ★★
theorem a6_7 : (∀ x, P x → Q x) → (∃ x, P x) → ∃ x, Q x := by
  sorry

-- 6.8 ★★  Eşitlik
theorem a6_8 (a b c : α) (h1 : a = b) (h2 : c = b) : a = c := by
  sorry

-- 6.9 ★★  Eşitlik ve fonksiyonlar
theorem a6_9 (f : α → α) (a b : α) (h : a = b) : f (f a) = f (f b) := by
  sorry

-- 6.10 ★★★  (KLASİK) Niceleyici değillemesi, iki yönlü
theorem a6_10 : (¬ ∀ x, P x) ↔ ∃ x, ¬ P x := by
  sorry

-- 6.11 ★★★  (KLASİK) İçki içen paradoksu
--   "Barda öyle biri vardır ki, o içiyorsa herkes içiyordur."
theorem a6_11 [Inhabited α] : ∃ x, P x → ∀ y, P y := by
  sorry

-- 6.12 ★★★  Berber paradoksunun genel hâli (yapıcı)
theorem a6_12 : ¬ ∃ x, ∀ y, R x y ↔ ¬ R y y := by
  sorry

end Alistirma06
