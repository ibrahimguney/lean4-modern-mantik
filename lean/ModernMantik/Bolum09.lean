/-
  Lean 4 ile Modern Mantık
  Bölüm 9 — Tümevarımsal Tipler

  Bu bölüm yalnızca Lean çekirdeğini kullanır.

  `-- ANCHOR: ad` / `-- ANCHOR_END: ad` satırları kitabın kaynağı
  tarafından okunur. Lütfen silmeyin.
-/

namespace Bolum09

/-! ## 9.1  inductive'in anatomisi -/

-- ANCHOR: renk
inductive Renk where
  | kirmizi
  | yesil
  | mavi
  deriving Repr, DecidableEq

def Renk.sonraki : Renk → Renk
  | .kirmizi => .yesil
  | .yesil   => .mavi
  | .mavi    => .kirmizi

#eval Renk.sonraki .mavi        -- Bolum09.Renk.kirmizi

theorem uc_kez_sonraki (r : Renk) : r.sonraki.sonraki.sonraki = r := by
  cases r <;> rfl                -- üç durumun her biri hesaplanarak doğrulanır
-- ANCHOR_END: renk

-- ANCHOR: belki
inductive Belki (α : Type) where
  | hic    : Belki α             -- değer yok
  | sadece : α → Belki α         -- bir değer var
  deriving Repr

def guvenliBol (a b : Nat) : Belki Nat :=
  if b = 0 then .hic else .sadece (a / b)

#eval guvenliBol 10 2           -- Bolum09.Belki.sadece 5
#eval guvenliBol 10 0           -- Bolum09.Belki.hic
-- ANCHOR_END: belki

/-! ## 9.2  Mantık bağlaçları tümevarımsal tiplerdir -/

-- ANCHOR: baglaclar
inductive Ve (P Q : Prop) : Prop where
  | intro : P → Q → Ve P Q                  -- tek kurucu, iki alan

inductive Veya (P Q : Prop) : Prop where
  | sol : P → Veya P Q                      -- iki kurucu
  | sag : Q → Veya P Q

inductive Dogru : Prop where
  | tanik : Dogru                           -- tek kurucu, alan yok

inductive Yanlis : Prop                     -- hiç kurucu yok!

inductive Var {α : Type} (P : α → Prop) : Prop where
  | intro (w : α) (h : P w) : Var P         -- tanık ve kanıt
-- ANCHOR_END: baglaclar

-- ANCHOR: baglac_ispat
theorem Ve.degisme {P Q : Prop} (h : Ve P Q) : Ve Q P := by
  cases h with
  | intro hp hq => exact Ve.intro hq hp

theorem Veya.degisme {P Q : Prop} (h : Veya P Q) : Veya Q P := by
  cases h with
  | sol hp => exact Veya.sag hp
  | sag hq => exact Veya.sol hq

theorem Yanlis.elim' {P : Prop} (h : Yanlis) : P := by
  cases h                                   -- sıfır durum: bitti

theorem Var.ornek : Var (fun n : Nat => n > 3) :=
  Var.intro 4 (by decide)
-- ANCHOR_END: baglac_ispat

-- ANCHOR: print_or
#print Or
-- inductive Or : Prop → Prop → Prop
-- number of parameters: 2
-- constructors:
-- Or.inl : ∀ {a b : Prop}, a → a ∨ b
-- Or.inr : ∀ {a b : Prop}, b → a ∨ b
-- ANCHOR_END: print_or

-- ANCHOR: esit
-- Eşitlik de tümevarımsal bir tiptir: tek kurucusu yansımadır.
inductive Esit {α : Type} (a : α) : α → Prop where
  | refl : Esit a a

theorem Esit.simetri {α : Type} {a b : α} (h : Esit a b) : Esit b a := by
  cases h                     -- b'nin a olduğunu öğreniriz
  exact Esit.refl

