/-
  Lean 4 ile Modern Mantık
  Bölüm 7 — Alıştırmalar

  Her `sorry`'yi kendi ispatınızla değiştirin.
  Kütüphanedeki hazır teoremleri (Nat.zero_mul gibi) KULLANMADAN,
  tümevarımla ispatlamaya çalışın; `omega` serbesttir.
  Zorluk:  ★ temel   ★★ orta   ★★★ ileri
  Çözümler: ModernMantik/Cozumler/Bolum07.lean
-/
import ModernMantik.Bolum07

namespace Alistirma07

open Bolum07 Bolum07.Dogal

-- 7.1 ★  Tanımı açarak
theorem a7_1 (n : Dogal) : topla n (ard sifir) = ard n := by
  sorry

-- 7.2 ★★  Sıfırla soldan çarpma
theorem a7_2 (n : Dogal) : carp sifir n = sifir := by
  sorry

-- 7.3 ★★  Toplamada sadeleştirme
theorem a7_3 (a b c : Dogal) : topla a c = topla b c → a = b := by
  sorry

-- 7.4 ★  Nat'ta sıfırla soldan çarpma
theorem a7_4 (n : Nat) : 0 * n = 0 := by
  sorry

-- 7.5 ★★
def ucKat : Nat → Nat
  | 0     => 0
  | n + 1 => ucKat n + 3

theorem a7_5 (n : Nat) : ucKat n = 3 * n := by
  sorry

-- 7.6 ★★  Tek sayıların toplamı bir karedir: 1 + 3 + ⋯ + (2n−1) = n²
def tekToplam : Nat → Nat
  | 0     => 0
  | n + 1 => tekToplam n + (2 * n + 1)

theorem a7_6 (n : Nat) : tekToplam n = n * n := by
  sorry

-- 7.7 ★★  n < 2ⁿ
theorem a7_7 (n : Nat) : n < 2 ^ n := by
  sorry

-- 7.8 ★★★  Pul problemi: 8 kuruştan büyük her tutar 3'lük ve 5'lik
--          pullarla ödenebilir. (İpucu: Bolum07.guclu_tumevarim)
theorem a7_8 : ∀ n, ∃ a b, n + 8 = 3 * a + 5 * b := by
  sorry

end Alistirma07
