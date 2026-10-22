/-
  Lean 4 ile Modern Mantık
  Bölüm 14 — Basit Tipli λ-Hesabı ve Curry–Howard

  Bu bölüm yalnızca Lean çekirdeğini ve Bölüm 10–11'i kullanır.
  İçerik:
    1. Tipsiz λ-terimleri (de Bruijn indisleri), kaydırma, yerine koyma
    2. β-indirgeme, Ω, normal biçimler, bir normalleştirici
    3. Church sayıları
    4. Basit tipler, tipleme bağıntısı, S-K-I
    5. Ω'nin tiplenemezliği, Church tarzı bir tip denetleyici
    6. Curry–Howard: tiplenebilir terim ↦ doğal çıkarım türetimi

  `-- ANCHOR: ad` / `-- ANCHOR_END: ad` satırları kitabın kaynağı
  tarafından okunur. Lütfen silmeyin.
-/
import ModernMantik.Bolum11

namespace Bolum14

/-! ## 14.1  λ-terimleri -/

-- ANCHOR: terim
-- de Bruijn indisleri: `var n`, kendisinden n tane λ dışarıdaki
-- bağlayıcıyı gösterir.  λx. λy. x  ↦  lam (lam (var 1))
inductive Terim where
  | var : Nat → Terim
  | lam : Terim → Terim
  | app : Terim → Terim → Terim
  deriving Repr, DecidableEq

open Terim

def I : Terim := lam (var 0)                          -- λx. x
def K : Terim := lam (lam (var 1))                    -- λx. λy. x
def S : Terim :=                                      -- λx. λy. λz. x z (y z)
  lam (lam (lam (app (app (var 2) (var 0)) (app (var 1) (var 0)))))
def oD : Terim := lam (app (var 0) (var 0))          -- λx. x x
def Omega : Terim := app oD oD                        -- (λx. x x)(λx. x x)
-- ANCHOR_END: terim

/-! ## 14.2  Kaydırma ve yerine koyma -/

-- ANCHOR: yerine
-- c'den büyük ya da eşit (serbest) indisleri d kadar artır:
def kaydir (d : Nat) : Nat → Terim → Terim
  | c, var n   => if n < c then var n else var (n + d)
  | c, lam t   => lam (kaydir d (c + 1) t)
  | c, app t u => app (kaydir d c t) (kaydir d c u)

-- t[k := s]:  k indisinin yerine s'yi koy; k'dan büyük indisleri
-- bir azalt (bir bağlayıcı ortadan kalktı).
def yerine (k : Nat) (s : Terim) : Terim → Terim
  | var n   => if n < k then var n
               else if n = k then kaydir k 0 s
               else var (n - 1)
  | lam t   => lam (yerine (k + 1) s t)
  | app t u => app (yerine k s t) (yerine k s u)
-- ANCHOR_END: yerine

-- ANCHOR: kaydir_sifir
theorem kaydir_sifir : ∀ (c : Nat) (t : Terim), kaydir 0 c t = t
  | c, var n   => by simp [kaydir]
  | c, lam t   => by simp [kaydir, kaydir_sifir (c + 1) t]
  | c, app t u => by simp [kaydir, kaydir_sifir c t, kaydir_sifir c u]
-- ANCHOR_END: kaydir_sifir

/-! ## 14.3  β-indirgeme -/

