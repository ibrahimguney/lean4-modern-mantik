/-
  Lean 4 ile Modern Mantık
  Bölüm 9 — Alıştırmalar

  Her `sorry`'yi kendi ispatınızla değiştirin.
  Zorluk:  ★ temel   ★★ orta   ★★★ ileri
  Çözümler: ModernMantik/Cozumler/Bolum09.lean
-/
import ModernMantik.Bolum09

namespace Alistirma09

open Bolum09

-- 9.1 ★  Kendi Ve'mizin sol elemesi
theorem a9_1 {P Q : Prop} (h : Ve P Q) : P := by
  sorry

-- 9.2 ★  Kendi Veya'mız için durum ayırma
theorem a9_2 {P Q R : Prop} (h : Veya P Q) (hp : P → R) (hq : Q → R) : R := by
  sorry

-- 9.3 ★★  Kendi Var'ımız: tanığı koruyarak dönüştürme
theorem a9_3 {α : Type} {P Q : α → Prop} (h : ∀ x, P x → Q x) (hv : Var P) :
    Var Q := by
  sorry

-- 9.4 ★★  Ters çevirme uzunluğu korur
theorem a9_4 {α : Type} (xs : Liste α) : Liste.uzunluk (Liste.ters xs) = Liste.uzunluk xs := by
  sorry

-- 9.5 ★★  Bir ağaçtaki yaprak sayısı, düğüm sayısından bir fazladır
def yaprakSay {α : Type} : Agac α → Nat
  | .yaprak      => 1
  | .dugum l _ r => yaprakSay l + yaprakSay r

theorem a9_5 {α : Type} (t : Agac α) : yaprakSay t = Agac.boyut t + 1 := by
  sorry

-- 9.6 ★★
theorem a9_6 : ¬ Cift 3 := by
  sorry

-- 9.7 ★★  Ters çevirme (inversiyon)
theorem a9_7 (n : Nat) (h : Cift (n + 2)) : Cift n := by
  sorry

-- 9.8 ★★★  İki çift sayının toplamı çifttir
theorem a9_8 (m n : Nat) (hm : Cift m) (hn : Cift n) : Cift (m + n) := by
  sorry

-- 9.9 ★  Tek adım, kapanışın içindedir
theorem a9_9 {α : Type} {R : α → α → Prop} {a b : α} (h : R a b) : Kapanis R a b := by
  sorry

end Alistirma09
