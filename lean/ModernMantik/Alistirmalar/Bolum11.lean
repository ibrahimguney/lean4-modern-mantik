/-
  Lean 4 ile Modern Mantık
  Bölüm 11 — Alıştırmalar

  Her `sorry`'yi kendi ispatınızla değiştirin.
  Türetimlerde yalnızca `Turetilir`'in kurucularını kullanın; üyelik
  hedefleri (`X ∈ Γ`) için `by decide` ya da `List.Mem.head _` yeterlidir.
  Zorluk:  ★ temel   ★★ orta   ★★★ ileri
  Çözümler: ModernMantik/Cozumler/Bolum11.lean
-/
import ModernMantik.Bolum11

namespace Alistirma11

open Bolum10 Bolum10.Formul Bolum11

-- 11.1 ★
theorem a11_1 : Turetilir [p] p := by
  sorry

-- 11.2 ★  K aksiyomu
theorem a11_2 (A B : Formul) : Turetilir [] (A ⟹ B ⟹ A) := by
  sorry

-- 11.3 ★★
theorem a11_3 : Turetilir [p ⋀ q] (q ⋀ p) := by
  sorry

-- 11.4 ★★  Hipotetik kıyas, nesne dilinde
theorem a11_4 : Turetilir [p ⟹ q, q ⟹ r] (p ⟹ r) := by
  sorry

-- 11.5 ★★  Geçerlilik teoremiyle türetilemezlik
theorem a11_5 : ¬ Turetilir [] (p ⟹ q) := by
  sorry

-- 11.6 ★★  Varsayımlar da işe yaramayabilir
theorem a11_6 : ¬ Turetilir [p ⋁ q] p := by
  sorry

-- 11.7 ★★★  Üçüncü hâlin olanaksızlığı (raa gerekir)
theorem a11_7 : Turetilir [] (p ⋁ ∼p) := by
  sorry

-- 11.8 ★★★  Çift değilleme eleme, genel hâli
theorem a11_8 (A : Formul) : Turetilir [∼∼A] A := by
  sorry

end Alistirma11
