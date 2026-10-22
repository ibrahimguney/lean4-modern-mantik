/-
  Lean 4 ile Modern Mantık
  Bölüm 13 — Alıştırmalar

  Her `sorry`'yi kendi ispatınızla değiştirin.
  Üyelik hedefleri (`atom 0 ∈ [p, q]` gibi) için `by decide` yeterlidir.
  Zorluk:  ★ temel   ★★ orta   ★★★ ileri
  Çözümler: ModernMantik/Cozumler/Bolum13.lean
-/
import ModernMantik.Bolum13

namespace Alistirma13

open Bolum10 Bolum10.Formul Bolum11 Bolum12 Bolum13

-- 13.1 ★  Kesmesiz bir türetim
theorem a13_1 : Ardisik [p ⋀ q] [q ⋀ p] := by
  sorry

-- 13.2 ★  Çelişkili varsayımlar
theorem a13_2 : Ardisik [∼p, p] [] := by
  sorry

-- 13.3 ★  Zayıflatma, yapısal kuraldan
theorem a13_3 {Γ Δ : List Formul} (A : Formul) (h : Ardisik Γ Δ) :
    Ardisik (A :: Γ) Δ := by
  sorry

-- 13.4 ★★  Dummett formülü (sağda sıra değiştirmek gerekir)
theorem a13_4 : Ardisik [] [(p ⟹ q) ⋁ (q ⟹ p)] := by
  sorry

-- 13.5 ★★  Türetilemezlik, karşı modelle
theorem a13_5 : ¬ Ardisik [p ⋁ q] [p] := by
  sorry

-- 13.6 ★★  Sözdizimsel tersinirlik, tamlık yoluyla
theorem a13_6 {Γ Δ : List Formul} {A B : Formul} (h : Ardisik ((A ⋀ B) :: Γ) Δ) :
    Ardisik (A :: B :: Γ) Δ := by
  sorry

-- 13.7 ★★  Doğal çıkarımdan gelen bir önsavla kesme
theorem a13_7 {Γ Δ : List Formul} {A : Formul}
    (h1 : Turetilir Γ A) (h2 : Ardisik (A :: Γ) Δ) : Ardisik Γ Δ := by
  sorry

-- 13.8 ★★★  Ardışık hesap ve totolojiler
theorem a13_8 (A : Formul) : Ardisik [] [A] ↔ Totoloji A := by
  sorry

end Alistirma13
