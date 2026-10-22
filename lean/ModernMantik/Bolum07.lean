/-
  Lean 4 ile Modern Mantık
  Bölüm 7 — Doğal Sayılar ve Tümevarım

  `-- ANCHOR: ad` / `-- ANCHOR_END: ad` satırları kitabın kaynağı
  tarafından okunur. Lütfen silmeyin.
-/

namespace Bolum07

/-! ## 7.2  Kendi doğal sayılarımız -/

-- ANCHOR: dogal_tanim
inductive Dogal where
  | sifir : Dogal                -- 0 bir doğal sayıdır
  | ard   : Dogal → Dogal        -- n bir doğal sayıysa, ard n de öyledir
-- ANCHOR_END: dogal_tanim

namespace Dogal

-- ANCHOR: peano_teorem
-- Peano'nun iki aksiyomu, Lean'de TEOREMDİR:
theorem sifir_ard_degil (n : Dogal) : sifir ≠ ard n := by
  intro h
  cases h                        -- farklı kurucular asla eşit olamaz

theorem ard_birebir (n m : Dogal) (h : ard n = ard m) : n = m := by
  injection h with h'            -- kurucular birebirdir: h' : n = m
  exact h'
-- ANCHOR_END: peano_teorem

/-! ## 7.3  Özyineleme -/

-- ANCHOR: topla_tanim
def topla : Dogal → Dogal → Dogal
  | n, sifir => n                         -- n + 0 = n
  | n, ard m => ard (topla n m)           -- n + (m+1) = (n + m) + 1
-- ANCHOR_END: topla_tanim

-- ANCHOR: carp_tanim
def carp : Dogal → Dogal → Dogal
  | _, sifir => sifir                     -- n · 0 = 0
  | n, ard m => topla (carp n m) n        -- n · (m+1) = n·m + n
-- ANCHOR_END: carp_tanim

-- ANCHOR: sayiya
def sayiya : Dogal → Nat
  | sifir => 0
  | ard n => sayiya n + 1

def iki : Dogal := ard (ard sifir)
def uc  : Dogal := ard iki

#eval sayiya (topla iki uc)     -- 5
#eval sayiya (carp iki uc)      -- 6
-- ANCHOR_END: sayiya

/-! ## 7.4  Tümevarım ilkesi -/

-- ANCHOR: rec_check
#check @Dogal.rec
-- @Dogal.rec : {motive : Dogal → Sort u} →
--   motive sifir →
--   ((a : Dogal) → motive a → motive (ard a)) →
--   (t : Dogal) → motive t
-- ANCHOR_END: rec_check

-- ANCHOR: tumevarim
theorem tumevarim (P : Dogal → Prop)
    (h0 : P sifir)                          -- taban adımı
    (hs : ∀ n, P n → P (ard n)) :           -- tümevarım adımı
    ∀ n, P n := by
  intro n
  induction n with
  | sifir => exact h0
  | ard m ih => exact hs m ih               -- ih : P m  (tümevarım hipotezi)
-- ANCHOR_END: tumevarim

/-! ## 7.5  İlk tümevarım ispatları -/

-- ANCHOR: topla_sifir
-- Tanımdan doğrudan çıkar:
theorem topla_sifir (n : Dogal) : topla n sifir = n := rfl
-- ANCHOR_END: topla_sifir

-- ANCHOR: sifir_topla
-- Ama simetriği tümevarım ister!
theorem sifir_topla (n : Dogal) : topla sifir n = n := by
  induction n with
  | sifir => rfl
  | ard m ih =>
    show ard (topla sifir m) = ard m     -- tanımı bir adım aç
    rw [ih]
-- ANCHOR_END: sifir_topla

