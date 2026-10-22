/-
  Lean 4 ile Modern Mantık
  Bölüm 8 — Alıştırmalar

  Her `sorry`'yi kendi ispatınızla değiştirin.
  Mathlib'in taktiklerini (simp, tauto, ring, linarith, omega) ve
  `exact?` aramasını serbestçe kullanabilirsiniz.
  Zorluk:  ★ temel   ★★ orta   ★★★ ileri
  Çözümler: ModernMantik/Cozumler/Bolum08.lean
-/
import Mathlib

namespace Alistirma08

open Function

section Kumeler
variable {α : Type*} (s t u : Set α)

-- 8.1 ★
theorem a8_1 : s ∩ s = s := by
  sorry

-- 8.2 ★
theorem a8_2 : s ⊆ s ∪ t := by
  sorry

-- 8.3 ★★  Birleşimin kesişim üzerine dağılması
theorem a8_3 : s ∪ (t ∩ u) = (s ∪ t) ∩ (s ∪ u) := by
  sorry

-- 8.4 ★★  (KLASİK) Kesişimin tümleyeni
theorem a8_4 : (s ∩ t)ᶜ = sᶜ ∪ tᶜ := by
  sorry

-- 8.5 ★★
theorem a8_5 (h : s ⊆ t) : s ∩ u ⊆ t ∩ u := by
  sorry

end Kumeler

-- 8.6 ★★  Bölünebilirliğin geçişliliği, tanımdan (dvd_trans kullanmadan)
theorem a8_6 (a b c : ℕ) (h1 : a ∣ b) (h2 : b ∣ c) : a ∣ c := by
  sorry

section Fonksiyonlar
variable {α β γ : Type*} {f : α → β} {g : β → γ}

-- 8.7 ★★
theorem a8_7 (h : Surjective (g ∘ f)) : Surjective g := by
  sorry

-- 8.8 ★★
theorem a8_8 (h : Injective (g ∘ f)) : Injective f := by
  sorry

-- 8.9 ★★★  Sağ tersi olan fonksiyon örtendir
theorem a8_9 (k : β → α) (h : ∀ b, f (k b) = b) : Surjective f := by
  sorry

end Fonksiyonlar

-- 8.10 ★★★  "3'e bölündüğünde aynı kalanı verme" bir denklik ilişkisidir
def R3 (a b : ℤ) : Prop := ∃ k, b - a = 3 * k

theorem a8_10 : Equivalence R3 := by
  sorry

-- 8.11 ★★★  Köşegen yöntemi: ℕ'den (ℕ → ℕ)'ye örten fonksiyon yoktur
theorem a8_11 : ¬ ∃ F : ℕ → (ℕ → ℕ), Surjective F := by
  sorry

end Alistirma08
