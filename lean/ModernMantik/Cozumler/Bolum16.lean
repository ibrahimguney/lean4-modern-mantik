/-
  Lean 4 ile Modern Mantık
  Bölüm 16 — Alıştırma Çözümleri (eğitmenler için)
-/
import ModernMantik.Bolum16

namespace Cozum16

open Bolum16

-- 16.1
theorem a16_1 (p : Prop) : (True → p) = p := by
  exact propext ⟨fun h => h trivial, fun h _ => h⟩

-- 16.2
theorem a16_2 : (fun n : Nat => n * 1) = (fun n => n) := by
  funext n
  exact Nat.mul_one n

-- 16.3
theorem a16_3 : (fun n : Nat => n < 5 ∧ True) = (fun n => n < 5) := by
  funext n
  exact propext ⟨fun h => h.1, fun h => ⟨h, trivial⟩⟩

-- 16.4
theorem a16_4 (a b : Nat) : Tamsayi.mk (a + 1) (b + 1) = Tamsayi.mk a b := by
  apply Quotient.sound
  show (a + 1) + b = a + (b + 1)
  omega

-- 16.5
theorem a16_5 (x y z : Tamsayi) : (x + y) + z = x + (y + z) := by
  refine Quotient.inductionOn₃ x y z (fun a b c => ?_)
  show Tamsayi.mk ((a.1 + b.1) + c.1) ((a.2 + b.2) + c.2)
     = Tamsayi.mk (a.1 + (b.1 + c.1)) (a.2 + (b.2 + c.2))
  apply Quotient.sound
  show ((a.1 + b.1) + c.1) + (a.2 + (b.2 + c.2)) = (a.1 + (b.1 + c.1)) + ((a.2 + b.2) + c.2)
  omega

-- 16.6
theorem a16_6 (h : ∃ n : Nat, n * n = 49) : secilen h * secilen h = 49 := by
  exact secilen_ozellik h

-- 16.7
theorem a16_7 (p : Prop) (h : p ≠ True) : p = False := by
  cases prop_iki_deger p with
  | inl ht => exact absurd ht h
  | inr hf => exact hf

-- 16.8
theorem a16_8 (x y : Tamsayi) : x.isaret = y.isaret → x = y := by
  refine Quotient.inductionOn₂ x y (fun a b h => ?_)
  have h' : (a.1 : Int) - a.2 = (b.1 : Int) - b.2 := h
  apply Quotient.sound
  show a.1 + b.2 = b.1 + a.2
  omega

end Cozum16
