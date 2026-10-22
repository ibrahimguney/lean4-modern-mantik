/-
  Lean 4 ile Modern Mantık
  Bölüm 10 — Önermeler Mantığının Sözdizimi ve Anlambilimi

  Bu bölüm yalnızca Lean çekirdeğini kullanır. Burada tanımlanan
  `Formul`, `deger`, `Sonuc` kavramları Bölüm 11 ve 12'de kullanılır.

  `-- ANCHOR: ad` / `-- ANCHOR_END: ad` satırları kitabın kaynağı
  tarafından okunur. Lütfen silmeyin.
-/

namespace Bolum10

/-! ## 10.2  Sözdizimi -/

-- ANCHOR: formul_tanim
inductive Formul where
  | atom : Nat → Formul                -- p₀, p₁, p₂, …
  | bot  : Formul                      -- ⊥
  | ve   : Formul → Formul → Formul    -- A ∧ B
  | veya : Formul → Formul → Formul    -- A ∨ B
  | ise  : Formul → Formul → Formul    -- A → B
  deriving Repr, DecidableEq
-- ANCHOR_END: formul_tanim

namespace Formul

-- ANCHOR: gosterim
-- Nesne dilinin bağlaçları için ayrı semboller:
scoped infixr:35 " ⋀ " => Formul.ve
scoped infixr:30 " ⋁ " => Formul.veya
scoped infixr:25 " ⟹ " => Formul.ise

-- Tanımlanmış bağlaçlar:
def degil (A : Formul) : Formul := A ⟹ bot
def tepe : Formul := bot ⟹ bot
def esd (A B : Formul) : Formul := (A ⟹ B) ⋀ (B ⟹ A)

scoped prefix:40 "∼" => Formul.degil

-- Örnek atomlar:
def p : Formul := atom 0
def q : Formul := atom 1
def r : Formul := atom 2
-- ANCHOR_END: gosterim

/-! ## 10.3  Formüller üzerinde özyineleme -/

-- ANCHOR: formul_ozyineleme
-- Bağlaç sayısı:
def boyut : Formul → Nat
  | atom _   => 0
  | bot      => 0
  | ve A B   => boyut A + boyut B + 1
  | veya A B => boyut A + boyut B + 1
  | ise A B  => boyut A + boyut B + 1

-- Formülde geçen en büyük atom indeksi:
def enBuyukAtom : Formul → Nat
  | atom n   => n
  | bot      => 0
  | ve A B   => max (enBuyukAtom A) (enBuyukAtom B)
  | veya A B => max (enBuyukAtom A) (enBuyukAtom B)
  | ise A B  => max (enBuyukAtom A) (enBuyukAtom B)
-- ANCHOR_END: formul_ozyineleme

end Formul

open Formul

-- ANCHOR: ornek_formul
def peirce : Formul := ((p ⟹ q) ⟹ p) ⟹ p
def ucuncuHal : Formul := p ⋁ ∼p

#eval boyut peirce             -- 3
#eval peirce
-- Bolum10.Formul.ise (… (Bolum10.Formul.atom 0) …)
-- ANCHOR_END: ornek_formul

/-! ## 10.4  Anlambilim -/

-- ANCHOR: deger
-- Bir değerleme, her atoma bir doğruluk değeri verir.
abbrev Degerleme := Nat → Bool

-- Bir formülün bir değerleme altındaki doğruluk değeri (Tarski):
def deger (v : Degerleme) : Formul → Bool
  | atom n   => v n
  | bot      => false
  | ve A B   => deger v A && deger v B
  | veya A B => deger v A || deger v B
  | ise A B  => !deger v A || deger v B
-- ANCHOR_END: deger

-- ANCHOR: deger_degil
theorem deger_degil (v : Degerleme) (A : Formul) :
    deger v (∼A) = !deger v A := by
  show (!deger v A || false) = !deger v A
  cases deger v A <;> rfl
-- ANCHOR_END: deger_degil

/-! ## 10.5  Totoloji ve mantıksal sonuç -/

-- ANCHOR: totoloji_tanim
def Totoloji (A : Formul) : Prop :=
  ∀ v : Degerleme, deger v A = true

def Saglanabilir (A : Formul) : Prop :=
  ∃ v : Degerleme, deger v A = true

-- Γ |= A : Γ'nin bütün formüllerini doğru yapan her değerleme A'yı da doğru yapar.
def Sonuc (Γ : List Formul) (A : Formul) : Prop :=
  ∀ v : Degerleme, (∀ B ∈ Γ, deger v B = true) → deger v A = true
-- ANCHOR_END: totoloji_tanim

-- ANCHOR: totoloji_ornek
theorem p_ise_p : Totoloji (p ⟹ p) := by
  intro v
  show (!v 0 || v 0) = true
  cases v 0 <;> rfl

theorem peirce_totoloji : Totoloji peirce := by
  intro v
  show (!(!(!v 0 || v 1) || v 0) || v 0) = true
  cases v 0 <;> cases v 1 <;> rfl         -- dört satırlık doğruluk tablosu
-- ANCHOR_END: totoloji_ornek

