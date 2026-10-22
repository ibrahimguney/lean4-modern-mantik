/-
  Lean 4 ile Modern Mantık
  Bölüm 12 — Alıştırma Çözümleri (eğitmenler için)
-/
import ModernMantik.Bolum12

namespace Cozum12

open Bolum10 Bolum10.Formul Bolum11 Bolum12

-- 12.1
theorem a12_1 : Turetilir [] (p ⟹ p ⋁ q) := by
  apply tamlik_bos
  intro v
  show (!v 0 || (v 0 || v 1)) = true
  cases v 0 <;> cases v 1 <;> rfl

-- 12.2
theorem a12_2 {Δ : List Formul} {A : Formul} (h : Turetilir Δ A) :
    Turetilir Δ (∼∼A) := by
  apply Turetilir.iseG                        -- ∼A :: Δ ⊢ ⊥
  apply Turetilir.iseE (A := A)
  · exact bas
  · exact zay _ h

-- 12.3
theorem a12_3 : Turetilir [p ⋀ q] (q ⋀ p) := by
  apply tamlik
  intro v hv
  have h : (v 0 && v 1) = true := hv (p ⋀ q) (List.Mem.head _)
  simp at h                                   -- h : v 0 = true ∧ v 1 = true
  show (v 1 && v 0) = true
  simp [h.1, h.2]

-- 12.4
theorem a12_4 {Δ : List Formul} {A B : Formul} (h : Turetilir Δ (A ⟹ B)) :
    Turetilir Δ (∼B ⟹ ∼A) := by
  apply Turetilir.iseG                        -- ∼B :: Δ ⊢ ∼A
  apply Turetilir.iseG                        -- A :: ∼B :: Δ ⊢ ⊥
  apply Turetilir.iseE (A := B)
  · exact zay _ bas                           -- ∼B
  · apply Turetilir.iseE (A := A)
    · exact zay _ (zay _ h)                   -- A ⟹ B
    · exact bas                               -- A

-- 12.5
theorem a12_5 : ¬ Turetilir [p ⟹ q] (q ⟹ p) := by
  intro h
  -- p yanlış, q doğru:
  have h1 := gecerlilik h (fun n => n == 1) (by
    intro X hX
    cases hX with
    | head => rfl
    | tail _ hX' => cases hX')
  have h2 : false = true := h1
  cases h2

-- 12.6
theorem a12_6 {Γ : List Formul} {A B : Formul}
    (h1 : Turetilir Γ A) (h2 : Turetilir (A :: Γ) B) : Turetilir Γ B := by
  exact Turetilir.iseE (Turetilir.iseG h2) h1

-- 12.7
theorem a12_7 {Δ : List Formul} {A B : Formul} {a b : Bool}
    (hA : Kalmar Δ a A) (hB : Kalmar Δ b B) :
    Kalmar Δ ((!a || b) && (!b || a)) (esd A B) := by
  exact kalmar_ve (kalmar_ise hA hB) (kalmar_ise hB hA)

-- 12.8
theorem a12_8 (A : Formul) : ¬ Turetilir [A] bot ↔ Saglanabilir A := by
  constructor
  · intro h
    cases model_varligi h with
    | intro v hv =>
      show ∃ w, deger w A = true
      exact ⟨v, hv A (List.Mem.head _)⟩
  · intro hs ht
    cases hs with
    | intro v hv =>
      have h1 : false = true := gecerlilik ht v (by
        intro X hX
        cases hX with
        | head => exact hv
        | tail _ hX' => cases hX')
      cases h1

end Cozum12
