/-
  Lean 4 ile Modern Mantık
  Bölüm 2 — Önermeler Mantığı I: İmplikasyon, Ve, Veya

  `-- ANCHOR: ad` / `-- ANCHOR_END: ad` satırları kitabın kaynağı
  tarafından okunur. Lütfen silmeyin.
-/

namespace Bolum02

/-! ## 2.2  İmplikasyon (→) -/

-- ANCHOR: ozdeslik
theorem ozdeslik (P : Prop) : P → P := by
  intro hp    -- hp : P varsay, hedef: ⊢ P
  exact hp    -- varsayımın kendisi
-- ANCHOR_END: ozdeslik

-- ANCHOR: ozdeslik_terim
theorem ozdeslik' (P : Prop) : P → P :=
  fun hp => hp
-- ANCHOR_END: ozdeslik_terim

-- ANCHOR: modus_ponens
theorem modus_ponens (P Q : Prop) (hp : P) (hpq : P → Q) : Q := by
  apply hpq   -- Q'yu hpq ile elde ederim; P göstermem yeter
  exact hp
-- ANCHOR_END: modus_ponens

-- ANCHOR: modus_ponens_terim
theorem modus_ponens' (P Q : Prop) (hp : P) (hpq : P → Q) : Q :=
  hpq hp      -- implikasyonu uygulamak = fonksiyonu çağırmak
-- ANCHOR_END: modus_ponens_terim

-- ANCHOR: sabit
-- "P doğruysa, ne olursa olsun P doğrudur."
theorem sabit (P Q : Prop) : P → Q → P := by
  intro hp _  -- ikinci varsayıma ihtiyacımız yok: _ ile adsız bırak
  exact hp
-- ANCHOR_END: sabit

-- ANCHOR: hipotetik_kiyas
theorem hipotetik_kiyas (P Q R : Prop) (h1 : P → Q) (h2 : Q → R) : P → R := by
  intro p    -- p : P hipotezini içeri al, yeni hedef: ⊢ R
  apply h2   -- Hedef R idi, h2 sayesinde yeni hedef: ⊢ Q oldu
  apply h1   -- Hedef Q idi, h1 sayesinde yeni hedef: ⊢ P oldu
  exact p    -- Hedef P ve elimizde p : P var, ispat bitti!
-- ANCHOR_END: hipotetik_kiyas

-- ANCHOR: hipotetik_kiyas_terim
theorem hipotetik_kiyas' (P Q R : Prop) (h1 : P → Q) (h2 : Q → R) : P → R :=
  fun p => h2 (h1 p)
-- ANCHOR_END: hipotetik_kiyas_terim

/-! ## 2.3  Ve (∧) -/

-- ANCHOR: ve_giris
theorem ve_giris (P Q : Prop) (hp : P) (hq : Q) : P ∧ Q := by
  constructor   -- iki hedef: ⊢ P  ve  ⊢ Q
  · exact hp
  · exact hq
-- ANCHOR_END: ve_giris

-- ANCHOR: ve_giris_terim
theorem ve_giris' (P Q : Prop) (hp : P) (hq : Q) : P ∧ Q :=
  ⟨hp, hq⟩      -- And.intro hp hq ile aynı
-- ANCHOR_END: ve_giris_terim

-- ANCHOR: ve_eleme
theorem ve_sol (P Q : Prop) (h : P ∧ Q) : P := h.left
theorem ve_sag (P Q : Prop) (h : P ∧ Q) : Q := h.right
-- ANCHOR_END: ve_eleme

-- ANCHOR: ve_degisme
theorem ve_degisme (P Q : Prop) : P ∧ Q → Q ∧ P := by
  intro h
  obtain ⟨hp, hq⟩ := h   -- h'yi iki parçasına ayır
  exact ⟨hq, hp⟩
-- ANCHOR_END: ve_degisme

-- ANCHOR: ve_degisme_terim
theorem ve_degisme' (P Q : Prop) : P ∧ Q → Q ∧ P :=
  fun ⟨hp, hq⟩ => ⟨hq, hp⟩
-- ANCHOR_END: ve_degisme_terim

/-! ## 2.4  Veya (∨) -/

-- ANCHOR: veya_giris
theorem veya_sol (P Q : Prop) (hp : P) : P ∨ Q := by
  apply Or.inl   -- "sol taraf doğru" diyeceğim
  exact hp
theorem veya_sag (P Q : Prop) (hq : Q) : P ∨ Q := Or.inr hq
-- ANCHOR_END: veya_giris

-- ANCHOR: veya_degisme
theorem veya_degisme (P Q : Prop) : P ∨ Q → Q ∨ P := by
  intro h
  cases h with
  | inl hp => exact Or.inr hp   -- 1. durum: P doğru
  | inr hq => exact Or.inl hq   -- 2. durum: Q doğru
-- ANCHOR_END: veya_degisme

-- ANCHOR: veya_degisme_rcases
theorem veya_degisme₂ (P Q : Prop) : P ∨ Q → Q ∨ P := by
  rintro (hp | hq)
  · exact Or.inr hp
  · exact Or.inl hq
-- ANCHOR_END: veya_degisme_rcases

-- ANCHOR: veya_degisme_terim
theorem veya_degisme' (P Q : Prop) : P ∨ Q → Q ∨ P :=
  fun h => Or.elim h (fun hp => Or.inr hp) (fun hq => Or.inl hq)
-- ANCHOR_END: veya_degisme_terim

-- ANCHOR: dagilma
theorem ve_veya_dagilma (P Q R : Prop) :
    P ∧ (Q ∨ R) → (P ∧ Q) ∨ (P ∧ R) := by
  intro h
  obtain ⟨hp, hqr⟩ := h
  cases hqr with
  | inl hq => exact Or.inl ⟨hp, hq⟩
  | inr hr => exact Or.inr ⟨hp, hr⟩
-- ANCHOR_END: dagilma

/-! ## 2.5  Curry–Howard: → fonksiyon, ∧ çift, ∨ seçim -/

-- ANCHOR: curry
theorem curry_kurali (P Q R : Prop) : (P ∧ Q → R) → (P → Q → R) :=
  fun h hp hq => h ⟨hp, hq⟩

theorem uncurry_kurali (P Q R : Prop) : (P → Q → R) → (P ∧ Q → R) :=
  fun h ⟨hp, hq⟩ => h hp hq
-- ANCHOR_END: curry

end Bolum02