-- ANCHOR: adim
-- Tek adım β-indirgeme (terimin her yerinde):
inductive Adim : Terim → Terim → Prop where
  | beta   {t s}     : Adim (app (lam t) s) (yerine 0 s t)
  | solda  {t t' u}  : Adim t t' → Adim (app t u) (app t' u)
  | sagda  {t u u'}  : Adim u u' → Adim (app t u) (app t u')
  | icinde {t t'}    : Adim t t' → Adim (lam t) (lam t')

-- Sıfır ya da daha çok adım:
inductive Adimlar : Terim → Terim → Prop where
  | refl {t}     : Adimlar t t
  | adim {t u w} : Adim t u → Adimlar u w → Adimlar t w

-- Normal biçim: hiçbir adım atılamaz.
def Normal (t : Terim) : Prop := ∀ u, ¬ Adim t u
-- ANCHOR_END: adim

-- ANCHOR: ornek_adim
theorem I_adim (s : Terim) : Adim (app I s) s := by
  have h := @Adim.beta (var 0) s
  have e : yerine 0 s (var 0) = s := by simp [yerine, kaydir_sifir]
  rw [e] at h
  exact h

theorem lam_var_normal : Normal (lam (var 0)) := by
  intro u h
  cases h with
  | icinde h' => cases h'
-- ANCHOR_END: ornek_adim

-- ANCHOR: omega
-- Ω kendisine indirgenir…
theorem omega_adim : Adim Omega Omega := by
  have h := @Adim.beta (app (var 0) (var 0)) oD
  have e : yerine 0 oD (app (var 0) (var 0)) = Omega := by decide
  rw [e] at h
  exact h

-- …ve başka hiçbir şeye indirgenmez.
theorem omega_tek {t : Terim} (h : Adim Omega t) : t = Omega := by
  unfold Omega oD at h
  cases h with
  | beta => decide
  | solda h1 =>
    cases h1 with
    | icinde h2 =>
      cases h2 with
      | solda h3 => cases h3
      | sagda h3 => cases h3
  | sagda h1 =>
    cases h1 with
    | icinde h2 =>
      cases h2 with
      | solda h3 => cases h3
      | sagda h3 => cases h3

theorem omega_hep_omega : ∀ {t u : Terim}, Adimlar t u → t = Omega → u = Omega := by
  intro t u h
  induction h with
  | refl => intro e; exact e
  | adim h1 _ ih =>
    intro e
    subst e
    exact ih (omega_tek h1)

-- Ω'nin normal biçimi yoktur.
theorem omega_normallesmez : ¬ ∃ u, Adimlar Omega u ∧ Normal u := by
  intro ⟨u, h, hn⟩
  have e := omega_hep_omega h rfl
  subst e
  exact hn Omega omega_adim
-- ANCHOR_END: omega

/-! ## 14.4  Bir normalleştirici -/

-- ANCHOR: normallestir
-- Normal sıra: en soldaki, en dıştaki β-indirgenebilir ifade önce.
def adim? : Terim → Option Terim
  | app (lam t) s => some (yerine 0 s t)
  | app t u =>
    match adim? t with
    | some t' => some (app t' u)
    | none    => (adim? u).map (fun u' => app t u')
  | lam t => (adim? t).map lam
  | var _ => none

def normallestir : Nat → Terim → Terim
  | 0,     t => t
  | n + 1, t =>
    match adim? t with
    | some t' => normallestir n t'
    | none    => t

#eval normallestir 100 (app (app (app S K) K) (var 7))   -- Terim.var 7
#eval normallestir 100 (app (app S K) K) == I              -- true
-- ANCHOR_END: normallestir

/-! ## 14.5  Church sayıları -/

-- ANCHOR: church
-- n  ↦  λf. λx. f (f (… (f x)))
def tekrarla : Nat → Terim
  | 0     => var 0
  | n + 1 => app (var 1) (tekrarla n)

def church (n : Nat) : Terim := lam (lam (tekrarla n))

-- ardıl = λn. λf. λx. f (n f x)
def ardil : Terim :=
  lam (lam (lam (app (var 1) (app (app (var 2) (var 1)) (var 0)))))
-- topla = λm. λn. λf. λx. m f (n f x)
def topla : Terim :=
  lam (lam (lam (lam (app (app (var 3) (var 1))
                          (app (app (var 2) (var 1)) (var 0))))))
-- carp = λm. λn. λf. m (n f)
def carp : Terim :=
  lam (lam (lam (app (var 2) (app (var 1) (var 0)))))

#eval normallestir 1000 (app ardil (church 2)) == church 3                  -- true
#eval normallestir 1000 (app (app topla (church 2)) (church 3)) == church 5 -- true
#eval normallestir 1000 (app (app carp (church 2)) (church 3)) == church 6  -- true

example : normallestir 100 (app (app topla (church 1)) (church 1)) = church 2 := by
  decide
-- ANCHOR_END: church

/-! ## 14.6  Basit tipler -/

-- ANCHOR: tip
inductive Tip where
  | taban : Nat → Tip              -- temel tipler: α₀, α₁, …
  | ok    : Tip → Tip → Tip        -- A ⇒ B
  deriving Repr, DecidableEq

namespace Tip
scoped infixr:25 " ⇒ " => Tip.ok
end Tip

open Tip

-- de Bruijn bağlamında bir indisin tipi:
def bul : List Tip → Nat → Option Tip
  | [],     _     => none
  | A :: _, 0     => some A
  | _ :: Γ, n + 1 => bul Γ n

-- Γ ⊢ t : A   (Curry tarzı: terimlerde tip yazılmaz)
inductive Tiplenir : List Tip → Terim → Tip → Prop where
  | degisken  {Γ n A}     : bul Γ n = some A → Tiplenir Γ (var n) A
  | soyutlama {Γ t A B}   : Tiplenir (A :: Γ) t B → Tiplenir Γ (lam t) (A ⇒ B)
  | uygulama  {Γ t u A B} : Tiplenir Γ t (A ⇒ B) → Tiplenir Γ u A →
                              Tiplenir Γ (app t u) B
-- ANCHOR_END: tip

-- ANCHOR: ski_tip
theorem I_tip (A : Tip) : Tiplenir [] I (A ⇒ A) :=
  Tiplenir.soyutlama (Tiplenir.degisken rfl)

theorem K_tip (A B : Tip) : Tiplenir [] K (A ⇒ B ⇒ A) :=
  Tiplenir.soyutlama (Tiplenir.soyutlama (Tiplenir.degisken rfl))

theorem S_tip (A B C : Tip) :
    Tiplenir [] S ((A ⇒ B ⇒ C) ⇒ (A ⇒ B) ⇒ A ⇒ C) := by
  apply Tiplenir.soyutlama                    -- x : A ⇒ B ⇒ C
  apply Tiplenir.soyutlama                    -- y : A ⇒ B
  apply Tiplenir.soyutlama                    -- z : A
  apply Tiplenir.uygulama (A := B)            -- (x z) (y z)
  · apply Tiplenir.uygulama (A := A)          -- x z
    · exact Tiplenir.degisken rfl
    · exact Tiplenir.degisken rfl
  · apply Tiplenir.uygulama (A := A)          -- y z
    · exact Tiplenir.degisken rfl
    · exact Tiplenir.degisken rfl
-- ANCHOR_END: ski_tip

/-! ## 14.7  Ω tiplenemez -/

-- ANCHOR: omega_tip
-- Hiçbir tip kendisini içeren bir ok tipine eşit olamaz.
theorem ok_kendisi_degil : ∀ (A B : Tip), A ≠ (A ⇒ B)
  | taban _, _, h => by cases h
  | ok A₁ A₂, B, h => by
    injection h with h1 _
    exact ok_kendisi_degil A₁ A₂ h1

-- λx. x x hiçbir bağlamda, hiçbir tiple tiplenemez.
theorem oD_tiplenemez {Γ : List Tip} {A : Tip} : ¬ Tiplenir Γ oD A := by
  intro h
  unfold oD at h
  cases h with
  | soyutlama h1 =>
    cases h1 with
    | uygulama h2 h3 =>
      cases h2 with
      | degisken e2 =>
        cases h3 with
        | degisken e3 =>
          simp [bul] at e2 e3            -- e2 : A' = C ⇒ B',  e3 : A' = C
          subst e3
          exact ok_kendisi_degil _ _ e2
-- ANCHOR_END: omega_tip

/-! ## 14.8  Bir tip denetleyici (Church tarzı) -/

-- ANCHOR: denetleyici
-- Church tarzı terimler: her λ bağladığı değişkenin tipini taşır.
inductive TTerim where
  | var : Nat → TTerim
  | lam : Tip → TTerim → TTerim
  | app : TTerim → TTerim → TTerim

-- Tip bilgisini silmek:
def sil : TTerim → Terim
  | .var n   => .var n
  | .lam _ t => .lam (sil t)
  | .app t u => .app (sil t) (sil u)

-- Tip çıkarımı: Church tarzında her terimin en fazla bir tipi vardır.
def tipBul : List Tip → TTerim → Option Tip
  | Γ, .var n   => bul Γ n
  | Γ, .lam A t => (tipBul (A :: Γ) t).map (fun B => A ⇒ B)
  | Γ, .app t u =>
    match tipBul Γ t, tipBul Γ u with
    | some (.ok A B), some A' => if A = A' then some B else none
    | _, _ => none

#eval tipBul [] (.lam (taban 0) (.var 0))                       -- some (α₀ ⇒ α₀)
#eval tipBul [] (.lam (taban 0 ⇒ taban 0) (.app (.var 0) (.var 0)))  -- none
-- ANCHOR_END: denetleyici

-- ANCHOR: denetleyici_dogru
-- Denetleyici doğrudur: bulduğu tip, tipleme bağıntısında da geçerlidir.
theorem tipBul_dogru : ∀ (Γ : List Tip) (t : TTerim) (A : Tip),
    tipBul Γ t = some A → Tiplenir Γ (sil t) A
  | Γ, .var n, A, h => Tiplenir.degisken h
  | Γ, .lam B t, A, h => by
    cases e : tipBul (B :: Γ) t with
    | none => simp [tipBul, e] at h
    | some C =>
      simp [tipBul, e] at h                 -- h : B ⇒ C = A
      subst h
      exact Tiplenir.soyutlama (tipBul_dogru (B :: Γ) t C e)
  | Γ, .app t u, A, h => by
    cases e1 : tipBul Γ t with
    | none => simp [tipBul, e1] at h
    | some T =>
      cases e2 : tipBul Γ u with
      | none => simp [tipBul, e1, e2] at h
      | some A' =>
        cases T with
        | taban n => simp [tipBul, e1, e2] at h
        | ok A₁ B₁ =>
          by_cases hA : A₁ = A'
          · simp [tipBul, e1, e2, hA] at h  -- h : B₁ = A
            subst hA
            subst h
            exact Tiplenir.uygulama (tipBul_dogru Γ t _ e1) (tipBul_dogru Γ u _ e2)
          · simp [tipBul, e1, e2, hA] at h
-- ANCHOR_END: denetleyici_dogru

/-! ## 14.9  Curry–Howard -/

open Bolum10 Bolum11

-- ANCHOR: curry_howard
-- Tipler formüllerdir: taban tipler atomlar, ok tipi ise ⟹.
def tipFormul : Tip → Formul
  | taban n => Formul.atom n
  | ok A B  => Formul.ise (tipFormul A) (tipFormul B)

theorem bul_mem : ∀ {Γ : List Tip} {n : Nat} {A : Tip}, bul Γ n = some A → A ∈ Γ
  | [], _, _, h => by simp [bul] at h
  | B :: Γ, 0, A, h => by
    simp [bul] at h                         -- h : B = A
    rw [h]
    exact List.Mem.head _
  | B :: Γ, n + 1, A, h => List.Mem.tail _ (bul_mem (Γ := Γ) (n := n) h)

-- Curry–Howard: tiplenebilen her terim, tipinin bir doğal çıkarım
-- türetimidir. Değişken ↦ varsayım, λ ↦ ⟹G, uygulama ↦ ⟹E.
theorem curry_howard {Γ : List Tip} {t : Terim} {A : Tip} (h : Tiplenir Γ t A) :
    Turetilir (Γ.map tipFormul) (tipFormul A) := by
  induction h with
  | degisken e => exact Turetilir.varsayim (List.mem_map.2 ⟨_, bul_mem e, rfl⟩)
  | soyutlama _ ih => exact Turetilir.iseG ih
  | uygulama _ _ ih1 ih2 => exact Turetilir.iseE ih1 ih2
-- ANCHOR_END: curry_howard

-- ANCHOR: sonuclar
-- Kapalı bir terimin tipi, bir totolojiye karşılık gelir.
theorem kapali_tip_totoloji {t : Terim} {A : Tip} (h : Tiplenir [] t A) :
    Totoloji (tipFormul A) :=
  turetilir_totoloji (curry_howard h)

-- α₀ ⇒ α₁ tipinde kapalı bir terim yoktur.
theorem bos_tip : ¬ ∃ t, Tiplenir [] t (taban 0 ⇒ taban 1) := by
  intro ⟨t, h⟩
  have h1 := kapali_tip_totoloji h (fun n => n == 0)   -- α₀ doğru, α₁ yanlış
  have h2 : false = true := h1
  cases h2
-- ANCHOR_END: sonuclar

-- ANCHOR: sig_church
-- Karşılaştırma: Lean'in kendi λ-hesabında Church sayıları (sığ gömme).
def ChurchSayi : Type 1 := ∀ α : Type, (α → α) → α → α

def iki : ChurchSayi := fun _ f x => f (f x)
def uc  : ChurchSayi := fun _ f x => f (f (f x))
def toplaC (m n : ChurchSayi) : ChurchSayi := fun α f x => m α f (n α f x)

#eval toplaC iki uc Nat (· + 1) 0       -- 5
#eval iki String (· ++ "!") "merhaba"   -- "merhaba!!"
-- ANCHOR_END: sig_church

end Bolum14
