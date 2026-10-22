/-
  Lean 4 ile Modern Mantık
  Bölüm 14 — Alıştırma Çözümleri (eğitmenler için)
-/
import ModernMantik.Bolum14

namespace Cozum14

open Bolum14 Bolum14.Terim Bolum14.Tip

-- 14.1
theorem a14_1 : Normal (lam (lam (var 1))) := by
  intro u h
  cases h with
  | icinde h1 =>
    cases h1 with
    | icinde h2 => cases h2

-- 14.2
theorem a14_2 (s : Terim) : Adimlar (app I (app I s)) s := by
  exact Adimlar.adim (I_adim _) (Adimlar.adim (I_adim _) Adimlar.refl)

-- 14.3
def bilesim : Terim := lam (lam (lam (app (var 2) (app (var 1) (var 0)))))

theorem a14_3 (A B C : Tip) :
    Tiplenir [] bilesim ((B ⇒ C) ⇒ (A ⇒ B) ⇒ A ⇒ C) := by
  apply Tiplenir.soyutlama                  -- f : B ⇒ C
  apply Tiplenir.soyutlama                  -- g : A ⇒ B
  apply Tiplenir.soyutlama                  -- x : A
  apply Tiplenir.uygulama (A := B)
  · exact Tiplenir.degisken rfl
  · apply Tiplenir.uygulama (A := A)
    · exact Tiplenir.degisken rfl
    · exact Tiplenir.degisken rfl

-- 14.4
theorem tekrarla_tip (A : Tip) : ∀ n, Tiplenir [A, A ⇒ A] (tekrarla n) A
  | 0     => Tiplenir.degisken rfl
  | n + 1 => Tiplenir.uygulama (A := A) (Tiplenir.degisken rfl) (tekrarla_tip A n)

theorem a14_4 (A : Tip) (n : Nat) : Tiplenir [] (church n) ((A ⇒ A) ⇒ A ⇒ A) :=
  Tiplenir.soyutlama (Tiplenir.soyutlama (tekrarla_tip A n))

-- 14.5
theorem a14_5 : ¬ ∃ t, Tiplenir [] t (taban 0) := by
  intro ⟨t, h⟩
  have h1 := kapali_tip_totoloji h (fun _ => false)
  have h2 : false = true := h1
  cases h2

-- 14.6
theorem a14_6 : ∃ A B : Tip, A ≠ B ∧ Tiplenir [] I A ∧ Tiplenir [] I B := by
  exact ⟨taban 0 ⇒ taban 0, taban 1 ⇒ taban 1, by decide, I_tip _, I_tip _⟩

-- 14.7
theorem a14_7 : ¬ ∃ t, Tiplenir [] t ((taban 0 ⇒ taban 1) ⇒ taban 0) := by
  intro ⟨t, h⟩
  have h1 := kapali_tip_totoloji h (fun _ => false)
  have h2 : false = true := h1
  cases h2

-- 14.8
theorem a14_8 {Γ : List Tip} {A : Tip} : ¬ Tiplenir Γ Omega A := by
  intro h
  unfold Omega at h
  cases h with
  | uygulama h1 _ => exact oD_tiplenemez h1

end Cozum14
