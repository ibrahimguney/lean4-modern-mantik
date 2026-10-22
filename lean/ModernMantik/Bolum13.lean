/-
  Lean 4 ile Modern Mantık
  Bölüm 13 — Ardışık Hesap ve Kesme Eleme

  Bu bölüm yalnızca Lean çekirdeğini ve Bölüm 10–12'yi kullanır.
  İçerik:
    1. Kesmesiz klasik ardışık hesap (G3 tarzı, çok sonuçlu)
    2. Geçerlilik
    3. Tersinirlik önsavları ve kesmesiz tamlık (ispat arama)
    4. Kesme kuralının elenebilirliği (anlambilimsel yoldan)
    5. Doğal çıkarım ile denklik

  `-- ANCHOR: ad` / `-- ANCHOR_END: ad` satırları kitabın kaynağı
  tarafından okunur. Lütfen silmeyin.
-/
import ModernMantik.Bolum12

namespace Bolum13

open Bolum10 Bolum10.Formul Bolum11 Bolum12

/-! ## 13.2  Kesmesiz ardışık hesap -/

-- ANCHOR: ardisik
-- Ardisik Γ Δ :  Γ ⇒ Δ   ("Γ'nin hepsi doğruysa Δ'dan biri doğrudur")
inductive Ardisik : List Formul → List Formul → Prop where
  | ax    {Γ Δ n}   : atom n ∈ Γ → atom n ∈ Δ → Ardisik Γ Δ
  | botL  {Γ Δ}     : bot ∈ Γ → Ardisik Γ Δ
  | veL   {Γ Δ A B} : Ardisik (A :: B :: Γ) Δ → Ardisik ((A ⋀ B) :: Γ) Δ
  | veR   {Γ Δ A B} : Ardisik Γ (A :: Δ) → Ardisik Γ (B :: Δ) →
                        Ardisik Γ ((A ⋀ B) :: Δ)
  | veyaL {Γ Δ A B} : Ardisik (A :: Γ) Δ → Ardisik (B :: Γ) Δ →
                        Ardisik ((A ⋁ B) :: Γ) Δ
  | veyaR {Γ Δ A B} : Ardisik Γ (A :: B :: Δ) → Ardisik Γ ((A ⋁ B) :: Δ)
  | iseL  {Γ Δ A B} : Ardisik Γ (A :: Δ) → Ardisik (B :: Γ) Δ →
                        Ardisik ((A ⟹ B) :: Γ) Δ
  | iseR  {Γ Δ A B} : Ardisik (A :: Γ) (B :: Δ) → Ardisik Γ ((A ⟹ B) :: Δ)
  -- yapısal kural: zayıflatma + değiştirme + daraltma bir arada
  | degis {Γ Γ' Δ Δ'} : Ardisik Γ Δ →
                        (∀ X, X ∈ Γ → X ∈ Γ') → (∀ X, X ∈ Δ → X ∈ Δ') →
                        Ardisik Γ' Δ'
-- ANCHOR_END: ardisik

-- ANCHOR: ornekler
-- Peirce yasası: çok sonuçlu ardışıklarda klasik mantık "kendiliğinden" gelir.
theorem peirce_ardisik : Ardisik [] [peirce] := by
  apply Ardisik.iseR                     -- (p ⟹ q) ⟹ p  ⇒  p
  apply Ardisik.iseL                     -- iki öncül
  · apply Ardisik.iseR                   -- p  ⇒  q, p
    exact Ardisik.ax (n := 0) (by decide) (by decide)
  · exact Ardisik.ax (n := 0) (by decide) (by decide)     -- p  ⇒  p

-- Üçüncü hâl: sağda iki formül birden durabilir.
theorem ucuncu_hal_ardisik : Ardisik [] [p ⋁ ∼p] := by
  apply Ardisik.veyaR                    -- ⇒ p, ∼p
  apply Ardisik.degis (Γ := []) (Δ := [∼p, p])
  · apply Ardisik.iseR                   -- p ⇒ ⊥, p
    exact Ardisik.ax (n := 0) (by decide) (by decide)
  · intro X hX; cases hX
  · intro X hX
    cases hX with
    | head => exact List.Mem.tail _ (List.Mem.head _)
    | tail _ h =>
      cases h with
      | head => exact List.Mem.head _
      | tail _ h' => cases h'
