/-
  Lean 4 ile Modern Mantık
  Bölüm 3 — Önermeler Mantığı II: Değilleme, Çelişki ve Denklik

  `-- ANCHOR: ad` / `-- ANCHOR_END: ad` satırları kitabın kaynağı
  tarafından okunur. Lütfen silmeyin.

  Bu dosyadaki ispatların hiçbiri klasik mantık kullanmaz.
-/

namespace Bolum03

/-! ## 3.1  True ve False -/

-- ANCHOR: dogru
theorem dogru : True := trivial          -- True'nun tek kanıtı
theorem dogru' : True := True.intro      -- aynı kanıt, adıyla
-- ANCHOR_END: dogru

-- ANCHOR: ex_falso
-- Çelişkiden her şey çıkar (ex falso quodlibet).
theorem ex_falso (P : Prop) : False → P := by
  intro h
  exact False.elim h
-- ANCHOR_END: ex_falso

-- ANCHOR: ex_falso_cases
-- False'un hiç durumu yoktur: durum ayırma hedefi anında kapatır.
theorem ex_falso' (P : Prop) : False → P := by
  intro h
  cases h
-- ANCHOR_END: ex_falso_cases

/-! ## 3.2  Değilleme: ¬P := P → False -/

-- ANCHOR: not_tanim
#check @Not            -- Not : Prop → Prop
#print Not             -- def Not : Prop → Prop := fun a => a → False  (öznitelikleriyle birlikte)
-- ANCHOR_END: not_tanim

-- ANCHOR: degil_giris
-- P ∧ ¬P asla doğru olamaz (çelişmezlik ilkesi).
theorem celismezlik (P : Prop) : ¬(P ∧ ¬P) := by
  intro h                  -- h : P ∧ ¬P,  hedef: ⊢ False
  obtain ⟨hp, hnp⟩ := h
  exact hnp hp             -- ¬P bir fonksiyondur: P alır, False verir
-- ANCHOR_END: degil_giris

-- ANCHOR: degil_giris_terim
theorem celismezlik' (P : Prop) : ¬(P ∧ ¬P) :=
  fun ⟨hp, hnp⟩ => hnp hp
-- ANCHOR_END: degil_giris_terim

-- ANCHOR: cift_degil_giris
-- P'den ¬¬P çıkar (yapıcı olarak!).
theorem cift_degilleme_giris (P : Prop) : P → ¬¬P := by
  intro hp hnp             -- ¬¬P = ¬P → False; ikinci varsayım hnp : ¬P
  exact hnp hp
-- ANCHOR_END: cift_degil_giris

/-! ## 3.3  Çelişkiyle çalışmak: absurd, exfalso, contradiction -/

-- ANCHOR: celiski_uc_yol
theorem celiski₁ (P Q : Prop) (hp : P) (hnp : ¬P) : Q := by
  exfalso                  -- hedefi False'a çevir
  exact hnp hp

theorem celiski₂ (P Q : Prop) (hp : P) (hnp : ¬P) : Q :=
  absurd hp hnp            -- absurd : a → ¬a → b

theorem celiski₃ (P Q : Prop) (hp : P) (hnp : ¬P) : Q := by
  contradiction            -- bağlamda çelişki arar
-- ANCHOR_END: celiski_uc_yol

/-! ## 3.4  Kontrapozisyon -/

-- ANCHOR: kontrapozisyon
theorem kontrapozisyon (P Q : Prop) : (P → Q) → ¬Q → ¬P := by
  intro hpq hnq hp         -- ¬P'nin içindeki P'yi de içeri al
  exact hnq (hpq hp)
-- ANCHOR_END: kontrapozisyon

-- ANCHOR: kontrapozisyon_terim
theorem kontrapozisyon' (P Q : Prop) : (P → Q) → ¬Q → ¬P :=
  fun hpq hnq hp => hnq (hpq hp)
-- ANCHOR_END: kontrapozisyon_terim

-- ANCHOR: modus_tollens
-- Modus tollens: P → Q ve ¬Q'dan ¬P.
theorem modus_tollens (P Q : Prop) (hpq : P → Q) (hnq : ¬Q) : ¬P :=
  kontrapozisyon P Q hpq hnq
-- ANCHOR_END: modus_tollens

/-! ## 3.5  Denklik (↔) -/

