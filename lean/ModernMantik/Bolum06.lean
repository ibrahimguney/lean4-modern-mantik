/-
  Lean 4 ile Modern Mantık
  Bölüm 6 — Yüklemler Mantığı: ∀, ∃ ve Eşitlik

  `-- ANCHOR: ad` / `-- ANCHOR_END: ad` satırları kitabın kaynağı
  tarafından okunur. Lütfen silmeyin.
-/

namespace Bolum06

/-! ## 6.1  Yüklemler -/

-- ANCHOR: sokrates
-- Bölüm 1'deki kıyas, sonunda Lean'de:
theorem sokrates_olumlu
    (Varlik : Type)                       -- tanım evreni
    (Insan Olumlu : Varlik → Prop)        -- iki yüklem
    (sokrates : Varlik)                   -- bir birey
    (h1 : ∀ x, Insan x → Olumlu x)        -- Bütün insanlar ölümlüdür.
    (h2 : Insan sokrates) :               -- Sokrates bir insandır.
    Olumlu sokrates :=                    -- O hâlde Sokrates ölümlüdür.
  h1 sokrates h2
-- ANCHOR_END: sokrates

-- ANCHOR: yuklem_tip
#check fun n : Nat => n % 2 = 0   -- Nat → Prop   ("çifttir" yüklemi)
#check fun n : Nat => n > 3       -- Nat → Prop
#check ∀ n : Nat, n + 0 = n       -- Prop
-- ANCHOR_END: yuklem_tip

/-! ## 6.2  Evrensel niceleyici -/

-- ANCHOR: forall_giris
theorem herkes_kendine_esit (α : Type) : ∀ x : α, x = x := by
  intro x          -- "keyfi bir x alalım"
  rfl
-- ANCHOR_END: forall_giris

-- ANCHOR: forall_eleme
theorem forall_ornek (α : Type) (P : α → Prop) (h : ∀ x, P x) (a : α) : P a :=
  h a              -- ∀'yı uygulamak: fonksiyonu a'ya çağırmak
-- ANCHOR_END: forall_eleme

-- ANCHOR: forall_ve
theorem forall_ve (α : Type) (P Q : α → Prop) :
    (∀ x, P x ∧ Q x) → (∀ x, P x) := by
  intro h x
  exact (h x).left
-- ANCHOR_END: forall_ve

-- ANCHOR: specialize
theorem specialize_ornek (α : Type) (P Q : α → Prop) (a : α)
    (h : ∀ x, P x → Q x) (hp : P a) : Q a := by
  specialize h a   -- h : P a → Q a
  exact h hp
-- ANCHOR_END: specialize

/-! ## 6.3  Varoluşsal niceleyici -/

-- ANCHOR: exists_giris
theorem uctten_buyuk_var : ∃ n : Nat, n > 3 :=
  ⟨4, by decide⟩   -- tanık: 4,  kanıt: 4 > 3

theorem uctten_buyuk_var' : ∃ n : Nat, n > 3 := by
  refine ⟨4, ?_⟩   -- önce tanığı ver...  ⊢ 4 > 3
  decide           -- ...sonra kanıtı
-- ANCHOR_END: exists_giris

-- ANCHOR: exists_eleme
theorem exists_ornek (α : Type) (P Q : α → Prop)
    (h1 : ∀ x, P x → Q x) (h2 : ∃ x, P x) : ∃ x, Q x := by
  obtain ⟨a, ha⟩ := h2     -- "öyle bir a olsun ki P a"
  exact ⟨a, h1 a ha⟩       -- aynı a, Q için de tanıktır
-- ANCHOR_END: exists_eleme

-- ANCHOR: exists_eleme_terim
theorem exists_ornek' (α : Type) (P Q : α → Prop)
    (h1 : ∀ x, P x → Q x) (h2 : ∃ x, P x) : ∃ x, Q x :=
  let ⟨a, ha⟩ := h2
  ⟨a, h1 a ha⟩
-- ANCHOR_END: exists_eleme_terim

/-! ## 6.4  Niceleyicilerin etkileşimi -/

-- ANCHOR: degil_exists
-- Yapıcı: "P'yi sağlayan yok" ↔ "herkes P'yi sağlamaz"
theorem degil_exists (α : Type) (P : α → Prop) :
    (¬ ∃ x, P x) ↔ ∀ x, ¬ P x := by
  constructor
  · intro h x hpx
    exact h ⟨x, hpx⟩
  · rintro h ⟨x, hpx⟩
    exact h x hpx
-- ANCHOR_END: degil_exists

-- ANCHOR: degil_forall_kolay
-- Yapıcı yön:
theorem exists_degil (α : Type) (P : α → Prop) :
    (∃ x, ¬ P x) → ¬ ∀ x, P x := by
  rintro ⟨x, hnx⟩ hall
  exact hnx (hall x)
-- ANCHOR_END: degil_forall_kolay

