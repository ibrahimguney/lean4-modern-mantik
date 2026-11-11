/-
  Lean 4 ile Modern Mantık — Uygulama
  Mecelle'nin külli kaideleri: pilot çalışmanın uzantısı

  Kapsam: md. 13, 23, 24, 36, 51, 64, 85, 87, 100 ve Kitâbü'l-Büyû'dan
  md. 236, 251, 293, 294, 344, 348, 350, 369.
  Okuma ilkesi ve nesne dili `Pilot.lean` ile aynıdır: her formül, bir
  kaide şemasının tek bir olaydaki örneğidir. Atom numaraları 22'den başlar.

  Metinler 1887 baskısından (archive.org `mecelleyiahkmiad00turk`) okunmuştur.

  `-- ANCHOR: ad` / `-- ANCHOR_END: ad` satırlarını silmeyin.
-/
import ModernMantik.Mecelle.Pilot

namespace Mecelle.Uzanti

open Bolum10 Bolum10.Formul Mecelle.Pilot

/-! ## 1. Yeni atomlar -/

-- ANCHOR: atomlar
-- Mâni ve sukût (md. 24, 51)
def maniZail     : Formul := atom 22  -- bir hükmü durduran engel kalkmıştır
def avdet        : Formul := atom 23  -- durmuş olan hüküm ya da hak yeniden işler
def sakit        : Formul := atom 24  -- hak düşürülmüştür (ıskat edilmiştir)
-- Tasrih, delâlet ve ıtlak (md. 13, 36, 64; md. 251)
def tasrih       : Formul := atom 25  -- akitte konuya ilişkin açık bir söz vardır
def delaletGore  : Formul := atom 26  -- hüküm bir delâlete (dolaylı anlatıma) göre verilir
def mutlak       : Formul := atom 27  -- söz kayıtsız (mutlak) söylenmiştir
def mutlakGore   : Formul := atom 28  -- hüküm sözün kayıtsız anlamına göre verilir
-- Yarar ve hasar (md. 85, 87; md. 236, 293, 294, 369)
def akit         : Formul := atom 29  -- satış akdi kurulmuştur
def teslim       : Formul := atom 30  -- satılan mal alıcıya teslim edilmiştir
def yararAlici   : Formul := atom 31  -- satılan malın ürün ve artışı alıcıya aittir
def hasarAlici   : Formul := atom 32  -- satılan malın telef hasarı alıcıya aittir
-- Örtük rıza (md. 100; md. 344, 348, 350)
def bilgi        : Formul := atom 33  -- alıcı eski ayıbı bilmektedir
def tasarruf     : Formul := atom 34  -- alıcı malda mülkiyet gereği bir tasarrufta bulunmuştur
def riza         : Formul := atom 35  -- alıcı ayıba razı olmuştur
def iadeMumkun   : Formul := atom 36  -- malı satıcıya geri vermek hâlâ mümkündür
def kusurHakki   : Formul := atom 37  -- alıcının ayıp için bir hakkı (iade ya da bedel eksikliği) vardır
-- ANCHOR_END: atomlar

/-! ## 2. Kaideler, maddeler ve köprüler -/

-- ANCHOR: kaideler
-- md. 13  Tasrih mukabelesinde delâlete itibar yoktur.
def md13  : Formul := tasrih ⟹ ∼delaletGore
-- md. 23  Bir özür için caiz olan şey ol özrün zevaliyle bâtıl olur.
--         (Özür = zaruret, caiz = aslen memnu fiilin mübahlığı.)
def md23  : Formul := aslenMemnu ⋀ ∼zaruret ⟹ ∼mubah
-- md. 24  Mâni zâil oldukta memnu avdet eder.
def md24  : Formul := maniZail ⟹ avdet
-- md. 51  Sâkıt olan şey avdet etmez.
def md51  : Formul := sakit ⟹ ∼avdet
-- md. 64  Mutlak ıtlakı üzere cârî olur, eğer nassan yahut delâleten takyid
--         delili bulunmaz ise. (İstisna maddenin kendi metnindedir.)
def md64  : Formul := mutlak ⋀ ∼tasrih ⋀ ∼orf ⟹ mutlakGore
-- md. 85  Bir şeyin nef'i zımanı mukabelesindedir: hasarı taşıyan yararı alır.
def md85  : Formul := hasarAlici ⟹ yararAlici
-- md. 87  Mazarrat menfaat mukabelesindedir: yararı alan hasara katlanır.
def md87  : Formul := yararAlici ⟹ hasarAlici
-- md. 100 Kendi tarafından tamam olan şeyi nakza çalışanın sa'yi merduddur.
def md100 : Formul := riza ⟹ ∼kusurHakki
-- ANCHOR_END: kaideler

