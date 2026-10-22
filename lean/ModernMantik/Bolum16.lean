/-
  Lean 4 ile Modern Mantık
  Bölüm 16 — Lean'in Aksiyomları

  Bu bölüm yalnızca Lean çekirdeğini kullanır.

  `-- ANCHOR: ad` / `-- ANCHOR_END: ad` satırları kitabın kaynağı
  tarafından okunur. Lütfen silmeyin.
-/

namespace Bolum16

universe u v

/-! ## 16.1  Önerme dışsallığı -/

-- ANCHOR: propext
#check @propext            -- propext : ∀ {a b : Prop}, (a ↔ b) → a = b

theorem ve_dogru (p : Prop) : (p ∧ True) = p :=
  propext ⟨fun h => h.1, fun h => ⟨h, trivial⟩⟩

-- ↔ ile yeniden yazmak, arka planda propext kullanır.
theorem ters_yaz (p q : Prop) (h : p ↔ q) (hq : q) : p := by
  rw [h]
  exact hq

#print axioms ve_dogru     -- [propext]
#print axioms ters_yaz     -- [propext]
-- ANCHOR_END: propext

-- ANCHOR: iki_deger
-- propext + üçüncü hâl:  Prop'un yalnızca iki "değeri" vardır.
theorem prop_iki_deger (p : Prop) : p = True ∨ p = False := by
  cases Classical.em p with
  | inl hp  => exact Or.inl (propext ⟨fun _ => trivial, fun _ => hp⟩)
  | inr hnp => exact Or.inr (propext ⟨fun h => hnp h, fun h => h.elim⟩)
-- ANCHOR_END: iki_deger

/-! ## 16.2  Bölüm tipleri: tamsayılar -/

-- ANCHOR: tamsayi
-- (a, b) çifti "a − b" sayısını temsil eder.  (a, b) ~ (c, d)  ↔  a + d = c + b
def IlgiliMi (x y : Nat × Nat) : Prop := x.1 + y.2 = y.1 + x.2

theorem ilgili_denklik : Equivalence IlgiliMi where
  refl _ := rfl
  symm h := Eq.symm h
  trans h1 h2 := by unfold IlgiliMi at *; omega

instance tamsayiSetoid : Setoid (Nat × Nat) := ⟨IlgiliMi, ilgili_denklik⟩

abbrev Tamsayi : Type := Quotient tamsayiSetoid

def Tamsayi.mk (a b : Nat) : Tamsayi := Quotient.mk tamsayiSetoid (a, b)

-- Farklı temsilciler, aynı tamsayı:  3 − 1 = 5 − 3
example : Tamsayi.mk 3 1 = Tamsayi.mk 5 3 :=
  Quotient.sound (show 3 + 3 = 5 + 1 from rfl)
-- ANCHOR_END: tamsayi

-- ANCHOR: tamsayi_islem
-- Bölümden dışarı fonksiyon: temsilciye bağlı olmadığı kanıtlanmalı.
def Tamsayi.isaret : Tamsayi → Int :=
  Quotient.lift (fun x => (x.1 : Int) - x.2) (by
    intro a b h
    have h' : a.1 + b.2 = b.1 + a.2 := h
    show (a.1 : Int) - a.2 = (b.1 : Int) - b.2
    omega)

def Tamsayi.topla : Tamsayi → Tamsayi → Tamsayi :=
  Quotient.lift₂ (fun x y => Tamsayi.mk (x.1 + y.1) (x.2 + y.2)) (by
    intro a1 b1 a2 b2 h1 h2
    have h1' : a1.1 + a2.2 = a2.1 + a1.2 := h1
    have h2' : b1.1 + b2.2 = b2.1 + b1.2 := h2
    apply Quotient.sound
    show (a1.1 + b1.1) + (a2.2 + b2.2) = (a2.1 + b2.1) + (a1.2 + b1.2)
    omega)

def Tamsayi.negatif : Tamsayi → Tamsayi :=
  Quotient.lift (fun x => Tamsayi.mk x.2 x.1) (by
    intro a b h
    have h' : a.1 + b.2 = b.1 + a.2 := h
    apply Quotient.sound
    show a.2 + b.1 = b.2 + a.1
    omega)

def Tamsayi.sifir : Tamsayi := Tamsayi.mk 0 0

instance : Add Tamsayi := ⟨Tamsayi.topla⟩
instance : Neg Tamsayi := ⟨Tamsayi.negatif⟩

#eval (Tamsayi.mk 3 5).isaret                          -- -2
#eval (Tamsayi.mk 3 5 + Tamsayi.mk 10 1).isaret        -- 7
-- ANCHOR_END: tamsayi_islem

-- ANCHOR: tamsayi_teorem
-- Bölüm üzerinde ispat: temsilciler üzerinde ispat + Quotient.sound.
theorem Tamsayi.topla_degisme (x y : Tamsayi) : x + y = y + x :=
  Quotient.inductionOn₂ x y (fun a b => by
    show Tamsayi.mk (a.1 + b.1) (a.2 + b.2) = Tamsayi.mk (b.1 + a.1) (b.2 + a.2)
    apply Quotient.sound
    show (a.1 + b.1) + (b.2 + a.2) = (b.1 + a.1) + (a.2 + b.2)
    omega)