-- ANCHOR: sonuc_ornek
-- Anlambilimsel modus ponens:  p, p ⟹ q ⊨ q
theorem mp_sonuc : Sonuc [p, p ⟹ q] q := by
  intro v h
  have h1 : v 0 = true := h p (by simp)
  have h2 : (!v 0 || v 1) = true := h (p ⟹ q) (by simp)
  show v 1 = true
  rw [h1] at h2
  simpa using h2
-- ANCHOR_END: sonuc_ornek

-- ANCHOR: zayiflatma
-- Bir varsayım eklemek bir sonucu bozmaz.
theorem sonuc_zayiflatma (Γ : List Formul) (A B : Formul)
    (h : Sonuc Γ A) : Sonuc (B :: Γ) A := by
  intro v hv
  apply h v
  intro C hC
  exact hv C (by simp [hC])
-- ANCHOR_END: zayiflatma

/-! ## 10.6  Bir karar yöntemi -/

-- ANCHOR: karar
-- 0, 1, …, n−1 atomlarına verilebilecek bütün değerlemeler (2ⁿ tane):
def genislet (n : Nat) : List Degerleme → List Degerleme
  | []      => []
  | v :: vs => v :: (fun k => if k = n then true else v k) :: genislet n vs

def tumDegerlemeler : Nat → List Degerleme
  | 0     => [fun _ => false]
  | n + 1 => genislet n (tumDegerlemeler n)

def totolojiMi (A : Formul) : Bool :=
  (tumDegerlemeler (enBuyukAtom A + 1)).all (fun v => deger v A)

#eval totolojiMi (p ⟹ p)           -- true
#eval totolojiMi peirce             -- true
#eval totolojiMi ucuncuHal          -- true
#eval totolojiMi (p ⟹ q)            -- false
#eval (tumDegerlemeler 10).length   -- 1024
-- ANCHOR_END: karar

/-! ## 10.7  Yerellik ve yerine koyma -/

-- ANCHOR: yerellik
-- Bir formülün değeri yalnızca içinde geçen atomlara bağlıdır.
theorem yerellik (A : Formul) (v w : Degerleme) :
    (∀ n, n ≤ enBuyukAtom A → v n = w n) → deger v A = deger w A := by
  induction A with
  | atom n =>
    intro h
    exact h n (Nat.le_refl n)
  | bot =>
    intro _
    rfl
  | ve A B ihA ihB =>
    intro h
    show (deger v A && deger v B) = (deger w A && deger w B)
    rw [ihA (fun n hn => h n (Nat.le_trans hn (Nat.le_max_left _ _))),
        ihB (fun n hn => h n (Nat.le_trans hn (Nat.le_max_right _ _)))]
  | veya A B ihA ihB =>
    intro h
    show (deger v A || deger v B) = (deger w A || deger w B)
    rw [ihA (fun n hn => h n (Nat.le_trans hn (Nat.le_max_left _ _))),
        ihB (fun n hn => h n (Nat.le_trans hn (Nat.le_max_right _ _)))]
  | ise A B ihA ihB =>
    intro h
    show (!deger v A || deger v B) = (!deger w A || deger w B)
    rw [ihA (fun n hn => h n (Nat.le_trans hn (Nat.le_max_left _ _))),
        ihB (fun n hn => h n (Nat.le_trans hn (Nat.le_max_right _ _)))]
-- ANCHOR_END: yerellik

-- ANCHOR: yerine_koy
-- Her atomun yerine bir formül koymak:
def yerineKoy (σ : Nat → Formul) : Formul → Formul
  | atom n   => σ n
  | bot      => bot
  | ve A B   => yerineKoy σ A ⋀ yerineKoy σ B
  | veya A B => yerineKoy σ A ⋁ yerineKoy σ B
  | ise A B  => yerineKoy σ A ⟹ yerineKoy σ B

theorem deger_yerineKoy (σ : Nat → Formul) (v : Degerleme) (A : Formul) :
    deger v (yerineKoy σ A) = deger (fun n => deger v (σ n)) A := by
  induction A with
  | atom n => rfl
  | bot => rfl
  | ve A B ihA ihB =>
    show (deger v (yerineKoy σ A) && deger v (yerineKoy σ B))
       = (deger (fun n => deger v (σ n)) A && deger (fun n => deger v (σ n)) B)
    rw [ihA, ihB]
  | veya A B ihA ihB =>
    show (deger v (yerineKoy σ A) || deger v (yerineKoy σ B))
       = (deger (fun n => deger v (σ n)) A || deger (fun n => deger v (σ n)) B)
    rw [ihA, ihB]
  | ise A B ihA ihB =>
    show (!deger v (yerineKoy σ A) || deger v (yerineKoy σ B))
       = (!deger (fun n => deger v (σ n)) A || deger (fun n => deger v (σ n)) B)
    rw [ihA, ihB]

-- Totolojiler yerine koyma altında kapalıdır:
theorem totoloji_yerineKoy (σ : Nat → Formul) (A : Formul) (h : Totoloji A) :
    Totoloji (yerineKoy σ A) := by
  intro v
  rw [deger_yerineKoy]
  exact h _
-- ANCHOR_END: yerine_koy

end Bolum10
