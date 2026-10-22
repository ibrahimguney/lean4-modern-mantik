/-
  Lean 4 ile Modern Mantık
  Bölüm 3 — Alıştırma Çözümleri (eğitmenler için)
  Hiçbir çözüm klasik mantık kullanmaz.
-/

namespace Cozum03

variable (P Q R : Prop)

-- 3.1
theorem a3_1 : ¬False := by
  intro h
  exact h

-- 3.2
theorem a3_2 : P → True := by
  intro _
  trivial

-- 3.3
theorem a3_3 : P → ¬P → Q := by
  intro hp hnp
  exact absurd hp hnp

-- 3.4
theorem a3_4 : P ↔ P := by
  constructor
  · intro hp
    exact hp
  · intro hp
    exact hp

-- 3.5
theorem a3_5 : (P ↔ Q) → (Q ↔ P) := by
  intro h
  exact ⟨h.mpr, h.mp⟩

-- 3.6
theorem a3_6 : (P ↔ Q) → (Q ↔ R) → (P ↔ R) := by
  intro hpq hqr
  constructor
  · intro hp
    exact hqr.mp (hpq.mp hp)
  · intro hr
    exact hpq.mpr (hqr.mpr hr)

-- 3.7
theorem a3_7 : P ∨ Q → ¬P → Q := by
  intro h hnp
  cases h with
  | inl hp => exact absurd hp hnp
  | inr hq => exact hq

-- 3.8  İpucu: önce ¬P'yi, sonra P'yi elde edin.
theorem a3_8 : ¬(P ↔ ¬P) := by
  intro h
  have hnp : ¬P := fun hp => h.mp hp hp
  exact hnp (h.mpr hnp)

-- 3.9
theorem a3_9 : ¬(P → Q) → ¬Q := by
  intro h hq
  exact h (fun _ => hq)

-- 3.10
theorem a3_10 : ¬¬(P → Q) → ¬¬P → ¬¬Q := by
  intro hnnpq hnnp hnq
  apply hnnpq
  intro hpq
  apply hnnp
  intro hp
  exact hnq (hpq hp)

-- 3.11
theorem a3_11 : ¬(P ∧ Q) → ¬¬(¬P ∨ ¬Q) := by
  intro h hn
  apply hn
  apply Or.inl
  intro hp
  apply hn
  apply Or.inr
  intro hq
  exact h ⟨hp, hq⟩

-- 3.12
theorem a3_12 : ¬¬(((P → Q) → P) → P) := by
  intro h
  apply h
  intro hpqp
  apply hpqp
  intro hp
  exfalso
  apply h
  intro _
  exact hp

end Cozum03
