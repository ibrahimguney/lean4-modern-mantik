/-
  Lean 4 ile Modern Mantık
  Bölüm 15 — Bağımlı Tipler ve Lean'in Çekirdeği

  Bu bölüm yalnızca Lean çekirdeğini kullanır.

  `-- ANCHOR: ad` / `-- ANCHOR_END: ad` satırları kitabın kaynağı
  tarafından okunur. Lütfen silmeyin.
-/

namespace Bolum15

/-! ## 15.1  Π-tipleri: bağımlı fonksiyonlar -/

-- ANCHOR: pi
-- Bir tip ailesi: Bool'dan tiplere bir fonksiyon.
def SayiYaDaMetin : Bool → Type
  | true  => Nat
  | false => String

-- Bağımlı fonksiyon: dönüş tipi argümana bağlı.
def ornekDeger : (b : Bool) → SayiYaDaMetin b
  | true  => (42 : Nat)
  | false => "kırk iki"

example : ornekDeger true = (42 : Nat) := rfl
example : ornekDeger false = "kırk iki" := rfl

-- ∀ de bir Π-tipidir: iki yazım aynı terimdir.
example : (∀ n : Nat, n + 0 = n) = ((n : Nat) → n + 0 = n) := rfl
-- ANCHOR_END: pi

/-! ## 15.2  Uzunluk indisli vektörler -/

universe u v

-- ANCHOR: vek
inductive Vek (α : Type u) : Nat → Type u where
  | bos  : Vek α 0
  | ekle {n : Nat} : α → Vek α n → Vek α (n + 1)

namespace Vek

variable {α : Type u} {β : Type v}

-- Boş olmayan bir vektörün başı: Option'a gerek yok!
def bas {n : Nat} : Vek α (n + 1) → α
  | ekle a _ => a

def kuyruk {n : Nat} : Vek α (n + 1) → Vek α n
  | ekle _ v => v

def esle (f : α → β) {n : Nat} : Vek α n → Vek β n
  | bos      => bos
  | ekle a v => ekle (f a) (esle f v)

-- Yalnızca aynı uzunluktaki vektörler fermuarlanabilir.
def fermuar {n : Nat} : Vek α n → Vek β n → Vek (α × β) n
  | bos,      bos      => bos
  | ekle a v, ekle b w => ekle (a, b) (fermuar v w)

def birlestir {m n : Nat} : Vek α m → Vek α n → Vek α (n + m)
  | bos,      w => w
  | ekle a v, w => ekle a (birlestir v w)

def toList {n : Nat} : Vek α n → List α
  | bos      => []
  | ekle a v => a :: toList v
-- ANCHOR_END: vek

-- ANCHOR: vek_ornek
def ornekV : Vek Nat 3 := ekle 1 (ekle 2 (ekle 3 bos))

#eval ornekV.bas                                  -- 1
#eval (ornekV.esle (· * 10)).toList               -- [10, 20, 30]
#eval (fermuar ornekV (ornekV.esle toString)).toList
-- [(1, "1"), (2, "2"), (3, "3")]
-- #eval (bos : Vek Nat 0).bas    -- tip hatası: 0, n + 1 biçiminde değil
-- ANCHOR_END: vek_ornek

/-! ## 15.3  Fin ile güvenli indisleme -/

