/-
  Lean 4 ile Modern Mantık
  Bölüm 10 — Alıştırmalar

  Her `sorry`'yi kendi ispatınızla değiştirin.
  Zorluk:  ★ temel   ★★ orta   ★★★ ileri
  Çözümler: ModernMantik/Cozumler/Bolum10.lean
-/
import ModernMantik.Bolum10

namespace Alistirma10

open Bolum10 Bolum10.Formul

-- 10.1 ★  Değillemenin boyutu
theorem a10_1 (A : Formul) : boyut (∼A) = boyut A + 1 := by
  sorry

-- 10.2 ★★  Ve'nin değişmesi bir totolojidir
theorem a10_2 : Totoloji (p ⋀ q ⟹ q ⋀ p) := by
  sorry

-- 10.3 ★★  p ⋀ q ⊨ p
theorem a10_3 : Sonuc [p ⋀ q] p := by
  sorry

-- 10.4 ★★  Veya'ya giriş, anlambilimsel olarak
theorem a10_4 (Γ : List Formul) (A B : Formul) (h : Sonuc Γ A) : Sonuc Γ (A ⋁ B) := by
  sorry

-- 10.5 ★★  Totolojiler her şeyden çıkar
theorem a10_5 (Γ : List Formul) (A : Formul) (h : Totoloji A) : Sonuc Γ A := by
  sorry

-- 10.6 ★★★  Anlambilimsel modus ponens, genel hâli
theorem a10_6 (Γ : List Formul) (A B : Formul)
    (h1 : Sonuc Γ (A ⟹ B)) (h2 : Sonuc Γ A) : Sonuc Γ B := by
  sorry

-- 10.7 ★★★  Anlambilimsel çıkarım teoremi
theorem a10_7 (Γ : List Formul) (A B : Formul) (h : Sonuc (A :: Γ) B) :
    Sonuc Γ (A ⟹ B) := by
  sorry

-- 10.8 ★★  ⊥ sağlanabilir değildir
theorem a10_8 : ¬ Saglanabilir bot := by
  sorry

end Alistirma10