theorem Tamsayi.topla_ters (x : Tamsayi) : x + -x = Tamsayi.sifir :=
  Quotient.inductionOn x (fun a => by
    show Tamsayi.mk (a.1 + a.2) (a.2 + a.1) = Tamsayi.mk 0 0
    apply Quotient.sound
    show (a.1 + a.2) + 0 = 0 + (a.2 + a.1)
    omega)

#print axioms Tamsayi.topla_degisme      -- [propext, Quot.sound]
-- ANCHOR_END: tamsayi_teorem

/-! ## 16.3  Fonksiyon dışsallığı, Quot.sound'dan -/

-- ANCHOR: funext
section
variable {α : Sort u} {β : α → Sort v}

-- Noktasal eşitlik: her girdide aynı çıktı.
def NoktaEsit (f g : (x : α) → β x) : Prop := ∀ x, f x = g x

-- "Dışsal fonksiyonlar": noktasal eşitliğe göre bölüm.
-- Böyle bir fonksiyonu bir noktada değerlendirmek iyi tanımlıdır:
def uygula (q : Quot (@NoktaEsit α β)) (x : α) : β x :=
  Quot.lift (fun f => f x) (fun _ _ h => h x) q

-- funext, Quot.sound'un bir sonucudur.
theorem fonk_dissallik {f g : (x : α) → β x} (h : ∀ x, f x = g x) : f = g := by
  show uygula (Quot.mk NoktaEsit f) = uygula (Quot.mk NoktaEsit g)
  apply congrArg
  exact Quot.sound h
end

#print axioms fonk_dissallik                    -- [Quot.sound]
-- ANCHOR_END: funext

-- ANCHOR: funext_ornek
theorem sifir_topla_fonk : (fun n : Nat => 0 + n) = (fun n => n) :=
  fonk_dissallik (fun n => Nat.zero_add n)
-- ANCHOR_END: funext_ornek

/-! ## 16.4  Seçim aksiyomu -/

-- ANCHOR: secim
#check @Classical.choice   -- Classical.choice : {α : Sort u} → Nonempty α → α

-- ∃'ten tanık "seçmek" artık mümkün, ama hesaplanamaz.
noncomputable def secilen {α : Sort u} {P : α → Prop} (h : ∃ x, P x) : α :=
  Classical.choose h

theorem secilen_ozellik {α : Sort u} {P : α → Prop} (h : ∃ x, P x) :
    P (secilen h) :=
  Classical.choose_spec h

theorem ucten_buyuk_var : ∃ n : Nat, n > 3 := ⟨4, by decide⟩

noncomputable def ucten_buyuk : Nat := secilen ucten_buyuk_var
-- #eval ucten_buyuk   -- hata: noncomputable; hangi sayının seçildiğini bilemeyiz
theorem ucten_buyuk_ozellik : ucten_buyuk > 3 := secilen_ozellik ucten_buyuk_var
-- ANCHOR_END: secim

/-! ## 16.5  Diaconescu teoremi -/

-- ANCHOR: diaconescu
-- Seçim + propext + funext  ⟹  üçüncü hâl.
-- (Lean çekirdeğindeki Classical.em ispatının açıklamalı bir uyarlaması.)
theorem diaconescu (p : Prop) : p ∨ ¬p :=
  let U (x : Prop) : Prop := x = True ∨ p
  let V (x : Prop) : Prop := x = False ∨ p
  have exU : ∃ x, U x := ⟨True, Or.inl rfl⟩
  have exV : ∃ x, V x := ⟨False, Or.inl rfl⟩
  -- Seçim aksiyomu: iki yüklemden birer tanık seç.
  let u : Prop := Classical.choose exU
  let v : Prop := Classical.choose exV
  have u_def : U u := Classical.choose_spec exU
  have v_def : V v := Classical.choose_spec exV
  -- (1) Ya u ≠ v ya da p:
  have uv_ya_da_p : u ≠ v ∨ p :=
    match u_def, v_def with
    | Or.inr h, _ => Or.inr h
    | _, Or.inr h => Or.inr h
    | Or.inl hu, Or.inl hv =>
      have hne : u ≠ v := hv ▸ hu ▸ true_ne_false
      Or.inl hne
  -- (2) p doğruysa U ile V aynı yüklemdir (propext + funext), dolayısıyla u = v:
  have p_ise_uv : p → u = v :=
    fun hp =>
    have hUV : U = V :=
      funext fun x =>
        have hl : (x = True ∨ p) → (x = False ∨ p) := fun _ => Or.inr hp
        have hr : (x = False ∨ p) → (x = True ∨ p) := fun _ => Or.inr hp
        show (x = True ∨ p) = (x = False ∨ p) from propext (Iff.intro hl hr)
    have h0 : ∀ eU eV, @Classical.choose _ U eU = @Classical.choose _ V eV := by
      rw [hUV]; intros; rfl
    show u = v from h0 _ _
  -- (3) Birleştir:
  match uv_ya_da_p with
  | Or.inl hne => Or.inr (mt p_ise_uv hne)
  | Or.inr h   => Or.inl h

#print axioms diaconescu   -- [propext, Classical.choice, Quot.sound]
-- ANCHOR_END: diaconescu

end Bolum16