-- ANCHOR: al
-- Fin n = {i : Nat // i < n}: n'den küçük sayılar.
def al : {n : Nat} → Vek α n → Fin n → α
  | _, bos,      i          => Fin.elim0 i
  | _, ekle a _, ⟨0, _⟩     => a
  | _, ekle _ v, ⟨i + 1, h⟩ => al v ⟨i, Nat.lt_of_succ_lt_succ h⟩

#eval ornekV.al 2                                 -- 3
-- #eval ornekV.al 5   -- hata: 5 < 3 kanıtlanamaz

theorem al_esle (f : α → β) :
    ∀ {n : Nat} (v : Vek α n) (i : Fin n), (v.esle f).al i = f (v.al i)
  | _, bos,      i          => Fin.elim0 i
  | _, ekle _ _, ⟨0, _⟩     => rfl
  | _, ekle _ v, ⟨i + 1, h⟩ => al_esle f v ⟨i, Nat.lt_of_succ_lt_succ h⟩
-- ANCHOR_END: al

/-! ## 15.4  Bağımlı tipler üzerinde ispat -/

-- ANCHOR: ters
def sonaEkle {n : Nat} : Vek α n → α → Vek α (n + 1)
  | bos,      a => ekle a bos
  | ekle b v, a => ekle b (sonaEkle v a)

def ters {n : Nat} : Vek α n → Vek α n
  | bos      => bos
  | ekle a v => sonaEkle (ters v) a

theorem toList_length {n : Nat} (v : Vek α n) : v.toList.length = n := by
  induction v with
  | bos => rfl
  | ekle a v ih => simp [toList, ih]

theorem ters_sonaEkle {n : Nat} (v : Vek α n) (a : α) :
    (v.sonaEkle a).ters = ekle a v.ters := by
  induction v with
  | bos => rfl
  | ekle b v ih =>
    show (v.sonaEkle a).ters.sonaEkle b = ekle a (v.ters.sonaEkle b)
    exact (congrArg (fun w => sonaEkle w b) ih).trans rfl

theorem ters_ters {n : Nat} (v : Vek α n) : v.ters.ters = v := by
  induction v with
  | bos => rfl
  | ekle a v ih =>
    show (v.ters.sonaEkle a).ters = ekle a v
    rw [ters_sonaEkle, ih]
-- ANCHOR_END: ters

-- ANCHOR: donustur
-- Eşitlik boyunca taşıma:  n = m  ise  Vek α n  ile  Vek α m  aynı tiptir.
def donustur {n m : Nat} (h : n = m) (v : Vek α n) : Vek α m := h ▸ v
-- ANCHOR_END: donustur

end Vek

/-! ## 15.5  Σ-tipleri: bağımlı çiftler -/

open Vek

-- ANCHOR: sigma
-- Uzunluğu ne olursa olsun bir vektör: (n : Nat) × Vek Nat n
def herhangiV : (n : Nat) × Vek Nat n := ⟨2, ekle 7 (ekle 8 bos)⟩

#eval herhangiV.1                         -- 2
#eval herhangiV.2.toList                  -- [7, 8]

-- Alt tip: özelliği sağlayan değerler. {x : α // P x}
def ciftSayi : {n : Nat // n % 2 = 0} := ⟨10, rfl⟩

#eval ciftSayi.val                        -- 10

-- Varlık niceleyicisi: tanık bir Prop içinde "kilitli"dir.
theorem ucten_buyuk : ∃ n : Nat, n > 3 := ⟨4, by decide⟩
-- ANCHOR_END: sigma

/-! ## 15.6  Evrenler -/

-- ANCHOR: evrenler
#check Nat                          -- Nat : Type
#check Type                         -- Type : Type 1
#check Type 1                       -- Type 1 : Type 2
#check Prop                         -- Prop : Type
#check Sort 0                       -- Prop : Type
#check @List.map                    -- {α : Type u_1} → {β : Type u_2} → …

-- Predikatif: Type'lar üzerinde niceleme bir üst evrene çıkar.
#check ((α : Type) → α → α)         -- (α : Type) → α → α : Type 1
-- İmpredikatif: Prop'lar üzerinde niceleme Prop'ta kalır.
#check (∀ p : Prop, p → p)          -- ∀ (p : Prop), p → p : Prop

def PolimorfikOzdeslik : Prop := ∀ p : Prop, p → p
theorem polimorfik_ozdeslik : PolimorfikOzdeslik := fun _ h => h
-- ANCHOR_END: evrenler

/-! ## 15.7  Kanıt-ilgisizliği ve tanımsal eşitlik -/

-- ANCHOR: kanit_ilgisiz
-- Aynı önermenin iki kanıtı tanımsal olarak eşittir.
theorem kanit_ilgisiz (p : Prop) (h1 h2 : p) : h1 = h2 := rfl

-- Bu yüzden alt tip elemanları yalnızca değerleriyle belirlenir.
example (h1 h2 : 5 > 0) : (⟨5, h1⟩ : {n : Nat // n > 0}) = ⟨5, h2⟩ := rfl
-- ANCHOR_END: kanit_ilgisiz

-- ANCHOR: tanimsal
-- Tanımsal eşitlik: iki taraf hesaplanınca aynı terim olur.
example : 2 + 2 = 4 := rfl
example (n : Nat) : n + 0 = n := rfl          -- Nat.add ikinci argümanda özyinelemeli
-- example (n : Nat) : 0 + n = n := rfl       -- HATA: tanımsal değil
example (n : Nat) : 0 + n = n := Nat.zero_add n  -- önermesel: tümevarımla ispatlı
-- ANCHOR_END: tanimsal

/-! ## 15.8  Çekirdek ve aksiyomlar -/

-- ANCHOR: aksiyomlar
theorem em_ornek (p : Prop) : p ∨ ¬p := Classical.em p

#print axioms em_ornek
-- 'Bolum15.em_ornek' depends on axioms: [propext, Classical.choice, Quot.sound]
#print axioms Vek.ters_ters
-- 'Bolum15.Vek.ters_ters' does not depend on any axioms
-- ANCHOR_END: aksiyomlar

-- ANCHOR: ozyineleyici
#check @Vek.rec
-- @Vek.rec : {α : Type u} → {motive : (a : Nat) → Vek α a → Sort u_1} →
--   motive 0 Vek.bos →
--   ({n : Nat} → (a : α) → (a_1 : Vek α n) → motive n a_1 →
--      motive (n + 1) (Vek.ekle a a_1)) →
--   {a : Nat} → (t : Vek α a) → motive a t
#check @Exists.intro
-- @Exists.intro : ∀ {α : Sort u} {p : α → Prop} (w : α), p w → Exists p
-- ANCHOR_END: ozyineleyici

-- ANCHOR: elaborasyon
-- Yazdığımız ifade ile çekirdeğin gördüğü terim:
set_option pp.all true in
#check fun (x : Nat) => x + 1
-- fun (x : Nat) => @HAdd.hAdd.{0, 0, 0} Nat Nat Nat
--   (@instHAdd.{0} Nat instAddNat) x (@OfNat.ofNat.{0} Nat 1 (instOfNatNat 1))
-- ANCHOR_END: elaborasyon

end Bolum15