-- ANCHOR: sifir_topla_terim
-- Aynı ispat, özyinelemeli bir fonksiyon olarak:
theorem sifir_topla' : ∀ n : Dogal, topla sifir n = n
  | sifir => rfl
  | ard m => congrArg ard (sifir_topla' m)
-- ANCHOR_END: sifir_topla_terim

-- ANCHOR: ard_topla
theorem ard_topla (n m : Dogal) : topla (ard n) m = ard (topla n m) := by
  induction m with
  | sifir => rfl
  | ard k ih =>
    show ard (topla (ard n) k) = ard (ard (topla n k))
    rw [ih]
-- ANCHOR_END: ard_topla

-- ANCHOR: topla_degisme
theorem topla_degisme (n m : Dogal) : topla n m = topla m n := by
  induction m with
  | sifir =>
    show n = topla sifir n
    rw [sifir_topla]
  | ard k ih =>
    show ard (topla n k) = topla (ard k) n
    rw [ard_topla, ih]
-- ANCHOR_END: topla_degisme

-- ANCHOR: topla_birlesme
theorem topla_birlesme (a b c : Dogal) :
    topla (topla a b) c = topla a (topla b c) := by
  induction c with
  | sifir => rfl
  | ard k ih =>
    show ard (topla (topla a b) k) = ard (topla a (topla b k))
    rw [ih]
-- ANCHOR_END: topla_birlesme

end Dogal

/-! ## 7.6  Lean'in Nat'ı -/

-- ANCHOR: nat_print
#print Nat
-- inductive Nat : Type
-- number of parameters: 0
-- constructors:
-- Nat.zero : Nat
-- Nat.succ (n : Nat) : Nat
-- ANCHOR_END: nat_print

-- ANCHOR: nat_sifir_arti
theorem sifir_arti (n : Nat) : 0 + n = n := by
  induction n with
  | zero => rfl
  | succ m ih =>                  -- ⊢ 0 + (m + 1) = m + 1
    rw [← Nat.add_assoc, ih]      -- 0 + (m + 1) = (0 + m) + 1 = m + 1
-- ANCHOR_END: nat_sifir_arti

-- ANCHOR: iki_kat
def ikiKat : Nat → Nat
  | 0     => 0
  | n + 1 => ikiKat n + 2

theorem ikiKat_esit (n : Nat) : ikiKat n = 2 * n := by
  induction n with
  | zero => rfl
  | succ m ih =>
    show ikiKat m + 2 = 2 * (m + 1)
    omega                         -- ih'yi de kullanarak doğrusal aritmetiği çözer
-- ANCHOR_END: iki_kat

-- ANCHOR: gauss_tanim
-- toplam n = 1 + 2 + ⋯ + n
def toplam : Nat → Nat
  | 0     => 0
  | n + 1 => toplam n + (n + 1)

#eval toplam 100                  -- 5050
example : 2 * toplam 10 = 10 * 11 := by decide
-- ANCHOR_END: gauss_tanim

-- ANCHOR: gauss
theorem gauss (n : Nat) : 2 * toplam n = n * (n + 1) := by
  induction n with
  | zero => rfl
  | succ m ih =>
    show 2 * (toplam m + (m + 1)) = (m + 1) * (m + 1 + 1)
    rw [Nat.left_distrib, ih]     -- ⊢ m * (m + 1) + 2 * (m + 1) = …
    rw [← Nat.right_distrib]      -- ⊢ (m + 2) * (m + 1) = (m + 1) * (m + 1 + 1)
    exact Nat.mul_comm (m + 2) (m + 1)
-- ANCHOR_END: gauss

/-! ## 7.7  Güçlü tümevarım -/

-- ANCHOR: guclu
theorem guclu_tumevarim (P : Nat → Prop)
    (h : ∀ n, (∀ m, m < n → P m) → P n) : ∀ n, P n := by
  -- Daha güçlü bir önermeyi sıradan tümevarımla ispatla:
  have anahtar : ∀ n, ∀ m, m < n → P m := by
    intro n
    induction n with
    | zero =>
      intro m hm
      omega                       -- m < 0 olamaz
    | succ k ih =>
      intro m hm                  -- hm : m < k + 1
      cases Nat.lt_or_ge m k with
      | inl hlt => exact ih m hlt
      | inr hge =>
        have hmk : m = k := by omega
        rw [hmk]
        exact h k ih
  intro n
  exact anahtar (n + 1) n (by omega)
-- ANCHOR_END: guclu

/-! ## 7.8  Otomasyon -/

-- ANCHOR: otomasyon
example (n : Nat) : n + 0 = n := by simp
example (a b : Nat) (h : a < b) : a + 1 ≤ b := by omega
example (x y : Nat) (h1 : x + y = 10) (h2 : x = 3 * y + 2) : y = 2 := by omega
example : 2 ^ 10 = 1024 := by decide
-- ANCHOR_END: otomasyon

end Bolum07
