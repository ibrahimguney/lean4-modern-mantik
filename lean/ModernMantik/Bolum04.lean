/-
  Lean 4 ile Modern Mantık
  Bölüm 4 — Yapıcı ve Klasik Mantık

  `-- ANCHOR: ad` / `-- ANCHOR_END: ad` satırları kitabın kaynağı
  tarafından okunur. Lütfen silmeyin.
-/

namespace Bolum04

/-! ## 4.2  Classical.em: klasik mantığın kapısı -/

-- ANCHOR: em_check
#check @Classical.em               -- Classical.em : ∀ (p : Prop), p ∨ ¬p
#check @Classical.byContradiction  -- ∀ {p : Prop}, (¬p → False) → p
-- ANCHOR_END: em_check

-- ANCHOR: cift_degil_eleme
-- Çift değillemeyi elemek (klasik).
theorem cift_degilleme_eleme (P : Prop) : ¬¬P → P := by
  intro hnnp
  cases Classical.em P with
  | inl hp  => exact hp                  -- P doğruysa iş bitti
  | inr hnp => exact absurd hnp hnnp     -- ¬P ise ¬¬P ile çelişir
-- ANCHOR_END: cift_degil_eleme

-- ANCHOR: celiski_ile_ispat
-- Çelişki ile ispat (reductio ad absurdum).
theorem kontrapozisyon_ters (P Q : Prop) : (¬Q → ¬P) → (P → Q) := by
  intro h hp
  apply Classical.byContradiction        -- "Q yanlış olsaydı..."
  intro hnq                              -- hnq : ¬Q,  hedef: ⊢ False
  exact h hnq hp
-- ANCHOR_END: celiski_ile_ispat

-- ANCHOR: demorgan_ve_klasik
-- Bölüm 3'te ispatlayamadığımız De Morgan yönü.
theorem demorgan_ve_klasik (P Q : Prop) : ¬(P ∧ Q) → ¬P ∨ ¬Q := by
  intro h
  cases Classical.em P with
  | inl hp  => exact Or.inr (fun hq => h ⟨hp, hq⟩)
  | inr hnp => exact Or.inl hnp
-- ANCHOR_END: demorgan_ve_klasik

-- ANCHOR: peirce
-- Bölüm 2'deki Peirce yasası, sonunda.
theorem peirce (P Q : Prop) : ((P → Q) → P) → P := by
  intro h
  cases Classical.em P with
  | inl hp  => exact hp
  | inr hnp => exact h (fun hp => absurd hp hnp)
-- ANCHOR_END: peirce

/-! ## 4.3  Üç ilke birbirine denktir -/

-- ANCHOR: ilkeler
/-- Üçüncü hâlin olanaksızlığı (Excluded Middle) -/
abbrev EM : Prop := ∀ P : Prop, P ∨ ¬P
/-- Çift değilleme eleme (Double Negation Elimination) -/
abbrev DNE : Prop := ∀ P : Prop, ¬¬P → P
/-- Peirce yasası -/
abbrev Peirce : Prop := ∀ P Q : Prop, ((P → Q) → P) → P
-- ANCHOR_END: ilkeler

-- ANCHOR: em_dne
theorem em_dne : EM → DNE := by
  intro em P hnnp
  cases em P with
  | inl hp  => exact hp
  | inr hnp => exact absurd hnp hnnp
-- ANCHOR_END: em_dne

-- ANCHOR: dne_peirce
theorem dne_peirce : DNE → Peirce := by
  intro dne P Q h
  apply dne                 -- ⊢ ¬¬P
  intro hnp                 -- hnp : ¬P,  ⊢ False
  apply hnp                 -- ⊢ P
  apply h                   -- ⊢ P → Q
  intro hp
  exact absurd hp hnp
-- ANCHOR_END: dne_peirce

-- ANCHOR: peirce_em
theorem peirce_em : Peirce → EM := by
  intro pe P
  apply pe (P ∨ ¬P) False   -- Q yerine False seç
  intro h                   -- h : ¬(P ∨ ¬P)
  apply Or.inr
  intro hp
  exact h (Or.inl hp)
-- ANCHOR_END: peirce_em

-- ANCHOR: uc_ilke_denk
theorem em_iff_dne : EM ↔ DNE :=
  ⟨em_dne, fun h => peirce_em (dne_peirce h)⟩

theorem em_iff_peirce : EM ↔ Peirce :=
  ⟨fun h => dne_peirce (em_dne h), peirce_em⟩
-- ANCHOR_END: uc_ilke_denk

/-! ## 4.4  Hangi aksiyomlar kullanıldı? -/

-- ANCHOR: print_axioms
#print axioms em_dne
-- 'Bolum04.em_dne' does not depend on any axioms

#print axioms cift_degilleme_eleme
-- 'Bolum04.cift_degilleme_eleme' depends on axioms:
--   [propext, Classical.choice, Quot.sound]
-- ANCHOR_END: print_axioms

/-! ## 4.5  Glivenko: klasik totolojiler çift değilleme altında yapıcıdır -/

-- ANCHOR: glivenko_peirce
-- Klasik mantık kullanmadan:
theorem peirce_cift_degil (P Q : Prop) : ¬¬(((P → Q) → P) → P) := by
  intro h                   -- h : ¬(Peirce örneği)
  apply h
  intro hpqp                -- ⊢ P
  apply hpqp                -- ⊢ P → Q
  intro hp
  exfalso                   -- P elimizde; h'yi çürütmek için kullanalım
  apply h
  intro _
  exact hp
-- ANCHOR_END: glivenko_peirce

/-! ## 4.6  Karar verilebilir önermeler -/

-- ANCHOR: decidable
example : 3 < 5 := by decide        -- hesaplayarak ispat
#eval decide (3 < 5)                -- true
#eval decide (2 + 2 = 5)            -- false

-- Karar verilebilir önermeler için üçüncü hâl, seçim aksiyomu olmadan:
theorem esit_ya_da_degil (n m : Nat) : n = m ∨ n ≠ m :=
  Decidable.em (n = m)
-- ANCHOR_END: decidable

-- ANCHOR: decidable_dne
-- Karar verilebilir bir önerme için çift değilleme eleme:
theorem cift_degil_karar (P : Prop) [Decidable P] : ¬¬P → P := by
  intro hnnp
  cases Decidable.em P with
  | inl hp  => exact hp
  | inr hnp => exact absurd hnp hnnp
-- ANCHOR_END: decidable_dne

end Bolum04