-- ANCHOR: maddeler
-- Kitâbü'l-Büyû'dan maddeler
-- md. 236  Akitten sonra, teslimden önce meydana gelen ürün alıcıya aittir.
def md236 : Formul := akit ⋀ ∼teslim ⟹ yararAlici
-- md. 293  Teslimden önce telef olan malın zararı satıcıya aittir.
def md293 : Formul := akit ⋀ ∼teslim ⟹ ∼hasarAlici
-- md. 294  Teslimden sonra telef olan malın zararı alıcıya aittir.
def md294 : Formul := akit ⋀ teslim ⟹ hasarAlici
-- md. 369  Kurulmuş satışın hükmü mülkiyettir (yarar mülkiyeti izler).
def md369 : Formul := akit ⟹ yararAlici
-- md. 348  Geri vermek mümkünken, ayıbı öğrendikten sonra satan bedel eksikliğini isteyemez.
def md348 : Formul := bilgi ⋀ tasarruf ⋀ iadeMumkun ⟹ ∼kusurHakki
-- md. 350  Geri vermeye engel varsa, ayıbı öğrendikten sonra satsa bile bedel eksikliğini alır.
def md350 : Formul := bilgi ⋀ tasarruf ⋀ ∼iadeMumkun ⟹ kusurHakki
-- ANCHOR_END: maddeler

