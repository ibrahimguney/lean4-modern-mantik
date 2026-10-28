/-
  Lean 4 ile Modern Mantık — Uygulama
  Mecelle'nin külli kaideleri: önermeler mantığıyla bir pilot çalışma

  Kapsam: md. 2, 4, 5, 17, 19, 20, 21, 22, 25, 26, 27, 36.
  Nesne dili Bölüm 10'daki `Formul`'dür; yeni bir mantık tanımlanmaz.

  Okuma ilkesi. Bir külli kaide bütün olaylar hakkındadır. Önermeler
  mantığında onu tek bir olay için yazarız: atomlar, ele alınan *bir*
  olayın özelliklerini anlatır. Bu yüzden her formül bir kaide şemasının
  o olaydaki örneğidir. Niceleyici gerektiren okumalar Cilt II'ye kalır.

  Madde metinleri ve kaynakları: `mecelle/pilot-derlem.md`.

  `-- ANCHOR: ad` / `-- ANCHOR_END: ad` satırlarını silmeyin.
-/
import ModernMantik.Bolum10

namespace Mecelle.Pilot

open Bolum10 Bolum10.Formul

/-! ## 1. Atom sözlüğü -/

-- ANCHOR: atomlar
-- Yakîn ve istishab (md. 4, 5)
def yakin        : Formul := atom 0   -- önceki hâl (A) kesin olarak sabittir
def sek          : Formul := atom 1   -- A'nın kalktığına dair yalnızca şek vardır
def hukumA       : Formul := atom 2   -- A'nın devam ettiğine hükmolunur
def degisimSabit : Formul := atom 3   -- A'nın kalktığı delille sabittir
-- Meşakkat ve zaruret (md. 17, 21, 22)
def mesakkat     : Formul := atom 4   -- fiilde meşakkat vardır
def teysir       : Formul := atom 5   -- kolaylık (ruhsat) tanınır
def zaruret      : Formul := atom 6   -- zaruret hâli vardır
def aslenMemnu   : Formul := atom 7   -- fiil aslen yasaktır
def mubah        : Formul := atom 8   -- fiil (bu olayda) mübahtır
def miktariAsar  : Formul := atom 9   -- fiil zaruretin miktarını aşar
-- Zarar (md. 19, 20, 25, 26, 27)
def zarar        : Formul := atom 10  -- giderilmesi istenen bir zarar Z vardır
def izale        : Formul := atom 11  -- Z'nin giderilmesine hükmolunur
def tedbirCaiz   : Formul := atom 12  -- Z'yi gidermek için önerilen T tedbiri caizdir
def misil        : Formul := atom 13  -- T'nin doğurduğu zarar Z'nin mislidir (dengidir)
def ehaf         : Formul := atom 14  -- T'nin doğurduğu zarar Z'den hafiftir
def amm          : Formul := atom 15  -- Z âmm (genel) bir zarardır
def has          : Formul := atom 16  -- T'nin doğurduğu zarar hâs (özel) bir zarardır
def mukabele     : Formul := atom 17  -- T, zarara zararla karşılık vermektir
-- Niyet (md. 2) ve örf (md. 36)
def maksat       : Formul := atom 18  -- fiil M maksadıyla yapılmıştır
def hukumM       : Formul := atom 19  -- fiile M maksadına uygun hüküm bağlanır
def orf          : Formul := atom 20  -- konuda yerleşik bir örf ve âdet vardır
def orfeGore     : Formul := atom 21  -- hüküm örfe göre verilir
-- ANCHOR_END: atomlar

/-! ## 2. Kaideler -/

