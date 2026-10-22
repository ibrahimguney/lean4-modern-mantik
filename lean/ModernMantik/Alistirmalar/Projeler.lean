/-
  Lean 4 ile Modern Mantık — Cilt I
  Bölüm 17 — Projeler

  Her projenin hedef teoremi burada `sorry` ile verilmiştir. Bir proje,
  birkaç günden birkaç haftaya kadar sürebilecek, bağımsız bir
  formalizasyon çalışmasıdır. Önerilen adımlar kitabın 17. bölümündedir.

  Bu dosyadaki `sorry`'ler kasıtlıdır; CI bu dosyayı `sorry` denetiminden
  muaf tutar (Alistirmalar/ klasörü).

  `-- ANCHOR: ad` / `-- ANCHOR_END: ad` satırları kitabın kaynağı
  tarafından okunur. Lütfen silmeyin.
-/
import ModernMantik.Bolum13
import ModernMantik.Bolum14
import ModernMantik.Bolum15
import ModernMantik.Bolum16

namespace Projeler

/-! ## A. Karar yöntemleri ve yansıma -/

section A
open Bolum10 Bolum13

-- ANCHOR: p1
-- P1. Doğruluk tablosu yöntemi doğru ve tamdır.
theorem p1_dogru (A : Formul) : totolojiMi A = true → Totoloji A := by
  sorry

theorem p1_tam (A : Formul) : Totoloji A → totolojiMi A = true := by
  sorry
-- ANCHOR_END: p1

-- ANCHOR: p2
-- P2. Ardışık hesapta ispat arama doğrudur.
theorem p2_ara_dogru (n : Nat) (Γ Δ : List Formul) (P Q : List Nat) :
    ara n Γ Δ P Q = true →
      Ardisik (Γ ++ P.map Formul.atom) (Δ ++ Q.map Formul.atom) := by
  sorry
-- ANCHOR_END: p2
end A

section A3
open Bolum14 Bolum14.Terim

-- ANCHOR: p3
-- P3. Normalleştiricinin her adımı bir β-adımıdır.
theorem p3_adim_dogru (t u : Terim) : adim? t = some u → Adim t u := by
  sorry
-- ANCHOR_END: p3
end A3

/-! ## B. İspat kuramı -/

section B
open Bolum10 Bolum10.Formul Bolum11 Bolum13

-- ANCHOR: p4
-- P4. Yapıcı doğal çıkarım: Turetilir'in RAA'sız parçası.
inductive TuretilirY : List Formul → Formul → Prop where
  | varsayim {Γ A}    : A ∈ Γ → TuretilirY Γ A
  | veG     {Γ A B}   : TuretilirY Γ A → TuretilirY Γ B → TuretilirY Γ (A ⋀ B)
  | veE1    {Γ A B}   : TuretilirY Γ (A ⋀ B) → TuretilirY Γ A
  | veE2    {Γ A B}   : TuretilirY Γ (A ⋀ B) → TuretilirY Γ B
  | veyaG1  {Γ A B}   : TuretilirY Γ A → TuretilirY Γ (A ⋁ B)
  | veyaG2  {Γ A B}   : TuretilirY Γ B → TuretilirY Γ (A ⋁ B)
  | veyaE   {Γ A B C} : TuretilirY Γ (A ⋁ B) →
                TuretilirY (A :: Γ) C → TuretilirY (B :: Γ) C → TuretilirY Γ C
  | iseG    {Γ A B}   : TuretilirY (A :: Γ) B → TuretilirY Γ (A ⟹ B)
  | iseE    {Γ A B}   : TuretilirY Γ (A ⟹ B) → TuretilirY Γ A → TuretilirY Γ B
  | botE    {Γ A}     : TuretilirY Γ bot → TuretilirY Γ A

-- (a) Isınma: her yapıcı türetim, klasik bir türetimdir.
theorem p4_gomme {Γ : List Formul} {A : Formul} (h : TuretilirY Γ A) :
    Turetilir Γ A := by
  sorry

