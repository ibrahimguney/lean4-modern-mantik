/-
  Lean 4 ile Modern Mantık
  Bölüm 5 — Doğal Çıkarım Ağaçları ve Lean Taktikleri

  `-- ANCHOR: ad` / `-- ANCHOR_END: ad` satırları kitabın kaynağı
  tarafından okunur. Lütfen silmeyin.
-/

namespace Bolum05

/-! ## 5.2  Varsayım kuralı -/

-- ANCHOR: varsayim
theorem varsayim (P Q : Prop) (hp : P) (hq : Q) : P := by
  assumption        -- bağlamda türü hedefe uyan bir hipotez arar
-- ANCHOR_END: varsayim

/-! ## 5.4  Geriye ve ileriye akıl yürütme -/

-- ANCHOR: kiyas_geri
-- Geriye doğru: hedeften hipotezlere.
theorem kiyas_geri (P Q R : Prop) (h1 : P → Q) (h2 : Q → R) : P → R := by
  intro p
  apply h2          -- ⊢ Q
  apply h1          -- ⊢ P
  exact p
-- ANCHOR_END: kiyas_geri

-- ANCHOR: kiyas_ileri
-- İleriye doğru: hipotezlerden hedefe.
theorem kiyas_ileri (P Q R : Prop) (h1 : P → Q) (h2 : Q → R) : P → R := by
  intro p
  have q : Q := h1 p    -- yeni bir ara sonuç
  have r : R := h2 q    -- bir tane daha
  exact r
-- ANCHOR_END: kiyas_ileri

-- ANCHOR: kiyas_suffices
-- "Şunu göstermek yeter": geriye doğru, ama adım adını koyarak.
theorem kiyas_suffices (P Q R : Prop) (h1 : P → Q) (h2 : Q → R) : P → R := by
  intro p
  suffices q : Q by exact h2 q   -- Q elimizde olsaydı R kolaydı...
  exact h1 p                     -- ...o hâlde Q'yu gösterelim
-- ANCHOR_END: kiyas_suffices

-- ANCHOR: kiyas_show
-- show: hedefi açıkça yazarak okunabilirliği artırmak.
theorem kiyas_show (P Q R : Prop) (h1 : P → Q) (h2 : Q → R) : P → R := by
  intro p
  show R
  exact h2 (h1 p)
-- ANCHOR_END: kiyas_show

/-! ## 5.6  Kapsamlı bir örnek -/

-- ANCHOR: durum_iff
theorem durum_ayirma_iff (P Q R : Prop) :
    (P → R) ∧ (Q → R) ↔ (P ∨ Q → R) := by
  constructor
  · -- (→) yönü
    rintro ⟨hpr, hqr⟩ (hp | hq)
    · exact hpr hp
    · exact hqr hq
  · -- (←) yönü
    intro h
    exact ⟨fun hp => h (Or.inl hp), fun hq => h (Or.inr hq)⟩
-- ANCHOR_END: durum_iff

-- ANCHOR: durum_iff_terim
theorem durum_ayirma_iff' (P Q R : Prop) :
    (P → R) ∧ (Q → R) ↔ (P ∨ Q → R) :=
  ⟨fun ⟨hpr, hqr⟩ h => Or.elim h hpr hqr,
   fun h => ⟨fun hp => h (Or.inl hp), fun hq => h (Or.inr hq)⟩⟩
-- ANCHOR_END: durum_iff_terim

/-! ## 5.7  İspat normalleştirme -/

-- ANCHOR: dolambacli
-- Önce bir çift kur, sonra hemen sök: gereksiz bir dolambaç.
theorem dolambacli (P Q : Prop) (hp : P) (hq : Q) : P :=
  (⟨hp, hq⟩ : P ∧ Q).left

-- Dolambaç kaldırılmış (normal) ispat.
theorem dolaysiz (P Q : Prop) (hp : P) (hq : Q) : P :=
  hp
-- ANCHOR_END: dolambacli

-- ANCHOR: dolambacli_imp
-- Önce bir fonksiyon kur, sonra hemen uygula.
theorem dolambacli_imp (P Q : Prop) (hp : P) (hpq : P → Q) : Q :=
  (fun h : P => hpq h) hp
-- ANCHOR_END: dolambacli_imp

-- ANCHOR: hesaplama
-- Aynı dolambaçlar veri dünyasında "hesaplama" adını alır:
example : (fun x : Nat => x + 1) 2 = 3 := rfl       -- β-indirgeme
example (a : Nat) (b : Bool) : (a, b).1 = a := rfl  -- çiftin sökülmesi
-- ANCHOR_END: hesaplama

/-! ## 5.8  Taktik birleştiricileri -/

-- ANCHOR: birlestirici_uzun
theorem ve_uc (P Q R : Prop) (hp : P) (hq : Q) (hr : R) : P ∧ Q ∧ R := by
  constructor
  · exact hp
  · constructor
    · exact hq
    · exact hr
-- ANCHOR_END: birlestirici_uzun

-- ANCHOR: birlestirici_kisa
theorem ve_uc' (P Q R : Prop) (hp : P) (hq : Q) (hr : R) : P ∧ Q ∧ R := by
  refine ⟨?_, ?_, ?_⟩ <;> assumption

theorem ve_uc'' (P Q R : Prop) (hp : P) (hq : Q) (hr : R) : P ∧ Q ∧ R := by
  refine ⟨?_, ?_, ?_⟩
  all_goals assumption
-- ANCHOR_END: birlestirici_kisa

-- ANCHOR: birlestirici_veya
theorem veya_degisme (P Q : Prop) : P ∨ Q → Q ∨ P := by
  intro h
  rcases h with h | h <;> (first | exact Or.inr h | exact Or.inl h)
-- ANCHOR_END: birlestirici_veya

end Bolum05
