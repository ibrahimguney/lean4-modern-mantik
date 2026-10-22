/-
  Lean 4 ile Modern Mantık
  Bölüm 2 — Alıştırma Çözümleri (eğitmenler için)
-/

namespace Cozum02

variable (P Q R : Prop)

-- 2.1
theorem a2_1 : P ∧ Q → P := by
  intro h
  exact h.left

-- 2.2
theorem a2_2 : P → P ∨ Q := by
  intro hp
  exact Or.inl hp

-- 2.3
theorem a2_3 : (P → Q) → (P → R) → P → Q ∧ R := by
  intro hpq hpr hp
  exact ⟨hpq hp, hpr hp⟩

-- 2.4
theorem a2_4 : P ∧ (Q ∧ R) → (P ∧ Q) ∧ R := by
  intro h
  obtain ⟨hp, hq, hr⟩ := h
  exact ⟨⟨hp, hq⟩, hr⟩

-- 2.5
theorem a2_5 : P ∨ (Q ∨ R) → (P ∨ Q) ∨ R := by
  intro h
  cases h with
  | inl hp => exact Or.inl (Or.inl hp)
  | inr hqr =>
    cases hqr with
    | inl hq => exact Or.inl (Or.inr hq)
    | inr hr => exact Or.inr hr

-- 2.6
theorem a2_6 : (P → R) → (Q → R) → P ∨ Q → R := by
  intro hpr hqr h
  cases h with
  | inl hp => exact hpr hp
  | inr hq => exact hqr hq

-- 2.7
theorem a2_7 : (P ∧ Q) ∨ (P ∧ R) → P ∧ (Q ∨ R) := by
  intro h
  cases h with
  | inl hpq => exact ⟨hpq.left, Or.inl hpq.right⟩
  | inr hpr => exact ⟨hpr.left, Or.inr hpr.right⟩

-- 2.8
theorem a2_8 : (P → Q → R) → (P → Q) → P → R :=
  fun hpqr hpq hp => hpqr hp (hpq hp)

-- 2.9
theorem a2_9 : P ∨ (Q ∧ R) → (P ∨ Q) ∧ (P ∨ R) := by
  intro h
  cases h with
  | inl hp => exact ⟨Or.inl hp, Or.inl hp⟩
  | inr hqr => exact ⟨Or.inr hqr.left, Or.inr hqr.right⟩

-- 2.10
theorem a2_10 : (P ∨ Q) ∧ (P ∨ R) → P ∨ (Q ∧ R) := by
  intro h
  obtain ⟨hpq, hpr⟩ := h
  cases hpq with
  | inl hp => exact Or.inl hp
  | inr hq =>
    cases hpr with
    | inl hp => exact Or.inl hp
    | inr hr => exact Or.inr ⟨hq, hr⟩

end Cozum02
