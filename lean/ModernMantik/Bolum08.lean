/-
  Lean 4 ile Modern Mantık
  Bölüm 8 — Kümeler, İlişkiler ve Fonksiyonlar

  Bu bölümden itibaren Mathlib kullanılır.

  `-- ANCHOR: ad` / `-- ANCHOR_END: ad` satırları kitabın kaynağı
  tarafından okunur. Lütfen silmeyin.
-/
import Mathlib
import ModernMantik.Bolum07

namespace Bolum08

/-! ## 8.1  Mathlib'e ilk bakış -/

-- ANCHOR: mathlib_ilk
#check Nat.Prime                 -- Nat.Prime (p : ℕ) : Prop
#check (Real.sqrt 2 : ℝ)        -- √2 : ℝ
#check Finset.sum_range_succ    -- ∑ x ∈ range (n + 1), f x = ∑ x ∈ range n, f x + f n

example : Nat.Prime 97 := by norm_num
example (x : ℝ) : 0 ≤ x ^ 2 + 1 := by positivity
example (x y : ℝ) (h1 : x < y) (h2 : y < 3) : x < 3 := by linarith
-- ANCHOR_END: mathlib_ilk

-- ANCHOR: gauss_ring
-- Bölüm 7'deki Gauss ispatı, ring taktiğiyle:
theorem gauss_ring (n : ℕ) : 2 * Bolum07.toplam n = n * (n + 1) := by
  induction n with
  | zero => rfl
  | succ m ih =>
    show 2 * (Bolum07.toplam m + (m + 1)) = (m + 1) * (m + 1 + 1)
    rw [mul_add, ih]
    ring                          -- polinom eşitliğini kendiliğinden çözer
-- ANCHOR_END: gauss_ring

-- ANCHOR: gauss_finset
-- Aynı formül, Mathlib'in toplam gösterimiyle:
theorem gauss_finset (n : ℕ) :
    2 * ∑ i ∈ Finset.range (n + 1), i = n * (n + 1) := by
  induction n with
  | zero => simp
  | succ m ih =>
    rw [Finset.sum_range_succ, mul_add, ih]
    ring
-- ANCHOR_END: gauss_finset

/-! ## 8.2  Kümeler yüklemdir -/

section Kumeler

variable {α : Type*}

-- ANCHOR: kume_tanim
-- Mathlib'de:  def Set (α : Type u) := α → Prop
example : (3 : ℕ) ∈ {n : ℕ | n % 2 = 1} := by simp
example (P : α → Prop) (a : α) : a ∈ {x | P x} ↔ P a := Iff.rfl
-- ANCHOR_END: kume_tanim

/-! ## 8.3  Küme işlemleri -/

-- ANCHOR: altkume
theorem altkume_gecisli (s t u : Set α) (h1 : s ⊆ t) (h2 : t ⊆ u) : s ⊆ u := by
  intro x hx                     -- s ⊆ t  demek:  ∀ x, x ∈ s → x ∈ t
  exact h2 (h1 hx)
-- ANCHOR_END: altkume

-- ANCHOR: kesisim_degisme
theorem kesisim_degisme (s t : Set α) : s ∩ t = t ∩ s := by
  ext x                          -- iki küme, aynı elemanlara sahipse eşittir
  constructor
  · rintro ⟨hs, ht⟩              -- x ∈ s ∩ t  demek:  x ∈ s ∧ x ∈ t
    exact ⟨ht, hs⟩
  · rintro ⟨ht, hs⟩
    exact ⟨hs, ht⟩
-- ANCHOR_END: kesisim_degisme

-- ANCHOR: dagilma
theorem kesisim_birlesim (s t u : Set α) : s ∩ (t ∪ u) = (s ∩ t) ∪ (s ∩ u) := by
  ext x
  constructor
  · rintro ⟨hs, ht | hu⟩
    · exact Or.inl ⟨hs, ht⟩
    · exact Or.inr ⟨hs, hu⟩
  · rintro (⟨hs, ht⟩ | ⟨hs, hu⟩)
    · exact ⟨hs, Or.inl ht⟩
    · exact ⟨hs, Or.inr hu⟩
-- ANCHOR_END: dagilma

