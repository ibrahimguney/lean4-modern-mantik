/-
  Lean 4 ile Modern Mantık
  Bölüm 15 — Alıştırmalar

  Her `sorry`'yi kendi ispatınızla değiştirin.
  Zorluk:  ★ temel   ★★ orta   ★★★ ileri
  Çözümler: ModernMantik/Cozumler/Bolum15.lean
-/
import ModernMantik.Bolum15

namespace Alistirma15

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

-- 15.1 ★  Sabit vektörü eşlemek
theorem a15_1 (f : α → β) (a : α) : ∀ n, (tekrarlaV a n).esle f = tekrarlaV (f a) n := by
  sorry

-- 15.2 ★  Sona eklenen, sondadır
theorem a15_2 (a : α) : ∀ {n : Nat} (v : Vek α n), son (v.sonaEkle a) = a := by
  sorry

-- 15.3 ★★  Fermuarın ilk bileşeni
theorem a15_3 : ∀ {n : Nat} (v : Vek α n) (w : Vek β n),
    (Vek.fermuar v w).esle Prod.fst = v := by
  sorry

-- 15.4 ★★  Birleştirme ve listeler
theorem a15_4 : ∀ {m n : Nat} (v : Vek α m) (w : Vek α n),
    (v.birlestir w).toList = v.toList ++ w.toList := by
  sorry

-- 15.5 ★★  Taşıma listeyi değiştirmez
theorem a15_5 {n m : Nat} (h : n = m) (v : Vek α n) :
    (Vek.donustur h v).toList = v.toList := by
  sorry

-- 15.6 ★  Fin'de kanıt-ilgisizliği
theorem a15_6 (h1 h2 : 2 < 5) : (⟨2, h1⟩ : Fin 5) = ⟨2, h2⟩ := by
  sorry

-- 15.7 ★★  Listeden vektöre: uzunluk doğru
theorem a15_7 (l : List α) : (listedenV l).1 = l.length := by
  sorry

-- 15.8 ★★★  Sabit vektörün her elemanı aynıdır
theorem a15_8 (a : α) : ∀ {n : Nat} (i : Fin n), (tekrarlaV a n).al i = a := by
  sorry

end Alistirma15
