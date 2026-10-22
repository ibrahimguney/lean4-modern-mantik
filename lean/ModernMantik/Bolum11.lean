/-
  Lean 4 ile Modern Mantık
  Bölüm 11 — Geçerlilik Teoremi

  Bu bölüm yalnızca Lean çekirdeğini ve Bölüm 10'u kullanır.

  `-- ANCHOR: ad` / `-- ANCHOR_END: ad` satırları kitabın kaynağı
  tarafından okunur. Lütfen silmeyin.
-/
import ModernMantik.Bolum10

namespace Bolum11

open Bolum10 Bolum10.Formul

/-! ## 11.1  Klasik doğal çıkarım -/

-- ANCHOR: turetilir
-- Turetilir Γ A :  "A, Γ varsayımlarından türetilebilir"  (Γ ⊢ A)
inductive Turetilir : List Formul → Formul → Prop where
  | varsayim {Γ A}   : A ∈ Γ → Turetilir Γ A
  | veG     {Γ A B}  : Turetilir Γ A → Turetilir Γ B → Turetilir Γ (A ⋀ B)
  | veE1    {Γ A B}  : Turetilir Γ (A ⋀ B) → Turetilir Γ A
  | veE2    {Γ A B}  : Turetilir Γ (A ⋀ B) → Turetilir Γ B
  | veyaG1  {Γ A B}  : Turetilir Γ A → Turetilir Γ (A ⋁ B)
  | veyaG2  {Γ A B}  : Turetilir Γ B → Turetilir Γ (A ⋁ B)
  | veyaE   {Γ A B C} : Turetilir Γ (A ⋁ B) →
                Turetilir (A :: Γ) C → Turetilir (B :: Γ) C → Turetilir Γ C
  | iseG    {Γ A B}  : Turetilir (A :: Γ) B → Turetilir Γ (A ⟹ B)
  | iseE    {Γ A B}  : Turetilir Γ (A ⟹ B) → Turetilir Γ A → Turetilir Γ B
  | botE    {Γ A}    : Turetilir Γ bot → Turetilir Γ A
  | raa     {Γ A}    : Turetilir ((∼A) :: Γ) bot → Turetilir Γ A    -- klasik kural
-- ANCHOR_END: turetilir

/-! ## 11.2  Türetim örnekleri -/

-- ANCHOR: ornek_ozdeslik
theorem ozdeslik (A : Formul) : Turetilir [] (A ⟹ A) := by
  apply Turetilir.iseG            -- [A] ⊢ A göstermek yeter
  apply Turetilir.varsayim        -- A ∈ [A]
  exact List.Mem.head _
-- ANCHOR_END: ornek_ozdeslik

-- ANCHOR: ornek_peirce
theorem peirce_turetilir : Turetilir [] peirce := by
  apply Turetilir.iseG                         -- [(p⟹q)⟹p] ⊢ p
  apply Turetilir.raa                          -- [∼p, (p⟹q)⟹p] ⊢ ⊥
  apply Turetilir.iseE (A := p)
  · exact Turetilir.varsayim (by decide)       -- ∼p varsayımı
  · apply Turetilir.iseE (A := p ⟹ q)          -- p'yi (p⟹q)⟹p ile elde et
    · exact Turetilir.varsayim (by decide)
    · apply Turetilir.iseG                     -- [p, ∼p, …] ⊢ q
      apply Turetilir.botE                     -- çelişkiden her şey
      apply Turetilir.iseE (A := p)
      · exact Turetilir.varsayim (by decide)   -- ∼p
      · exact Turetilir.varsayim (by decide)   -- p
-- ANCHOR_END: ornek_peirce

/-! ## 11.3  Geçerlilik teoremi -/

-- ANCHOR: baglam_ekle
-- Yardımcı önsav: Bağlama doğru bir formül eklemek doğruluğu bozmaz.
theorem baglam_ekle {v : Degerleme} {Γ : List Formul} {A : Formul}
    (hA : deger v A = true) (hv : ∀ X ∈ Γ, deger v X = true) :
    ∀ X ∈ A :: Γ, deger v X = true := by
  intro X hX
  cases hX with
  | head => exact hA
  | tail _ hX' => exact hv X hX'
-- ANCHOR_END: baglam_ekle