-- ANCHOR: degil_forall_klasik
-- Ters yön klasiktir: "herkes P değil" bilgisinden bir tanık çıkarmak.
theorem degil_forall (α : Type) (P : α → Prop) :
    (¬ ∀ x, P x) → ∃ x, ¬ P x := by
  intro h
  apply Classical.byContradiction
  intro hyok                   -- hyok : ¬ ∃ x, ¬ P x
  apply h
  intro x
  apply Classical.byContradiction
  intro hpx                    -- hpx : ¬ P x
  exact hyok ⟨x, hpx⟩
-- ANCHOR_END: degil_forall_klasik

-- ANCHOR: sira
-- "Herkesi seven biri varsa, herkesi seven biri vardır."
theorem exists_forall_sira (α β : Type) (R : α → β → Prop) :
    (∃ x, ∀ y, R x y) → (∀ y, ∃ x, R x y) := by
  rintro ⟨x, hx⟩ y
  exact ⟨x, hx y⟩
-- ANCHOR_END: sira

-- ANCHOR: sira_karsi
-- Ters yön yanlıştır. Doğal sayılarda R x y := x > y :
theorem her_sayidan_buyuk_var : ∀ y : Nat, ∃ x, x > y :=
  fun y => ⟨y + 1, by omega⟩

theorem en_buyuk_yok : ¬ ∃ x : Nat, ∀ y, x > y := by
  rintro ⟨x, hx⟩
  exact Nat.lt_irrefl x (hx x)     -- x > x olamaz
-- ANCHOR_END: sira_karsi

/-! ## 6.6  Eşitlik -/

-- ANCHOR: esitlik_temel
theorem esit_simetri (α : Type) (a b : α) (h : a = b) : b = a :=
  h.symm

theorem esit_gecisli (α : Type) (a b c : α) (h1 : a = b) (h2 : b = c) : a = c :=
  h1.trans h2
-- ANCHOR_END: esitlik_temel

-- ANCHOR: esitlik_rw
theorem esit_rw (a b c : Nat) (h1 : a = b) (h2 : b = c) : a + 1 = c + 1 := by
  rw [h1]          -- ⊢ b + 1 = c + 1
  rw [h2]          -- ⊢ c + 1 = c + 1   (rfl ile kendiliğinden kapanır)
-- ANCHOR_END: esitlik_rw

-- ANCHOR: esitlik_subst
-- Yerine koyma: a = b ve P a ise P b.
theorem yerine_koy (α : Type) (P : α → Prop) (a b : α)
    (h : a = b) (hp : P a) : P b :=
  h ▸ hp
-- ANCHOR_END: esitlik_subst

-- ANCHOR: esitlik_congr
theorem esit_fonksiyon (α β : Type) (f : α → β) (a b : α) (h : a = b) :
    f a = f b :=
  congrArg f h
-- ANCHOR_END: esitlik_congr

-- ANCHOR: calc_ornek
theorem zincir (a b c d : Nat) (h1 : a = b) (h2 : b = c) (h3 : c = d) : a = d :=
  calc a = b := h1
    _ = c := h2
    _ = d := h3
-- ANCHOR_END: calc_ornek

-- ANCHOR: leibniz
-- Leibniz: a'nın her özelliği b'nin de özelliğiyse, a = b.
theorem leibniz (α : Type) (a b : α) (h : ∀ P : α → Prop, P a → P b) : a = b :=
  h (fun x => a = x) rfl
-- ANCHOR_END: leibniz

/-! ## 6.7  Berber paradoksu -/

-- ANCHOR: berber
-- "Kendini tıraş etmeyen herkesi, ve yalnızca onları tıraş eden bir berber yoktur."
theorem berber_yok (Kisi : Type) (TirasEder : Kisi → Kisi → Prop) :
    ¬ ∃ b : Kisi, ∀ x : Kisi, TirasEder b x ↔ ¬ TirasEder x x := by
  rintro ⟨b, hb⟩
  have h := hb b                           -- berber kendini tıraş eder mi?
  have hn : ¬ TirasEder b b :=
    fun hbb => h.mp hbb hbb                -- ederse, etmez
  exact hn (h.mpr hn)                      -- etmezse, eder
-- ANCHOR_END: berber

/-! ## 6.8  Boş evren -/

-- ANCHOR: bos_evren
-- Evren boş değilse, ∀'dan ∃ çıkar.
theorem forall_exists (α : Type) [Inhabited α] (P : α → Prop)
    (h : ∀ x, P x) : ∃ x, P x :=
  ⟨default, h default⟩

-- Boş evrende ∀ her zaman doğrudur, ∃ her zaman yanlıştır:
theorem bos_forall (P : Empty → Prop) : ∀ x, P x :=
  fun x => x.elim

theorem bos_exists (P : Empty → Prop) : ¬ ∃ x, P x :=
  fun ⟨x, _⟩ => x.elim
-- ANCHOR_END: bos_evren

end Bolum06
