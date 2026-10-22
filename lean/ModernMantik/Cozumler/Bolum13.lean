/-
  Lean 4 ile Modern Mantık
  Bölüm 13 — Alıştırma Çözümleri (eğitmenler için)
-/
import ModernMantik.Bolum13

namespace Cozum13

open Bolum10 Bolum10.Formul Bolum11 Bolum12 Bolum13

-- 13.1
theorem a13_1 : Ardisik [p ⋀ q] [q ⋀ p] := by
  apply Ardisik.veL                          -- p, q ⇒ q ⋀ p
  apply Ardisik.veR
  · exact Ardisik.ax (n := 1) (by decide) (by decide)
  · exact Ardisik.ax (n := 0) (by decide) (by decide)

-- 13.2
theorem a13_2 : Ardisik [∼p, p] [] := by
  apply Ardisik.iseL                         -- p ⇒ p   ve   ⊥, p ⇒
  · exact Ardisik.ax (n := 0) (by decide) (by decide)
  · exact Ardisik.botL (by decide)

-- 13.3
theorem a13_3 {Γ Δ : List Formul} (A : Formul) (h : Ardisik Γ Δ) :
    Ardisik (A :: Γ) Δ := by
  exact Ardisik.degis h (fun _ hX => List.Mem.tail _ hX) (fun _ hX => hX)

-- 13.4
theorem a13_4 : Ardisik [] [(p ⟹ q) ⋁ (q ⟹ p)] := by
  apply Ardisik.veyaR                        -- ⇒ p ⟹ q, q ⟹ p
  apply Ardisik.iseR                         -- p ⇒ q, q ⟹ p
  apply Ardisik.degis (Γ := [p]) (Δ := [q ⟹ p, q])
  · apply Ardisik.iseR                       -- q, p ⇒ p, q
    exact Ardisik.ax (n := 0) (by decide) (by decide)
  · intro X hX; exact hX
  · intro X hX
    cases hX with
    | head => exact List.Mem.tail _ (List.Mem.head _)
    | tail _ h =>
      cases h with
      | head => exact List.Mem.head _
      | tail _ h' => cases h'

-- 13.5
theorem a13_5 : ¬ Ardisik [p ⋁ q] [p] := by
  intro h
  -- p yanlış, q doğru:
  obtain ⟨Y, hY, hYv⟩ := ardisik_gecerli h (fun n => n == 1) (by
    intro X hX
    cases hX with
    | head => rfl
    | tail _ h' => cases h')
  cases hY with
  | head =>
    have h2 : false = true := hYv
    cases h2
  | tail _ h' => cases h'

-- 13.6
theorem a13_6 {Γ Δ : List Formul} {A B : Formul} (h : Ardisik ((A ⋀ B) :: Γ) Δ) :
    Ardisik (A :: B :: Γ) Δ := by
  exact ardisik_tam (ters_veL (ardisik_gecerli h))

-- 13.7
theorem a13_7 {Γ Δ : List Formul} {A : Formul}
    (h1 : Turetilir Γ A) (h2 : Ardisik (A :: Γ) Δ) : Ardisik Γ Δ := by
  refine kesme (A := A) ?_ h2
  apply Ardisik.degis (dogal_ardisik.1 h1)
  · intro X hX; exact hX
  · intro X hX
    cases hX with
    | head => exact List.Mem.head _
    | tail _ h => cases h

-- 13.8
theorem a13_8 (A : Formul) : Ardisik [] [A] ↔ Totoloji A := by
  constructor
  · intro h v
    exact gecerli_tek.1 (ardisik_gecerli h) v (by intro X hX; cases hX)
  · intro h
    exact ardisik_tam (gecerli_tek.2 (fun v _ => h v))

end Cozum13
