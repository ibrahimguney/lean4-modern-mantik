/-
  Lean 4 ile Modern Mantık
  Bölüm 7 — Alıştırma Çözümleri (eğitmenler için)
-/
import ModernMantik.Bolum07

namespace Cozum07

open Bolum07 Bolum07.Dogal

-- 7.1
theorem a7_1 (n : Dogal) : topla n (ard sifir) = ard n := rfl

-- 7.2
theorem a7_2 (n : Dogal) : carp sifir n = sifir := by
  induction n with
  | sifir => rfl
  | ard k ih =>
    show carp sifir k = sifir      -- carp sifir (ard k) = topla (carp sifir k) sifir
    exact ih

-- 7.3
theorem a7_3 (a b c : Dogal) : topla a c = topla b c → a = b := by
  induction c with
  | sifir =>
    intro h
    exact h
  | ard k ih =>
    intro h
    change ard (topla a k) = ard (topla b k) at h
    injection h with h'
    exact ih h'

-- 7.4
theorem a7_4 (n : Nat) : 0 * n = 0 := by
  induction n with
  | zero => rfl
  | succ m ih =>
    show 0 * m + 0 = 0
    omega

-- 7.5
def ucKat : Nat → Nat
  | 0     => 0
  | n + 1 => ucKat n + 3

theorem a7_5 (n : Nat) : ucKat n = 3 * n := by
  induction n with
  | zero => rfl
  | succ m ih =>
    show ucKat m + 3 = 3 * (m + 1)
    omega

-- 7.6
def tekToplam : Nat → Nat
  | 0     => 0
  | n + 1 => tekToplam n + (2 * n + 1)

theorem a7_6 (n : Nat) : tekToplam n = n * n := by
  induction n with
  | zero => rfl
  | succ m ih =>
    show tekToplam m + (2 * m + 1) = (m + 1) * (m + 1)
    rw [ih, Nat.right_distrib, Nat.left_distrib]
    omega                          -- m * m bir "atom" olarak işlenir

-- 7.7
theorem a7_7 (n : Nat) : n < 2 ^ n := by
  induction n with
  | zero => decide
  | succ m ih =>
    rw [Nat.pow_succ]
    omega                          -- 2 ^ m bir "atom" olarak işlenir

-- 7.8
theorem a7_8 : ∀ n, ∃ a b, n + 8 = 3 * a + 5 * b := by
  apply Bolum07.guclu_tumevarim
  intro n ih
  cases Nat.lt_or_ge n 3 with
  | inl h =>
    have h3 : n = 0 ∨ n = 1 ∨ n = 2 := by omega
    rcases h3 with rfl | rfl | rfl
    · exact ⟨1, 1, rfl⟩            --  8 = 3 + 5
    · exact ⟨3, 0, rfl⟩            --  9 = 3 + 3 + 3
    · exact ⟨0, 2, rfl⟩            -- 10 = 5 + 5
  | inr h =>
    obtain ⟨a, b, hab⟩ := ih (n - 3) (by omega)
    exact ⟨a + 1, b, by omega⟩     -- bir 3'lük pul daha ekle

end Cozum07
