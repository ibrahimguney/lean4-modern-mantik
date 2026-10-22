/-
  Lean 4 ile Modern Mantık
  Bölüm 12 — Tamlık Teoremi

  Bu bölüm yalnızca Lean çekirdeğini ve Bölüm 10–11'i kullanır.
  İspat, Kalmár'ın (1935) yöntemini izler:
    1. Türetilmiş kurallar      (zay, bas, ucuncu_hal, …)
    2. İşaretli atomlar ve atom bağlamı
    3. Kalmár önsavı             (doğruluk tablosunun her satırı bir türetimdir)
    4. Atomların teker teker elenmesi
    5. Tamlık:  Γ ⊨ A  →  Γ ⊢ A

  `-- ANCHOR: ad` / `-- ANCHOR_END: ad` satırları kitabın kaynağı
  tarafından okunur. Lütfen silmeyin.
-/
import ModernMantik.Bolum11

namespace Bolum12

open Bolum10 Bolum10.Formul Bolum11

/-! ## 12.2  Türetilmiş kurallar -/

-- ANCHOR: temel_araclar
-- Bağlamın başındaki formül her zaman türetilebilir.
theorem bas {Δ : List Formul} {A : Formul} : Turetilir (A :: Δ) A :=
  Turetilir.varsayim (List.Mem.head _)

-- Bağlamın başına bir varsayım eklemek (zayıflatmanın en sık kullanılan hâli).
theorem zay {Δ : List Formul} {A : Formul} (B : Formul)
    (h : Turetilir Δ A) : Turetilir (B :: Δ) A :=
  zayiflatma h (B :: Δ) (fun _ hX => List.Mem.tail _ hX)
-- ANCHOR_END: temel_araclar

-- ANCHOR: ucuncu_hal
-- Her bağlamda ve her formül için:  Δ ⊢ B ⋁ ∼B
theorem ucuncu_hal (Δ : List Formul) (B : Formul) : Turetilir Δ (B ⋁ ∼B) := by
  apply Turetilir.raa                           -- ∼(B ⋁ ∼B) :: Δ ⊢ ⊥
  apply Turetilir.iseE (A := B ⋁ ∼B)
  · exact bas
  · apply Turetilir.veyaG2                      -- ∼B göstermek yeter
    apply Turetilir.iseG                        -- B :: ∼(B ⋁ ∼B) :: Δ ⊢ ⊥
    apply Turetilir.iseE (A := B ⋁ ∼B)
    · exact zay _ bas
    · apply Turetilir.veyaG1
      exact bas

-- Durum ayrımı: B'den de ∼B'den de A çıkıyorsa A çıkar.
theorem durum_ayrimi {Γ : List Formul} {A B : Formul}
    (h1 : Turetilir (B :: Γ) A) (h2 : Turetilir (∼B :: Γ) A) : Turetilir Γ A :=
  Turetilir.veyaE (ucuncu_hal Γ B) h1 h2
-- ANCHOR_END: ucuncu_hal

-- ANCHOR: turetilmis_kurallar
-- ∼A ⊢ ∼(A ⋀ B)
theorem ve_yanlis1 {Δ : List Formul} {A B : Formul}
    (h : Turetilir Δ (∼A)) : Turetilir Δ (∼(A ⋀ B)) := by
  apply Turetilir.iseG                          -- (A ⋀ B) :: Δ ⊢ ⊥
  apply Turetilir.iseE (A := A)
  · exact zay _ h
  · exact Turetilir.veE1 (B := B) bas

-- ∼B ⊢ ∼(A ⋀ B)
theorem ve_yanlis2 {Δ : List Formul} {A B : Formul}
    (h : Turetilir Δ (∼B)) : Turetilir Δ (∼(A ⋀ B)) := by
  apply Turetilir.iseG
  apply Turetilir.iseE (A := B)
  · exact zay _ h
  · exact Turetilir.veE2 (A := A) bas