-- (b) Asıl hedef (Cilt II'ye köprü): Peirce yasası yapıcı olarak türetilemez.
theorem p4_peirce_yapici_degil : ¬ TuretilirY [] peirce := by
  sorry
-- ANCHOR_END: p4

-- ANCHOR: p5
-- P5. Gentzen'in Hauptsatz'ı, sözdizimsel olarak.
inductive ArdisikK : List Formul → List Formul → Prop where
  | ax    {Γ Δ n}   : atom n ∈ Γ → atom n ∈ Δ → ArdisikK Γ Δ
  | botL  {Γ Δ}     : bot ∈ Γ → ArdisikK Γ Δ
  | veL   {Γ Δ A B} : ArdisikK (A :: B :: Γ) Δ → ArdisikK ((A ⋀ B) :: Γ) Δ
  | veR   {Γ Δ A B} : ArdisikK Γ (A :: Δ) → ArdisikK Γ (B :: Δ) →
                        ArdisikK Γ ((A ⋀ B) :: Δ)
  | veyaL {Γ Δ A B} : ArdisikK (A :: Γ) Δ → ArdisikK (B :: Γ) Δ →
                        ArdisikK ((A ⋁ B) :: Γ) Δ
  | veyaR {Γ Δ A B} : ArdisikK Γ (A :: B :: Δ) → ArdisikK Γ ((A ⋁ B) :: Δ)
  | iseL  {Γ Δ A B} : ArdisikK Γ (A :: Δ) → ArdisikK (B :: Γ) Δ →
                        ArdisikK ((A ⟹ B) :: Γ) Δ
  | iseR  {Γ Δ A B} : ArdisikK (A :: Γ) (B :: Δ) → ArdisikK Γ ((A ⟹ B) :: Δ)
  | degis {Γ Γ' Δ Δ'} : ArdisikK Γ Δ →
                        (∀ X, X ∈ Γ → X ∈ Γ') → (∀ X, X ∈ Δ → X ∈ Δ') →
                        ArdisikK Γ' Δ'
  | kesme {Γ Δ A}   : ArdisikK Γ (A :: Δ) → ArdisikK (A :: Γ) Δ → ArdisikK Γ Δ

-- Hedef: bu teoremi ardisik_gecerli / ardisik_tam KULLANMADAN,
-- türetimleri dönüştürerek ispatlayın.
theorem p5_kesme_eleme {Γ Δ : List Formul} (h : ArdisikK Γ Δ) : Ardisik Γ Δ := by
  sorry
-- ANCHOR_END: p5

-- ANCHOR: p6
-- P6. Gentzen'in LJ'si: sağda en fazla bir formül.
inductive ArdisikJ : List Formul → Option Formul → Prop where
  | ax     {Γ n}     : atom n ∈ Γ → ArdisikJ Γ (some (atom n))
  | botL   {Γ C}     : bot ∈ Γ → ArdisikJ Γ C
  | veL    {Γ C A B} : ArdisikJ (A :: B :: Γ) C → ArdisikJ ((A ⋀ B) :: Γ) C
  | veR    {Γ A B}   : ArdisikJ Γ (some A) → ArdisikJ Γ (some B) →
                         ArdisikJ Γ (some (A ⋀ B))
  | veyaL  {Γ C A B} : ArdisikJ (A :: Γ) C → ArdisikJ (B :: Γ) C →
                         ArdisikJ ((A ⋁ B) :: Γ) C
  | veyaR1 {Γ A B}   : ArdisikJ Γ (some A) → ArdisikJ Γ (some (A ⋁ B))
  | veyaR2 {Γ A B}   : ArdisikJ Γ (some B) → ArdisikJ Γ (some (A ⋁ B))
  | iseL   {Γ C A B} : ArdisikJ ((A ⟹ B) :: Γ) (some A) → ArdisikJ (B :: Γ) C →
                         ArdisikJ ((A ⟹ B) :: Γ) C
  | iseR   {Γ A B}   : ArdisikJ (A :: Γ) (some B) → ArdisikJ Γ (some (A ⟹ B))
  | zayifR {Γ C}     : ArdisikJ Γ none → ArdisikJ Γ C
  | degis  {Γ Γ' C}  : ArdisikJ Γ C → (∀ X, X ∈ Γ → X ∈ Γ') → ArdisikJ Γ' C

-- Hedef: LJ ile yapıcı doğal çıkarım aynı şeyleri türetir.
theorem p6_LJ_dogal {Γ : List Formul} {A : Formul} :
    ArdisikJ Γ (some A) ↔ TuretilirY Γ A := by
  sorry
-- ANCHOR_END: p6
end B

/-! ## C. λ-hesabı -/

section C
open Bolum14 Bolum14.Terim Bolum14.Tip

-- ANCHOR: p7
-- P7. Tip korunumu (subject reduction).
theorem p7_tip_korunumu {Γ : List Tip} {t u : Terim} {A : Tip}
    (h : Tiplenir Γ t A) (s : Adim t u) : Tiplenir Γ u A := by
  sorry
-- ANCHOR_END: p7

-- ANCHOR: p8
-- P8. Church–Rosser teoremi (birleşebilirlik).
theorem p8_church_rosser {t u₁ u₂ : Terim}
    (h1 : Adimlar t u₁) (h2 : Adimlar t u₂) :
    ∃ w, Adimlar u₁ w ∧ Adimlar u₂ w := by
  sorry
-- ANCHOR_END: p8

-- ANCHOR: p9
-- P9. Güçlü normalleşme (Tait).
inductive GucluNormal : Terim → Prop where
  | giris {t} : (∀ u, Adim t u → GucluNormal u) → GucluNormal t

-- Isınma: Ω güçlü normalleşmez.
theorem p9_omega : ¬ GucluNormal Omega := by
  sorry

theorem p9_guclu_normallesme {Γ : List Tip} {t : Terim} {A : Tip}
    (h : Tiplenir Γ t A) : GucluNormal t := by
  sorry
-- ANCHOR_END: p9
end C

/-! ## D. Bağımlı tipler ve bölümler -/

section D
open Bolum15 Bolum15.Vek

-- ANCHOR: p10
-- P10. Biriktiricili ters çevirme.
def p10_tersAux {α : Type} {m n : Nat} : Vek α m → Vek α n → Vek α (m + n) :=
  sorry

theorem p10_dogru {α : Type} {m : Nat} (v : Vek α m) :
    (p10_tersAux v Vek.bos).toList = v.toList.reverse := by
  sorry
-- ANCHOR_END: p10
end D

section D2
open Bolum16

-- ANCHOR: p11
-- P11. Tamsayılar bir değişmeli halkadır.
def p11_carp : Tamsayi → Tamsayi → Tamsayi :=
  sorry

theorem p11_dagilma (x y z : Tamsayi) :
    p11_carp x (y + z) = p11_carp x y + p11_carp x z := by
  sorry
-- ANCHOR_END: p11
end D2

section D3
open Bolum10 Bolum11

-- ANCHOR: p12
-- P12. Yapıcı model varlığı: Classical kullanmadan.
def p12_modelBul (Γ : List Formul) : Option Degerleme :=
  sorry

theorem p12_dogru (Γ : List Formul) (v : Degerleme) :
    p12_modelBul Γ = some v → ∀ B ∈ Γ, deger v B = true := by
  sorry

theorem p12_tam (Γ : List Formul) :
    p12_modelBul Γ = none → Turetilir Γ Formul.bot := by
  sorry
-- ANCHOR_END: p12
end D3

end Projeler
