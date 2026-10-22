/-
  Lean 4 ile Modern Mantık
  Bölüm 10 — Alıştırma Çözümleri (eğitmenler için)
-/
import ModernMantik.Bolum10

namespace Cozum10

open Bolum10 Bolum10.Formul

-- 10.1
theorem a10_1 (A : Formul) : boyut (∼A) = boyut A + 1 := by
  show boyut A + 0 + 1 = boyut A + 1
  omega

-- 10.2
theorem a10_2 : Totoloji (p ⋀ q ⟹ q ⋀ p) := by
  intro v
  show (!(v 0 && v 1) || (v 1 && v 0)) = true
  cases v 0 <;> cases v 1 <;> rfl

-- 10.3
theorem a10_3 : Sonuc [p ⋀ q] p := by
  intro v h
  have h1 : (v 0 && v 1) = true := h (p ⋀ q) (by simp)
  show v 0 = true
  revert h1
  cases v 0 <;> cases v 1 <;> simp

-- 10.4
theorem a10_4 (Γ : List Formul) (A B : Formul) (h : Sonuc Γ A) : Sonuc Γ (A ⋁ B) := by
  intro v hv
  have hA : deger v A = true := h v hv
  show (deger v A || deger v B) = true
  simp [hA]

-- 10.5
theorem a10_5 (Γ : List Formul) (A : Formul) (h : Totoloji A) : Sonuc Γ A := by
  intro v _
  exact h v

-- 10.6
theorem a10_6 (Γ : List Formul) (A B : Formul)
    (h1 : Sonuc Γ (A ⟹ B)) (h2 : Sonuc Γ A) : Sonuc Γ B := by
  intro v hv
  have a : (!deger v A || deger v B) = true := h1 v hv
  have b : deger v A = true := h2 v hv
  rw [b] at a
  simpa using a

-- 10.7
theorem a10_7 (Γ : List Formul) (A B : Formul) (h : Sonuc (A :: Γ) B) :
    Sonuc Γ (A ⟹ B) := by
  intro v hv
  show (!deger v A || deger v B) = true
  cases hA : deger v A with
  | false => rfl
  | true =>
    have hB : deger v B = true := by
      apply h v
      intro C hC
      cases hC with
      | head => exact hA
      | tail _ hC' => exact hv C hC'
    simp [hB]

-- 10.8
theorem a10_8 : ¬ Saglanabilir bot := by
  rintro ⟨v, hv⟩
  have h : false = true := hv   -- deger v bot, tanım gereği false'tur
  cases h

end Cozum10
