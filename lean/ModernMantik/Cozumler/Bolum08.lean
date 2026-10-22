/-
  Lean 4 ile Modern Mantık
  Bölüm 8 — Alıştırma Çözümleri (eğitmenler için)
-/
import Mathlib

namespace Cozum08

open Function

section Kumeler
variable {α : Type*} (s t u : Set α)

-- 8.1
theorem a8_1 : s ∩ s = s := by
  ext x
  constructor
  · rintro ⟨hs, _⟩
    exact hs
  · intro hs
    exact ⟨hs, hs⟩

-- 8.2
theorem a8_2 : s ⊆ s ∪ t := by
  intro x hx
  exact Or.inl hx

-- 8.3
theorem a8_3 : s ∪ (t ∩ u) = (s ∪ t) ∩ (s ∪ u) := by
  ext x
  simp only [Set.mem_union, Set.mem_inter_iff]
  tauto

-- 8.4 (KLASİK: tauto klasik mantık kullanır)
theorem a8_4 : (s ∩ t)ᶜ = sᶜ ∪ tᶜ := by
  ext x
  simp only [Set.mem_compl_iff, Set.mem_inter_iff, Set.mem_union]
  tauto

-- 8.5
theorem a8_5 (h : s ⊆ t) : s ∩ u ⊆ t ∩ u := by
  rintro x ⟨hs, hu⟩
  exact ⟨h hs, hu⟩

end Kumeler

-- 8.6
theorem a8_6 (a b c : ℕ) (h1 : a ∣ b) (h2 : b ∣ c) : a ∣ c := by
  obtain ⟨k, hk⟩ := h1            -- b = a * k
  obtain ⟨l, hl⟩ := h2            -- c = b * l
  refine ⟨k * l, ?_⟩
  rw [hl, hk]
  ring

section Fonksiyonlar
variable {α β γ : Type*} {f : α → β} {g : β → γ}

-- 8.7
theorem a8_7 (h : Surjective (g ∘ f)) : Surjective g := by
  intro c
  obtain ⟨a, ha⟩ := h c
  exact ⟨f a, ha⟩

-- 8.8
theorem a8_8 (h : Injective (g ∘ f)) : Injective f := by
  intro a b hab
  apply h
  show g (f a) = g (f b)
  rw [hab]

-- 8.9
theorem a8_9 (k : β → α) (h : ∀ b, f (k b) = b) : Surjective f := by
  intro b
  exact ⟨k b, h b⟩

end Fonksiyonlar

def R3 (a b : ℤ) : Prop := ∃ k, b - a = 3 * k

-- 8.10
theorem a8_10 : Equivalence R3 := by
  constructor
  · intro a
    exact ⟨0, by ring⟩
  · rintro a b ⟨k, hk⟩
    exact ⟨-k, by linarith⟩
  · rintro a b c ⟨k, hk⟩ ⟨l, hl⟩
    exact ⟨k + l, by linarith⟩

-- 8.11
theorem a8_11 : ¬ ∃ F : ℕ → (ℕ → ℕ), Surjective F := by
  rintro ⟨F, hF⟩
  obtain ⟨a, ha⟩ := hF (fun n => F n n + 1)    -- köşegeni değiştir
  have h : F a a = F a a + 1 := congrFun ha a
  omega

end Cozum08
