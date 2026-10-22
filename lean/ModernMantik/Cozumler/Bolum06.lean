/-
  Lean 4 ile Modern Mantık
  Bölüm 6 — Alıştırma Çözümleri (eğitmenler için)
-/

namespace Cozum06

variable (α : Type) (P Q : α → Prop) (R : α → α → Prop)

-- 6.1
theorem a6_1 : (∀ x, P x ∧ Q x) → ∀ x, P x := by
  intro h x
  exact (h x).left

-- 6.2
theorem a6_2 : (∀ x, P x) → (∀ x, Q x) → ∀ x, P x ∧ Q x := by
  intro hp hq x
  exact ⟨hp x, hq x⟩

-- 6.3
theorem a6_3 : (∃ x, P x ∧ Q x) → ∃ x, P x := by
  rintro ⟨x, hp, _⟩
  exact ⟨x, hp⟩

-- 6.4
theorem a6_4 : (∀ x, P x ∧ Q x) ↔ (∀ x, P x) ∧ (∀ x, Q x) := by
  constructor
  · intro h
    exact ⟨fun x => (h x).left, fun x => (h x).right⟩
  · rintro ⟨hp, hq⟩ x
    exact ⟨hp x, hq x⟩

-- 6.5
theorem a6_5 : (∃ x, P x ∨ Q x) ↔ (∃ x, P x) ∨ (∃ x, Q x) := by
  constructor
  · rintro ⟨x, hp | hq⟩
    · exact Or.inl ⟨x, hp⟩
    · exact Or.inr ⟨x, hq⟩
  · rintro (⟨x, hp⟩ | ⟨x, hq⟩)
    · exact ⟨x, Or.inl hp⟩
    · exact ⟨x, Or.inr hq⟩

-- 6.6  (Tersi yanlıştır: "çift olan bir sayı var" ve "tek olan bir sayı var"
--       doğrudur, ama "hem çift hem tek olan bir sayı var" yanlıştır.)
theorem a6_6 : (∃ x, P x ∧ Q x) → (∃ x, P x) ∧ (∃ x, Q x) := by
  rintro ⟨x, hp, hq⟩
  exact ⟨⟨x, hp⟩, ⟨x, hq⟩⟩

-- 6.7
theorem a6_7 : (∀ x, P x → Q x) → (∃ x, P x) → ∃ x, Q x := by
  rintro h ⟨x, hp⟩
  exact ⟨x, h x hp⟩

-- 6.8
theorem a6_8 (a b c : α) (h1 : a = b) (h2 : c = b) : a = c :=
  h1.trans h2.symm

-- 6.9
theorem a6_9 (f : α → α) (a b : α) (h : a = b) : f (f a) = f (f b) := by
  rw [h]

-- 6.10 (KLASİK)
theorem a6_10 : (¬ ∀ x, P x) ↔ ∃ x, ¬ P x := by
  constructor
  · intro h
    apply Classical.byContradiction
    intro hyok
    apply h
    intro x
    apply Classical.byContradiction
    intro hpx
    exact hyok ⟨x, hpx⟩
  · rintro ⟨x, hx⟩ hall
    exact hx (hall x)

-- 6.11 (KLASİK)
theorem a6_11 [Inhabited α] : ∃ x, P x → ∀ y, P y := by
  cases Classical.em (∀ y, P y) with
  | inl h => exact ⟨default, fun _ => h⟩
  | inr h =>
    have hvar : ∃ y, ¬ P y := by
      apply Classical.byContradiction
      intro hyok
      apply h
      intro y
      apply Classical.byContradiction
      intro hpy
      exact hyok ⟨y, hpy⟩
    obtain ⟨y, hy⟩ := hvar
    exact ⟨y, fun hp => absurd hp hy⟩

-- 6.12
theorem a6_12 : ¬ ∃ x, ∀ y, R x y ↔ ¬ R y y := by
  rintro ⟨x, hx⟩
  have h := hx x
  have hn : ¬ R x x := fun hxx => h.mp hxx hxx
  exact hn (h.mpr hn)

end Cozum06