-- ANCHOR: dagilma_simp
-- Aynı teorem, Mathlib'in otomasyonuyla:
theorem kesisim_birlesim' (s t u : Set α) : s ∩ (t ∪ u) = (s ∩ t) ∪ (s ∩ u) := by
  ext x
  simp only [Set.mem_inter_iff, Set.mem_union]
  tauto
-- ANCHOR_END: dagilma_simp

-- ANCHOR: tumleyen
theorem birlesim_tumleyen (s t : Set α) : (s ∪ t)ᶜ = sᶜ ∩ tᶜ := by
  ext x
  constructor
  · intro h                       -- h : x ∉ s ∪ t
    exact ⟨fun hs => h (Or.inl hs), fun ht => h (Or.inr ht)⟩
  · rintro ⟨hs, ht⟩ (h | h)
    · exact hs h
    · exact ht h
-- ANCHOR_END: tumleyen

end Kumeler

/-! ## 8.4  İlişkiler -/

-- ANCHOR: mod_denk
def modDenk (n a b : ℕ) : Prop := a % n = b % n

theorem modDenk_denklik (n : ℕ) : Equivalence (modDenk n) where
  refl _ := rfl                          -- yansıma
  symm h := Eq.symm h                    -- simetri
  trans h1 h2 := Eq.trans h1 h2          -- geçişme
-- ANCHOR_END: mod_denk

-- ANCHOR: bolunme
-- Bölünebilirlik bir kısmi sıralamadır:
example (a : ℕ) : a ∣ a := dvd_refl a
example (a b c : ℕ) (h1 : a ∣ b) (h2 : b ∣ c) : a ∣ c := dvd_trans h1 h2
example (a b : ℕ) (h1 : a ∣ b) (h2 : b ∣ a) : a = b := Nat.dvd_antisymm h1 h2
-- ANCHOR_END: bolunme

/-! ## 8.5  Fonksiyonlar -/

section Fonksiyonlar

open Function

variable {α β γ : Type*}

-- ANCHOR: birebir_ornek
theorem iki_kat_birebir : Injective (fun n : ℕ => 2 * n) := by
  intro a b h                     -- h : 2 * a = 2 * b  (tanım gereği)
  have h' : 2 * a = 2 * b := h
  omega

theorem iki_kat_orten_degil : ¬ Surjective (fun n : ℕ => 2 * n) := by
  intro h
  obtain ⟨a, ha⟩ := h 1           -- 2 * a = 1 olan bir a olsaydı...
  have ha' : 2 * a = 1 := ha
  omega
-- ANCHOR_END: birebir_ornek

-- ANCHOR: bileske
theorem birebir_bileske {f : α → β} {g : β → γ}
    (hf : Injective f) (hg : Injective g) : Injective (g ∘ f) := by
  intro a b h                     -- h : g (f a) = g (f b)
  apply hf
  apply hg
  exact h

theorem orten_bileske {f : α → β} {g : β → γ}
    (hf : Surjective f) (hg : Surjective g) : Surjective (g ∘ f) := by
  intro c
  obtain ⟨b, hb⟩ := hg c          -- g b = c
  obtain ⟨a, ha⟩ := hf b          -- f a = b
  refine ⟨a, ?_⟩
  show g (f a) = c
  rw [ha, hb]
-- ANCHOR_END: bileske

-- ANCHOR: sol_ters
theorem sol_ters_birebir (f : α → β) (g : β → α)
    (h : ∀ a, g (f a) = a) : Injective f := by
  intro a b hab                   -- hab : f a = f b
  rw [← h a, ← h b, hab]
-- ANCHOR_END: sol_ters

-- ANCHOR: cantor
-- Cantor: Bir kümeden onun alt kümelerine örten fonksiyon yoktur.
theorem cantor (f : α → Set α) : ¬ Surjective f := by
  intro hf
  obtain ⟨a, ha⟩ := hf {x | x ∉ f x}      -- köşegen küme
  have h1 : a ∉ f a := by
    intro h
    have h2 : a ∈ {x | x ∉ f x} := by
      rw [← ha]
      exact h
    exact h2 h
  have h3 : a ∈ f a := by
    rw [ha]
    exact h1
  exact h1 h3
-- ANCHOR_END: cantor

end Fonksiyonlar

end Bolum08