-- ∼A, ∼B ⊢ ∼(A ⋁ B)
theorem veya_yanlis {Δ : List Formul} {A B : Formul}
    (hA : Turetilir Δ (∼A)) (hB : Turetilir Δ (∼B)) :
    Turetilir Δ (∼(A ⋁ B)) := by
  apply Turetilir.iseG                          -- (A ⋁ B) :: Δ ⊢ ⊥
  apply Turetilir.veyaE (A := A) (B := B) bas
  · apply Turetilir.iseE (A := A)               -- A :: (A ⋁ B) :: Δ ⊢ ⊥
    · exact zay _ (zay _ hA)
    · exact bas
  · apply Turetilir.iseE (A := B)               -- B :: (A ⋁ B) :: Δ ⊢ ⊥
    · exact zay _ (zay _ hB)
    · exact bas

-- ∼A ⊢ A ⟹ B        (yanlış öncül)
theorem ise_on_yanlis {Δ : List Formul} {A B : Formul}
    (h : Turetilir Δ (∼A)) : Turetilir Δ (A ⟹ B) := by
  apply Turetilir.iseG                          -- A :: Δ ⊢ B
  apply Turetilir.botE
  apply Turetilir.iseE (A := A)
  · exact zay _ h
  · exact bas

-- B ⊢ A ⟹ B         (doğru sonuç)
theorem ise_son_dogru {Δ : List Formul} {A B : Formul}
    (h : Turetilir Δ B) : Turetilir Δ (A ⟹ B) :=
  Turetilir.iseG (zay _ h)

-- A, ∼B ⊢ ∼(A ⟹ B)
theorem ise_yanlis {Δ : List Formul} {A B : Formul}
    (hA : Turetilir Δ A) (hB : Turetilir Δ (∼B)) :
    Turetilir Δ (∼(A ⟹ B)) := by
  apply Turetilir.iseG                          -- (A ⟹ B) :: Δ ⊢ ⊥
  apply Turetilir.iseE (A := B)
  · exact zay _ hB
  · apply Turetilir.iseE (A := A)
    · exact bas
    · exact zay _ hA
-- ANCHOR_END: turetilmis_kurallar

/-! ## 12.3  İşaretli atomlar -/

-- ANCHOR: isaretli
-- v'ye göre "işaretli" atom:  v n doğruysa pₙ, yanlışsa ∼pₙ.
def isaretli (v : Degerleme) (n : Nat) : Formul :=
  if v n = true then atom n else ∼(atom n)

