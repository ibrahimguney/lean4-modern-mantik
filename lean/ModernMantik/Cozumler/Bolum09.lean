/-
  Lean 4 ile Modern Mantık
  Bölüm 9 — Alıştırma Çözümleri (eğitmenler için)
-/
import ModernMantik.Bolum09

namespace Cozum09

open Bolum09

-- 9.1
theorem a9_1 {P Q : Prop} (h : Ve P Q) : P := by
  cases h with
  | intro hp _ => exact hp

-- 9.2
theorem a9_2 {P Q R : Prop} (h : Veya P Q) (hp : P → R) (hq : Q → R) : R := by
  cases h with
  | sol p => exact hp p
  | sag q => exact hq q

-- 9.3
theorem a9_3 {α : Type} {P Q : α → Prop} (h : ∀ x, P x → Q x) (hv : Var P) :
    Var Q := by
  cases hv with
  | intro w hw => exact Var.intro w (h w hw)

-- 9.4
theorem a9_4 {α : Type} (xs : Liste α) :
    Liste.uzunluk (Liste.ters xs) = Liste.uzunluk xs := by
  induction xs with
  | bos => rfl
  | ekle x xs ih =>
    show Liste.uzunluk (Liste.birlestir (Liste.ters xs) (Liste.ekle x Liste.bos))
       = Liste.uzunluk xs + 1
    have h1 : Liste.uzunluk (Liste.ekle x Liste.bos) = 1 := rfl
    rw [Liste.uzunluk_birlestir, ih, h1]

-- 9.5
def yaprakSay {α : Type} : Agac α → Nat
  | .yaprak      => 1
  | .dugum l _ r => yaprakSay l + yaprakSay r

theorem a9_5 {α : Type} (t : Agac α) : yaprakSay t = Agac.boyut t + 1 := by
  induction t with
  | yaprak => rfl
  | dugum l x r ihl ihr =>
    show yaprakSay l + yaprakSay r = (Agac.boyut l + 1 + Agac.boyut r) + 1
    omega

-- 9.6
theorem a9_6 : ¬ Cift 3 := by
  intro h
  cases h with
  | iki_ekle _ h1 => cases h1     -- Cift 1'e indirgendi; o da imkânsız

-- 9.7
theorem a9_7 (n : Nat) (h : Cift (n + 2)) : Cift n := by
  cases h with
  | iki_ekle _ h' => exact h'

-- 9.8
theorem a9_8 (m n : Nat) (hm : Cift m) (hn : Cift n) : Cift (m + n) := by
  induction hm with
  | sifir =>
    rw [Nat.zero_add]
    exact hn
  | iki_ekle k _ ih =>
    have h : k + 2 + n = (k + n) + 2 := by omega
    rw [h]
    exact Cift.iki_ekle (k + n) ih

-- 9.9
theorem a9_9 {α : Type} {R : α → α → Prop} {a b : α} (h : R a b) : Kapanis R a b :=
  Kapanis.adim h (Kapanis.refl b)

end Cozum09