-- ANCHOR: gecerlilik
theorem gecerlilik {Γ : List Formul} {A : Formul}
    (h : Turetilir Γ A) : Sonuc Γ A := by
  induction h with
  | @varsayim Γ A hA =>
    intro v hv
    exact hv A hA
  | @veG Γ A B _ _ ih1 ih2 =>
    intro v hv
    show (deger v A && deger v B) = true
    simp [ih1 v hv, ih2 v hv]
  | @veE1 Γ A B _ ih =>
    intro v hv
    have h1 : (deger v A && deger v B) = true := ih v hv
    simp at h1                                  -- h1 : deger v A = true ∧ …
    exact h1.1
  | @veE2 Γ A B _ ih =>
    intro v hv
    have h1 : (deger v A && deger v B) = true := ih v hv
    simp at h1
    exact h1.2
  | @veyaG1 Γ A B _ ih =>
    intro v hv
    show (deger v A || deger v B) = true
    simp [ih v hv]
  | @veyaG2 Γ A B _ ih =>
    intro v hv
    show (deger v A || deger v B) = true
    simp [ih v hv]
  | @veyaE Γ A B C _ _ _ ih1 ih2 ih3 =>
    intro v hv
    have h1 : (deger v A || deger v B) = true := ih1 v hv
    simp at h1                                  -- h1 : deger v A = true ∨ …
    cases h1 with
    | inl hA => exact ih2 v (baglam_ekle hA hv)
    | inr hB => exact ih3 v (baglam_ekle hB hv)
  | @iseG Γ A B _ ih =>
    intro v hv
    show (!deger v A || deger v B) = true
    cases hA : deger v A with
    | false => rfl                              -- öncül yanlışsa ⟹ doğrudur
    | true => simp [ih v (baglam_ekle hA hv)]
  | @iseE Γ A B _ _ ih1 ih2 =>
    intro v hv
    have h1 : (!deger v A || deger v B) = true := ih1 v hv
    have h2 : deger v A = true := ih2 v hv
    simpa [h2] using h1
  | @botE Γ A _ ih =>
    intro v hv
    have h1 : false = true := ih v hv           -- ⊥ hiçbir zaman doğru değil
    cases h1
  | @raa Γ A _ ih =>
    intro v hv
    cases hA : deger v A with
    | true => rfl
    | false =>                                  -- A yanlışsa ∼A doğrudur…
      have hn : deger v (∼A) = true := by
        show (!deger v A || false) = true
        simp [hA]
      have h1 : false = true := ih v (baglam_ekle hn hv)   -- …ve ⊥ doğru olurdu
      cases h1
-- ANCHOR_END: gecerlilik

/-! ## 11.4  Sonuçlar -/

-- ANCHOR: sonuclar
-- Türetilebilen her formül bir totolojidir.
theorem turetilir_totoloji {A : Formul} (h : Turetilir [] A) : Totoloji A :=
  fun v => gecerlilik h v (by intro X hX; cases hX)

-- Sistem tutarlıdır: ⊥ türetilemez.
theorem tutarlilik : ¬ Turetilir [] bot := by
  intro h
  have h1 : false = true := turetilir_totoloji h (fun _ => false)
  cases h1

-- Bir atom tek başına türetilemez.
theorem atom_turetilemez : ¬ Turetilir [] p := by
  intro h
  have h1 : false = true := turetilir_totoloji h (fun _ => false)
  cases h1
-- ANCHOR_END: sonuclar

/-! ## 11.5  Yapısal özellik: zayıflatma -/

-- ANCHOR: zayiflatma
theorem kapsam_ekle {Γ Δ : List Formul} (A : Formul)
    (hs : ∀ X, X ∈ Γ → X ∈ Δ) : ∀ X, X ∈ A :: Γ → X ∈ A :: Δ := by
  intro X hX
  cases hX with
  | head => exact List.Mem.head _
  | tail _ hX' => exact List.Mem.tail _ (hs X hX')

-- Daha büyük bir bağlamda da aynı formül türetilebilir.
theorem zayiflatma {Γ : List Formul} {A : Formul} (h : Turetilir Γ A)
    (Δ : List Formul) (hs : ∀ X, X ∈ Γ → X ∈ Δ) : Turetilir Δ A := by
  induction h generalizing Δ with
  | varsayim hA => exact .varsayim (hs _ hA)
  | veG _ _ ih1 ih2 => exact .veG (ih1 Δ hs) (ih2 Δ hs)
  | veE1 _ ih => exact .veE1 (ih Δ hs)
  | veE2 _ ih => exact .veE2 (ih Δ hs)
  | veyaG1 _ ih => exact .veyaG1 (ih Δ hs)
  | veyaG2 _ ih => exact .veyaG2 (ih Δ hs)
  | veyaE _ _ _ ih1 ih2 ih3 =>
    exact .veyaE (ih1 Δ hs) (ih2 _ (kapsam_ekle _ hs)) (ih3 _ (kapsam_ekle _ hs))
  | iseG _ ih => exact .iseG (ih _ (kapsam_ekle _ hs))
  | iseE _ _ ih1 ih2 => exact .iseE (ih1 Δ hs) (ih2 Δ hs)
  | botE _ ih => exact .botE (ih Δ hs)
  | raa _ ih => exact .raa (ih _ (kapsam_ekle _ hs))
-- ANCHOR_END: zayiflatma

end Bolum11
