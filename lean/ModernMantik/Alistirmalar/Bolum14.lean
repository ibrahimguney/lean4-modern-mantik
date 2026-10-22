/-
  Lean 4 ile Modern Mantık
  Bölüm 14 — Alıştırmalar

  Her `sorry`'yi kendi ispatınızla değiştirin.
  Zorluk:  ★ temel   ★★ orta   ★★★ ileri
  Çözümler: ModernMantik/Cozumler/Bolum14.lean
-/
import ModernMantik.Bolum14

namespace Alistirma14

open Bolum14 Bolum14.Terim Bolum14.Tip

-- 14.1 ★  K normal biçimdedir
theorem a14_1 : Normal (lam (lam (var 1))) := by
  sorry

-- 14.2 ★  İki adımlık indirgeme
theorem a14_2 (s : Terim) : Adimlar (app I (app I s)) s := by
  sorry

-- 14.3 ★★  Bileşke kombinatörü  B = λf. λg. λx. f (g x)
def bilesim : Terim := lam (lam (lam (app (var 2) (app (var 1) (var 0)))))

theorem a14_3 (A B C : Tip) :
    Tiplenir [] bilesim ((B ⇒ C) ⇒ (A ⇒ B) ⇒ A ⇒ C) := by
  sorry

-- 14.4 ★★  Her Church sayısının tipi (A ⇒ A) ⇒ A ⇒ A'dır
theorem tekrarla_tip (A : Tip) (n : Nat) : Tiplenir [A, A ⇒ A] (tekrarla n) A := by
  sorry

theorem a14_4 (A : Tip) (n : Nat) : Tiplenir [] (church n) ((A ⇒ A) ⇒ A ⇒ A) := by
  sorry

-- 14.5 ★★  Taban tipte kapalı terim yoktur
theorem a14_5 : ¬ ∃ t, Tiplenir [] t (taban 0) := by
  sorry

-- 14.6 ★★  Curry tarzında tip tek değildir
theorem a14_6 : ∃ A B : Tip, A ≠ B ∧ Tiplenir [] I A ∧ Tiplenir [] I B := by
  sorry

-- 14.7 ★★  Peirce'ın öncülü boştur
theorem a14_7 : ¬ ∃ t, Tiplenir [] t ((taban 0 ⇒ taban 1) ⇒ taban 0) := by
  sorry

-- 14.8 ★★★  Ω tiplenemez
theorem a14_8 {Γ : List Tip} {A : Tip} : ¬ Tiplenir Γ Omega A := by
  sorry

end Alistirma14