theorem Esit.gecisme {α : Type} {a b c : α} (h1 : Esit a b) (h2 : Esit b c) :
    Esit a c := by
  cases h1
  exact h2
-- ANCHOR_END: esit

/-! ## 9.3  Listeler -/

-- ANCHOR: liste_tanim
inductive Liste (α : Type) where
  | bos  : Liste α                       -- boş liste
  | ekle : α → Liste α → Liste α         -- başa bir eleman ekle
  deriving Repr
-- ANCHOR_END: liste_tanim

namespace Liste

variable {α : Type}

-- ANCHOR: liste_fonk
def uzunluk : Liste α → Nat
  | bos       => 0
  | ekle _ xs => uzunluk xs + 1

def birlestir : Liste α → Liste α → Liste α
  | bos,       ys => ys
  | ekle x xs, ys => ekle x (birlestir xs ys)

def ters : Liste α → Liste α
  | bos       => bos
  | ekle x xs => birlestir (ters xs) (ekle x bos)

#eval ters (ekle 1 (ekle 2 (ekle 3 bos)))
-- Bolum09.Liste.ekle 3 (Bolum09.Liste.ekle 2 (Bolum09.Liste.ekle 1 (Bolum09.Liste.bos)))
-- ANCHOR_END: liste_fonk

-- ANCHOR: birlestir_bos
theorem birlestir_bos (xs : Liste α) : birlestir xs bos = xs := by
  induction xs with
  | bos => rfl
  | ekle x xs ih =>
    show ekle x (birlestir xs bos) = ekle x xs
    rw [ih]
-- ANCHOR_END: birlestir_bos

-- ANCHOR: uzunluk_birlestir
theorem uzunluk_birlestir (xs ys : Liste α) :
    uzunluk (birlestir xs ys) = uzunluk xs + uzunluk ys := by
  induction xs with
  | bos =>
    show uzunluk ys = 0 + uzunluk ys
    omega
  | ekle x xs ih =>
    show uzunluk (birlestir xs ys) + 1 = (uzunluk xs + 1) + uzunluk ys
    omega
-- ANCHOR_END: uzunluk_birlestir

-- ANCHOR: birlestir_birlesme
theorem birlestir_birlesme (xs ys zs : Liste α) :
    birlestir (birlestir xs ys) zs = birlestir xs (birlestir ys zs) := by
  induction xs with
  | bos => rfl
  | ekle x xs ih =>
    show ekle x (birlestir (birlestir xs ys) zs) = ekle x (birlestir xs (birlestir ys zs))
    rw [ih]
-- ANCHOR_END: birlestir_birlesme

-- ANCHOR: ters_birlestir
theorem ters_birlestir (xs ys : Liste α) :
    ters (birlestir xs ys) = birlestir (ters ys) (ters xs) := by
  induction xs with
  | bos =>
    show ters ys = birlestir (ters ys) bos
    rw [birlestir_bos]
  | ekle x xs ih =>
    show birlestir (ters (birlestir xs ys)) (ekle x bos)
       = birlestir (ters ys) (birlestir (ters xs) (ekle x bos))
    rw [ih, birlestir_birlesme]
-- ANCHOR_END: ters_birlestir

-- ANCHOR: ters_ters
theorem ters_ters (xs : Liste α) : ters (ters xs) = xs := by
  induction xs with
  | bos => rfl
  | ekle x xs ih =>
    calc ters (ters (ekle x xs))
        = ters (birlestir (ters xs) (ekle x bos))       := rfl
      _ = birlestir (ters (ekle x bos)) (ters (ters xs)) := ters_birlestir _ _
      _ = birlestir (ters (ekle x bos)) xs              := by rw [ih]
      _ = ekle x xs                                     := rfl
-- ANCHOR_END: ters_ters

end Liste

/-! ## 9.4  İkili ağaçlar -/

-- ANCHOR: agac
inductive Agac (α : Type) where
  | yaprak : Agac α
  | dugum  : Agac α → α → Agac α → Agac α   -- sol alt ağaç, değer, sağ alt ağaç