-- ANCHOR: iff_giris
theorem ve_degisme_iff (P Q : Prop) : P ∧ Q ↔ Q ∧ P := by
  constructor
  · rintro ⟨hp, hq⟩        -- soldan sağa
    exact ⟨hq, hp⟩
  · rintro ⟨hq, hp⟩        -- sağdan sola
    exact ⟨hp, hq⟩
-- ANCHOR_END: iff_giris

-- ANCHOR: iff_giris_terim
theorem ve_degisme_iff' (P Q : Prop) : P ∧ Q ↔ Q ∧ P :=
  ⟨fun ⟨hp, hq⟩ => ⟨hq, hp⟩, fun ⟨hq, hp⟩ => ⟨hp, hq⟩⟩
-- ANCHOR_END: iff_giris_terim

-- ANCHOR: iff_eleme
theorem iff_kullan (P Q : Prop) (h : P ↔ Q) (hp : P) : Q :=
  h.mp hp                  -- Iff.mp : (P ↔ Q) → P → Q

theorem iff_kullan' (P Q : Prop) (h : P ↔ Q) (hq : Q) : P :=
  h.mpr hq                 -- Iff.mpr : (P ↔ Q) → Q → P
-- ANCHOR_END: iff_eleme

-- ANCHOR: iff_rw
-- Denk önermeler birbirinin yerine yazılabilir.
theorem iff_yeniden_yaz (P Q R : Prop) (h : P ↔ Q) (hqr : Q → R) : P → R := by
  rw [h]                   -- hedefteki P'leri Q yap:  ⊢ Q → R
  exact hqr
-- ANCHOR_END: iff_rw

-- ANCHOR: uclu_degilleme
-- Üç değilleme bir değillemeye indirgenir (yapıcı olarak).
theorem uclu_degilleme (P : Prop) : ¬¬¬P ↔ ¬P := by
  constructor
  · intro h3 hp
    exact h3 (cift_degilleme_giris P hp)
  · intro hnp hnnp
    exact hnnp hnp
-- ANCHOR_END: uclu_degilleme

/-! ## 3.6  De Morgan yasaları -/

-- ANCHOR: demorgan_veya
theorem demorgan_veya (P Q : Prop) : ¬(P ∨ Q) ↔ ¬P ∧ ¬Q := by
  constructor
  · intro h
    exact ⟨fun hp => h (Or.inl hp), fun hq => h (Or.inr hq)⟩
  · rintro ⟨hnp, hnq⟩ (hp | hq)
    · exact hnp hp
    · exact hnq hq
-- ANCHOR_END: demorgan_veya

-- ANCHOR: demorgan_ve_kolay
-- Bu yön yapıcıdır.
theorem demorgan_ve_kolay (P Q : Prop) : ¬P ∨ ¬Q → ¬(P ∧ Q) := by
  rintro (hnp | hnq) ⟨hp, hq⟩
  · exact hnp hp
  · exact hnq hq
-- ANCHOR_END: demorgan_ve_kolay

-- Ters yön, ¬(P ∧ Q) → ¬P ∨ ¬Q, yapıcı olarak ispatlanamaz.
-- Klasik ispatı Bolum04.lean içindedir (demorgan_ve_klasik).

/-! ## 3.7  Üçüncü hâlin olanaksızlığı yanlış olamaz -/

-- ANCHOR: em_cift_degil
-- P ∨ ¬P'yi yapıcı olarak ispatlayamayız, ama YANLIŞ olmadığını ispatlayabiliriz.
theorem em_yanlis_olamaz (P : Prop) : ¬¬(P ∨ ¬P) := by
  intro h                  -- h : ¬(P ∨ ¬P),  hedef: ⊢ False
  apply h
  apply Or.inr             -- ¬P'yi seç
  intro hp                 -- hp : P,  hedef: ⊢ False
  apply h
  exact Or.inl hp          -- P elimizde: P ∨ ¬P'nin sol tarafı
-- ANCHOR_END: em_cift_degil

-- ANCHOR: em_cift_degil_terim
theorem em_yanlis_olamaz' (P : Prop) : ¬¬(P ∨ ¬P) :=
  fun h => h (Or.inr (fun hp => h (Or.inl hp)))
-- ANCHOR_END: em_cift_degil_terim

end Bolum03