-- ANCHOR_END: ornekler

/-! ## 13.3  Anlambilim ve geçerlilik -/

-- ANCHOR: gecerli_tanim
abbrev HepsiDogru (v : Degerleme) (Γ : List Formul) : Prop :=
  ∀ X ∈ Γ, deger v X = true

abbrev BiriDogru (v : Degerleme) (Δ : List Formul) : Prop :=
  ∃ Y ∈ Δ, deger v Y = true

-- Γ ⇒ Δ geçerlidir: Γ'yi doğrulayan her değerleme Δ'dan birini doğrular.
def Gecerli (Γ Δ : List Formul) : Prop :=
  ∀ v : Degerleme, HepsiDogru v Γ → BiriDogru v Δ
-- ANCHOR_END: gecerli_tanim

-- ANCHOR: liste_onsavlari
theorem hepsi_cons {v : Degerleme} {A : Formul} {Γ : List Formul} :
    HepsiDogru v (A :: Γ) ↔ deger v A = true ∧ HepsiDogru v Γ := by
  constructor
  · intro h
    exact ⟨h A (List.Mem.head _), fun X hX => h X (List.Mem.tail _ hX)⟩
  · intro h X hX
    cases hX with
    | head => exact h.1
    | tail _ hX' => exact h.2 X hX'

theorem biri_cons {v : Degerleme} {A : Formul} {Δ : List Formul} :
    BiriDogru v (A :: Δ) ↔ deger v A = true ∨ BiriDogru v Δ := by
  constructor
  · intro h
    obtain ⟨Y, hY, hv⟩ := h
    cases hY with
    | head => exact Or.inl hv
    | tail _ hY' => exact Or.inr ⟨Y, hY', hv⟩
  · intro h
    cases h with
    | inl hA => exact ⟨A, List.Mem.head _, hA⟩
    | inr h' =>
      obtain ⟨Y, hY, hv⟩ := h'
      exact ⟨Y, List.Mem.tail _ hY, hv⟩

theorem gecerli_mono {Γ Γ' Δ Δ' : List Formul} (h : Gecerli Γ Δ)
    (hΓ : ∀ X, X ∈ Γ → X ∈ Γ') (hΔ : ∀ X, X ∈ Δ → X ∈ Δ') :
    Gecerli Γ' Δ' := by
  intro v hv
  obtain ⟨Y, hY, hYv⟩ := h v (fun X hX => hv X (hΓ X hX))
  exact ⟨Y, hΔ Y hY, hYv⟩
-- ANCHOR_END: liste_onsavlari

-- ANCHOR: ardisik_gecerli
theorem ardisik_gecerli {Γ Δ : List Formul} (h : Ardisik Γ Δ) : Gecerli Γ Δ := by
  induction h with
  | ax h1 h2 =>
    intro v hv
    exact ⟨_, h2, hv _ h1⟩
  | botL h1 =>
    intro v hv
    have hb : false = true := hv _ h1
    cases hb
  | @veL Γ Δ A B _ ih =>
    intro v hv
    rw [hepsi_cons] at hv
    have hAB : (deger v A && deger v B) = true := hv.1
    simp at hAB
    exact ih v (hepsi_cons.2 ⟨hAB.1, hepsi_cons.2 ⟨hAB.2, hv.2⟩⟩)
  | @veR Γ Δ A B _ _ ih1 ih2 =>
    intro v hv
    have h1 := ih1 v hv
    have h2 := ih2 v hv
    rw [biri_cons] at h1 h2 ⊢
    cases h1 with
    | inr h => exact Or.inr h
    | inl hA =>
      cases h2 with
      | inr h => exact Or.inr h
      | inl hB =>
        left
        show (deger v A && deger v B) = true
        simp [hA, hB]
  | @veyaL Γ Δ A B _ _ ih1 ih2 =>
    intro v hv
    rw [hepsi_cons] at hv
    have hAB : (deger v A || deger v B) = true := hv.1
    simp at hAB
    cases hAB with
    | inl hA => exact ih1 v (hepsi_cons.2 ⟨hA, hv.2⟩)
    | inr hB => exact ih2 v (hepsi_cons.2 ⟨hB, hv.2⟩)
  | @veyaR Γ Δ A B _ ih =>
    intro v hv
    have h1 := ih v hv
    rw [biri_cons, biri_cons] at h1
    rw [biri_cons]
    cases h1 with
    | inl hA =>
      left
      show (deger v A || deger v B) = true
      simp [hA]
    | inr h1 =>
      cases h1 with
      | inl hB =>
        left
        show (deger v A || deger v B) = true
        simp [hB]
      | inr hR => exact Or.inr hR
  | @iseL Γ Δ A B _ _ ih1 ih2 =>
    intro v hv
    rw [hepsi_cons] at hv
    have hi : (!deger v A || deger v B) = true := hv.1
    cases hA : deger v A with
    | false =>
      have h1 := ih1 v hv.2
      rw [biri_cons, hA] at h1
      cases h1 with
      | inl h => cases h
      | inr h => exact h
    | true =>
      rw [hA] at hi
      simp at hi
      exact ih2 v (hepsi_cons.2 ⟨hi, hv.2⟩)
  | @iseR Γ Δ A B _ ih =>
    intro v hv
    rw [biri_cons]
    cases hA : deger v A with
    | false =>
      left
      show (!deger v A || deger v B) = true
      simp [hA]
    | true =>
      have h1 := ih v (hepsi_cons.2 ⟨hA, hv⟩)
      rw [biri_cons] at h1
      cases h1 with
      | inl hB =>
        left
        show (!deger v A || deger v B) = true
        simp [hA, hB]
      | inr hR => exact Or.inr hR
  | degis _ hΓ hΔ ih => exact gecerli_mono ih hΓ hΔ