-- ANCHOR: kaideler
def md2  : Formul := maksat ⟹ hukumM                         -- umûr bi-makâsıdihâ
def md4  : Formul := yakin ⋀ sek ⟹ hukumA                    -- yakîn şekle zâil olmaz
def md5  : Formul := yakin ⋀ ∼degisimSabit ⟹ hukumA          -- istishab
def md17 : Formul := mesakkat ⟹ teysir                       -- meşakkat teysiri celbeder
def md19 : Formul := mukabele ⟹ ∼tedbirCaiz                  -- mukabele bi'z-zarar yoktur
def md20 : Formul := zarar ⟹ izale                           -- zarar izale olunur
def md21 : Formul := zaruret ⋀ aslenMemnu ⟹ mubah            -- zaruret memnuu mübah kılar
def md22 : Formul := zaruret ⋀ aslenMemnu ⋀ miktariAsar ⟹ ∼mubah  -- zaruret kendi miktarınca
def md25 : Formul := misil ⟹ ∼tedbirCaiz                     -- zarar misliyle izale olunmaz
def md26 : Formul := zarar ⋀ amm ⋀ has ⟹ tedbirCaiz          -- âmm için hâs ihtiyar olunur
def md27 : Formul := zarar ⋀ ehaf ⟹ tedbirCaiz               -- eşed ehaf ile izale olunur
def md36 : Formul := orf ⟹ orfeGore                          -- âdet muhakkemdir
-- ANCHOR_END: kaideler

-- ANCHOR: kopruler
-- Köprü ilkeleri: metinde açıkça yazmayan, ama kaideleri birbirine
-- bağlamak için gereken varsayımlar. Her biri bir yorumdur.
def K1 : Formul := sek ⟹ ∼degisimSabit        -- yalnız şek, değişimi ispat etmez
def K2 : Formul := zaruret ⟹ mesakkat         -- zaruret, meşakkatin en ağır derecesidir
def K3 : Formul := amm ⋀ has ⟹ ehaf           -- hâs zarar, âmm zarara göre hafiftir
def K4 : Formul := ∼(misil ⋀ ehaf)            -- iki zarar hem denk hem farklı olamaz
def K5 : Formul := mukabele ⟹ misil           -- misilleme, denk zararla karşılıktır
-- ANCHOR_END: kopruler

/-! ## 3. Yardımcılar -/

-- Sonlu bir atom listesini doğru, gerisini yanlış yapan değerleme:
def model (l : List Nat) : Degerleme := fun n => l.contains n

-- Bir formül listesinin birleşimi:
def hepsi : List Formul → Formul
  | []      => tepe
  | A :: Γ  => A ⋀ hepsi Γ

/-! ## 4. Bulgular

İspat kalıbı. `Sonuc Γ A` ve `¬ Saglanabilir A` için tanımları açıp
yalnızca geçen atomları Bool değişkenlere genelleriz; geri kalan
doğruluk tablosunu `decide` tarar. Olumsuz sonuçlar (`¬ Sonuc`) için
somut bir karşı değerleme (`model [...]`) veririz.
-/

