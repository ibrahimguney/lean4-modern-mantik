/-
  Lean 4 ile Modern Mantık
  Bölüm 4 — Alıştırma Çözümleri (eğitmenler için)
-/

namespace Cozum04

variable (P Q R : Prop)

-- 4.1 (KLASİK)
theorem a4_1 : (P → Q) → ¬P ∨ Q := by
  intro h
  cases Classical.em P with
  | inl hp  => exact Or.inr (h hp)
  | inr hnp => exact Or.inl hnp

-- 4.2 (YAPICI)
theorem a4_2 : ¬P ∨ Q → (P → Q) := by
  intro h hp
  cases h with
  | inl hnp => exact absurd hp hnp
  | inr hq  => exact hq

-- 4.3 (KLASİK)
theorem a4_3 : ¬(P → Q) → P ∧ ¬Q := by
  intro h
  constructor
  · apply Classical.byContradiction
    intro hnp
    exact h (fun hp => absurd hp hnp)
  · intro hq
    exact h (fun _ => hq)

-- 4.4 (KLASİK)
theorem a4_4 : (¬Q → ¬P) → (P → Q) :=
  fun h hp => Classical.byContradiction (fun hnq => h hnq hp)

-- 4.5 (KLASİK)
theorem a4_5 : (P → Q) ∨ (Q → P) := by
  cases Classical.em P with
  | inl hp  => exact Or.inr (fun _ => hp)
  | inr hnp => exact Or.inl (fun hp => absurd hp hnp)

-- 4.6 (YAPICI)
theorem a4_6 [Decidable P] : ¬(P ∧ Q) → ¬P ∨ ¬Q := by
  intro h
  cases Decidable.em P with
  | inl hp  => exact Or.inr (fun hq => h ⟨hp, hq⟩)
  | inr hnp => exact Or.inl hnp

-- 4.7 (YAPICI)
theorem a4_7 : ¬¬((P → Q) ∨ (Q → P)) := by
  intro h
  apply h
  apply Or.inl
  intro hp
  exfalso
  apply h
  apply Or.inr
  intro _
  exact hp

-- 4.8 (YAPICI)
theorem a4_8 (dne : ∀ X : Prop, ¬¬X → X) : P ∨ ¬P := by
  apply dne
  intro h
  apply h
  apply Or.inr
  intro hp
  exact h (Or.inl hp)

end Cozum04
