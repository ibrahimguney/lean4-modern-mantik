/-
  Lean 4 ile Modern Mantık
  Bölüm 1 — Mantık Nedir, İspat Asistanı Nedir?

  Bu dosyadaki `-- ANCHOR: ad` ve `-- ANCHOR_END: ad` satırları,
  kitabın LaTeX kaynağının kodu buradan okuyabilmesi içindir.
  Lütfen silmeyin.
-/

namespace Bolum01

-- ANCHOR: check_eval
#check 2 + 2          -- 2 + 2 : Nat
#eval 2 + 2           -- 4
#check (2 + 2 = 4)    -- 2 + 2 = 4 : Prop
#check (2 + 2 = 5)    -- 2 + 2 = 5 : Prop   (yanlış ama geçerli bir önerme!)
-- ANCHOR_END: check_eval

-- ANCHOR: ilk_teorem
-- Elimizde P'nin bir kanıtı varsa, P doğrudur.
theorem ilk_teorem (P : Prop) (hp : P) : P := hp
-- ANCHOR_END: ilk_teorem

-- ANCHOR: ilk_teorem_taktik
-- Aynı teorem, bu kez taktik moduyla:
theorem ilk_teorem' (P : Prop) (hp : P) : P := by
  exact hp
-- ANCHOR_END: ilk_teorem_taktik

-- ANCHOR: rfl_ornek
-- Hesaplamayla doğrulanan bir eşitlik:
example : 2 + 2 = 4 := rfl
-- ANCHOR_END: rfl_ornek

-- ANCHOR: check_teorem
#check @ilk_teorem    -- ∀ (P : Prop), P → P
-- ANCHOR_END: check_teorem

end Bolum01
