/-
  Lean 4 ile Modern Mantık
  Bölüm 15 — Alıştırma Çözümleri (eğitmenler için)
-/
import ModernMantik.Bolum15

namespace Cozum15

open Bolum15 Bolum15.Vek

universe u v
variable {α : Type u} {β : Type v}

-- Alıştırmalarda kullanılan tanımlar:
def tekrarlaV (a : α) : (n : Nat) → Vek α n
  | 0     => .bos
  | n + 1 => .ekle a (tekrarlaV a n)

def son : {n : Nat} → Vek α (n + 1) → α
  | 0,     .ekle a _ => a
  | _ + 1, .ekle _ v => son v

def listedenV : List α → (n : Nat) × Vek α n
  | []     => ⟨0, .bos⟩
  | a :: l => ⟨(listedenV l).1 + 1, .ekle a (listedenV l).2⟩

-- 15.1
theorem a15_1 (f : α → β) (a : α) : ∀ n, (tekrarlaV a n).esle f = tekrarlaV (f a) n
  | 0     => rfl
  | n + 1 => by
    show Vek.ekle (f a) ((tekrarlaV a n).esle f) = Vek.ekle (f a) (tekrarlaV (f a) n)
    rw [a15_1 f a n]

-- 15.2
theorem a15_2 (a : α) : ∀ {n : Nat} (v : Vek α n), son (v.sonaEkle a) = a
  | _, .bos      => rfl
  | _, .ekle _ v => a15_2 a v

-- 15.3
theorem a15_3 : ∀ {n : Nat} (v : Vek α n) (w : Vek β n),
    (Vek.fermuar v w).esle Prod.fst = v
  | _, .bos,      .bos      => rfl
  | _, .ekle a v, .ekle _ w => by
    show Vek.ekle a ((Vek.fermuar v w).esle Prod.fst) = Vek.ekle a v
    rw [a15_3 v w]

-- 15.4
theorem a15_4 : ∀ {m n : Nat} (v : Vek α m) (w : Vek α n),
    (v.birlestir w).toList = v.toList ++ w.toList
  | _, _, .bos,      _ => rfl
  | _, _, .ekle a v, w => by
    show a :: (v.birlestir w).toList = a :: (v.toList ++ w.toList)
    rw [a15_4 v w]

-- 15.5
theorem a15_5 {n m : Nat} (h : n = m) (v : Vek α n) :
    (Vek.donustur h v).toList = v.toList := by
  subst h
  rfl

-- 15.6
theorem a15_6 (h1 h2 : 2 < 5) : (⟨2, h1⟩ : Fin 5) = ⟨2, h2⟩ := by
  rfl

-- 15.7
theorem a15_7 (l : List α) : (listedenV l).1 = l.length := by
  induction l with
  | nil => rfl
  | cons a l ih => simp [listedenV, ih]

-- 15.8
theorem a15_8 (a : α) : ∀ {n : Nat} (i : Fin n), (tekrarlaV a n).al i = a
  | 0,     i          => Fin.elim0 i
  | _ + 1, ⟨0, _⟩     => rfl
  | _ + 1, ⟨i + 1, h⟩ => a15_8 a ⟨i, Nat.lt_of_succ_lt_succ h⟩

end Cozum15