-- ANCHOR: kopruler
-- Yeni köprü ilkeleri (Pilot'taki K1–K5'in devamı)
def K6 : Formul := maniZail ⟹ ∼sakit             -- engelin kalkması, hakkın düşmediğini (yalnız durduğunu) varsayar
def K7 : Formul := orfeGore ⟹ delaletGore        -- örfe göre hüküm, bir delâlete göre hükümdür
def K8 : Formul := ∼(orfeGore ⋀ mutlakGore)       -- aynı sözü hem örfe hem kayıtsız anlamına göre yorumlamak olmaz
def K9 : Formul := bilgi ⋀ tasarruf ⟹ riza        -- bilerek tasarruf ayıba rızadır (md. 344'ün kendi gerekçesi)
-- ANCHOR_END: kopruler

/-! ## 3. Yardımcı -/

macro "ac2" : tactic => `(tactic|
  simp only [hepsi, tepe, degil, esd, md13, md21, md21t, md22, md23, md24, md36, md51,
    md64, md85, md87, md100, md236, md293, md294, md369, md348, md350, K6, K7, K8, K9,
    zaruret, aslenMemnu, mubah, miktariAsar, orf, orfeGore, maniZail, avdet, sakit,
    tasrih, delaletGore, mutlak, mutlakGore, akit, teslim, yararAlici, hasarAlici,
    bilgi, tasarruf, riza, iadeMumkun, kusurHakki, deger] at *)

/-! ## 4. Bulgular -/

/-! ### U1–U2. Zaruret: ruhsatın çift yönlülüğü (md. 21–23) -/

-- ANCHOR: zaruret_cift_yon
-- U1. md. 23, md. 21'den çıkmaz: "zaruret varsa mübah" önermesinden
-- "zaruret yoksa mübah değil" çıkmaz (öncülün reddi). md. 23 bunu ayrıca koyar.
theorem md23_md21den_cikmaz : ¬ Sonuc [md21] md23 := by
  intro h; have := h (model [7, 8]) (by decide); revert this; decide

-- U2. md. 21′, 22 ve 23 birlikte, aslen yasak bir fiil için mübahlığı tam olarak
-- tanımlar: fiil ancak ve ancak zaruret varsa ve zaruretin miktarını aşmıyorsa mübahtır.
theorem ruhsat_tanimi :
    Sonuc [md21t, md22, md23, aslenMemnu] (esd mubah (zaruret ⋀ ∼miktariAsar)) := by
  intro v h
  have h1 := h md21t (by simp); have h2 := h md22 (by simp)
  have h3 := h md23 (by simp); have h4 := h aslenMemnu (by simp)
  ac2; revert h1 h2 h3 h4
  generalize v 6 = a; generalize v 7 = b; generalize v 8 = c; generalize v 9 = d
  revert a b c d; decide
-- ANCHOR_END: zaruret_cift_yon

/-! ### U3–U4. Mâni ve sukût (md. 24, 51) -/

-- ANCHOR: mani_sukut
-- U3. Harfiyen okunursa md. 24 ve md. 51, engeli kalkmış ama hakkı düşmüş bir
-- olayda çatışır: biri hakkın döndüğünü, öteki dönmediğini söyler.
theorem md24_md51_catisir :
    ¬ Saglanabilir (hepsi [md24, md51, maniZail, sakit]) := by
  intro ⟨v, h⟩; ac2; revert h
  generalize v 22 = a; generalize v 23 = b; generalize v 24 = c
  revert a b c; decide

-- U4. K6 bu olayı dışlar; K6 ile iki kaide, engeli kalkmış olaylarda tutarlıdır.
theorem K6_catismayi_dislar : ¬ Saglanabilir (hepsi [K6, maniZail, sakit]) := by
  intro ⟨v, h⟩; ac2; revert h
  generalize v 22 = a; generalize v 24 = b
  revert a b; decide

theorem mani_sukut_tutarli : Saglanabilir (hepsi [md24, md51, K6, maniZail]) :=
  ⟨model [22, 23], by decide⟩
-- ANCHOR_END: mani_sukut

/-! ### U5–U8. Tasrih, örf ve ıtlak (md. 13, 36, 64; md. 251) -/

-- ANCHOR: yorum_merdiveni
-- U5. md. 36 harfiyen okunursa, akitte açık söz ile örf birlikte bulunduğunda
-- md. 13 ile çatışır (K7 ile örfe göre hüküm bir delâlettir).
theorem md13_md36_catisir :
    ¬ Saglanabilir (hepsi [md13, md36, K7, tasrih, orf]) := by
  intro ⟨v, h⟩; ac2; revert h
  generalize v 20 = a; generalize v 21 = b; generalize v 25 = c; generalize v 26 = d
  revert a b c d; decide

-- U6. md. 13, md. 36'yı tahsis eder: örf ancak açık söz yokken hakemdir.
def md36t : Formul := orf ⋀ ∼tasrih ⟹ orfeGore

theorem md36_md36tyi_gerektirir : Sonuc [md36] md36t := by
  intro v h
  have h1 := h md36 (by simp)
  simp only [md36t]; ac2; revert h1
  generalize v 20 = a; generalize v 21 = b; generalize v 25 = c
  revert a b c; decide

theorem tasrih_tahsisi_tutarli :
    Saglanabilir (hepsi [md13, md36t, K7, tasrih, orf]) :=
  ⟨model [20, 25], by decide⟩

-- U7. md. 64'ün istisnası kendi metnindedir; bu yüzden md. 36′ ile çatışmaz.
-- Kayıtsız söz, açık söz ve örf birlikte üç basamaklı bir sıra kurar.
-- md. 251'in üç durumu bu sıradan çıkar:
-- (a) kayıtsız satış, açık söz yok, örf var  ⇒ örfe göre (kayıtsız anlama göre değil)
theorem md251_orf :
    Sonuc [md36t, md64, K8, mutlak, ∼tasrih, orf] (orfeGore ⋀ ∼mutlakGore) := by
  intro v h
  have h1 := h md36t (by simp); have h2 := h md64 (by simp); have h3 := h K8 (by simp)
  have h4 := h mutlak (by simp); have h5 := h (∼tasrih) (by simp); have h6 := h orf (by simp)
  simp only [md36t] at *; ac2; revert h1 h2 h3 h4 h5 h6
  generalize v 20 = a; generalize v 21 = b; generalize v 25 = c
  generalize v 27 = d; generalize v 28 = e
  revert a b c d e; decide

-- (b) kayıtsız satış, açık söz yok, örf yok  ⇒ kayıtsız anlama göre (peşin)
theorem md251_mutlak :
    Sonuc [md64, mutlak, ∼tasrih, ∼orf] mutlakGore := by
  intro v h
  have h1 := h md64 (by simp); have h2 := h mutlak (by simp)
  have h3 := h (∼tasrih) (by simp); have h4 := h (∼orf) (by simp)
  ac2; revert h1 h2 h3 h4
  generalize v 20 = a; generalize v 25 = b; generalize v 27 = c; generalize v 28 = d
  revert a b c d; decide

-- (c) açık söz var  ⇒ örfe göre hüküm verilmez
theorem md251_tasrih :
    Sonuc [md13, K7, tasrih] (∼orfeGore) := by
  intro v h
  have h1 := h md13 (by simp); have h2 := h K7 (by simp); have h3 := h tasrih (by simp)
  ac2; revert h1 h2 h3
  generalize v 21 = a; generalize v 25 = b; generalize v 26 = c
  revert a b c; decide

-- U8. Bu tek sözlükte md. 36 ile md. 45 ("örf ile tayin nas ile tayin gibidir")
-- aynı formüle düşer: ikisinin farkı yalnız "gibi" benzetmesindedir.
def md45 : Formul := orf ⟹ orfeGore
theorem md36_md45_ayni : md36 = md45 := rfl
-- ANCHOR_END: yorum_merdiveni

/-! ### U9–U11. Yarar, hasar ve teslim (md. 85, 87; md. 236, 293, 294, 369) -/

-- ANCHOR: yarar_hasar
-- U9. md. 87 harfiyen okunursa, akitten sonra teslimden önceki dönemde
-- md. 236 ve md. 293 ile çatışır: ürün alıcının, hasar satıcınındır.
theorem md87_satis_catisir :
    ¬ Saglanabilir (hepsi [md87, md236, md293, akit, ∼teslim]) := by
  intro ⟨v, h⟩; ac2; revert h
  generalize v 29 = a; generalize v 30 = b; generalize v 31 = c; generalize v 32 = d
  revert a b c d; decide

-- U10. Çatışma, hasarın eldeliğe (teslime) bağlanmasıyla kalkar.
def md87t : Formul := yararAlici ⋀ teslim ⟹ hasarAlici

theorem md87_md87tyi_gerektirir : Sonuc [md87] md87t := by
  intro v h
  have h1 := h md87 (by simp)
  simp only [md87t]; ac2; revert h1
  generalize v 30 = a; generalize v 31 = b; generalize v 32 = c
  revert a b c; decide

theorem teslim_tahsisi_tutarli :
    Saglanabilir (hepsi [md85, md87t, md236, md293, md294, md369, akit, ∼teslim]) :=
  ⟨model [29, 31], by decide⟩

-- U11. Kaide maddeyi yönetir: md. 294, tahsis edilmiş md. 87 ile md. 369'dan çıkar.
theorem md294_kaideden : Sonuc [md87t, md369] md294 := by
  intro v h
  have h1 := h md87t (by simp); have h2 := h md369 (by simp)
  simp only [md87t] at *; ac2; revert h1 h2
  generalize v 29 = a; generalize v 30 = b; generalize v 31 = c; generalize v 32 = d
  revert a b c d; decide

-- Ama md. 293 kaidelerden çıkmaz; teslimden önceki hasar kuralı kendi başına bir hükümdür.
theorem md293_kaideden_cikmaz : ¬ Sonuc [md85, md87t, md369] md293 := by
  intro h; have := h (model [29, 31, 32]) (by decide); revert this; decide
-- ANCHOR_END: yarar_hasar

/-! ### U12–U14. Örtük rıza (md. 100; md. 344, 348, 350) -/

-- ANCHOR: ortuk_riza
-- U12. K9 ve md. 100'den genel bir şema çıkar: ayıbı bilerek tasarruf eden,
-- ayıp için bir hak iddia edemez.
def sema : Formul := bilgi ⋀ tasarruf ⟹ ∼kusurHakki

theorem sema_turetilir : Sonuc [K9, md100] sema := by
  intro v h
  have h1 := h K9 (by simp); have h2 := h md100 (by simp)
  simp only [sema]; ac2; revert h1 h2
  generalize v 33 = a; generalize v 34 = b; generalize v 35 = c; generalize v 37 = d
  revert a b c d; decide

-- U13. Şema harfiyen okunursa md. 350 ile çatışır: iade imkânsızken satan alıcı
-- bedel eksikliğini yine alır.
theorem sema_md350_catisir :
    ¬ Saglanabilir (hepsi [K9, md100, md350, bilgi, tasarruf, ∼iadeMumkun]) := by
  intro ⟨v, h⟩; ac2; revert h
  generalize v 33 = a; generalize v 34 = b; generalize v 35 = c
  generalize v 36 = d; generalize v 37 = e
  revert a b c d e; decide

-- U14. Köprü "iade mümkünse" koşuluyla daraltılınca çatışma kalkar ve md. 348 çıkar.
def K9t : Formul := bilgi ⋀ tasarruf ⋀ iadeMumkun ⟹ riza

theorem K9_K9tyi_gerektirir : Sonuc [K9] K9t := by
  intro v h
  have h1 := h K9 (by simp)
  simp only [K9t]; ac2; revert h1
  generalize v 33 = a; generalize v 34 = b; generalize v 35 = c; generalize v 36 = d
  revert a b c d; decide

theorem md348_kaideden : Sonuc [K9t, md100] md348 := by
  intro v h
  have h1 := h K9t (by simp); have h2 := h md100 (by simp)
  simp only [K9t] at *; ac2; revert h1 h2
  generalize v 33 = a; generalize v 34 = b; generalize v 35 = c
  generalize v 36 = d; generalize v 37 = e
  revert a b c d e; decide

theorem riza_tahsisi_tutarli :
    Saglanabilir (hepsi [K9t, md100, md348, md350, bilgi, tasarruf, ∼iadeMumkun]) :=
  ⟨model [33, 34, 37], by decide⟩
-- ANCHOR_END: ortuk_riza

end Mecelle.Uzanti