-- Boş ardışık  [] ⇒ []  türetilemez: sistem tutarlıdır.
theorem bos_ardisik_yok : ¬ Ardisik [] [] := by
  intro h
  obtain ⟨Y, hY, _⟩ := ardisik_gecerli h (fun _ => false) (by intro X hX; cases hX)
  cases hY
-- ANCHOR_END: ardisik_gecerli

/-! ## 13.4  Tersinirlik -/

-- ANCHOR: tersinirlik
-- Her kural tersinirdir: sonuç geçerliyse öncüller de geçerlidir.
theorem ters_veL {Γ Δ : List Formul} {A B : Formul}
    (h : Gecerli ((A ⋀ B) :: Γ) Δ) : Gecerli (A :: B :: Γ) Δ := by
  intro v hv
  rw [hepsi_cons, hepsi_cons] at hv
  apply h v
  rw [hepsi_cons]
  refine ⟨?_, hv.2.2⟩
  show (deger v A && deger v B) = true
  simp [hv.1, hv.2.1]

theorem ters_veR1 {Γ Δ : List Formul} {A B : Formul}
    (h : Gecerli Γ ((A ⋀ B) :: Δ)) : Gecerli Γ (A :: Δ) := by
  intro v hv
  have h1 := h v hv
  rw [biri_cons] at h1 ⊢
  cases h1 with
  | inl hAB =>
    have hAB' : (deger v A && deger v B) = true := hAB
    simp at hAB'
    exact Or.inl hAB'.1
  | inr hR => exact Or.inr hR

theorem ters_veR2 {Γ Δ : List Formul} {A B : Formul}
    (h : Gecerli Γ ((A ⋀ B) :: Δ)) : Gecerli Γ (B :: Δ) := by
  intro v hv
  have h1 := h v hv
  rw [biri_cons] at h1 ⊢
  cases h1 with
  | inl hAB =>
    have hAB' : (deger v A && deger v B) = true := hAB
    simp at hAB'
    exact Or.inl hAB'.2
  | inr hR => exact Or.inr hR

theorem ters_veyaL1 {Γ Δ : List Formul} {A B : Formul}
    (h : Gecerli ((A ⋁ B) :: Γ) Δ) : Gecerli (A :: Γ) Δ := by
  intro v hv
  rw [hepsi_cons] at hv
  apply h v
  rw [hepsi_cons]
  refine ⟨?_, hv.2⟩
  show (deger v A || deger v B) = true
  simp [hv.1]

