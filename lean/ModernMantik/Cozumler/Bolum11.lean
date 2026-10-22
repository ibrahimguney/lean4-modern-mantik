/-
  Lean 4 ile Modern Mantık
  Bölüm 11 — Alıştırma Çözümleri (eğitmenler için)
-/
import ModernMantik.Bolum11

namespace Cozum11

open Bolum10 Bolum10.Formul Bolum11

-- 11.1
theorem a11_1 : Turetilir [p] p :=
  Turetilir.varsayim (List.Mem.head _)

-- 11.2
theorem a11_2 (A B : Formul) : Turetilir [] (A ⟹ B ⟹ A) := by
  apply Turetilir.iseG                      -- [A] ⊢ B ⟹ A
  apply Turetilir.iseG                      -- [B, A] ⊢ A
  apply Turetilir.varsayim
  exact List.Mem.tail _ (List.Mem.head _)

-- 11.3
theorem a11_3 : Turetilir [p ⋀ q] (q ⋀ p) := by
  apply Turetilir.veG
  · apply Turetilir.veE2 (A := p)
    exact Turetilir.varsayim (List.Mem.head _)
  · apply Turetilir.veE1 (B := q)
    exact Turetilir.varsayim (List.Mem.head _)

-- 11.4
theorem a11_4 : Turetilir [p ⟹ q, q ⟹ r] (p ⟹ r) := by
  apply Turetilir.iseG                      -- [p, p⟹q, q⟹r] ⊢ r
  apply Turetilir.iseE (A := q)
  · exact Turetilir.varsayim (by decide)    -- q ⟹ r
  · apply Turetilir.iseE (A := p)
    · exact Turetilir.varsayim (by decide)  -- p ⟹ q
    · exact Turetilir.varsayim (by decide)  -- p

-- 11.5  p doğru, q yanlış olan bir değerleme seçelim.
theorem a11_5 : ¬ Turetilir [] (p ⟹ q) := by
  intro h
  have h1 : false = true := turetilir_totoloji h (fun n => n == 0)
  cases h1

-- 11.6  p yanlış, q doğru olan bir değerleme seçelim.
theorem a11_6 : ¬ Turetilir [p ⋁ q] p := by
  intro h
  have h1 := gecerlilik h (fun n => n == 1) (by
    intro X hX
    cases hX with
    | head => rfl
    | tail _ hX' => cases hX')
  have h2 : false = true := h1
  cases h2

-- 11.7
theorem a11_7 : Turetilir [] (p ⋁ ∼p) := by
  apply Turetilir.raa                         -- [∼(p ⋁ ∼p)] ⊢ ⊥
  apply Turetilir.iseE (A := p ⋁ ∼p)
  · exact Turetilir.varsayim (by decide)
  · apply Turetilir.veyaG2                    -- ∼p'yi göster
    apply Turetilir.iseG                      -- [p, ∼(p ⋁ ∼p)] ⊢ ⊥
    apply Turetilir.iseE (A := p ⋁ ∼p)
    · exact Turetilir.varsayim (by decide)
    · apply Turetilir.veyaG1
      exact Turetilir.varsayim (List.Mem.head _)

-- 11.8
theorem a11_8 (A : Formul) : Turetilir [∼∼A] A := by
  apply Turetilir.raa                         -- [∼A, ∼∼A] ⊢ ⊥
  apply Turetilir.iseE (A := ∼A)
  · exact Turetilir.varsayim (List.Mem.tail _ (List.Mem.head _))   -- ∼∼A
  · exact Turetilir.varsayim (List.Mem.head _)                     -- ∼A

end Cozum11