-- İlk k atomun işaretli hâlleri:  [p'ₖ₋₁, …, p'₁, p'₀]
def atomBaglami (v : Degerleme) : Nat → List Formul
  | 0     => []
  | k + 1 => isaretli v k :: atomBaglami v k

theorem atomBaglami_ardil (v : Degerleme) (k : Nat) :
    atomBaglami v (k + 1) = isaretli v k :: atomBaglami v k := rfl
-- ANCHOR_END: isaretli

-- ANCHOR: isaretli_ozellik
theorem isaretli_dogru {v : Degerleme} {n : Nat} (h : v n = true) :
    isaretli v n = atom n := by
  simp [isaretli, h]

theorem isaretli_yanlis {v : Degerleme} {n : Nat} (h : v n = false) :
    isaretli v n = ∼(atom n) := by
  simp [isaretli, h]

-- n < k ise n'inci işaretli atom bağlamdadır.
theorem isaretli_mem (v : Degerleme) {n k : Nat} (h : n < k) :
    isaretli v n ∈ atomBaglami v k := by
  induction k with
  | zero => exact absurd h (Nat.not_lt_zero n)
  | succ k ih =>
    rw [atomBaglami_ardil]
    by_cases hnk : n = k
    · rw [hnk]
      exact List.Mem.head _
    · exact List.Mem.tail _ (ih (by omega))
-- ANCHOR_END: isaretli_ozellik

/-! ## 12.4  Kalmár önsavı -/

-- ANCHOR: kalmar_tanim
-- "Δ, A'yı b değerine uygun biçimde türetir":
--   b doğruysa Δ ⊢ A,   b yanlışsa Δ ⊢ ∼A.
abbrev Kalmar (Δ : List Formul) (b : Bool) (A : Formul) : Prop :=
  (b = true → Turetilir Δ A) ∧ (b = false → Turetilir Δ (∼A))
-- ANCHOR_END: kalmar_tanim

-- ANCHOR: kalmar_baglaclar
-- Her bağlaç için, doğruluk tablosunun satırları türetimlere dönüşür.
theorem kalmar_ve {Δ : List Formul} {A B : Formul} {a b : Bool}
    (hA : Kalmar Δ a A) (hB : Kalmar Δ b B) : Kalmar Δ (a && b) (A ⋀ B) := by
  cases a with
  | false => exact ⟨fun h => by simp at h, fun _ => ve_yanlis1 (hA.2 rfl)⟩
  | true =>
    cases b with
    | false => exact ⟨fun h => by simp at h, fun _ => ve_yanlis2 (hB.2 rfl)⟩
    | true  => exact ⟨fun _ => Turetilir.veG (hA.1 rfl) (hB.1 rfl),
                      fun h => by simp at h⟩

theorem kalmar_veya {Δ : List Formul} {A B : Formul} {a b : Bool}
    (hA : Kalmar Δ a A) (hB : Kalmar Δ b B) : Kalmar Δ (a || b) (A ⋁ B) := by
  cases a with
  | true => exact ⟨fun _ => Turetilir.veyaG1 (hA.1 rfl), fun h => by simp at h⟩
  | false =>
    cases b with
    | true  => exact ⟨fun _ => Turetilir.veyaG2 (hB.1 rfl), fun h => by simp at h⟩
    | false => exact ⟨fun h => by simp at h,
                      fun _ => veya_yanlis (hA.2 rfl) (hB.2 rfl)⟩

theorem kalmar_ise {Δ : List Formul} {A B : Formul} {a b : Bool}
    (hA : Kalmar Δ a A) (hB : Kalmar Δ b B) : Kalmar Δ (!a || b) (A ⟹ B) := by
  cases a with
  | false => exact ⟨fun _ => ise_on_yanlis (hA.2 rfl), fun h => by simp at h⟩
  | true =>
    cases b with
    | true  => exact ⟨fun _ => ise_son_dogru (hB.1 rfl), fun h => by simp at h⟩
    | false => exact ⟨fun h => by simp at h,
                      fun _ => ise_yanlis (hA.1 rfl) (hB.2 rfl)⟩

theorem kalmar_bot (v : Degerleme) (Δ : List Formul) :
    Kalmar Δ (deger v bot) bot := by
  show Kalmar Δ false bot
  exact ⟨fun h => by simp at h, fun _ => Turetilir.iseG bas⟩   -- ⊢ ⊥ ⟹ ⊥

theorem kalmar_atom (v : Degerleme) {n k : Nat} (h : n < k) :
    Kalmar (atomBaglami v k) (deger v (atom n)) (atom n) := by
  have hm := isaretli_mem v h
  show Kalmar (atomBaglami v k) (v n) (atom n)
  cases hv : v n with
  | false =>
    rw [isaretli_yanlis hv] at hm
    exact ⟨fun h => by simp at h, fun _ => Turetilir.varsayim hm⟩
  | true =>
    rw [isaretli_dogru hv] at hm
    exact ⟨fun _ => Turetilir.varsayim hm, fun h => by simp at h⟩
-- ANCHOR_END: kalmar_baglaclar

-- ANCHOR: kalmar
-- Kalmár önsavı (1935).  A'nın bütün atomları k'dan küçükse,
-- v'nin işaretli atomları A'yı ya da ∼A'yı türetir.
theorem kalmar (v : Degerleme) (k : Nat) :
    ∀ A : Formul, enBuyukAtom A < k →
      Kalmar (atomBaglami v k) (deger v A) A := by
  intro A
  induction A with
  | atom n => intro hk; exact kalmar_atom v (n := n) hk
  | bot => intro _; exact kalmar_bot v _
  | ve A B ihA ihB =>
    intro hk
    have h : max (enBuyukAtom A) (enBuyukAtom B) < k := hk
    exact kalmar_ve (ihA (Nat.lt_of_le_of_lt (Nat.le_max_left _ _) h))
                    (ihB (Nat.lt_of_le_of_lt (Nat.le_max_right _ _) h))
  | veya A B ihA ihB =>
    intro hk
    have h : max (enBuyukAtom A) (enBuyukAtom B) < k := hk
    exact kalmar_veya (ihA (Nat.lt_of_le_of_lt (Nat.le_max_left _ _) h))
                      (ihB (Nat.lt_of_le_of_lt (Nat.le_max_right _ _) h))
  | ise A B ihA ihB =>
    intro hk
    have h : max (enBuyukAtom A) (enBuyukAtom B) < k := hk
    exact kalmar_ise (ihA (Nat.lt_of_le_of_lt (Nat.le_max_left _ _) h))
                     (ihB (Nat.lt_of_le_of_lt (Nat.le_max_right _ _) h))
-- ANCHOR_END: kalmar

/-! ## 12.5  Atomların elenmesi -/

-- ANCHOR: ata
-- v'nin j'inci atomunu b yapan değerleme:
def ata (v : Degerleme) (j : Nat) (b : Bool) : Degerleme :=
  fun n => if n = j then b else v n

theorem isaretli_uyum {v w : Degerleme} {n : Nat} (h : v n = w n) :
    isaretli v n = isaretli w n := by
  unfold isaretli
  rw [h]

-- k'dan küçük atomlarda anlaşan değerlemeler aynı atom bağlamını verir.
theorem baglam_uyum {v w : Degerleme} :
    ∀ k : Nat, (∀ n, n < k → v n = w n) → atomBaglami v k = atomBaglami w k
  | 0, _ => rfl
  | k + 1, h => by
    rw [atomBaglami_ardil, atomBaglami_ardil,
        isaretli_uyum (h k (by omega)),
        baglam_uyum k (fun n hn => h n (by omega))]
-- ANCHOR_END: ata

-- ANCHOR: atom_ele
-- Bir adım: j'inci atomu bağlamdan çıkar.
theorem atom_ele {A : Formul} {j : Nat}
    (h : ∀ v : Degerleme, Turetilir (atomBaglami v (j + 1)) A) :
    ∀ v : Degerleme, Turetilir (atomBaglami v j) A := by
  intro v
  -- j'den küçük atomlarda ata v j b ile v aynıdır:
  have e : ∀ b, atomBaglami (ata v j b) j = atomBaglami v j := by
    intro b
    apply baglam_uyum
    intro n hn
    have hne : n ≠ j := by omega
    simp [ata, hne]
  -- 1. satır: pⱼ doğru
  have h1 : Turetilir (atom j :: atomBaglami v j) A := by
    have t := h (ata v j true)
    have i : isaretli (ata v j true) j = atom j := isaretli_dogru (by simp [ata])
    rw [atomBaglami_ardil, i, e] at t
    exact t
  -- 2. satır: pⱼ yanlış
  have h2 : Turetilir (∼(atom j) :: atomBaglami v j) A := by
    have t := h (ata v j false)
    have i : isaretli (ata v j false) j = ∼(atom j) := isaretli_yanlis (by simp [ata])
    rw [atomBaglami_ardil, i, e] at t
    exact t
  -- pⱼ ⋁ ∼pⱼ ile birleştir:
  exact durum_ayrimi h1 h2

-- Bütün atomlar: k adımda boş bağlama in.
theorem atomlari_ele {A : Formul} :
    ∀ k : Nat, (∀ v : Degerleme, Turetilir (atomBaglami v k) A) →
      Turetilir [] A
  | 0, h => h (fun _ => false)
  | k + 1, h => atomlari_ele k (atom_ele h)
-- ANCHOR_END: atom_ele

/-! ## 12.6  Tamlık teoremi -/

-- ANCHOR: zayif_tamlik
-- Zayıf tamlık:  ⊨ A  →  ⊢ A
theorem tamlik_bos {A : Formul} (h : Totoloji A) : Turetilir [] A :=
  atomlari_ele (enBuyukAtom A + 1)
    (fun v => (kalmar v (enBuyukAtom A + 1) A (by omega)).1 (h v))
-- ANCHOR_END: zayif_tamlik

-- ANCHOR: kapat
-- Varsayımları öncül olarak içeri taşı:  kapat [B₁, B₂] A = B₂ ⟹ B₁ ⟹ A
def kapat : List Formul → Formul → Formul
  | [],     A => A
  | B :: Γ, A => kapat Γ (B ⟹ A)

-- Anlambilim tarafı:  B :: Γ ⊨ A  →  Γ ⊨ B ⟹ A
theorem sonuc_ise {Γ : List Formul} {A B : Formul}
    (h : Sonuc (B :: Γ) A) : Sonuc Γ (B ⟹ A) := by
  intro v hv
  show (!deger v B || deger v A) = true
  cases hB : deger v B with
  | false => rfl
  | true => simp [h v (baglam_ekle hB hv)]

theorem kapat_sonuc :
    ∀ (Γ : List Formul) (A : Formul), Sonuc Γ A → Totoloji (kapat Γ A)
  | [], A, h => by
    intro v
    exact h v (by intro X hX; cases hX)
  | B :: Γ, A, h => kapat_sonuc Γ (B ⟹ A) (sonuc_ise h)

-- Türetim tarafı:  ⊢ kapat Γ A  →  Γ ⊢ A
theorem kapat_turetilir :
    ∀ (Γ : List Formul) (A : Formul), Turetilir [] (kapat Γ A) → Turetilir Γ A
  | [], _, h => h
  | B :: Γ, A, h => Turetilir.iseE (zay B (kapat_turetilir Γ (B ⟹ A) h)) bas
-- ANCHOR_END: kapat

-- ANCHOR: tamlik
-- Tamlık teoremi (önermeler mantığı, sonlu varsayımlar):  Γ ⊨ A  →  Γ ⊢ A
theorem tamlik {Γ : List Formul} {A : Formul} (h : Sonuc Γ A) : Turetilir Γ A :=
  kapat_turetilir Γ A (tamlik_bos (kapat_sonuc Γ A h))

-- Geçerlilik ile birlikte:  ⊢ ile ⊨ aynı ilişkidir.
theorem turetilir_iff_sonuc {Γ : List Formul} {A : Formul} :
    Turetilir Γ A ↔ Sonuc Γ A :=
  ⟨gecerlilik, tamlik⟩
-- ANCHOR_END: tamlik

/-! ## 12.7  Sonuçlar -/

-- ANCHOR: sonuclar
-- Peirce yasası: bu kez türetim yazmadan, doğruluk tablosundan.
theorem peirce_yeniden : Turetilir [] peirce :=
  tamlik_bos peirce_totoloji

-- Model varlığı: tutarlı her varsayım listesinin bir modeli vardır.
theorem model_varligi {Γ : List Formul} (h : ¬ Turetilir Γ bot) :
    ∃ v : Degerleme, ∀ B ∈ Γ, deger v B = true := by
  apply Classical.byContradiction
  intro hyok
  apply h
  apply tamlik
  intro v hv
  exact (hyok ⟨v, hv⟩).elim

-- Türetilemezlik artık bir karşı modelle gösterilir ve tersine:
theorem turetilemez_iff {Γ : List Formul} {A : Formul} :
    ¬ Turetilir Γ A ↔ ¬ Sonuc Γ A :=
  ⟨fun h hs => h (tamlik hs), fun h ht => h (gecerlilik ht)⟩
-- ANCHOR_END: sonuclar

end Bolum12