theorem ters_veyaL2 {Γ Δ : List Formul} {A B : Formul}
    (h : Gecerli ((A ⋁ B) :: Γ) Δ) : Gecerli (B :: Γ) Δ := by
  intro v hv
  rw [hepsi_cons] at hv
  apply h v
  rw [hepsi_cons]
  refine ⟨?_, hv.2⟩
  show (deger v A || deger v B) = true
  simp [hv.1]

theorem ters_veyaR {Γ Δ : List Formul} {A B : Formul}
    (h : Gecerli Γ ((A ⋁ B) :: Δ)) : Gecerli Γ (A :: B :: Δ) := by
  intro v hv
  have h1 := h v hv
  rw [biri_cons] at h1
  rw [biri_cons, biri_cons]
  cases h1 with
  | inl hAB =>
    have hAB' : (deger v A || deger v B) = true := hAB
    simp at hAB'
    cases hAB' with
    | inl hA => exact Or.inl hA
    | inr hB => exact Or.inr (Or.inl hB)
  | inr hR => exact Or.inr (Or.inr hR)

theorem ters_iseL1 {Γ Δ : List Formul} {A B : Formul}
    (h : Gecerli ((A ⟹ B) :: Γ) Δ) : Gecerli Γ (A :: Δ) := by
  intro v hv
  rw [biri_cons]
  cases hA : deger v A with
  | true => exact Or.inl rfl
  | false =>
    right
    apply h v
    rw [hepsi_cons]
    refine ⟨?_, hv⟩
    show (!deger v A || deger v B) = true
    simp [hA]

theorem ters_iseL2 {Γ Δ : List Formul} {A B : Formul}
    (h : Gecerli ((A ⟹ B) :: Γ) Δ) : Gecerli (B :: Γ) Δ := by
  intro v hv
  rw [hepsi_cons] at hv
  apply h v
  rw [hepsi_cons]
  refine ⟨?_, hv.2⟩
  show (!deger v A || deger v B) = true
  simp [hv.1]

theorem ters_iseR {Γ Δ : List Formul} {A B : Formul}
    (h : Gecerli Γ ((A ⟹ B) :: Δ)) : Gecerli (A :: Γ) (B :: Δ) := by
  intro v hv
  rw [hepsi_cons] at hv
  have h1 := h v hv.2
  rw [biri_cons] at h1 ⊢
  cases h1 with
  | inl hAB =>
    have hAB' : (!deger v A || deger v B) = true := hAB
    left
    simpa [hv.1] using hAB'
  | inr hR => exact Or.inr hR

-- Sağdaki ⊥ hiçbir zaman doğru değildir; atılabilir.
theorem ters_botR {Γ Δ : List Formul}
    (h : Gecerli Γ (bot :: Δ)) : Gecerli Γ Δ := by
  intro v hv
  have h1 := h v hv
  rw [biri_cons] at h1
  cases h1 with
  | inl hb =>
    have hb' : false = true := hb
    cases hb'
  | inr h => exact h
-- ANCHOR_END: tersinirlik

/-! ## 13.5  Kesmesiz tamlık: ispat arama -/

-- ANCHOR: olcu
-- Bir ardışığın "ağırlığı": her bağlaç 2, her formül 1 sayılır.
def olcu : List Formul → Nat
  | []     => 0
  | A :: Γ => 2 * boyut A + 1 + olcu Γ
-- ANCHOR_END: olcu

-- ANCHOR: tasi
-- Bir formülü listenin başından, atom bölümünün başına taşımak:
theorem tasi1 {X a : Formul} {L M : List Formul}
    (h : X ∈ a :: (L ++ M)) : X ∈ L ++ a :: M := by
  cases h with
  | head => exact List.mem_append_right L (List.Mem.head _)
  | tail _ h' =>
    rcases List.mem_append.1 h' with h1 | h1
    · exact List.mem_append_left _ h1
    · exact List.mem_append_right L (List.Mem.tail _ h1)

theorem tasi2 {X a : Formul} {L M : List Formul}
    (h : X ∈ L ++ a :: M) : X ∈ a :: (L ++ M) := by
  rcases List.mem_append.1 h with h1 | h1
  · exact List.Mem.tail _ (List.mem_append_left _ h1)
  · cases h1 with
    | head => exact List.Mem.head _
    | tail _ h2 => exact List.Mem.tail _ (List.mem_append_right L h2)
-- ANCHOR_END: tasi

