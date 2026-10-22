/-
  Lean 4 ile Modern Mantık
  Bölüm 16 — Alıştırmalar

  Her `sorry`'yi kendi ispatınızla değiştirin.
  Zorluk:  ★ temel   ★★ orta   ★★★ ileri
  Çözümler: ModernMantik/Cozumler/Bolum16.lean
-/
import ModernMantik.Bolum16

namespace Alistirma16

open Bolum16

-- 16.1 ★  propext ile önerme eşitliği
theorem a16_1 (p : Prop) : (True → p) = p := by
  sorry

-- 16.2 ★  Fonksiyon dışsallığı
theorem a16_2 : (fun n : Nat => n * 1) = (fun n => n) := by
  sorry

-- 16.3 ★★  Yüklem eşitliği: propext + funext
theorem a16_3 : (fun n : Nat => n < 5 ∧ True) = (fun n => n < 5) := by
  sorry

-- 16.4 ★★  Aynı tamsayının iki temsilcisi
theorem a16_4 (a b : Nat) : Tamsayi.mk (a + 1) (b + 1) = Tamsayi.mk a b := by
  sorry

-- 16.5 ★★  Tamsayılarda toplama birleşmelidir
theorem a16_5 (x y z : Tamsayi) : (x + y) + z = x + (y + z) := by
  sorry

-- 16.6 ★★  Seçilen tanık özelliği sağlar
theorem a16_6 (h : ∃ n : Nat, n * n = 49) : secilen h * secilen h = 49 := by
  sorry

-- 16.7 ★★  Doğru olmayan önerme yanlıştır (klasik)
theorem a16_7 (p : Prop) (h : p ≠ True) : p = False := by
  sorry

-- 16.8 ★★★  İşaret fonksiyonu birebirdir
theorem a16_8 (x y : Tamsayi) : x.isaret = y.isaret → x = y := by
  sorry

end Alistirma16