-- Tanımları açmak için kullanılan sadeleştirme kümesi:
macro "ac" : tactic => `(tactic|
  simp only [hepsi, tepe, degil, md2, md4, md5, md17, md19, md20, md21, md22, md25,
    md26, md27, md36, K1, K2, K3, K4, K5, yakin, sek, hukumA, degisimSabit, mesakkat,
    teysir, zaruret, aslenMemnu, mubah, miktariAsar, zarar, izale, tedbirCaiz, misil,
    ehaf, amm, has, mukabele, maksat, hukumM, orf, orfeGore, deger] at *)

-- ANCHOR: tutarlilik
-- B1. Pilot kaidelerin tamamı birlikte tutarlıdır. (Hiçbir koşulun
-- gerçekleşmediği "boş olay" bir modeldir; asıl soru olay betimleriyledir.)
def pilot : List Formul :=
  [md2, md4, md5, md17, md19, md20, md21, md22, md25, md26, md27, md36]

theorem pilot_tutarli : Saglanabilir (hepsi pilot) := ⟨model [], by decide⟩
-- ANCHOR_END: tutarlilik

/-! ### Yakîn ve istishab -/

-- ANCHOR: yakin
-- B2. md. 4, md. 5'ten ve K1 köprüsünden çıkar.
theorem md4_md5ten : Sonuc [md5, K1] md4 := by
  intro v h
  have h1 := h md5 (by simp); have h2 := h K1 (by simp)
  ac; revert h1 h2
  generalize v 0 = a; generalize v 1 = b; generalize v 2 = c; generalize v 3 = d
  revert a b c d; decide

-- B3. Tersi doğru değildir: md. 5, md. 4'ten ve K1'den çıkmaz.
-- Karşı olay: önceki hâl sabit, şek yok, değişim ispat edilmemiş, ama hüküm verilmemiş.
theorem md5_md4ten_cikmaz : ¬ Sonuc [md4, K1] md5 := by
  intro h; have := h (model [0]) (by decide); revert this; decide
-- ANCHOR_END: yakin

/-! ### Zaruret -/

-- ANCHOR: zaruret
-- B4. md. 21 harfiyen okunursa, zaruret miktarını aşan bir olayda md. 22 ile çatışır.
theorem md21_md22_catisir :
    ¬ Saglanabilir (hepsi [md21, md22, zaruret, aslenMemnu, miktariAsar]) := by
  intro ⟨v, h⟩; ac; revert h
  generalize v 6 = a; generalize v 7 = b; generalize v 8 = c; generalize v 9 = d
  revert a b c d; decide

-- B5. md. 22, md. 21'i tahsis eder: istisnayı md. 21'in koşuluna yazınca çatışma kalkar.
def md21t : Formul := zaruret ⋀ aslenMemnu ⋀ ∼miktariAsar ⟹ mubah

theorem md21_md21tyi_gerektirir : Sonuc [md21] md21t := by
  intro v h
  have h1 := h md21 (by simp)
  simp only [md21t] ; ac; revert h1
  generalize v 6 = a; generalize v 7 = b; generalize v 8 = c; generalize v 9 = d
  revert a b c d; decide

theorem tahsis_tutarli :
    Saglanabilir (hepsi [md21t, md22, zaruret, aslenMemnu, miktariAsar]) :=
  ⟨model [6, 7, 9], by decide⟩

-- B6. md. 21, md. 17'nin bir örneği değildir: zaruret meşakkat sayılsa (K2) bile,
-- "kolaylık tanınır" sonucu "yasak mübah olur" sonucunu vermez.
theorem md21_md17den_cikmaz : ¬ Sonuc [md17, K2] md21 := by
  intro h; have := h (model [4, 5, 6, 7]) (by decide); revert this; decide
-- ANCHOR_END: zaruret

/-! ### Zarar -/

-- ANCHOR: zarar
-- B7. md. 25 ile md. 27, tedbirin zararı hem denk hem hafif sayılırsa çatışır.
-- Önermeler mantığı "denk" ile "hafif"in birbirini dışladığını bilmez (K4 gerekir).
theorem md25_md27_catisir :
    ¬ Saglanabilir (hepsi [md25, md27, zarar, misil, ehaf]) := by
  intro ⟨v, h⟩; ac; revert h
  generalize v 10 = a; generalize v 12 = b; generalize v 13 = c; generalize v 14 = d
  revert a b c d; decide

-- B8. md. 25 ile md. 26 da çatışabilir: âmm zararı, ona denk bir hâs zararla gidermek.
theorem md25_md26_catisir :
    ¬ Saglanabilir (hepsi [md25, md26, zarar, amm, has, misil]) := by
  intro ⟨v, h⟩; ac; revert h
  generalize v 10 = a; generalize v 12 = b; generalize v 13 = c
  generalize v 15 = d; generalize v 16 = e
  revert a b c d e; decide

-- B9. K3 ve K4 bu çatışma olayını dışlar: âmm–hâs olayında zararlar denk olamaz.
theorem K3_K4_catismayi_dislar :
    ¬ Saglanabilir (hepsi [K3, K4, amm, has, misil]) := by
  intro ⟨v, h⟩; ac; revert h
  generalize v 13 = a; generalize v 14 = b; generalize v 15 = c; generalize v 16 = d
  revert a b c d; decide

-- B10. md. 26, md. 27'den K3 köprüsüyle çıkar; K3 olmadan çıkmaz.
theorem md26_md27den : Sonuc [md27, K3] md26 := by
  intro v h
  have h1 := h md27 (by simp); have h2 := h K3 (by simp)
  ac; revert h1 h2
  generalize v 10 = a; generalize v 12 = b; generalize v 14 = c
  generalize v 15 = d; generalize v 16 = e
  revert a b c d e; decide

theorem md26_yalniz_md27den_cikmaz : ¬ Sonuc [md27] md26 := by
  intro h; have := h (model [10, 15, 16]) (by decide); revert this; decide

-- B11. md. 19'un ikinci yarısı, md. 25'ten K5 köprüsüyle çıkar; tersi çıkmaz.
theorem md19_md25ten : Sonuc [md25, K5] md19 := by
  intro v h
  have h1 := h md25 (by simp); have h2 := h K5 (by simp)
  ac; revert h1 h2
  generalize v 12 = a; generalize v 13 = b; generalize v 17 = c
  revert a b c; decide

theorem md25_md19dan_cikmaz : ¬ Sonuc [md19, K5] md25 := by
  intro h; have := h (model [12, 13]) (by decide); revert this; decide
-- ANCHOR_END: zarar

/-! ### Beş temel kaide -/

-- ANCHOR: bes_kaide
-- B12. Geleneğin "beş temel kaide" saydığı md. 2, 4, 17, 20, 36 birbirinden
-- bağımsızdır: hiçbiri öteki dördünden çıkmaz.
theorem md2_bagimsiz  : ¬ Sonuc [md4, md17, md20, md36] md2 := by
  intro h; have := h (model [18]) (by decide); revert this; decide
theorem md4_bagimsiz  : ¬ Sonuc [md2, md17, md20, md36] md4 := by
  intro h; have := h (model [0, 1]) (by decide); revert this; decide
theorem md17_bagimsiz : ¬ Sonuc [md2, md4, md20, md36] md17 := by
  intro h; have := h (model [4]) (by decide); revert this; decide
theorem md20_bagimsiz : ¬ Sonuc [md2, md4, md17, md36] md20 := by
  intro h; have := h (model [10]) (by decide); revert this; decide
theorem md36_bagimsiz : ¬ Sonuc [md2, md4, md17, md20] md36 := by
  intro h; have := h (model [20]) (by decide); revert this; decide

-- B13. md. 20 bütün pilot kaidelerden ve köprülerden bile çıkmaz.
theorem md20_her_seyden_bagimsiz :
    ¬ Sonuc [md2, md4, md5, md17, md19, md21, md22, md25, md26, md27, md36,
             K1, K2, K3, K4, K5] md20 := by
  intro h; have := h (model [10]) (by decide); revert this; decide
-- ANCHOR_END: bes_kaide

/-! ## 5. Bir vaka -/

-- ANCHOR: vaka
-- Ehil olmayan hekimin men edilmesi (md. 26'nın şerhlerdeki örneği):
-- Z = halkın sağlığına gelen zarar (âmm), T = hekimin men edilmesi (hâs zarar).
-- Zarar kaideleri ve köprülerle birlikte, tedbirin caiz olduğu sonucu çıkar
-- ve md. 25 bunu engellemez.
def zararKaideleri : List Formul := [md19, md20, md25, md26, md27, K3, K4, K5]
def hekimOlayi     : List Formul := [zarar, amm, has, ∼mukabele]

theorem hekim_men_caiz : Sonuc (zararKaideleri ++ hekimOlayi) tedbirCaiz := by
  intro v h
  have h1 := h md26 (by simp [zararKaideleri, hekimOlayi])
  have h2 := h zarar (by simp [zararKaideleri, hekimOlayi])
  have h3 := h amm (by simp [zararKaideleri, hekimOlayi])
  have h4 := h has (by simp [zararKaideleri, hekimOlayi])
  ac; revert h1 h2 h3 h4
  generalize v 10 = a; generalize v 12 = b; generalize v 15 = c; generalize v 16 = d
  revert a b c d; decide

theorem hekim_olayi_tutarli : Saglanabilir (hepsi (zararKaideleri ++ hekimOlayi)) :=
  ⟨model [10, 11, 12, 14, 15, 16], by decide⟩
-- ANCHOR_END: vaka

end Mecelle.Pilot