-- ANCHOR: atomik
-- Yalnızca atomlardan oluşan bir ardışık için karşı model:
def karsiModel (P : List Nat) : Degerleme := fun n => decide (n ∈ P)

theorem atomik (P Q : List Nat)
    (hg : Gecerli ([] ++ P.map atom) ([] ++ Q.map atom)) :
    Ardisik ([] ++ P.map atom) ([] ++ Q.map atom) := by
  have hg' : Gecerli (P.map atom) (Q.map atom) := hg
  show Ardisik (P.map atom) (Q.map atom)
  -- Sol taraftaki atomları doğru, gerisini yanlış yapan değerleme:
  have hsol : HepsiDogru (karsiModel P) (P.map atom) := by
    intro X hX
    obtain ⟨n, hn, hX'⟩ := List.mem_map.1 hX
    rw [← hX']
    show decide (n ∈ P) = true
    simp [hn]
  obtain ⟨Y, hY, hYv⟩ := hg' (karsiModel P) hsol
  obtain ⟨m, hm, hY'⟩ := List.mem_map.1 hY
  rw [← hY'] at hYv
  have hmP : decide (m ∈ P) = true := hYv
  simp at hmP                                -- hmP : m ∈ P
  -- Ortak atom bulundu: aksiyom.
  exact Ardisik.ax (n := m) (List.mem_map.2 ⟨m, hmP, rfl⟩)
                            (List.mem_map.2 ⟨m, hm, rfl⟩)
-- ANCHOR_END: atomik

-- ANCHOR: tam_aux
-- İspat arama, bir tamlık ispatı olarak.
-- Γ, Δ : henüz işlenmemiş formüller;  P, Q : kenara alınmış atomlar.
theorem tam_aux : ∀ (n : Nat) (Γ Δ : List Formul) (P Q : List Nat),
    olcu Γ + olcu Δ < n →
    Gecerli (Γ ++ P.map atom) (Δ ++ Q.map atom) →
    Ardisik (Γ ++ P.map atom) (Δ ++ Q.map atom)
  | 0, _, _, _, _, hn, _ => absurd hn (Nat.not_lt_zero _)
  -- (1) Her şey atomik:
  | _ + 1, [], [], P, Q, _, hg => atomik P Q hg
  -- (2) Soldaki ilk formülü işle:
  | n + 1, Formul.atom k :: Γ, Δ, P, Q, hn, hg => by
    have hn' : olcu Γ + olcu Δ < n := by
      simp only [olcu, boyut] at hn; omega
    have hg' : Gecerli (Γ ++ (k :: P).map atom) (Δ ++ Q.map atom) :=
      gecerli_mono hg (fun X hX => tasi1 hX) (fun X hX => hX)
    exact Ardisik.degis (tam_aux n Γ Δ (k :: P) Q hn' hg')
      (fun X hX => tasi2 hX) (fun X hX => hX)
  | n + 1, Formul.bot :: Γ, Δ, P, Q, _, _ => by
    exact Ardisik.botL (List.Mem.head _)
  | n + 1, Formul.ve A B :: Γ, Δ, P, Q, hn, hg => by
    have hn' : olcu (A :: B :: Γ) + olcu Δ < n := by
      simp only [olcu, boyut] at hn ⊢; omega
    have hg' : Gecerli ((A :: B :: Γ) ++ P.map atom) (Δ ++ Q.map atom) :=
      ters_veL hg
    exact Ardisik.veL (tam_aux n _ Δ P Q hn' hg')
  | n + 1, Formul.veya A B :: Γ, Δ, P, Q, hn, hg => by
    have h1 : olcu (A :: Γ) + olcu Δ < n := by
      simp only [olcu, boyut] at hn ⊢; omega
    have h2 : olcu (B :: Γ) + olcu Δ < n := by
      simp only [olcu, boyut] at hn ⊢; omega
    have g1 : Gecerli ((A :: Γ) ++ P.map atom) (Δ ++ Q.map atom) := ters_veyaL1 hg
    have g2 : Gecerli ((B :: Γ) ++ P.map atom) (Δ ++ Q.map atom) := ters_veyaL2 hg
    exact Ardisik.veyaL (tam_aux n _ Δ P Q h1 g1) (tam_aux n _ Δ P Q h2 g2)
  | n + 1, Formul.ise A B :: Γ, Δ, P, Q, hn, hg => by
    have h1 : olcu Γ + olcu (A :: Δ) < n := by
      simp only [olcu, boyut] at hn ⊢; omega
    have h2 : olcu (B :: Γ) + olcu Δ < n := by
      simp only [olcu, boyut] at hn ⊢; omega
    have g1 : Gecerli (Γ ++ P.map atom) ((A :: Δ) ++ Q.map atom) := ters_iseL1 hg
    have g2 : Gecerli ((B :: Γ) ++ P.map atom) (Δ ++ Q.map atom) := ters_iseL2 hg
    exact Ardisik.iseL (tam_aux n Γ _ P Q h1 g1) (tam_aux n _ Δ P Q h2 g2)
  -- (3) Sol boşaldı; sağdaki ilk formülü işle:
  | n + 1, [], Formul.atom k :: Δ, P, Q, hn, hg => by
    have hn' : olcu [] + olcu Δ < n := by
      simp only [olcu, boyut] at hn ⊢; omega
    have hg' : Gecerli ([] ++ P.map atom) (Δ ++ (k :: Q).map atom) :=
      gecerli_mono hg (fun X hX => hX) (fun X hX => tasi1 hX)
    exact Ardisik.degis (tam_aux n [] Δ P (k :: Q) hn' hg')
      (fun X hX => hX) (fun X hX => tasi2 hX)
  | n + 1, [], Formul.bot :: Δ, P, Q, hn, hg => by
    have hn' : olcu [] + olcu Δ < n := by
      simp only [olcu, boyut] at hn ⊢; omega
    have hg' : Gecerli ([] ++ P.map atom) (Δ ++ Q.map atom) := ters_botR hg
    exact Ardisik.degis (tam_aux n [] Δ P Q hn' hg')
      (fun X hX => hX) (fun X hX => List.Mem.tail _ hX)
  | n + 1, [], Formul.ve A B :: Δ, P, Q, hn, hg => by
    have h1 : olcu [] + olcu (A :: Δ) < n := by
      simp only [olcu, boyut] at hn ⊢; omega
    have h2 : olcu [] + olcu (B :: Δ) < n := by
      simp only [olcu, boyut] at hn ⊢; omega
    have g1 : Gecerli ([] ++ P.map atom) ((A :: Δ) ++ Q.map atom) := ters_veR1 hg
    have g2 : Gecerli ([] ++ P.map atom) ((B :: Δ) ++ Q.map atom) := ters_veR2 hg
    exact Ardisik.veR (tam_aux n [] _ P Q h1 g1) (tam_aux n [] _ P Q h2 g2)
  | n + 1, [], Formul.veya A B :: Δ, P, Q, hn, hg => by
    have hn' : olcu [] + olcu (A :: B :: Δ) < n := by
      simp only [olcu, boyut] at hn ⊢; omega
    have hg' : Gecerli ([] ++ P.map atom) ((A :: B :: Δ) ++ Q.map atom) :=
      ters_veyaR hg
    exact Ardisik.veyaR (tam_aux n [] _ P Q hn' hg')
  | n + 1, [], Formul.ise A B :: Δ, P, Q, hn, hg => by
    have hn' : olcu [A] + olcu (B :: Δ) < n := by
      simp only [olcu, boyut] at hn ⊢; omega
    have hg' : Gecerli ([A] ++ P.map atom) ((B :: Δ) ++ Q.map atom) :=
      ters_iseR hg
    exact Ardisik.iseR (tam_aux n [A] _ P Q hn' hg')
-- ANCHOR_END: tam_aux

-- ANCHOR: ardisik_tam
-- Kesmesiz tamlık:  Γ ⇒ Δ geçerliyse, kesmesiz olarak türetilebilir.
theorem ardisik_tam {Γ Δ : List Formul} (h : Gecerli Γ Δ) : Ardisik Γ Δ := by
  have e1 : Γ ++ ([] : List Nat).map atom = Γ := List.append_nil Γ
  have e2 : Δ ++ ([] : List Nat).map atom = Δ := List.append_nil Δ
  have h' : Gecerli (Γ ++ ([] : List Nat).map atom)
                   (Δ ++ ([] : List Nat).map atom) := by
    rw [e1, e2]; exact h
  have t := tam_aux (olcu Γ + olcu Δ + 1) Γ Δ [] [] (by omega) h'
  rw [e1, e2] at t
  exact t
-- ANCHOR_END: ardisik_tam

/-! ## 13.6  Kesme kuralı -/

-- ANCHOR: kesme
-- Kesme elenebilir: sisteme eklemek, türetilebilenleri değiştirmez.
theorem kesme {Γ Δ : List Formul} {A : Formul}
    (h1 : Ardisik Γ (A :: Δ)) (h2 : Ardisik (A :: Γ) Δ) : Ardisik Γ Δ := by
  apply ardisik_tam
  intro v hv
  have k1 := ardisik_gecerli h1 v hv
  rw [biri_cons] at k1
  cases k1 with
  | inl hA => exact ardisik_gecerli h2 v (hepsi_cons.2 ⟨hA, hv⟩)
  | inr h => exact h
-- ANCHOR_END: kesme

/-! ## 13.7  Doğal çıkarım ile denklik -/

-- ANCHOR: denklik
theorem gecerli_tek {Γ : List Formul} {A : Formul} :
    Gecerli Γ [A] ↔ Sonuc Γ A := by
  constructor
  · intro h v hv
    obtain ⟨Y, hY, hYv⟩ := h v hv
    cases hY with
    | head => exact hYv
    | tail _ hY' => cases hY'
  · intro h v hv
    exact ⟨A, List.Mem.head _, h v hv⟩

-- Doğal çıkarım ile (kesmesiz) ardışık hesap aynı şeyleri türetir.
theorem dogal_ardisik {Γ : List Formul} {A : Formul} :
    Turetilir Γ A ↔ Ardisik Γ [A] :=
  ⟨fun h => ardisik_tam (gecerli_tek.2 (gecerlilik h)),
   fun h => tamlik (gecerli_tek.1 (ardisik_gecerli h))⟩
-- ANCHOR_END: denklik

/-! ## 13.8  Çalıştırılabilir ispat arama -/

-- ANCHOR: ara
-- tam_aux'un hesaplanabilir ikizi: türetim ağacını kurmak yerine
-- yalnızca "var mı?" sorusunu cevaplar.
def ara : Nat → List Formul → List Formul → List Nat → List Nat → Bool
  | 0, _, _, _, _ => false
  -- her şey atomik: ortak atom var mı?
  | _ + 1, [], [], P, Q => P.any (fun k => Q.contains k)
  -- soldaki ilk formül
  | n + 1, Formul.atom k :: Γ, Δ, P, Q => ara n Γ Δ (k :: P) Q
  | _ + 1, Formul.bot :: _, _, _, _ => true
  | n + 1, Formul.ve A B :: Γ, Δ, P, Q => ara n (A :: B :: Γ) Δ P Q
  | n + 1, Formul.veya A B :: Γ, Δ, P, Q =>
      ara n (A :: Γ) Δ P Q && ara n (B :: Γ) Δ P Q
  | n + 1, Formul.ise A B :: Γ, Δ, P, Q =>
      ara n Γ (A :: Δ) P Q && ara n (B :: Γ) Δ P Q
  -- sol boş: sağdaki ilk formül
  | n + 1, [], Formul.atom k :: Δ, P, Q => ara n [] Δ P (k :: Q)
  | n + 1, [], Formul.bot :: Δ, P, Q => ara n [] Δ P Q
  | n + 1, [], Formul.ve A B :: Δ, P, Q =>
      ara n [] (A :: Δ) P Q && ara n [] (B :: Δ) P Q
  | n + 1, [], Formul.veya A B :: Δ, P, Q => ara n [] (A :: B :: Δ) P Q
  | n + 1, [], Formul.ise A B :: Δ, P, Q => ara n [A] (B :: Δ) P Q

def ispatlanabilirMi (A : Formul) : Bool :=
  ara (olcu [A] + 1) [] [A] [] []

#eval ispatlanabilirMi peirce            -- true
#eval ispatlanabilirMi (p ⋁ ∼p)          -- true
#eval ispatlanabilirMi (p ⟹ q)           -- false
#eval ispatlanabilirMi ((p ⟹ q) ⟹ (∼q ⟹ ∼p))   -- true
-- ANCHOR_END: ara

end Bolum13