-- ANCHOR_END: agac

namespace Agac

variable {α : Type}

-- ANCHOR: agac_fonk
def boyut : Agac α → Nat
  | yaprak       => 0
  | dugum l _ r  => boyut l + 1 + boyut r

def ayna : Agac α → Agac α
  | yaprak       => yaprak
  | dugum l x r  => dugum (ayna r) x (ayna l)
-- ANCHOR_END: agac_fonk

-- ANCHOR: ayna_ayna
theorem ayna_ayna (t : Agac α) : ayna (ayna t) = t := by
  induction t with
  | yaprak => rfl
  | dugum l x r ihl ihr =>               -- İKİ tümevarım hipotezi
    show dugum (ayna (ayna l)) x (ayna (ayna r)) = dugum l x r
    rw [ihl, ihr]
-- ANCHOR_END: ayna_ayna

-- ANCHOR: boyut_ayna
theorem boyut_ayna (t : Agac α) : boyut (ayna t) = boyut t := by
  induction t with
  | yaprak => rfl
  | dugum l x r ihl ihr =>
    show boyut (ayna r) + 1 + boyut (ayna l) = boyut l + 1 + boyut r
    rw [ihl, ihr]
    omega
-- ANCHOR_END: boyut_ayna

end Agac

/-! ## 9.5  Tümevarımsal yüklemler -/

-- ANCHOR: cift_tanim
inductive Cift : Nat → Prop where
  | sifir : Cift 0                                -- 0 çifttir
  | iki_ekle (n : Nat) : Cift n → Cift (n + 2)    -- n çiftse n + 2 de çifttir
-- ANCHOR_END: cift_tanim

-- ANCHOR: cift_ornek
theorem dort_cift : Cift 4 :=
  Cift.iki_ekle 2 (Cift.iki_ekle 0 Cift.sifir)

theorem bir_cift_degil : ¬ Cift 1 := by
  intro h
  cases h                       -- 1 ne 0'dır ne de n + 2: hiçbir kural uymaz
-- ANCHOR_END: cift_ornek

-- ANCHOR: cift_iki_kat
theorem cift_iki_kat (n : Nat) : Cift (2 * n) := by
  induction n with
  | zero => exact Cift.sifir
  | succ m ih =>
    have h : 2 * (m + 1) = 2 * m + 2 := by omega
    rw [h]
    exact Cift.iki_ekle (2 * m) ih
-- ANCHOR_END: cift_iki_kat

-- ANCHOR: kural_tumevarimi
-- Kural tümevarımı: Cift n'nin kanıtı üzerinde tümevarım.
theorem cift_ise_iki_kat (n : Nat) (h : Cift n) : ∃ k, n = 2 * k := by
  induction h with
  | sifir => exact ⟨0, rfl⟩
  | iki_ekle m _ ih =>
    obtain ⟨k, hk⟩ := ih            -- m = 2 * k
    exact ⟨k + 1, by omega⟩         -- m + 2 = 2 * (k + 1)
-- ANCHOR_END: kural_tumevarimi

-- ANCHOR: kapanis
-- Bir ilişkinin yansımalı-geçişli kapanışı: "sıfır ya da daha fazla R adımı".
inductive Kapanis {α : Type} (R : α → α → Prop) : α → α → Prop where
  | refl (a : α) : Kapanis R a a
  | adim {a b c : α} : R a b → Kapanis R b c → Kapanis R a c

theorem Kapanis.gecisme {α : Type} {R : α → α → Prop} {a b c : α}
    (h1 : Kapanis R a b) : Kapanis R b c → Kapanis R a c := by
  induction h1 with
  | refl _ =>
    intro h2
    exact h2
  | adim hab _ ih =>
    intro h2
    exact Kapanis.adim hab (ih h2)
-- ANCHOR_END: kapanis

end Bolum09
