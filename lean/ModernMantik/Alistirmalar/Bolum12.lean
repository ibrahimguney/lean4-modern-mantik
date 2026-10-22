/-
  Lean 4 ile Modern Mantık
  Bölüm 12 — Alıştırmalar

  Her `sorry`'yi kendi ispatınızla değiştirin.
  Bölüm 12'nin araçları kullanılabilir: bas, zay, ucuncu_hal, durum_ayrimi,
  kalmar_ve, kalmar_ise, tamlik_bos, tamlik, model_varligi, …
  Zorluk:  ★ temel   ★★ orta   ★★★ ileri
  Çözümler: ModernMantik/Cozumler/Bolum12.lean
-/
import ModernMantik.Bolum12

namespace Alistirma12

open Bolum10 Bolum10.Formul Bolum11 Bolum12

-- 12.1 ★  Türetim yazmadan: doğruluk tablosu + tamlık
theorem a12_1 : Turetilir [] (p ⟹ p ⋁ q) := by
  sorry

-- 12.2 ★  Çift değilleme giriş (türetilmiş kural)
theorem a12_2 {Δ : List Formul} {A : Formul} (h : Turetilir Δ A) :
    Turetilir Δ (∼∼A) := by
  sorry

-- 12.3 ★★  Varsayımlı tamlık
theorem a12_3 : Turetilir [p ⋀ q] (q ⋀ p) := by
  sorry

-- 12.4 ★★  Kontrapozisyon (türetilmiş kural)
theorem a12_4 {Δ : List Formul} {A B : Formul} (h : Turetilir Δ (A ⟹ B)) :
    Turetilir Δ (∼B ⟹ ∼A) := by
  sorry

-- 12.5 ★★  Ters çevirme geçerli değildir
theorem a12_5 : ¬ Turetilir [p ⟹ q] (q ⟹ p) := by
  sorry

-- 12.6 ★  Kesme kuralı türetilebilir
theorem a12_6 {Γ : List Formul} {A B : Formul}
    (h1 : Turetilir Γ A) (h2 : Turetilir (A :: Γ) B) : Turetilir Γ B := by
  sorry

-- 12.7 ★★  Denklik bağlacı için Kalmár adımı
theorem a12_7 {Δ : List Formul} {A B : Formul} {a b : Bool}
    (hA : Kalmar Δ a A) (hB : Kalmar Δ b B) :
    Kalmar Δ ((!a || b) && (!b || a)) (esd A B) := by
  sorry

-- 12.8 ★★★  Tutarlılık = sağlanabilirlik
theorem a12_8 (A : Formul) : ¬ Turetilir [A] bot ↔ Saglanabilir A := by
  sorry

end Alistirma12
