/-
  Lean 4 ile Modern Mantık
  Bölüm 5 — Alıştırma Çözümleri (eğitmenler için)
-/

namespace Cozum05

variable (P Q R S : Prop)

-- 5.1
theorem a5_1 : (P → Q → R) → (Q → P → R) := by
  intro h hq hp
  exact h hp hq

-- 5.2 (ileriye doğru)
theorem a5_2 (h : P ∧ Q → R) (hp : P) (hq : Q) : R := by
  have hpq : P ∧ Q := ⟨hp, hq⟩
  have hr : R := h hpq
  exact hr

-- 5.3 (geriye doğru)
theorem a5_3 (h : P ∧ Q → R) (hp : P) (hq : Q) : R := by
  apply h
  exact ⟨hp, hq⟩

-- 5.4
theorem a5_4 : (P → Q ∧ R) ↔ (P → Q) ∧ (P → R) := by
  constructor
  · intro h
    exact ⟨fun hp => (h hp).left, fun hp => (h hp).right⟩
  · rintro ⟨hpq, hpr⟩ hp
    exact ⟨hpq hp, hpr hp⟩

-- 5.5
theorem a5_5 : (P ∨ Q) ∧ (P → R) ∧ (Q → R) → R := by
  rintro ⟨hpq, hpr, hqr⟩
  cases hpq with
  | inl hp => exact hpr hp
  | inr hq => exact hqr hq

-- 5.6
theorem a5_6 : P ∧ Q ∧ R → R ∧ Q ∧ P := by
  rintro ⟨hp, hq, hr⟩
  refine ⟨?_, ?_, ?_⟩ <;> assumption

-- 5.7 (geriye doğru)
theorem a5_7 : (P → Q) → (Q → R) → (R → S) → P → S := by
  intro hpq hqr hrs hp
  apply hrs
  apply hqr
  apply hpq
  exact hp

-- 5.7 (ileriye doğru)
theorem a5_7' : (P → Q) → (Q → R) → (R → S) → P → S := by
  intro hpq hqr hrs hp
  have hq : Q := hpq hp
  have hr : R := hqr hq
  exact hrs hr

-- 5.8
theorem a5_8 : (P ∨ Q → R) → ¬R → ¬P ∧ ¬Q := by
  intro h hnr
  constructor
  · intro hp
    exact hnr (h (Or.inl hp))
  · intro hq
    exact hnr (h (Or.inr hq))

-- 5.9
theorem a5_9 : (P ∨ Q) ∧ (R ∨ S) → (P ∧ R) ∨ (P ∧ S) ∨ (Q ∧ R) ∨ (Q ∧ S) := by
  rintro ⟨hp | hq, hr | hs⟩
  · exact Or.inl ⟨hp, hr⟩
  · exact Or.inr (Or.inl ⟨hp, hs⟩)
  · exact Or.inr (Or.inr (Or.inl ⟨hq, hr⟩))
  · exact Or.inr (Or.inr (Or.inr ⟨hq, hs⟩))

end Cozum05
