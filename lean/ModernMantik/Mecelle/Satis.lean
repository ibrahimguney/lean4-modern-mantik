/-
  Lean 4 ile Modern Mantık — Uygulama
  Mecelle: 99 kaide ile Satış Kitabı (Kitâbü'l-Büyû') birlikte

  Bu dosya kulliyat/satis_lean.py ile üretilmiştir; elle değiştirmeyin.
  Tanımlar: kulliyat/satis_spec.py. Kaideler, atomlar ve köprüler
  Kulliyat.lean'den gelir; burada Satış Kitabı'nın atomları (200-),
  maddeleri (sNNN), satış köprüleri (S1-) ve kısıtlamaları tanımlanır.
-/
import ModernMantik.Mecelle.Kulliyat

namespace Mecelle.Satis

open Bolum10 Bolum10.Formul Mecelle.Kulliyat

set_option linter.unusedSimpArgs false
set_option maxRecDepth 100000
set_option synthInstance.maxHeartbeats 2000000
set_option maxHeartbeats 4000000

/-! ## 1. Satış Kitabı atomları -/

def gecmisKip           : Formul := atom 200  -- icap ve kabul geçmiş zaman kipiyle söylenmiştir
def genisKip            : Formul := atom 201  -- icap ve kabul geniş zaman kipiyle söylenmiştir
def simdikiKast         : Formul := atom 202  -- taraflar şimdiki zamanı (hemen satışı) kastetmiştir
def vaatKipi            : Formul := atom 203  -- yalnız vaat anlamı taşıyan gelecek zaman kipi kullanılmıştır
def emirKipi            : Formul := atom 204  -- emir kipi kullanılmıştır
def icapIcerik          : Formul := atom 205  -- bildirim, şimdiki bir satış için icap ve kabul içerir
def sozluIcap           : Formul := atom 206  -- icap ve kabul sözle, şimdiki satış anlamında yapılmıştır
def fiiliTeati          : Formul := atom 207  -- taraflar malı ve bedeli fiilen alıp vermiştir
def satisKurulur        : Formul := atom 208  -- satış kurulur (münakit olur)
def sartAkitGeregi      : Formul := atom 210  -- şart akdin gereğidir
def sartPekistirir      : Formul := atom 211  -- şart akdin gereğini pekiştirir (rehin, kefil)
def sartMutearef        : Formul := atom 212  -- şart memlekette örf olarak yerleşmiştir
def sartYararsiz        : Formul := atom 213  -- şartın taraflardan hiçbirine yararı yoktur
def satisSahih          : Formul := atom 214  -- satış sahihtir
def sartGecerli         : Formul := atom 215  -- şart geçerlidir
def orfenKapsamda       : Formul := atom 216  -- şey örfte satılanın adının kapsamındadır
def parcaHukmunde       : Formul := atom 217  -- şey satılanın parçası hükmündedir
def surekliEklenti      : Formul := atom 218  -- şey satılana sürekli bağlı bir eklentidir
def anildi              : Formul := atom 219  -- şey satışta ayrıca anılmıştır
def satisaDahil         : Formul := atom 220  -- şey satışa dahildir
def bedeldenPay         : Formul := atom 221  -- şeyin bedelden bir payı vardır
def pesin               : Formul := atom 222  -- bedel peşin ödenir
def orfVadeli           : Formul := atom 223  -- konudaki örf satışın vadeli olmasıdır
def malinYerindeTeslim  : Formul := atom 224  -- mal, akit sırasında bulunduğu yerde teslim edilir
def teslimBedelsiz      : Formul := atom 225  -- satıcı bedeli almadan malı teslim etmiştir
def geriAlma            : Formul := atom 226  -- satıcı malı alıkoymak üzere geri alabilir
def eskiAyip            : Formul := atom 230  -- malda eski (satıcının elindeyken var olan) bir ayıp vardır
def yeniAyip            : Formul := atom 231  -- malda alıcının elindeyken yeni bir ayıp meydana gelmiştir
def yeniAyipKalkti      : Formul := atom 232  -- yeni ayıp ortadan kalkmıştır
def saticiIadeyeRazi    : Formul := atom 233  -- satıcı malı yeni ayıbıyla geri almaya razıdır
def fazlalik            : Formul := atom 234  -- mala alıcının malından bir şey katılmıştır (dikiş, boya)
def iadeHakki           : Formul := atom 235  -- alıcı malı geri verebilir (red hakkı)
def bedelEksikligi      : Formul := atom 236  -- alıcı bedel eksikliği (nuksân-ı semen) isteyebilir
def ayipAciklandi       : Formul := atom 237  -- satıcı ayıbı açıklamış, alıcı o ayıpla kabul etmiştir
def beraatSarti         : Formul := atom 238  -- satıcı ayıptan sorumlu olmamayı şart koşmuştur
def herAyibiylaKabul    : Formul := atom 239  -- alıcı 'her ayıbıyla kabulümdür' demiştir
def ayipsizGerekir      : Formul := atom 240  -- malın ayıptan salim olması gerekir
def azBozuk             : Formul := atom 241  -- bozukluk örfe göre az sayılacak ölçüdedir
def vasifSoylendi       : Formul := atom 245  -- satıcı malın istenen bir niteliği olduğunu söylemiştir
def vasifYok            : Formul := atom 246  -- mal o nitelikten yoksundur
def vasifHakki          : Formul := atom 247  -- alıcının vasıf muhayyerliği vardır
def gormeHakki          : Formul := atom 253  -- alıcının görme muhayyerliği vardır
def gabnHakki           : Formul := atom 254  -- aldanan tarafın fesih hakkı vardır
def gormedenAldi        : Formul := atom 248  -- alıcı malı akit sırasında görmemiştir
def onceGordu           : Formul := atom 249  -- alıcı malı daha önce satın alma amacıyla görmüştür
def gabn                : Formul := atom 250  -- satışta aşırı aldanma (gabn-i fâhiş) vardır
def tagrir              : Formul := atom 251  -- taraflardan biri öbürünü aldatmıştır
def gabnBilgisi         : Formul := atom 252  -- aldatılan, aşırı aldanmayı öğrenmiştir
def izinleAlindi        : Formul := atom 255  -- mal, sahibinin izniyle teslim alınmıştır
def kusur               : Formul := atom 256  -- telef, teslim alanın kusuruyla (taaddi) olmuştur
def gormekIcinAlindi    : Formul := atom 257  -- mal görmek ya da göstermek için alınmıştır
def sevmIleAlindi       : Formul := atom 258  -- mal bedeli belirtilerek satın almak üzere alınmıştır
def fasidSatis          : Formul := atom 259  -- satış fâsiddir
def batilSatis          : Formul := atom 260  -- satış bâtıldır
def telef               : Formul := atom 261  -- mal, alanın elinde telef olmuştur
def bedelKarsiligi      : Formul := atom 262  -- mal bir bedel karşılığı (mübadele amacıyla) tutulmaktadır
def satisNafiz          : Formul := atom 265  -- satış nâfizdir
def yetkili             : Formul := atom 266  -- satıcı malikin vekili, velisi ya da vasisidir
def baskaHak            : Formul := atom 267  -- malda başkasının hakkı vardır
def fuzuliSatis         : Formul := atom 268  -- satış fuzulinin satışıdır
def rehinliSatis        : Formul := atom 269  -- satılan mal rehinlidir
def icazet              : Formul := atom 270  -- hak sahibi satışa icazet vermiştir
def istisna             : Formul := atom 275  -- akit bir istisna (sipariş) akdidir
def istisnaSahih        : Formul := atom 276  -- istisna akdi sahihtir
def tarifeUygun         : Formul := atom 277  -- yapılan şey tarife uygundur
def donmeHakki          : Formul := atom 278  -- sipariş veren pazarlıktan dönebilir

/-! ## 2. Maddeler -/

def s168  : Formul := sozluIcap ⟹ satisKurulur  -- İcap ve kabul, satışı kuran sözlerdir.
def s169  : Formul := gecmisKip ⟹ sozluIcap  -- Geçmiş zaman kipi icap ve kabuldür.
def s170  : Formul := ((genisKip ⋀ simdikiKast) ⟹ sozluIcap) ⋀ ((genisKip ⋀ ∼simdikiKast) ⟹ ∼sozluIcap)
def s171  : Formul := vaatKipi ⟹ ∼sozluIcap
def s172  : Formul := ((emirKipi ⋀ ∼simdikiKast) ⟹ ∼sozluIcap) ⋀ ((emirKipi ⋀ simdikiKast) ⟹ sozluIcap)
def s173  : Formul := (mukatebe ⋀ icapIcerik) ⟹ satisKurulur  -- Yazışmayla.
def s174  : Formul := (dilsizIsaret ⋀ icapIcerik) ⟹ satisKurulur
def s175  : Formul := fiiliTeati ⟹ satisKurulur  -- Bey'-i teâtî.
def s186  : Formul := sartAkitGeregi ⟹ (satisSahih ⋀ sartGecerli)
def s187  : Formul := sartPekistirir ⟹ (satisSahih ⋀ sartGecerli)
def s188  : Formul := sartMutearef ⟹ (satisSahih ⋀ sartGecerli)
def s189  : Formul := sartYararsiz ⟹ (satisSahih ⋀ ∼sartGecerli)  -- Şart lağvdır.
def s230  : Formul := orfenKapsamda ⟹ satisaDahil
def s231  : Formul := parcaHukmunde ⟹ satisaDahil
def s232  : Formul := surekliEklenti ⟹ satisaDahil
def s233  : Formul := (((∼orfenKapsamda ⋀ ∼parcaHukmunde) ⋀ ∼surekliEklenti) ⋀ ∼anildi) ⟹ ∼satisaDahil
def s234  : Formul := (tabi ⋀ satisaDahil) ⟹ ∼bedeldenPay  -- Bağlı olarak dahil olanın bedelden payı yoktur.
def s236  : Formul := (akit ⋀ ∼teslim) ⟹ yararAlici  -- Uzantı.
def s251  : Formul := (((mutlak ⋀ ∼tasrih) ⋀ ∼orf) ⟹ pesin) ⋀ ((((mutlak ⋀ ∼tasrih) ⋀ orf) ⋀ orfVadeli) ⟹ ∼pesin)  -- Uzantı U7'nin formülü.
def s281  : Formul := teslimBedelsiz ⟹ ∼geriAlma  -- Alıkoyma hakkı düşer.
def s285  : Formul := (mutlak ⋀ ∼tasrih) ⟹ malinYerindeTeslim
def s293  : Formul := (akit ⋀ ∼teslim) ⟹ ∼hasarAlici  -- Uzantı.
def s294  : Formul := (akit ⋀ teslim) ⟹ hasarAlici  -- Uzantı.
def s298  : Formul := (sevmIleAlindi ⋀ telef) ⟹ tazmin  -- Satın almak üzere alınan.
def s299  : Formul := ((gormekIcinAlindi ⋀ telef) ⋀ ∼kusur) ⟹ ∼tazmin  -- Emanet.
def s369  : Formul := akit ⟹ yararAlici  -- Satışın hükmü mülkiyettir (uzantı).
def s370  : Formul := (((batilSatis ⋀ izinleAlindi) ⋀ telef) ⋀ ∼kusur) ⟹ ∼tazmin  -- Emanet.
def s371  : Formul := ((fasidSatis ⋀ izinleAlindi) ⋀ telef) ⟹ tazmin
def s336  : Formul := (mutlak ⋀ ∼tasrih) ⟹ ayipsizGerekir
def s337  : Formul := ((eskiAyip ⋀ ∼riza) ⟹ iadeHakki) ⋀ (iadeHakki ⟹ ∼bedelEksikligi)  -- Red ya da tam bedelle kabul; alıkoyup indirim yok.
def s341  : Formul := ayipAciklandi ⟹ ∼kusurHakki
def s342  : Formul := beraatSarti ⟹ ∼kusurHakki
def s343  : Formul := herAyibiylaKabul ⟹ ∼kusurHakki
def s344  : Formul := ((eskiAyip ⋀ bilgi) ⋀ tasarruf) ⟹ ∼kusurHakki  -- Metin: 'bu ayıba rıza demek olduğundan'.
def s345  : Formul := (eskiAyip ⋀ yeniAyip) ⟹ (∼iadeHakki ⋀ bedelEksikligi)
def s347  : Formul := (eskiAyip ⋀ yeniAyipKalkti) ⟹ iadeHakki
def s348  : Formul := ((eskiAyip ⋀ yeniAyip) ⋀ saticiIadeyeRazi) ⟹ (iadeHakki ⋀ ∼bedelEksikligi)  -- Metin: 'geri vermeye engel kalmadığından'.
def s349  : Formul := fazlalik ⟹ ∼iadeMumkun
def s350  : Formul := ((eskiAyip ⋀ ∼iadeMumkun) ⟹ bedelEksikligi) ⋀ ((∼iadeMumkun ⋀ saticiIadeyeRazi) ⟹ ∼iadeHakki)  -- Satıcı razı olsa bile geri alamaz; alıcı satsa bile indirim alır.
def s354  : Formul := azBozuk ⟹ ∼iadeHakki  -- Yüzde üç gibi az bozukluk affedilir.
def s310  : Formul := (vasifSoylendi ⋀ vasifYok) ⟹ vasifHakki  -- Vasıf muhayyerliği.
def s312  : Formul := (vasifSoylendi ⋀ tasarruf) ⟹ ∼vasifHakki  -- Metinde bilgi şartı yok.
def s320  : Formul := gormedenAldi ⟹ gormeHakki  -- Görme muhayyerliği.
def s332  : Formul := ((gormedenAldi ⋀ onceGordu) ⋀ ∼degisimSabit) ⟹ ∼gormeHakki  -- Görülmüş mal değişmemişse.
def s335  : Formul := (gormedenAldi ⋀ tasarruf) ⟹ ∼gormeHakki  -- Metinde bilgi şartı yok.
def s356  : Formul := (gabn ⋀ ∼tagrir) ⟹ ∼gabnHakki
def s357  : Formul := (gabn ⋀ tagrir) ⟹ gabnHakki
def s359  : Formul := (((gabn ⋀ tagrir) ⋀ gabnBilgisi) ⋀ tasarruf) ⟹ ∼gabnHakki
def s365  : Formul := satisNafiz ⟹ ((malik ⋁ yetkili) ⋀ ∼baskaHak)  -- Nâfiz olmanın şartları.
def s368  : Formul := (fuzuliSatis ⟹ (satisKurulur ⋀ ∼satisNafiz)) ⋀ (rehinliSatis ⟹ (satisKurulur ⋀ ∼satisNafiz))  -- Mevkuf satış.
def s378  : Formul := (fuzuliSatis ⋀ icazet) ⟹ satisNafiz
def s389  : Formul := (istisna ⋀ yayginKullanim) ⟹ istisnaSahih  -- Teamül olan şeylerde.
def s392  : Formul := ((istisna ⋀ tarifeUygun) ⟹ ∼donmeHakki) ⋀ ((istisna ⋀ ∼tarifeUygun) ⟹ donmeHakki)

/-! ## 3. Satış köprüleri -/

def S1  : Formul := (muhatabeGibi ⋀ icapIcerik) ⟹ sozluIcap  -- Yüz yüze konuşma gibi olan yazışma, sözlü icaptır (md. 69'un satışa uygulanması).
def S2  : Formul := (dilleBeyanGibi ⋀ icapIcerik) ⟹ sozluIcap  -- Dille beyan gibi olan işaret, sözlü icaptır (md. 70).
def S3  : Formul := fiiliTeati ⟹ maksat  -- Fiilen alıp verme, satış maksadını gösterir.
def S4  : Formul := (hukumM ⋀ fiiliTeati) ⟹ satisKurulur  -- Satış maksadına uygun hüküm, fiilî alışverişte satışın kurulmasıdır (md. 2'de M = satış).
def S5  : Formul := simdikiKast ⟹ maksat  -- Şimdiki zamanı kastetmek, satış maksadıdır.
def S6  : Formul := vaatKipi ⟹ ∼simdikiKast  -- Yalnız vaat anlamı taşıyan söz şimdiki satışı kastetmez.
def S7  : Formul := sartGecerli ⟹ sartliAkit  -- Geçerli bir şart, akitte bir şarttır.
def S8  : Formul := ∼(sartYararsiz ⋀ ((sartAkitGeregi ⋁ sartPekistirir) ⋁ sartMutearef))  -- Akdin gereği, pekiştirici ya da yerleşik bir şart yararsız değildir.
def S9  : Formul := parcaHukmunde ⟹ tabi  -- Parça hükmündeki şey satılana tâbidir.
def S10 : Formul := surekliEklenti ⟹ tabi  -- Sürekli eklenti satılana tâbidir.
def S11 : Formul := tabiHukum ⟹ satisaDahil  -- Hükümde satılana tâbi olan satışa dahildir.
def S12 : Formul := bedeldenPay ⟹ ayriHukum  -- Bedelden pay almak, ayrıca hüküm verilmektir.
def S13 : Formul := orfenKapsamda ⟹ orfenMaruf  -- Örfte satılanın kapsamında olan, örfen bilinendir.
def S14 : Formul := (orfenKapsamda ⋀ sartGibi) ⟹ satisaDahil  -- Şart koşulmuş gibi olan kapsam, satışa dahildir.
def S15 : Formul := mutlakGore ⟹ ((pesin ⋀ malinYerindeTeslim) ⋀ ayipsizGerekir)  -- Satışın kayıtsız anlamı: peşin, malın yerinde teslim, ayıpsız mal.
def S16 : Formul := orfVadeli ⟹ (orf ⋀ muttarid)  -- Satışın vadeli olduğu örf, konuda yerleşik bir örftür.
def S17 : Formul := (orfeGore ⋀ orfVadeli) ⟹ ∼pesin  -- Vadeli örfe göre hüküm, peşin olmamaktır.
def S18 : Formul := teslimBedelsiz ⟹ sakit  -- Bedelsiz teslim, alıkoyma hakkını düşürmektir.
def S19 : Formul := geriAlma ⟹ avdet  -- Malı alıkoymak üzere geri almak, düşen hakkın dönmesidir.
def S20 : Formul := yeniAyipKalkti ⟹ maniZail  -- Yeni ayıbın kalkması, iadeye engelin kalkmasıdır.
def S21 : Formul := saticiIadeyeRazi ⟹ maniZail  -- Satıcının razı olması, yeni ayıptan doğan engeli kaldırır.
def S22 : Formul := (eskiAyip ⋀ avdet) ⟹ iadeHakki  -- Engel kalkınca dönen hak, eski ayıptan doğan iade hakkıdır.
def S23 : Formul := iadeHakki ⟹ tedbirCaiz  -- İade, ayıbın zararını gidermek için caiz bir tedbirdir.
def S24 : Formul := (((eskiAyip ⋀ yeniAyip) ⋀ ∼yeniAyipKalkti) ⋀ ∼saticiIadeyeRazi) ⟹ misil  -- Yeni ayıplı malı geri vermek, satıcıya alıcınınkine denk bir zarar yükler.
def S25 : Formul := ((eskiAyip ⋀ ∼riza) ⋀ ∼iadeHakki) ⟹ ∼asilIfaMumkun  -- Alıcı ayıba razı değilken iade yoksa, aslın (malın sağlam teslimi) ifası mümkün değildir.
def S26 : Formul := bedelIfa ⟹ bedelEksikligi  -- Aslın bedelini ifa etmek, bedel eksikliğini ödemektir.
def S27 : Formul := iadeHakki ⟹ iadeMumkun  -- İade hakkı iadenin mümkün olmasını gerektirir.
def S28 : Formul := (kusurHakki ⟹ (iadeHakki ⋁ bedelEksikligi)) ⋀ ((iadeHakki ⋁ bedelEksikligi) ⟹ kusurHakki)  -- Ayıp hakkı, red ya da bedel eksikliği hakkıdır.
def S29 : Formul := ayipAciklandi ⟹ riza  -- Açıklanan ayıpla kabul rızadır.
def S30 : Formul := beraatSarti ⟹ riza  -- Ayıptan berâet şartını kabul etmek rızadır.
def S31 : Formul := herAyibiylaKabul ⟹ riza  -- Her ayıbıyla kabul rızadır.
def S32 : Formul := azBozuk ⟹ nadir  -- Örfe göre az bozukluk nadirdir.
def S33 : Formul := (iadeHakki ⋀ azBozuk) ⟹ muteber  -- Az bozukluk yüzünden iade, o bozukluğa itibar etmektir.
def S36 : Formul := onceGordu ⟹ yakin  -- Daha önce görülen malın hâli bilinmektedir.
def S37 : Formul := (hukumA ⋀ onceGordu) ⟹ ∼gormeHakki  -- Aynı hâlde sayılan, önceden görülmüş mal görülmüş sayılır.
def S38 : Formul := izinleAlindi ⟹ mubah  -- Sahibinin izniyle teslim almak caizdir.
def S39 : Formul := ∼kusur ⟹ ∼mubasir  -- Kusursuz telefte tutan kişi zararı doğrudan vermiş değildir.
def S40 : Formul := gormekIcinAlindi ⟹ izinleAlindi  -- Görmek için alınan mal sahibinin izniyle alınmıştır.
def S41 : Formul := sevmIleAlindi ⟹ (izinleAlindi ⋀ bedelKarsiligi)  -- Satın almak üzere alınan mal izinle ve bedel karşılığı alınmıştır.
def S42 : Formul := (fasidSatis ⋀ izinleAlindi) ⟹ bedelKarsiligi  -- Fâsid satışla teslim alınan mal bedel karşılığı tutulmaktadır.
def S43 : Formul := (∼malik ⋀ ∼yetkili) ⟹ (gayrinMali ⋀ ∼izin)  -- Satıcı ne malik ne yetkiliyse, sattığı başkasının malıdır ve izni yoktur.
def S45 : Formul := (baskaHak ⋀ ∼icazet) ⟹ mani  -- Malda başkasının hakkı, satışa engeldir.
def S46 : Formul := rehinliSatis ⟹ baskaHak  -- Rehinli malda alacaklının hakkı vardır.
def S47 : Formul := akit ⟹ muktezi  -- Kurulmuş satış, hükmünü gerektirir.
def S48 : Formul := satisNafiz ⟹ hukumVar  -- Nâfiz satışın hükmü doğmuştur.
def S49 : Formul := (istisna ⋀ orfeGore) ⟹ istisnaSahih  -- Örfe göre hüküm, teamül olan istisnayı sahih kılar.
def S50 : Formul := (fuzuliSatis ⋀ ∼icazet) ⟹ (∼malik ⋀ ∼yetkili)  -- Fuzuli, malik ya da yetkili olmadan satandır.
def S51 : Formul := ((((∼(gormekIcinAlindi ⋀ sevmIleAlindi) ⋀ ∼(gormekIcinAlindi ⋀ fasidSatis)) ⋀ ∼(gormekIcinAlindi ⋀ batilSatis)) ⋀ ∼(sevmIleAlindi ⋀ fasidSatis)) ⋀ ∼(sevmIleAlindi ⋀ batilSatis)) ⋀ ∼(fasidSatis ⋀ batilSatis)  -- Malın el değiştirme sebebi tektir: görmek için, satın almak üzere, fâsid ya da bâtıl satışla.
def S52 : Formul := tabi ⟹ ((parcaHukmunde ⋁ surekliEklenti) ⋁ orfenKapsamda)  -- Satılana tâbi olan, bu üç türden biridir.
def S53 : Formul := (((sartAkitGeregi ⋁ sartPekistirir) ⋁ sartMutearef) ⋁ sartYararsiz) ⟹ sartliAkit  -- Bu türlerden bir şart, akitte bir şarttır.
def S54 : Formul := azBozuk ⟹ ∼eskiAyip  -- Örfe göre az bozukluk, hüküm doğuran bir ayıp değildir.
def S55 : Formul := ((((∼(gecmisKip ⋀ genisKip) ⋀ ∼(gecmisKip ⋀ vaatKipi)) ⋀ ∼(gecmisKip ⋀ emirKipi)) ⋀ ∼(genisKip ⋀ vaatKipi)) ⋀ ∼(genisKip ⋀ emirKipi)) ⋀ ∼(vaatKipi ⋀ emirKipi)  -- Aynı sözün tek bir kipi vardır.
def S57 : Formul := gormekIcinAlindi ⟹ ∼bedelKarsiligi  -- Görmek için alınan mal, bahası söylenmiş olsa da bedel karşılığı tutulmaz.
def S58 : Formul := batilSatis ⟹ ∼bedelKarsiligi  -- Bâtıl satış hiçbir hüküm doğurmaz; mal bedel karşılığı tutulmaz.
def S56 : Formul := icazet ⟹ yetkili  -- Sonradan verilen icazet, önceden verilmiş yetki gibidir.

/-! ## 4. Satış Kitabı'nın getirdiği kısıtlamalar -/

-- md. 236 ve 293: teslimden önce yarar alıcının, hasar satıcınındır (uzantı U10).
def md87k : Formul := (yararAlici ⋀ teslim) ⟹ hasarAlici
-- md. 88, md. 85 ile md. 87'nin birleşimidir; md. 87'yle aynı kısıtlama.
def md88k : Formul := (hasarAlici ⟹ yararAlici) ⋀ ((yararAlici ⋀ teslim) ⟹ hasarAlici)
-- md. 298 ve 371: bedel karşılığı izinle tutulan mal kusursuz telef olsa da tazmin edilir.
def md91k : Formul := ((mubah ⋀ ∼mubasir) ⋀ ∼bedelKarsiligi) ⟹ ∼tazmin
-- md. 298 ve 371: bedel karşılığı tutulan malda sorumluluk akitten doğar.
def md90k : Formul := ((mutesebbib ⋀ digerMubasir) ⋀ ∼bedelKarsiligi) ⟹ ∼tazmin
-- md. 298 ve 371: aynı gerekçe.
def md93k : Formul := ((mutesebbib ⋀ ∼kast) ⋀ ∼bedelKarsiligi) ⟹ ∼tazmin
-- md. 298 ve 371: aynı gerekçe.
def md94k : Formul := (hayvanKendiliginden ⋀ ∼bedelKarsiligi) ⟹ ∼tazmin
-- md. 350: iade imkânsızken bilerek tasarruf rıza sayılmaz (uzantı U14).
def K9k   : Formul := ((bilgi ⋀ tasarruf) ⋀ iadeMumkun) ⟹ riza
-- md. 345 (yeni ayıp) ve md. 349-350 (fazlalık) iade hakkını kaldırır.
def s337k : Formul := ((((eskiAyip ⋀ ∼riza) ⋀ ∼yeniAyip) ⋀ ∼fazlalik) ⟹ iadeHakki) ⋀ (iadeHakki ⟹ ∼bedelEksikligi)
-- md. 350: iade imkânsızken satan alıcı bedel eksikliğini alır (md. 344′).
def s344k : Formul := (((eskiAyip ⋀ bilgi) ⋀ tasarruf) ⋀ iadeMumkun) ⟹ ∼kusurHakki
-- md. 347 (yeni ayıp kalkarsa), md. 348 (satıcı razıysa) iadeyi geri getirir; ayıba rıza (md. 341-344) her hakkı düşürür.
def s345k : Formul := (((((eskiAyip ⋀ yeniAyip) ⋀ ∼riza) ⋀ ∼yeniAyipKalkti) ⋀ ∼saticiIadeyeRazi) ⋀ ∼fazlalik) ⟹ (∼iadeHakki ⋀ bedelEksikligi)
-- md. 349-350: fazlalık iadeye kesin engeldir; rıza hakkı düşürür.
def s347k : Formul := (((eskiAyip ⋀ yeniAyipKalkti) ⋀ ∼riza) ⋀ ∼fazlalik) ⟹ iadeHakki
-- md. 350: fazlalık varken satıcı razı olsa da geri alamaz; rıza hakkı düşürür.
def s348k : Formul := ((((eskiAyip ⋀ yeniAyip) ⋀ saticiIadeyeRazi) ⋀ ∼riza) ⋀ ∼fazlalik) ⟹ (iadeHakki ⋀ ∼bedelEksikligi)
-- md. 312: tasarruf vasıf muhayyerliğini düşürür.
def s310k : Formul := ((vasifSoylendi ⋀ vasifYok) ⋀ ∼tasarruf) ⟹ vasifHakki
-- md. 332 (değişmemiş, önceden görülmüş mal) ve md. 335 (tasarruf) görme muhayyerliğini kaldırır.
def s320k : Formul := ((gormedenAldi ⋀ ∼tasarruf) ⋀ ∼(onceGordu ⋀ ∼degisimSabit)) ⟹ gormeHakki
-- md. 359: öğrendikten sonra tasarruf fesih hakkını düşürür.
def s357k : Formul := ((gabn ⋀ tagrir) ⋀ ∼(gabnBilgisi ⋀ tasarruf)) ⟹ gabnHakki
-- md. 378: icazet satışı nâfiz kılar.
def s365k : Formul := (satisNafiz ⋀ ∼icazet) ⟹ ((malik ⋁ yetkili) ⋀ ∼baskaHak)
-- md. 378: icazetle mevkuf satış nâfiz olur.
def s368k : Formul := ((fuzuliSatis ⋀ ∼icazet) ⟹ (satisKurulur ⋀ ∼satisNafiz)) ⋀ ((rehinliSatis ⋀ ∼icazet) ⟹ (satisKurulur ⋀ ∼satisNafiz))

def birlesik : List Formul :=
  [md2, md3, md4, md5, md6r, md7, md8, md9, md10, md11, md12r, md13, md14, md15, md16, md17, md18, md19, md20r, md21r, md22, md23, md24, md25, md26, md27, md28, md29, md30, md31, md32, md33, md34, md35, md36r, md37r, md38, md40, md41, md42, md43, md44, md45r, md46, md47, md48, md49, md50, md51, md52, md53, md56, md57, md58, md59, md60, md61r, md62, md63, md64, md65, md66, md67, md68, md69, md70, md71, md72, md73, md74, md75, md76, md77, md78, md79, md80, md82, md83, md84, md85, md86, md87k, md88k, md89, md90k, md91k, md92, md93k, md94k, md95, md96r, md97, md98, md99, md100]
def maddeler : List Formul :=
  [s168, s169, s170, s171, s172, s173, s174, s175, s186, s187, s188, s189, s230, s231, s232, s233, s234, s236, s251, s281, s285, s293, s294, s298, s299, s310k, s312, s320k, s332, s335, s336, s337k, s341, s342, s343, s344k, s345k, s347k, s348k, s349, s350, s354, s356, s357k, s359, s365k, s368k, s369, s370, s371, s378, s389, s392]
def satisKopruleri : List Formul :=
  [S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S20, S21, S22, S23, S24, S25, S26, S27, S28, S29, S30, S31, S32, S33, S36, S37, S38, S39, S40, S41, S42, S43, S45, S46, S47, S48, S49, S50, S51, S52, S53, S54, S55, S56, S57, S58]
def koprulerSon : List Formul :=
  [K1, K2, K3, K4, K5, K6, K7, K8, K9k, K10, K11, K12, K13, K14, K15, K16, K17, K18, K19, K20, K21, K22, K23, K24, K25, K26, K27, K28, K29, K30, K31, K32, K33, K34, K35, K36, K37, K38, K39]

/-! ## 5. Bir maddeyi kaideye bağlayan iddialar -/

-- Öncüller ve hedef, Satış Kitabı'nın kısıtlamalarından sonraki son biçimleridir.
-- md. 69 (yazışma) → md. 173: türer.
theorem iddia_s173_1 :
    Sonuc [md69, S1, s168] s173 := by
  intro v h
  have h0 := h md69 (by simp); have h1 := h S1 (by simp); have h2 := h s168 (by simp)
  simp only [hepsi, tepe, degil, deger, md69, S1, s168, s173, icapIcerik, muhatabeGibi, mukatebe, satisKurulur, sozluIcap] at *; revert h0 h1 h2
  generalize v 71 = x71; generalize v 72 = x72; generalize v 205 = x205; generalize v 206 = x206; generalize v 208 = x208
  revert x71 x72 x205 x206 x208; decide

-- md. 70 (dilsizin işareti) → md. 174: türer.
theorem iddia_s174_2 :
    Sonuc [md70, S2, s168] s174 := by
  intro v h
  have h0 := h md70 (by simp); have h1 := h S2 (by simp); have h2 := h s168 (by simp)
  simp only [hepsi, tepe, degil, deger, md70, S2, s168, s174, dilleBeyanGibi, dilsizIsaret, icapIcerik, satisKurulur, sozluIcap] at *; revert h0 h1 h2
  generalize v 73 = x73; generalize v 74 = x74; generalize v 205 = x205; generalize v 206 = x206; generalize v 208 = x208
  revert x73 x74 x205 x206 x208; decide

-- md. 2 (amaç) → md. 175; metnin kendi gerekçesi: türer.
theorem iddia_s175_3 :
    Sonuc [md2, S3, S4] s175 := by
  intro v h
  have h0 := h md2 (by simp); have h1 := h S3 (by simp); have h2 := h S4 (by simp)
  simp only [hepsi, tepe, degil, deger, md2, S3, S4, s175, fiiliTeati, hukumM, maksat, satisKurulur] at *; revert h0 h1 h2
  generalize v 18 = x18; generalize v 19 = x19; generalize v 207 = x207; generalize v 208 = x208
  revert x18 x19 x207 x208; decide

-- md. 43 (örfen maruf şart gibidir) → md. 188?: türemez (karşı model).
theorem iddia_s188_4 :
    ¬ Sonuc [md43, S13] s188 := by
  intro h; have := h (model [212, 214]) (by decide); revert this; decide

-- md. 43 → md. 230: türer.
theorem iddia_s230_5 :
    Sonuc [md43, S13, S14] s230 := by
  intro v h
  have h0 := h md43 (by simp); have h1 := h S13 (by simp); have h2 := h S14 (by simp)
  simp only [hepsi, tepe, degil, deger, md43, S13, S14, s230, orfenKapsamda, orfenMaruf, sartGibi, satisaDahil] at *; revert h0 h1 h2
  generalize v 163 = x163; generalize v 164 = x164; generalize v 216 = x216; generalize v 220 = x220
  revert x163 x164 x216 x220; decide

-- md. 47 (tâbi) → md. 231: türer.
theorem iddia_s231_6 :
    Sonuc [md47, S9, S11] s231 := by
  intro v h
  have h0 := h md47 (by simp); have h1 := h S9 (by simp); have h2 := h S11 (by simp)
  simp only [hepsi, tepe, degil, deger, md47, S9, S11, s231, parcaHukmunde, satisaDahil, tabi, tabiHukum] at *; revert h0 h1 h2
  generalize v 169 = x169; generalize v 170 = x170; generalize v 217 = x217; generalize v 220 = x220
  revert x169 x170 x217 x220; decide

-- md. 47 → md. 232: türer.
theorem iddia_s232_7 :
    Sonuc [md47, S10, S11] s232 := by
  intro v h
  have h0 := h md47 (by simp); have h1 := h S10 (by simp); have h2 := h S11 (by simp)
  simp only [hepsi, tepe, degil, deger, md47, S10, S11, s232, satisaDahil, surekliEklenti, tabi, tabiHukum] at *; revert h0 h1 h2
  generalize v 169 = x169; generalize v 170 = x170; generalize v 218 = x218; generalize v 220 = x220
  revert x169 x170 x218 x220; decide

-- md. 48 (tâbiye ayrıca hüküm yok) → md. 234: türer.
theorem iddia_s234_8 :
    Sonuc [md48, S12] s234 := by
  intro v h
  have h0 := h md48 (by simp); have h1 := h S12 (by simp)
  simp only [hepsi, tepe, degil, deger, md48, S12, s234, ayriHukum, bedeldenPay, satisaDahil, tabi] at *; revert h0 h1
  generalize v 169 = x169; generalize v 171 = x171; generalize v 220 = x220; generalize v 221 = x221
  revert x169 x171 x220 x221; decide

-- md. 369 → md. 236 (uzantı): türer.
theorem iddia_s236_9 :
    Sonuc [s369] s236 := by
  intro v h
  have h0 := h s369 (by simp)
  simp only [hepsi, tepe, degil, deger, s369, s236, akit, teslim, yararAlici] at *; revert h0
  generalize v 29 = x29; generalize v 30 = x30; generalize v 31 = x31
  revert x29 x30 x31; decide

-- md. 13, 36, 64 → md. 251 (uzantı U7): türer.
theorem iddia_s251_10 :
    Sonuc [md64, md36r, S15, S16, S17] s251 := by
  intro v h
  have h0 := h md64 (by simp); have h1 := h md36r (by simp); have h2 := h S15 (by simp); have h3 := h S16 (by simp); have h4 := h S17 (by simp)
  simp only [hepsi, tepe, degil, deger, md64, md36r, S15, S16, S17, s251, ayipsizGerekir, galib, malinYerindeTeslim, mutlak, mutlakGore, muttarid, orf, orfVadeli, orfeGore, pesin, tasrih] at *; revert h0 h1 h2 h3 h4
  generalize v 20 = x20; generalize v 21 = x21; generalize v 25 = x25; generalize v 27 = x27; generalize v 28 = x28; generalize v 159 = x159; generalize v 160 = x160; generalize v 222 = x222; generalize v 223 = x223; generalize v 224 = x224; generalize v 240 = x240
  revert x20 x21 x25 x27 x28 x159 x160 x222 x223 x224 x240
  intro x20 x21
  cases x20 <;> cases x21 <;> decide

-- md. 51 (düşen dönmez) → md. 281: türer.
theorem iddia_s281_11 :
    Sonuc [md51, S18, S19] s281 := by
  intro v h
  have h0 := h md51 (by simp); have h1 := h S18 (by simp); have h2 := h S19 (by simp)
  simp only [hepsi, tepe, degil, deger, md51, S18, S19, s281, avdet, geriAlma, sakit, teslimBedelsiz] at *; revert h0 h1 h2
  generalize v 23 = x23; generalize v 24 = x24; generalize v 225 = x225; generalize v 226 = x226
  revert x23 x24 x225 x226; decide

-- md. 64 (mutlak) → md. 285: türemez (karşı model).
theorem iddia_s285_12 :
    ¬ Sonuc [md64, S15] s285 := by
  intro h; have := h (model [20, 27, 222, 240]) (by decide); revert this; decide

-- md. 87 + md. 369 → md. 294 (uzantı U11; md. 87 teslimle kısıtlanır): türer.
theorem iddia_s294_13 :
    Sonuc [md87k, s369] s294 := by
  intro v h
  have h0 := h md87k (by simp); have h1 := h s369 (by simp)
  simp only [hepsi, tepe, degil, deger, md87k, s369, s294, akit, hasarAlici, teslim, yararAlici] at *; revert h0 h1
  generalize v 29 = x29; generalize v 30 = x30; generalize v 31 = x31; generalize v 32 = x32
  revert x29 x30 x31 x32; decide

-- md. 91 (cevaz-ı şer'i) → md. 299: türer.
theorem iddia_s299_14 :
    Sonuc [md91k, S38, S39, S40, S57] s299 := by
  intro v h
  have h0 := h md91k (by simp); have h1 := h S38 (by simp); have h2 := h S39 (by simp); have h3 := h S40 (by simp); have h4 := h S57 (by simp)
  simp only [hepsi, tepe, degil, deger, md91k, S38, S39, S40, S57, s299, bedelKarsiligi, gormekIcinAlindi, izinleAlindi, kusur, mubah, mubasir, tazmin, telef] at *; revert h0 h1 h2 h3 h4
  generalize v 8 = x8; generalize v 118 = x118; generalize v 126 = x126; generalize v 255 = x255; generalize v 256 = x256; generalize v 257 = x257; generalize v 261 = x261; generalize v 262 = x262
  revert x8 x118 x126 x255 x256 x257 x261 x262; decide

-- md. 64 → md. 336: türemez (karşı model).
theorem iddia_s336_15 :
    ¬ Sonuc [md64, S15] s336 := by
  intro h; have := h (model [20, 27, 222]) (by decide); revert this; decide

-- md. 100 → md. 341: türer.
theorem iddia_s341_16 :
    Sonuc [md100, S29] s341 := by
  intro v h
  have h0 := h md100 (by simp); have h1 := h S29 (by simp)
  simp only [hepsi, tepe, degil, deger, md100, S29, s341, ayipAciklandi, kusurHakki, riza] at *; revert h0 h1
  generalize v 35 = x35; generalize v 37 = x37; generalize v 237 = x237
  revert x35 x37 x237; decide

-- md. 100 → md. 342: türer.
theorem iddia_s342_17 :
    Sonuc [md100, S30] s342 := by
  intro v h
  have h0 := h md100 (by simp); have h1 := h S30 (by simp)
  simp only [hepsi, tepe, degil, deger, md100, S30, s342, beraatSarti, kusurHakki, riza] at *; revert h0 h1
  generalize v 35 = x35; generalize v 37 = x37; generalize v 238 = x238
  revert x35 x37 x238; decide

-- md. 100 → md. 343: türer.
theorem iddia_s343_18 :
    Sonuc [md100, S31] s343 := by
  intro v h
  have h0 := h md100 (by simp); have h1 := h S31 (by simp)
  simp only [hepsi, tepe, degil, deger, md100, S31, s343, herAyibiylaKabul, kusurHakki, riza] at *; revert h0 h1
  generalize v 35 = x35; generalize v 37 = x37; generalize v 239 = x239
  revert x35 x37 x239; decide

-- md. 100 + K9 → md. 344 (metnin kendi gerekçesi): türer.
theorem iddia_s344_19 :
    Sonuc [md100, K9k] s344k := by
  intro v h
  have h0 := h md100 (by simp); have h1 := h K9k (by simp)
  simp only [hepsi, tepe, degil, deger, md100, K9k, s344k, bilgi, eskiAyip, iadeMumkun, kusurHakki, riza, tasarruf] at *; revert h0 h1
  generalize v 33 = x33; generalize v 34 = x34; generalize v 35 = x35; generalize v 36 = x36; generalize v 37 = x37; generalize v 230 = x230
  revert x33 x34 x35 x36 x37 x230; decide

-- md. 25 (zarar misliyle giderilmez) + md. 53 (asıl olmazsa bedel) → md. 345: türer.
theorem iddia_s345_20 :
    Sonuc [md25, md53, S23, S24, S25, S26] s345k := by
  intro v h
  have h0 := h md25 (by simp); have h1 := h md53 (by simp); have h2 := h S23 (by simp); have h3 := h S24 (by simp); have h4 := h S25 (by simp); have h5 := h S26 (by simp)
  simp only [hepsi, tepe, degil, deger, md25, md53, S23, S24, S25, S26, s345k, asilIfaMumkun, bedelEksikligi, bedelIfa, eskiAyip, fazlalik, iadeHakki, misil, riza, saticiIadeyeRazi, tedbirCaiz, yeniAyip, yeniAyipKalkti] at *; revert h0 h1 h2 h3 h4 h5
  generalize v 12 = x12; generalize v 13 = x13; generalize v 35 = x35; generalize v 177 = x177; generalize v 178 = x178; generalize v 230 = x230; generalize v 231 = x231; generalize v 232 = x232; generalize v 233 = x233; generalize v 234 = x234; generalize v 235 = x235; generalize v 236 = x236
  revert x12 x13 x35 x177 x178 x230 x231 x232 x233 x234 x235 x236
  intro x12 x13 x35
  cases x12 <;> cases x13 <;> cases x35 <;> decide

-- md. 24 (engel kalkınca memnu döner) → md. 347: türer.
theorem iddia_s347_21 :
    Sonuc [md24, S20, S22] s347k := by
  intro v h
  have h0 := h md24 (by simp); have h1 := h S20 (by simp); have h2 := h S22 (by simp)
  simp only [hepsi, tepe, degil, deger, md24, S20, S22, s347k, avdet, eskiAyip, fazlalik, iadeHakki, maniZail, riza, yeniAyipKalkti] at *; revert h0 h1 h2
  generalize v 22 = x22; generalize v 23 = x23; generalize v 35 = x35; generalize v 230 = x230; generalize v 232 = x232; generalize v 234 = x234; generalize v 235 = x235
  revert x22 x23 x35 x230 x232 x234 x235; decide

-- md. 24 → md. 348 (metnin kendi gerekçesi): türer.
theorem iddia_s348_22 :
    Sonuc [md24, s337k, S21, S22] s348k := by
  intro v h
  have h0 := h md24 (by simp); have h1 := h s337k (by simp); have h2 := h S21 (by simp); have h3 := h S22 (by simp)
  simp only [hepsi, tepe, degil, deger, md24, s337k, S21, S22, s348k, avdet, bedelEksikligi, eskiAyip, fazlalik, iadeHakki, maniZail, riza, saticiIadeyeRazi, yeniAyip] at *; revert h0 h1 h2 h3
  generalize v 22 = x22; generalize v 23 = x23; generalize v 35 = x35; generalize v 230 = x230; generalize v 231 = x231; generalize v 233 = x233; generalize v 234 = x234; generalize v 235 = x235; generalize v 236 = x236
  revert x22 x23 x35 x230 x231 x233 x234 x235 x236; decide

-- md. 42 (nadire itibar yok) → md. 354: türer.
theorem iddia_s354_23 :
    Sonuc [md42, S32, S33] s354 := by
  intro v h
  have h0 := h md42 (by simp); have h1 := h S32 (by simp); have h2 := h S33 (by simp)
  simp only [hepsi, tepe, degil, deger, md42, S32, S33, s354, azBozuk, galib, iadeHakki, muteber, nadir] at *; revert h0 h1 h2
  generalize v 160 = x160; generalize v 161 = x161; generalize v 162 = x162; generalize v 235 = x235; generalize v 241 = x241
  revert x160 x161 x162 x235 x241; decide

-- md. 5 (istishab) → md. 332: türer.
theorem iddia_s332_24 :
    Sonuc [md5, S36, S37] s332 := by
  intro v h
  have h0 := h md5 (by simp); have h1 := h S36 (by simp); have h2 := h S37 (by simp)
  simp only [hepsi, tepe, degil, deger, md5, S36, S37, s332, degisimSabit, gormeHakki, gormedenAldi, hukumA, onceGordu, yakin] at *; revert h0 h1 h2
  generalize v 0 = x0; generalize v 2 = x2; generalize v 3 = x3; generalize v 248 = x248; generalize v 249 = x249; generalize v 253 = x253
  revert x0 x2 x3 x248 x249 x253; decide

-- md. 46 (mani öne alınır) → md. 368'in rehinli satış yarısı: türer.
theorem iddia_s368_25 :
    Sonuc [md46, S45, S46, S47, S48] (((rehinliSatis ⋀ akit) ⋀ ∼icazet) ⟹ ∼satisNafiz) := by
  intro v h
  have h0 := h md46 (by simp); have h1 := h S45 (by simp); have h2 := h S46 (by simp); have h3 := h S47 (by simp); have h4 := h S48 (by simp)
  simp only [hepsi, tepe, degil, deger, md46, S45, S46, S47, S48, akit, baskaHak, hukumVar, icazet, mani, muktezi, rehinliSatis, satisNafiz] at *; revert h0 h1 h2 h3 h4
  generalize v 29 = x29; generalize v 166 = x166; generalize v 167 = x167; generalize v 168 = x168; generalize v 265 = x265; generalize v 267 = x267; generalize v 269 = x269; generalize v 270 = x270
  revert x29 x166 x167 x168 x265 x267 x269 x270; decide

-- md. 96 (izinsiz tasarruf) → md. 368'in fuzuli yarısı: tasarruf caiz değil mi?: türemez (karşı model).
theorem iddia_s368_26 :
    ¬ Sonuc [md96r, S43, S50] ((fuzuliSatis ⋀ ∼icazet) ⟹ ∼mubah) := by
  intro h; have := h (model [6, 8, 131, 268]) (by decide); revert this; decide

-- md. 37 (yaygın kullanım hüccettir) → md. 389?: türemez (karşı model).
theorem iddia_s389_27 :
    ¬ Sonuc [md37r, S49] s389 := by
  intro h; have := h (model [25, 154, 275]) (by decide); revert this; decide

/-! ## 6. Külliyattan en çok üç öncülle türeyen maddeler -/

theorem tur_s175_md2_S3_S4 :
    Sonuc [md2, S3, S4] s175 := by
  intro v h
  have h0 := h md2 (by simp); have h1 := h S3 (by simp); have h2 := h S4 (by simp)
  simp only [hepsi, tepe, degil, deger, md2, S3, S4, s175, fiiliTeati, hukumM, maksat, satisKurulur] at *; revert h0 h1 h2
  generalize v 18 = x18; generalize v 19 = x19; generalize v 207 = x207; generalize v 208 = x208
  revert x18 x19 x207 x208; decide

theorem tur_s230_md43_S13_S14 :
    Sonuc [md43, S13, S14] s230 := by
  intro v h
  have h0 := h md43 (by simp); have h1 := h S13 (by simp); have h2 := h S14 (by simp)
  simp only [hepsi, tepe, degil, deger, md43, S13, S14, s230, orfenKapsamda, orfenMaruf, sartGibi, satisaDahil] at *; revert h0 h1 h2
  generalize v 163 = x163; generalize v 164 = x164; generalize v 216 = x216; generalize v 220 = x220
  revert x163 x164 x216 x220; decide

theorem tur_s231_md47_S9_S11 :
    Sonuc [md47, S9, S11] s231 := by
  intro v h
  have h0 := h md47 (by simp); have h1 := h S9 (by simp); have h2 := h S11 (by simp)
  simp only [hepsi, tepe, degil, deger, md47, S9, S11, s231, parcaHukmunde, satisaDahil, tabi, tabiHukum] at *; revert h0 h1 h2
  generalize v 169 = x169; generalize v 170 = x170; generalize v 217 = x217; generalize v 220 = x220
  revert x169 x170 x217 x220; decide

theorem tur_s232_md47_S10_S11 :
    Sonuc [md47, S10, S11] s232 := by
  intro v h
  have h0 := h md47 (by simp); have h1 := h S10 (by simp); have h2 := h S11 (by simp)
  simp only [hepsi, tepe, degil, deger, md47, S10, S11, s232, satisaDahil, surekliEklenti, tabi, tabiHukum] at *; revert h0 h1 h2
  generalize v 169 = x169; generalize v 170 = x170; generalize v 218 = x218; generalize v 220 = x220
  revert x169 x170 x218 x220; decide

theorem tur_s234_md48_S12 :
    Sonuc [md48, S12] s234 := by
  intro v h
  have h0 := h md48 (by simp); have h1 := h S12 (by simp)
  simp only [hepsi, tepe, degil, deger, md48, S12, s234, ayriHukum, bedeldenPay, satisaDahil, tabi] at *; revert h0 h1
  generalize v 169 = x169; generalize v 171 = x171; generalize v 220 = x220; generalize v 221 = x221
  revert x169 x171 x220 x221; decide

theorem tur_s234_md47_K28_S12 :
    Sonuc [md47, K28, S12] s234 := by
  intro v h
  have h0 := h md47 (by simp); have h1 := h K28 (by simp); have h2 := h S12 (by simp)
  simp only [hepsi, tepe, degil, deger, md47, K28, S12, s234, ayriHukum, bedeldenPay, satisaDahil, tabi, tabiHukum] at *; revert h0 h1 h2
  generalize v 169 = x169; generalize v 170 = x170; generalize v 171 = x171; generalize v 220 = x220; generalize v 221 = x221
  revert x169 x170 x171 x220 x221; decide

theorem tur_s281_md51_S18_S19 :
    Sonuc [md51, S18, S19] s281 := by
  intro v h
  have h0 := h md51 (by simp); have h1 := h S18 (by simp); have h2 := h S19 (by simp)
  simp only [hepsi, tepe, degil, deger, md51, S18, S19, s281, avdet, geriAlma, sakit, teslimBedelsiz] at *; revert h0 h1 h2
  generalize v 23 = x23; generalize v 24 = x24; generalize v 225 = x225; generalize v 226 = x226
  revert x23 x24 x225 x226; decide

theorem tur_s332_md5_S36_S37 :
    Sonuc [md5, S36, S37] s332 := by
  intro v h
  have h0 := h md5 (by simp); have h1 := h S36 (by simp); have h2 := h S37 (by simp)
  simp only [hepsi, tepe, degil, deger, md5, S36, S37, s332, degisimSabit, gormeHakki, gormedenAldi, hukumA, onceGordu, yakin] at *; revert h0 h1 h2
  generalize v 0 = x0; generalize v 2 = x2; generalize v 3 = x3; generalize v 248 = x248; generalize v 249 = x249; generalize v 253 = x253
  revert x0 x2 x3 x248 x249 x253; decide

theorem tur_s332_md10_S36_S37 :
    Sonuc [md10, S36, S37] s332 := by
  intro v h
  have h0 := h md10 (by simp); have h1 := h S36 (by simp); have h2 := h S37 (by simp)
  simp only [hepsi, tepe, degil, deger, md10, S36, S37, s332, degisimSabit, gormeHakki, gormedenAldi, hukumA, onceGordu, yakin] at *; revert h0 h1 h2
  generalize v 0 = x0; generalize v 2 = x2; generalize v 3 = x3; generalize v 248 = x248; generalize v 249 = x249; generalize v 253 = x253
  revert x0 x2 x3 x248 x249 x253; decide

theorem tur_s341_md100_S29 :
    Sonuc [md100, S29] s341 := by
  intro v h
  have h0 := h md100 (by simp); have h1 := h S29 (by simp)
  simp only [hepsi, tepe, degil, deger, md100, S29, s341, ayipAciklandi, kusurHakki, riza] at *; revert h0 h1
  generalize v 35 = x35; generalize v 37 = x37; generalize v 237 = x237
  revert x35 x37 x237; decide

theorem tur_s342_md100_S30 :
    Sonuc [md100, S30] s342 := by
  intro v h
  have h0 := h md100 (by simp); have h1 := h S30 (by simp)
  simp only [hepsi, tepe, degil, deger, md100, S30, s342, beraatSarti, kusurHakki, riza] at *; revert h0 h1
  generalize v 35 = x35; generalize v 37 = x37; generalize v 238 = x238
  revert x35 x37 x238; decide

theorem tur_s343_md100_S31 :
    Sonuc [md100, S31] s343 := by
  intro v h
  have h0 := h md100 (by simp); have h1 := h S31 (by simp)
  simp only [hepsi, tepe, degil, deger, md100, S31, s343, herAyibiylaKabul, kusurHakki, riza] at *; revert h0 h1
  generalize v 35 = x35; generalize v 37 = x37; generalize v 239 = x239
  revert x35 x37 x239; decide

theorem tur_s344_md100_K9 :
    Sonuc [md100, K9] s344 := by
  intro v h
  have h0 := h md100 (by simp); have h1 := h K9 (by simp)
  simp only [hepsi, tepe, degil, deger, md100, K9, s344, bilgi, eskiAyip, kusurHakki, riza, tasarruf] at *; revert h0 h1
  generalize v 33 = x33; generalize v 34 = x34; generalize v 35 = x35; generalize v 37 = x37; generalize v 230 = x230
  revert x33 x34 x35 x37 x230; decide

theorem tur_s347_md24_S20_S22 :
    Sonuc [md24, S20, S22] s347 := by
  intro v h
  have h0 := h md24 (by simp); have h1 := h S20 (by simp); have h2 := h S22 (by simp)
  simp only [hepsi, tepe, degil, deger, md24, S20, S22, s347, avdet, eskiAyip, iadeHakki, maniZail, yeniAyipKalkti] at *; revert h0 h1 h2
  generalize v 22 = x22; generalize v 23 = x23; generalize v 230 = x230; generalize v 232 = x232; generalize v 235 = x235
  revert x22 x23 x230 x232 x235; decide

theorem tur_s354_md42_S32_S33 :
    Sonuc [md42, S32, S33] s354 := by
  intro v h
  have h0 := h md42 (by simp); have h1 := h S32 (by simp); have h2 := h S33 (by simp)
  simp only [hepsi, tepe, degil, deger, md42, S32, S33, s354, azBozuk, galib, iadeHakki, muteber, nadir] at *; revert h0 h1 h2
  generalize v 160 = x160; generalize v 161 = x161; generalize v 162 = x162; generalize v 235 = x235; generalize v 241 = x241
  revert x160 x161 x162 x235 x241; decide

theorem tur_s370_md91r_S38_S39 :
    Sonuc [md91r, S38, S39] s370 := by
  intro v h
  have h0 := h md91r (by simp); have h1 := h S38 (by simp); have h2 := h S39 (by simp)
  simp only [hepsi, tepe, degil, deger, md91r, S38, S39, s370, batilSatis, izinleAlindi, kusur, mubah, mubasir, tazmin, telef] at *; revert h0 h1 h2
  generalize v 8 = x8; generalize v 118 = x118; generalize v 126 = x126; generalize v 255 = x255; generalize v 256 = x256; generalize v 260 = x260; generalize v 261 = x261
  revert x8 x118 x126 x255 x256 x260 x261; decide

/-! ## 7. Çatışmalar ve çözümleri -/

-- SÇ1. s169, s170, S6 — olay: {gecmisKip, genisKip, vaatKipi}
theorem scat1 :
    ¬ Saglanabilir (hepsi [s169, s170, S6, gecmisKip, genisKip, vaatKipi]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s169, s170, S6, gecmisKip, genisKip, simdikiKast, sozluIcap, vaatKipi] at *; revert h
  generalize v 200 = x200; generalize v 201 = x201; generalize v 202 = x202; generalize v 203 = x203; generalize v 206 = x206
  revert x200 x201 x202 x203 x206; decide

-- SÇ1 çözümü: S55 olayı imkânsız kılar.
theorem scat1_kopru :
    ¬ Saglanabilir (hepsi [S6, S55, gecmisKip, genisKip, vaatKipi]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S6, S55, emirKipi, gecmisKip, genisKip, simdikiKast, vaatKipi] at *; revert h
  generalize v 200 = x200; generalize v 201 = x201; generalize v 202 = x202; generalize v 203 = x203; generalize v 204 = x204
  revert x200 x201 x202 x203 x204; decide

-- SÇ2. s169, s170 — olay: {gecmisKip, genisKip, ¬simdikiKast}
theorem scat2 :
    ¬ Saglanabilir (hepsi [s169, s170, gecmisKip, genisKip, ∼simdikiKast]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s169, s170, gecmisKip, genisKip, simdikiKast, sozluIcap] at *; revert h
  generalize v 200 = x200; generalize v 201 = x201; generalize v 202 = x202; generalize v 206 = x206
  revert x200 x201 x202 x206; decide

-- SÇ2 çözümü: S55 olayı imkânsız kılar.
theorem scat2_kopru :
    ¬ Saglanabilir (hepsi [S55, gecmisKip, genisKip, ∼simdikiKast]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S55, emirKipi, gecmisKip, genisKip, simdikiKast, vaatKipi] at *; revert h
  generalize v 200 = x200; generalize v 201 = x201; generalize v 202 = x202; generalize v 203 = x203; generalize v 204 = x204
  revert x200 x201 x202 x203 x204; decide

-- SÇ3. s169, s171 — olay: {gecmisKip, vaatKipi}
theorem scat3 :
    ¬ Saglanabilir (hepsi [s169, s171, gecmisKip, vaatKipi]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s169, s171, gecmisKip, sozluIcap, vaatKipi] at *; revert h
  generalize v 200 = x200; generalize v 203 = x203; generalize v 206 = x206
  revert x200 x203 x206; decide

-- SÇ3 çözümü: S55 olayı imkânsız kılar.
theorem scat3_kopru :
    ¬ Saglanabilir (hepsi [S55, gecmisKip, vaatKipi]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S55, emirKipi, gecmisKip, genisKip, vaatKipi] at *; revert h
  generalize v 200 = x200; generalize v 201 = x201; generalize v 203 = x203; generalize v 204 = x204
  revert x200 x201 x203 x204; decide

-- SÇ4. s169, s172, S6 — olay: {emirKipi, gecmisKip, vaatKipi}
theorem scat4 :
    ¬ Saglanabilir (hepsi [s169, s172, S6, emirKipi, gecmisKip, vaatKipi]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s169, s172, S6, emirKipi, gecmisKip, simdikiKast, sozluIcap, vaatKipi] at *; revert h
  generalize v 200 = x200; generalize v 202 = x202; generalize v 203 = x203; generalize v 204 = x204; generalize v 206 = x206
  revert x200 x202 x203 x204 x206; decide

-- SÇ4 çözümü: S55 olayı imkânsız kılar.
theorem scat4_kopru :
    ¬ Saglanabilir (hepsi [S6, S55, emirKipi, gecmisKip, vaatKipi]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S6, S55, emirKipi, gecmisKip, genisKip, simdikiKast, vaatKipi] at *; revert h
  generalize v 200 = x200; generalize v 201 = x201; generalize v 202 = x202; generalize v 203 = x203; generalize v 204 = x204
  revert x200 x201 x202 x203 x204; decide

-- SÇ5. s169, s172 — olay: {emirKipi, gecmisKip, ¬simdikiKast}
theorem scat5 :
    ¬ Saglanabilir (hepsi [s169, s172, emirKipi, gecmisKip, ∼simdikiKast]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s169, s172, emirKipi, gecmisKip, simdikiKast, sozluIcap] at *; revert h
  generalize v 200 = x200; generalize v 202 = x202; generalize v 204 = x204; generalize v 206 = x206
  revert x200 x202 x204 x206; decide

-- SÇ5 çözümü: S55 olayı imkânsız kılar.
theorem scat5_kopru :
    ¬ Saglanabilir (hepsi [S55, emirKipi, gecmisKip, ∼simdikiKast]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S55, emirKipi, gecmisKip, genisKip, simdikiKast, vaatKipi] at *; revert h
  generalize v 200 = x200; generalize v 201 = x201; generalize v 202 = x202; generalize v 203 = x203; generalize v 204 = x204
  revert x200 x201 x202 x203 x204; decide

-- SÇ6. s170, s171 — olay: {genisKip, simdikiKast, vaatKipi}
theorem scat6 :
    ¬ Saglanabilir (hepsi [s170, s171, genisKip, simdikiKast, vaatKipi]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s170, s171, genisKip, simdikiKast, sozluIcap, vaatKipi] at *; revert h
  generalize v 201 = x201; generalize v 202 = x202; generalize v 203 = x203; generalize v 206 = x206
  revert x201 x202 x203 x206; decide

-- SÇ6 çözümü: S6 olayı imkânsız kılar.
theorem scat6_kopru :
    ¬ Saglanabilir (hepsi [S6, genisKip, simdikiKast, vaatKipi]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S6, genisKip, simdikiKast, vaatKipi] at *; revert h
  generalize v 201 = x201; generalize v 202 = x202; generalize v 203 = x203
  revert x201 x202 x203; decide

-- SÇ7. s171, s172 — olay: {emirKipi, simdikiKast, vaatKipi}
theorem scat7 :
    ¬ Saglanabilir (hepsi [s171, s172, emirKipi, simdikiKast, vaatKipi]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s171, s172, emirKipi, simdikiKast, sozluIcap, vaatKipi] at *; revert h
  generalize v 202 = x202; generalize v 203 = x203; generalize v 204 = x204; generalize v 206 = x206
  revert x202 x203 x204 x206; decide

-- SÇ7 çözümü: S6 olayı imkânsız kılar.
theorem scat7_kopru :
    ¬ Saglanabilir (hepsi [S6, emirKipi, simdikiKast, vaatKipi]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S6, emirKipi, simdikiKast, vaatKipi] at *; revert h
  generalize v 202 = x202; generalize v 203 = x203; generalize v 204 = x204
  revert x202 x203 x204; decide

-- SÇ8. s186, s189 — olay: {sartAkitGeregi, sartYararsiz}
theorem scat8 :
    ¬ Saglanabilir (hepsi [s186, s189, sartAkitGeregi, sartYararsiz]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s186, s189, sartAkitGeregi, sartGecerli, sartYararsiz, satisSahih] at *; revert h
  generalize v 210 = x210; generalize v 213 = x213; generalize v 214 = x214; generalize v 215 = x215
  revert x210 x213 x214 x215; decide

-- SÇ8 çözümü: S8 olayı imkânsız kılar.
theorem scat8_kopru :
    ¬ Saglanabilir (hepsi [S8, sartAkitGeregi, sartYararsiz]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S8, sartAkitGeregi, sartMutearef, sartPekistirir, sartYararsiz] at *; revert h
  generalize v 210 = x210; generalize v 211 = x211; generalize v 212 = x212; generalize v 213 = x213
  revert x210 x211 x212 x213; decide

-- SÇ9. s187, s189 — olay: {sartPekistirir, sartYararsiz}
theorem scat9 :
    ¬ Saglanabilir (hepsi [s187, s189, sartPekistirir, sartYararsiz]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s187, s189, sartGecerli, sartPekistirir, sartYararsiz, satisSahih] at *; revert h
  generalize v 211 = x211; generalize v 213 = x213; generalize v 214 = x214; generalize v 215 = x215
  revert x211 x213 x214 x215; decide

-- SÇ9 çözümü: S8 olayı imkânsız kılar.
theorem scat9_kopru :
    ¬ Saglanabilir (hepsi [S8, sartPekistirir, sartYararsiz]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S8, sartAkitGeregi, sartMutearef, sartPekistirir, sartYararsiz] at *; revert h
  generalize v 210 = x210; generalize v 211 = x211; generalize v 212 = x212; generalize v 213 = x213
  revert x210 x211 x212 x213; decide

-- SÇ10. s188, s189 — olay: {sartMutearef, sartYararsiz}
theorem scat10 :
    ¬ Saglanabilir (hepsi [s188, s189, sartMutearef, sartYararsiz]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s188, s189, sartGecerli, sartMutearef, sartYararsiz, satisSahih] at *; revert h
  generalize v 212 = x212; generalize v 213 = x213; generalize v 214 = x214; generalize v 215 = x215
  revert x212 x213 x214 x215; decide

-- SÇ10 çözümü: S8 olayı imkânsız kılar.
theorem scat10_kopru :
    ¬ Saglanabilir (hepsi [S8, sartMutearef, sartYararsiz]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S8, sartAkitGeregi, sartMutearef, sartPekistirir, sartYararsiz] at *; revert h
  generalize v 210 = x210; generalize v 211 = x211; generalize v 212 = x212; generalize v 213 = x213
  revert x210 x211 x212 x213; decide

-- SÇ11. s233, md47, S11 — olay: {tabi, ¬anildi, ¬orfenKapsamda, ¬parcaHukmunde, ¬surekliEklenti}
theorem scat11 :
    ¬ Saglanabilir (hepsi [s233, md47, S11, tabi, ∼anildi, ∼orfenKapsamda, ∼parcaHukmunde, ∼surekliEklenti]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s233, md47, S11, anildi, orfenKapsamda, parcaHukmunde, satisaDahil, surekliEklenti, tabi, tabiHukum] at *; revert h
  generalize v 169 = x169; generalize v 170 = x170; generalize v 216 = x216; generalize v 217 = x217; generalize v 218 = x218; generalize v 219 = x219; generalize v 220 = x220
  revert x169 x170 x216 x217 x218 x219 x220; decide

-- SÇ11 çözümü: S52 olayı imkânsız kılar.
theorem scat11_kopru :
    ¬ Saglanabilir (hepsi [S11, S52, tabi, ∼anildi, ∼orfenKapsamda, ∼parcaHukmunde, ∼surekliEklenti]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S11, S52, anildi, orfenKapsamda, parcaHukmunde, satisaDahil, surekliEklenti, tabi, tabiHukum] at *; revert h
  generalize v 169 = x169; generalize v 170 = x170; generalize v 216 = x216; generalize v 217 = x217; generalize v 218 = x218; generalize v 219 = x219; generalize v 220 = x220
  revert x169 x170 x216 x217 x218 x219 x220; decide

-- SÇ12. s298, s299 — olay: {gormekIcinAlindi, sevmIleAlindi, telef, ¬kusur}
theorem scat12 :
    ¬ Saglanabilir (hepsi [s298, s299, gormekIcinAlindi, sevmIleAlindi, telef, ∼kusur]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s298, s299, gormekIcinAlindi, kusur, sevmIleAlindi, tazmin, telef] at *; revert h
  generalize v 118 = x118; generalize v 256 = x256; generalize v 257 = x257; generalize v 258 = x258; generalize v 261 = x261
  revert x118 x256 x257 x258 x261; decide

-- SÇ12 çözümü: S51 olayı imkânsız kılar.
theorem scat12_kopru :
    ¬ Saglanabilir (hepsi [S51, gormekIcinAlindi, sevmIleAlindi, telef, ∼kusur]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S51, batilSatis, fasidSatis, gormekIcinAlindi, kusur, sevmIleAlindi, telef] at *; revert h
  generalize v 256 = x256; generalize v 257 = x257; generalize v 258 = x258; generalize v 259 = x259; generalize v 260 = x260; generalize v 261 = x261
  revert x256 x257 x258 x259 x260 x261; decide

-- SÇ13. s298, s370 — olay: {batilSatis, izinleAlindi, sevmIleAlindi, telef, ¬kusur}
theorem scat13 :
    ¬ Saglanabilir (hepsi [s298, s370, batilSatis, izinleAlindi, sevmIleAlindi, telef, ∼kusur]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s298, s370, batilSatis, izinleAlindi, kusur, sevmIleAlindi, tazmin, telef] at *; revert h
  generalize v 118 = x118; generalize v 255 = x255; generalize v 256 = x256; generalize v 258 = x258; generalize v 260 = x260; generalize v 261 = x261
  revert x118 x255 x256 x258 x260 x261; decide

-- SÇ13 çözümü: S51 olayı imkânsız kılar.
theorem scat13_kopru :
    ¬ Saglanabilir (hepsi [S51, batilSatis, izinleAlindi, sevmIleAlindi, telef, ∼kusur]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S51, batilSatis, fasidSatis, gormekIcinAlindi, izinleAlindi, kusur, sevmIleAlindi, telef] at *; revert h
  generalize v 255 = x255; generalize v 256 = x256; generalize v 257 = x257; generalize v 258 = x258; generalize v 259 = x259; generalize v 260 = x260; generalize v 261 = x261
  revert x255 x256 x257 x258 x259 x260 x261; decide

-- SÇ14. s298, md90 — olay: {digerMubasir, mutesebbib, sevmIleAlindi, telef}
theorem scat14 :
    ¬ Saglanabilir (hepsi [s298, md90, digerMubasir, mutesebbib, sevmIleAlindi, telef]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s298, md90, digerMubasir, mutesebbib, sevmIleAlindi, tazmin, telef] at *; revert h
  generalize v 118 = x118; generalize v 127 = x127; generalize v 129 = x129; generalize v 258 = x258; generalize v 261 = x261
  revert x118 x127 x129 x258 x261; decide

-- md90: kısıtlı biçimi gerektirir.
theorem md90_satista_kisitlanir :
    Sonuc [md90] md90k := by
  intro v h
  have h0 := h md90 (by simp)
  simp only [hepsi, tepe, degil, deger, md90, md90k, bedelKarsiligi, digerMubasir, mutesebbib, tazmin] at *; revert h0
  generalize v 118 = x118; generalize v 127 = x127; generalize v 129 = x129; generalize v 262 = x262
  revert x118 x127 x129 x262; decide

-- SÇ14 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat14_cozum :
    Saglanabilir (hepsi [s298, md90k, digerMubasir, mutesebbib, sevmIleAlindi, telef]) := ⟨model [118, 127, 129, 258, 261, 262], by decide⟩

-- SÇ15. s298, md93 — olay: {mutesebbib, sevmIleAlindi, telef, ¬kast}
theorem scat15 :
    ¬ Saglanabilir (hepsi [s298, md93, mutesebbib, sevmIleAlindi, telef, ∼kast]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s298, md93, kast, mutesebbib, sevmIleAlindi, tazmin, telef] at *; revert h
  generalize v 118 = x118; generalize v 127 = x127; generalize v 128 = x128; generalize v 258 = x258; generalize v 261 = x261
  revert x118 x127 x128 x258 x261; decide

-- md93: kısıtlı biçimi gerektirir.
theorem md93_satista_kisitlanir :
    Sonuc [md93] md93k := by
  intro v h
  have h0 := h md93 (by simp)
  simp only [hepsi, tepe, degil, deger, md93, md93k, bedelKarsiligi, kast, mutesebbib, tazmin] at *; revert h0
  generalize v 118 = x118; generalize v 127 = x127; generalize v 128 = x128; generalize v 262 = x262
  revert x118 x127 x128 x262; decide

-- SÇ15 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat15_cozum :
    Saglanabilir (hepsi [s298, md93k, mutesebbib, sevmIleAlindi, telef, ∼kast]) := ⟨model [118, 127, 258, 261, 262], by decide⟩

-- SÇ16. s298, md94 — olay: {hayvanKendiliginden, sevmIleAlindi, telef}
theorem scat16 :
    ¬ Saglanabilir (hepsi [s298, md94, hayvanKendiliginden, sevmIleAlindi, telef]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s298, md94, hayvanKendiliginden, sevmIleAlindi, tazmin, telef] at *; revert h
  generalize v 118 = x118; generalize v 130 = x130; generalize v 258 = x258; generalize v 261 = x261
  revert x118 x130 x258 x261; decide

-- md94: kısıtlı biçimi gerektirir.
theorem md94_satista_kisitlanir :
    Sonuc [md94] md94k := by
  intro v h
  have h0 := h md94 (by simp)
  simp only [hepsi, tepe, degil, deger, md94, md94k, bedelKarsiligi, hayvanKendiliginden, tazmin] at *; revert h0
  generalize v 118 = x118; generalize v 130 = x130; generalize v 262 = x262
  revert x118 x130 x262; decide

-- SÇ16 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat16_cozum :
    Saglanabilir (hepsi [s298, md94k, hayvanKendiliginden, sevmIleAlindi, telef]) := ⟨model [118, 130, 258, 261, 262], by decide⟩

-- SÇ17. s299, s371, S40 — olay: {fasidSatis, gormekIcinAlindi, telef, ¬kusur}
theorem scat17 :
    ¬ Saglanabilir (hepsi [s299, s371, S40, fasidSatis, gormekIcinAlindi, telef, ∼kusur]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s299, s371, S40, fasidSatis, gormekIcinAlindi, izinleAlindi, kusur, tazmin, telef] at *; revert h
  generalize v 118 = x118; generalize v 255 = x255; generalize v 256 = x256; generalize v 257 = x257; generalize v 259 = x259; generalize v 261 = x261
  revert x118 x255 x256 x257 x259 x261; decide

-- SÇ17 çözümü: S51 olayı imkânsız kılar.
theorem scat17_kopru :
    ¬ Saglanabilir (hepsi [S40, S51, fasidSatis, gormekIcinAlindi, telef, ∼kusur]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S40, S51, batilSatis, fasidSatis, gormekIcinAlindi, izinleAlindi, kusur, sevmIleAlindi, telef] at *; revert h
  generalize v 255 = x255; generalize v 256 = x256; generalize v 257 = x257; generalize v 258 = x258; generalize v 259 = x259; generalize v 260 = x260; generalize v 261 = x261
  revert x255 x256 x257 x258 x259 x260 x261; decide

-- SÇ18. s299, s371 — olay: {fasidSatis, gormekIcinAlindi, izinleAlindi, telef, ¬kusur}
theorem scat18 :
    ¬ Saglanabilir (hepsi [s299, s371, fasidSatis, gormekIcinAlindi, izinleAlindi, telef, ∼kusur]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s299, s371, fasidSatis, gormekIcinAlindi, izinleAlindi, kusur, tazmin, telef] at *; revert h
  generalize v 118 = x118; generalize v 255 = x255; generalize v 256 = x256; generalize v 257 = x257; generalize v 259 = x259; generalize v 261 = x261
  revert x118 x255 x256 x257 x259 x261; decide

-- SÇ18 çözümü: S51 olayı imkânsız kılar.
theorem scat18_kopru :
    ¬ Saglanabilir (hepsi [S51, fasidSatis, gormekIcinAlindi, izinleAlindi, telef, ∼kusur]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S51, batilSatis, fasidSatis, gormekIcinAlindi, izinleAlindi, kusur, sevmIleAlindi, telef] at *; revert h
  generalize v 255 = x255; generalize v 256 = x256; generalize v 257 = x257; generalize v 258 = x258; generalize v 259 = x259; generalize v 260 = x260; generalize v 261 = x261
  revert x255 x256 x257 x258 x259 x260 x261; decide

-- SÇ19. s299, md33 — olay: {gayrinMali, gormekIcinAlindi, mubasir, telef, zaruret, ¬kusur}
theorem scat19 :
    ¬ Saglanabilir (hepsi [s299, md33, gayrinMali, gormekIcinAlindi, mubasir, telef, zaruret, ∼kusur]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s299, md33, gayrinMali, gormekIcinAlindi, kusur, mubasir, tazmin, telef, zaruret] at *; revert h
  generalize v 6 = x6; generalize v 118 = x118; generalize v 126 = x126; generalize v 131 = x131; generalize v 256 = x256; generalize v 257 = x257; generalize v 261 = x261
  revert x6 x118 x126 x131 x256 x257 x261; decide

-- SÇ19 çözümü: S39 olayı imkânsız kılar.
theorem scat19_kopru :
    ¬ Saglanabilir (hepsi [S39, gayrinMali, gormekIcinAlindi, mubasir, telef, zaruret, ∼kusur]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S39, gayrinMali, gormekIcinAlindi, kusur, mubasir, telef, zaruret] at *; revert h
  generalize v 6 = x6; generalize v 126 = x126; generalize v 131 = x131; generalize v 256 = x256; generalize v 257 = x257; generalize v 261 = x261
  revert x6 x126 x131 x256 x257 x261; decide

-- SÇ20. s299, md92 — olay: {gormekIcinAlindi, mubasir, telef, ¬kusur}
theorem scat20 :
    ¬ Saglanabilir (hepsi [s299, md92, gormekIcinAlindi, mubasir, telef, ∼kusur]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s299, md92, gormekIcinAlindi, kusur, mubasir, tazmin, telef] at *; revert h
  generalize v 118 = x118; generalize v 126 = x126; generalize v 256 = x256; generalize v 257 = x257; generalize v 261 = x261
  revert x118 x126 x256 x257 x261; decide

-- SÇ20 çözümü: S39 olayı imkânsız kılar.
theorem scat20_kopru :
    ¬ Saglanabilir (hepsi [S39, gormekIcinAlindi, mubasir, telef, ∼kusur]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S39, gormekIcinAlindi, kusur, mubasir, telef] at *; revert h
  generalize v 126 = x126; generalize v 256 = x256; generalize v 257 = x257; generalize v 261 = x261
  revert x126 x256 x257 x261; decide

-- SÇ21. s310, s312 — olay: {tasarruf, vasifSoylendi, vasifYok}
theorem scat21 :
    ¬ Saglanabilir (hepsi [s310, s312, tasarruf, vasifSoylendi, vasifYok]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s310, s312, tasarruf, vasifHakki, vasifSoylendi, vasifYok] at *; revert h
  generalize v 34 = x34; generalize v 245 = x245; generalize v 246 = x246; generalize v 247 = x247
  revert x34 x245 x246 x247; decide

-- s310: kısıtlı biçimi gerektirir.
theorem s310_satista_kisitlanir :
    Sonuc [s310] s310k := by
  intro v h
  have h0 := h s310 (by simp)
  simp only [hepsi, tepe, degil, deger, s310, s310k, tasarruf, vasifHakki, vasifSoylendi, vasifYok] at *; revert h0
  generalize v 34 = x34; generalize v 245 = x245; generalize v 246 = x246; generalize v 247 = x247
  revert x34 x245 x246 x247; decide

-- SÇ21 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat21_cozum :
    Saglanabilir (hepsi [s310k, s312, tasarruf, vasifSoylendi, vasifYok]) := ⟨model [34, 245, 246], by decide⟩

-- SÇ22. s320, s332 — olay: {gormedenAldi, onceGordu, ¬degisimSabit}
theorem scat22 :
    ¬ Saglanabilir (hepsi [s320, s332, gormedenAldi, onceGordu, ∼degisimSabit]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s320, s332, degisimSabit, gormeHakki, gormedenAldi, onceGordu] at *; revert h
  generalize v 3 = x3; generalize v 248 = x248; generalize v 249 = x249; generalize v 253 = x253
  revert x3 x248 x249 x253; decide

-- s320: kısıtlı biçimi gerektirir.
theorem s320_satista_kisitlanir :
    Sonuc [s320] s320k := by
  intro v h
  have h0 := h s320 (by simp)
  simp only [hepsi, tepe, degil, deger, s320, s320k, degisimSabit, gormeHakki, gormedenAldi, onceGordu, tasarruf] at *; revert h0
  generalize v 3 = x3; generalize v 34 = x34; generalize v 248 = x248; generalize v 249 = x249; generalize v 253 = x253
  revert x3 x34 x248 x249 x253; decide

-- SÇ22 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat22_cozum :
    Saglanabilir (hepsi [s320k, s332, gormedenAldi, onceGordu, ∼degisimSabit]) := ⟨model [34, 248, 249], by decide⟩

-- SÇ23. s320, s335 — olay: {gormedenAldi, tasarruf}
theorem scat23 :
    ¬ Saglanabilir (hepsi [s320, s335, gormedenAldi, tasarruf]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s320, s335, gormeHakki, gormedenAldi, tasarruf] at *; revert h
  generalize v 34 = x34; generalize v 248 = x248; generalize v 253 = x253
  revert x34 x248 x253; decide

-- SÇ23 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat23_cozum :
    Saglanabilir (hepsi [s320k, s335, gormedenAldi, tasarruf]) := ⟨model [3, 34, 248, 249], by decide⟩

-- SÇ24. s341, s345, S28 — olay: {ayipAciklandi, eskiAyip, yeniAyip}
theorem scat24 :
    ¬ Saglanabilir (hepsi [s341, s345, S28, ayipAciklandi, eskiAyip, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s341, s345, S28, ayipAciklandi, bedelEksikligi, eskiAyip, iadeHakki, kusurHakki, yeniAyip] at *; revert h
  generalize v 37 = x37; generalize v 230 = x230; generalize v 231 = x231; generalize v 235 = x235; generalize v 236 = x236; generalize v 237 = x237
  revert x37 x230 x231 x235 x236 x237; decide

-- s345: kısıtlı biçimi gerektirir.
theorem s345_satista_kisitlanir :
    Sonuc [s345] s345k := by
  intro v h
  have h0 := h s345 (by simp)
  simp only [hepsi, tepe, degil, deger, s345, s345k, bedelEksikligi, eskiAyip, fazlalik, iadeHakki, riza, saticiIadeyeRazi, yeniAyip, yeniAyipKalkti] at *; revert h0
  generalize v 35 = x35; generalize v 230 = x230; generalize v 231 = x231; generalize v 232 = x232; generalize v 233 = x233; generalize v 234 = x234; generalize v 235 = x235; generalize v 236 = x236
  revert x35 x230 x231 x232 x233 x234 x235 x236; decide

-- SÇ24 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat24_cozum :
    Saglanabilir (hepsi [s341, s345k, S28, ayipAciklandi, eskiAyip, yeniAyip]) := ⟨model [35, 230, 231, 237], by decide⟩

-- SÇ25. s341, s347, S28 — olay: {ayipAciklandi, eskiAyip, yeniAyipKalkti}
theorem scat25 :
    ¬ Saglanabilir (hepsi [s341, s347, S28, ayipAciklandi, eskiAyip, yeniAyipKalkti]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s341, s347, S28, ayipAciklandi, bedelEksikligi, eskiAyip, iadeHakki, kusurHakki, yeniAyipKalkti] at *; revert h
  generalize v 37 = x37; generalize v 230 = x230; generalize v 232 = x232; generalize v 235 = x235; generalize v 236 = x236; generalize v 237 = x237
  revert x37 x230 x232 x235 x236 x237; decide

-- s347: kısıtlı biçimi gerektirir.
theorem s347_satista_kisitlanir :
    Sonuc [s347] s347k := by
  intro v h
  have h0 := h s347 (by simp)
  simp only [hepsi, tepe, degil, deger, s347, s347k, eskiAyip, fazlalik, iadeHakki, riza, yeniAyipKalkti] at *; revert h0
  generalize v 35 = x35; generalize v 230 = x230; generalize v 232 = x232; generalize v 234 = x234; generalize v 235 = x235
  revert x35 x230 x232 x234 x235; decide

-- SÇ25 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat25_cozum :
    Saglanabilir (hepsi [s341, s347k, S28, ayipAciklandi, eskiAyip, yeniAyipKalkti]) := ⟨model [35, 230, 232, 237], by decide⟩

-- SÇ26. s341, s348, S28 — olay: {ayipAciklandi, eskiAyip, saticiIadeyeRazi, yeniAyip}
theorem scat26 :
    ¬ Saglanabilir (hepsi [s341, s348, S28, ayipAciklandi, eskiAyip, saticiIadeyeRazi, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s341, s348, S28, ayipAciklandi, bedelEksikligi, eskiAyip, iadeHakki, kusurHakki, saticiIadeyeRazi, yeniAyip] at *; revert h
  generalize v 37 = x37; generalize v 230 = x230; generalize v 231 = x231; generalize v 233 = x233; generalize v 235 = x235; generalize v 236 = x236; generalize v 237 = x237
  revert x37 x230 x231 x233 x235 x236 x237; decide

-- s348: kısıtlı biçimi gerektirir.
theorem s348_satista_kisitlanir :
    Sonuc [s348] s348k := by
  intro v h
  have h0 := h s348 (by simp)
  simp only [hepsi, tepe, degil, deger, s348, s348k, bedelEksikligi, eskiAyip, fazlalik, iadeHakki, riza, saticiIadeyeRazi, yeniAyip] at *; revert h0
  generalize v 35 = x35; generalize v 230 = x230; generalize v 231 = x231; generalize v 233 = x233; generalize v 234 = x234; generalize v 235 = x235; generalize v 236 = x236
  revert x35 x230 x231 x233 x234 x235 x236; decide

-- SÇ26 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat26_cozum :
    Saglanabilir (hepsi [s341, s348k, S28, ayipAciklandi, eskiAyip, saticiIadeyeRazi, yeniAyip]) := ⟨model [35, 230, 231, 233, 237], by decide⟩

-- SÇ27. s342, s345, S28 — olay: {beraatSarti, eskiAyip, yeniAyip}
theorem scat27 :
    ¬ Saglanabilir (hepsi [s342, s345, S28, beraatSarti, eskiAyip, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s342, s345, S28, bedelEksikligi, beraatSarti, eskiAyip, iadeHakki, kusurHakki, yeniAyip] at *; revert h
  generalize v 37 = x37; generalize v 230 = x230; generalize v 231 = x231; generalize v 235 = x235; generalize v 236 = x236; generalize v 238 = x238
  revert x37 x230 x231 x235 x236 x238; decide

-- SÇ27 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat27_cozum :
    Saglanabilir (hepsi [s342, s345k, S28, beraatSarti, eskiAyip, yeniAyip]) := ⟨model [35, 230, 231, 238], by decide⟩

-- SÇ28. s342, s347, S28 — olay: {beraatSarti, eskiAyip, yeniAyipKalkti}
theorem scat28 :
    ¬ Saglanabilir (hepsi [s342, s347, S28, beraatSarti, eskiAyip, yeniAyipKalkti]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s342, s347, S28, bedelEksikligi, beraatSarti, eskiAyip, iadeHakki, kusurHakki, yeniAyipKalkti] at *; revert h
  generalize v 37 = x37; generalize v 230 = x230; generalize v 232 = x232; generalize v 235 = x235; generalize v 236 = x236; generalize v 238 = x238
  revert x37 x230 x232 x235 x236 x238; decide

-- SÇ28 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat28_cozum :
    Saglanabilir (hepsi [s342, s347k, S28, beraatSarti, eskiAyip, yeniAyipKalkti]) := ⟨model [35, 230, 232, 238], by decide⟩

-- SÇ29. s342, s348, S28 — olay: {beraatSarti, eskiAyip, saticiIadeyeRazi, yeniAyip}
theorem scat29 :
    ¬ Saglanabilir (hepsi [s342, s348, S28, beraatSarti, eskiAyip, saticiIadeyeRazi, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s342, s348, S28, bedelEksikligi, beraatSarti, eskiAyip, iadeHakki, kusurHakki, saticiIadeyeRazi, yeniAyip] at *; revert h
  generalize v 37 = x37; generalize v 230 = x230; generalize v 231 = x231; generalize v 233 = x233; generalize v 235 = x235; generalize v 236 = x236; generalize v 238 = x238
  revert x37 x230 x231 x233 x235 x236 x238; decide

-- SÇ29 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat29_cozum :
    Saglanabilir (hepsi [s342, s348k, S28, beraatSarti, eskiAyip, saticiIadeyeRazi, yeniAyip]) := ⟨model [35, 230, 231, 233, 238], by decide⟩

-- SÇ30. s343, s345, S28 — olay: {eskiAyip, herAyibiylaKabul, yeniAyip}
theorem scat30 :
    ¬ Saglanabilir (hepsi [s343, s345, S28, eskiAyip, herAyibiylaKabul, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s343, s345, S28, bedelEksikligi, eskiAyip, herAyibiylaKabul, iadeHakki, kusurHakki, yeniAyip] at *; revert h
  generalize v 37 = x37; generalize v 230 = x230; generalize v 231 = x231; generalize v 235 = x235; generalize v 236 = x236; generalize v 239 = x239
  revert x37 x230 x231 x235 x236 x239; decide

-- SÇ30 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat30_cozum :
    Saglanabilir (hepsi [s343, s345k, S28, eskiAyip, herAyibiylaKabul, yeniAyip]) := ⟨model [35, 230, 231, 239], by decide⟩

-- SÇ31. s343, s347, S28 — olay: {eskiAyip, herAyibiylaKabul, yeniAyipKalkti}
theorem scat31 :
    ¬ Saglanabilir (hepsi [s343, s347, S28, eskiAyip, herAyibiylaKabul, yeniAyipKalkti]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s343, s347, S28, bedelEksikligi, eskiAyip, herAyibiylaKabul, iadeHakki, kusurHakki, yeniAyipKalkti] at *; revert h
  generalize v 37 = x37; generalize v 230 = x230; generalize v 232 = x232; generalize v 235 = x235; generalize v 236 = x236; generalize v 239 = x239
  revert x37 x230 x232 x235 x236 x239; decide

-- SÇ31 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat31_cozum :
    Saglanabilir (hepsi [s343, s347k, S28, eskiAyip, herAyibiylaKabul, yeniAyipKalkti]) := ⟨model [35, 230, 232, 239], by decide⟩

-- SÇ32. s343, s348, S28 — olay: {eskiAyip, herAyibiylaKabul, saticiIadeyeRazi, yeniAyip}
theorem scat32 :
    ¬ Saglanabilir (hepsi [s343, s348, S28, eskiAyip, herAyibiylaKabul, saticiIadeyeRazi, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s343, s348, S28, bedelEksikligi, eskiAyip, herAyibiylaKabul, iadeHakki, kusurHakki, saticiIadeyeRazi, yeniAyip] at *; revert h
  generalize v 37 = x37; generalize v 230 = x230; generalize v 231 = x231; generalize v 233 = x233; generalize v 235 = x235; generalize v 236 = x236; generalize v 239 = x239
  revert x37 x230 x231 x233 x235 x236 x239; decide

-- SÇ32 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat32_cozum :
    Saglanabilir (hepsi [s343, s348k, S28, eskiAyip, herAyibiylaKabul, saticiIadeyeRazi, yeniAyip]) := ⟨model [35, 230, 231, 233, 239], by decide⟩

-- SÇ33. s344, s345, S28 — olay: {bilgi, eskiAyip, tasarruf, yeniAyip}
theorem scat33 :
    ¬ Saglanabilir (hepsi [s344, s345, S28, bilgi, eskiAyip, tasarruf, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s344, s345, S28, bedelEksikligi, bilgi, eskiAyip, iadeHakki, kusurHakki, tasarruf, yeniAyip] at *; revert h
  generalize v 33 = x33; generalize v 34 = x34; generalize v 37 = x37; generalize v 230 = x230; generalize v 231 = x231; generalize v 235 = x235; generalize v 236 = x236
  revert x33 x34 x37 x230 x231 x235 x236; decide

-- s344: kısıtlı biçimi gerektirir.
theorem s344_satista_kisitlanir :
    Sonuc [s344] s344k := by
  intro v h
  have h0 := h s344 (by simp)
  simp only [hepsi, tepe, degil, deger, s344, s344k, bilgi, eskiAyip, iadeMumkun, kusurHakki, tasarruf] at *; revert h0
  generalize v 33 = x33; generalize v 34 = x34; generalize v 36 = x36; generalize v 37 = x37; generalize v 230 = x230
  revert x33 x34 x36 x37 x230; decide

-- SÇ33 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat33_cozum :
    Saglanabilir (hepsi [s344k, s345k, S28, bilgi, eskiAyip, tasarruf, yeniAyip]) := ⟨model [33, 34, 35, 37, 230, 231, 235], by decide⟩

-- SÇ34. s344, s347, S28 — olay: {bilgi, eskiAyip, tasarruf, yeniAyipKalkti}
theorem scat34 :
    ¬ Saglanabilir (hepsi [s344, s347, S28, bilgi, eskiAyip, tasarruf, yeniAyipKalkti]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s344, s347, S28, bedelEksikligi, bilgi, eskiAyip, iadeHakki, kusurHakki, tasarruf, yeniAyipKalkti] at *; revert h
  generalize v 33 = x33; generalize v 34 = x34; generalize v 37 = x37; generalize v 230 = x230; generalize v 232 = x232; generalize v 235 = x235; generalize v 236 = x236
  revert x33 x34 x37 x230 x232 x235 x236; decide

-- SÇ34 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat34_cozum :
    Saglanabilir (hepsi [s344k, s347k, S28, bilgi, eskiAyip, tasarruf, yeniAyipKalkti]) := ⟨model [33, 34, 35, 37, 230, 232, 236], by decide⟩

-- SÇ35. s344, s348, S28 — olay: {bilgi, eskiAyip, saticiIadeyeRazi, tasarruf, yeniAyip}
theorem scat35 :
    ¬ Saglanabilir (hepsi [s344, s348, S28, bilgi, eskiAyip, saticiIadeyeRazi, tasarruf, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s344, s348, S28, bedelEksikligi, bilgi, eskiAyip, iadeHakki, kusurHakki, saticiIadeyeRazi, tasarruf, yeniAyip] at *; revert h
  generalize v 33 = x33; generalize v 34 = x34; generalize v 37 = x37; generalize v 230 = x230; generalize v 231 = x231; generalize v 233 = x233; generalize v 235 = x235; generalize v 236 = x236
  revert x33 x34 x37 x230 x231 x233 x235 x236; decide

-- SÇ35 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat35_cozum :
    Saglanabilir (hepsi [s344k, s348k, S28, bilgi, eskiAyip, saticiIadeyeRazi, tasarruf, yeniAyip]) := ⟨model [33, 34, 35, 37, 230, 231, 233, 236], by decide⟩

-- SÇ36. s345, s347 — olay: {eskiAyip, yeniAyip, yeniAyipKalkti}
theorem scat36 :
    ¬ Saglanabilir (hepsi [s345, s347, eskiAyip, yeniAyip, yeniAyipKalkti]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s345, s347, bedelEksikligi, eskiAyip, iadeHakki, yeniAyip, yeniAyipKalkti] at *; revert h
  generalize v 230 = x230; generalize v 231 = x231; generalize v 232 = x232; generalize v 235 = x235; generalize v 236 = x236
  revert x230 x231 x232 x235 x236; decide

-- SÇ36 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat36_cozum :
    Saglanabilir (hepsi [s345k, s347k, eskiAyip, yeniAyip, yeniAyipKalkti]) := ⟨model [35, 230, 231, 232], by decide⟩

-- SÇ37. s345, s348 — olay: {eskiAyip, saticiIadeyeRazi, yeniAyip}
theorem scat37 :
    ¬ Saglanabilir (hepsi [s345, s348, eskiAyip, saticiIadeyeRazi, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s345, s348, bedelEksikligi, eskiAyip, iadeHakki, saticiIadeyeRazi, yeniAyip] at *; revert h
  generalize v 230 = x230; generalize v 231 = x231; generalize v 233 = x233; generalize v 235 = x235; generalize v 236 = x236
  revert x230 x231 x233 x235 x236; decide

-- SÇ37 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat37_cozum :
    Saglanabilir (hepsi [s345k, s348k, eskiAyip, saticiIadeyeRazi, yeniAyip]) := ⟨model [35, 230, 231, 233], by decide⟩

-- SÇ38. s345, md24, S21, S22 — olay: {eskiAyip, saticiIadeyeRazi, yeniAyip}
theorem scat38 :
    ¬ Saglanabilir (hepsi [s345, md24, S21, S22, eskiAyip, saticiIadeyeRazi, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s345, md24, S21, S22, avdet, bedelEksikligi, eskiAyip, iadeHakki, maniZail, saticiIadeyeRazi, yeniAyip] at *; revert h
  generalize v 22 = x22; generalize v 23 = x23; generalize v 230 = x230; generalize v 231 = x231; generalize v 233 = x233; generalize v 235 = x235; generalize v 236 = x236
  revert x22 x23 x230 x231 x233 x235 x236; decide

-- SÇ38 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat38_cozum :
    Saglanabilir (hepsi [s345k, md24, S21, S22, eskiAyip, saticiIadeyeRazi, yeniAyip]) := ⟨model [22, 23, 35, 230, 231, 233, 235, 236], by decide⟩

-- SÇ39. s345, md24, S20, S22 — olay: {eskiAyip, yeniAyip, yeniAyipKalkti}
theorem scat39 :
    ¬ Saglanabilir (hepsi [s345, md24, S20, S22, eskiAyip, yeniAyip, yeniAyipKalkti]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s345, md24, S20, S22, avdet, bedelEksikligi, eskiAyip, iadeHakki, maniZail, yeniAyip, yeniAyipKalkti] at *; revert h
  generalize v 22 = x22; generalize v 23 = x23; generalize v 230 = x230; generalize v 231 = x231; generalize v 232 = x232; generalize v 235 = x235; generalize v 236 = x236
  revert x22 x23 x230 x231 x232 x235 x236; decide

-- SÇ39 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat39_cozum :
    Saglanabilir (hepsi [s345k, md24, S20, S22, eskiAyip, yeniAyip, yeniAyipKalkti]) := ⟨model [22, 23, 35, 230, 231, 232, 235, 236], by decide⟩

-- SÇ40. s345, md100, S28, S29 — olay: {ayipAciklandi, eskiAyip, yeniAyip}
theorem scat40 :
    ¬ Saglanabilir (hepsi [s345, md100, S28, S29, ayipAciklandi, eskiAyip, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s345, md100, S28, S29, ayipAciklandi, bedelEksikligi, eskiAyip, iadeHakki, kusurHakki, riza, yeniAyip] at *; revert h
  generalize v 35 = x35; generalize v 37 = x37; generalize v 230 = x230; generalize v 231 = x231; generalize v 235 = x235; generalize v 236 = x236; generalize v 237 = x237
  revert x35 x37 x230 x231 x235 x236 x237; decide

-- SÇ40 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat40_cozum :
    Saglanabilir (hepsi [s345k, md100, S28, S29, ayipAciklandi, eskiAyip, yeniAyip]) := ⟨model [35, 230, 231, 237], by decide⟩

-- SÇ41. s345, md100, S28, S30 — olay: {beraatSarti, eskiAyip, yeniAyip}
theorem scat41 :
    ¬ Saglanabilir (hepsi [s345, md100, S28, S30, beraatSarti, eskiAyip, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s345, md100, S28, S30, bedelEksikligi, beraatSarti, eskiAyip, iadeHakki, kusurHakki, riza, yeniAyip] at *; revert h
  generalize v 35 = x35; generalize v 37 = x37; generalize v 230 = x230; generalize v 231 = x231; generalize v 235 = x235; generalize v 236 = x236; generalize v 238 = x238
  revert x35 x37 x230 x231 x235 x236 x238; decide

-- SÇ41 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat41_cozum :
    Saglanabilir (hepsi [s345k, md100, S28, S30, beraatSarti, eskiAyip, yeniAyip]) := ⟨model [35, 230, 231, 238], by decide⟩

-- SÇ42. s345, md100, K9, S28 — olay: {bilgi, eskiAyip, tasarruf, yeniAyip}
theorem scat42 :
    ¬ Saglanabilir (hepsi [s345, md100, K9, S28, bilgi, eskiAyip, tasarruf, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s345, md100, K9, S28, bedelEksikligi, bilgi, eskiAyip, iadeHakki, kusurHakki, riza, tasarruf, yeniAyip] at *; revert h
  generalize v 33 = x33; generalize v 34 = x34; generalize v 35 = x35; generalize v 37 = x37; generalize v 230 = x230; generalize v 231 = x231; generalize v 235 = x235; generalize v 236 = x236
  revert x33 x34 x35 x37 x230 x231 x235 x236; decide

-- SÇ42 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat42_cozum :
    Saglanabilir (hepsi [s345k, md100, K9k, S28, bilgi, eskiAyip, tasarruf, yeniAyip]) := ⟨model [33, 34, 35, 230, 231], by decide⟩

-- SÇ43. s345, md100, S28, S31 — olay: {eskiAyip, herAyibiylaKabul, yeniAyip}
theorem scat43 :
    ¬ Saglanabilir (hepsi [s345, md100, S28, S31, eskiAyip, herAyibiylaKabul, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s345, md100, S28, S31, bedelEksikligi, eskiAyip, herAyibiylaKabul, iadeHakki, kusurHakki, riza, yeniAyip] at *; revert h
  generalize v 35 = x35; generalize v 37 = x37; generalize v 230 = x230; generalize v 231 = x231; generalize v 235 = x235; generalize v 236 = x236; generalize v 239 = x239
  revert x35 x37 x230 x231 x235 x236 x239; decide

-- SÇ43 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat43_cozum :
    Saglanabilir (hepsi [s345k, md100, S28, S31, eskiAyip, herAyibiylaKabul, yeniAyip]) := ⟨model [35, 230, 231, 239], by decide⟩

-- SÇ44. s347, s349, S27 — olay: {eskiAyip, fazlalik, yeniAyipKalkti}
theorem scat44 :
    ¬ Saglanabilir (hepsi [s347, s349, S27, eskiAyip, fazlalik, yeniAyipKalkti]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s347, s349, S27, eskiAyip, fazlalik, iadeHakki, iadeMumkun, yeniAyipKalkti] at *; revert h
  generalize v 36 = x36; generalize v 230 = x230; generalize v 232 = x232; generalize v 234 = x234; generalize v 235 = x235
  revert x36 x230 x232 x234 x235; decide

-- SÇ44 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat44_cozum :
    Saglanabilir (hepsi [s347k, s349, S27, eskiAyip, fazlalik, yeniAyipKalkti]) := ⟨model [35, 230, 232, 234], by decide⟩

-- SÇ45. s347, s354 — olay: {azBozuk, eskiAyip, yeniAyipKalkti}
theorem scat45 :
    ¬ Saglanabilir (hepsi [s347, s354, azBozuk, eskiAyip, yeniAyipKalkti]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s347, s354, azBozuk, eskiAyip, iadeHakki, yeniAyipKalkti] at *; revert h
  generalize v 230 = x230; generalize v 232 = x232; generalize v 235 = x235; generalize v 241 = x241
  revert x230 x232 x235 x241; decide

-- SÇ45 çözümü: S54 olayı imkânsız kılar.
theorem scat45_kopru :
    ¬ Saglanabilir (hepsi [S54, azBozuk, eskiAyip, yeniAyipKalkti]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S54, azBozuk, eskiAyip, yeniAyipKalkti] at *; revert h
  generalize v 230 = x230; generalize v 232 = x232; generalize v 241 = x241
  revert x230 x232 x241; decide

-- SÇ46. s347, md42, S32, S33 — olay: {azBozuk, eskiAyip, yeniAyipKalkti}
theorem scat46 :
    ¬ Saglanabilir (hepsi [s347, md42, S32, S33, azBozuk, eskiAyip, yeniAyipKalkti]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s347, md42, S32, S33, azBozuk, eskiAyip, galib, iadeHakki, muteber, nadir, yeniAyipKalkti] at *; revert h
  generalize v 160 = x160; generalize v 161 = x161; generalize v 162 = x162; generalize v 230 = x230; generalize v 232 = x232; generalize v 235 = x235; generalize v 241 = x241
  revert x160 x161 x162 x230 x232 x235 x241; decide

-- SÇ46 çözümü: S54 olayı imkânsız kılar.
theorem scat46_kopru :
    ¬ Saglanabilir (hepsi [S32, S33, S54, azBozuk, eskiAyip, yeniAyipKalkti]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S32, S33, S54, azBozuk, eskiAyip, iadeHakki, muteber, nadir, yeniAyipKalkti] at *; revert h
  generalize v 161 = x161; generalize v 162 = x162; generalize v 230 = x230; generalize v 232 = x232; generalize v 235 = x235; generalize v 241 = x241
  revert x161 x162 x230 x232 x235 x241; decide

-- SÇ47. s347, md100, S28, S29 — olay: {ayipAciklandi, eskiAyip, yeniAyipKalkti}
theorem scat47 :
    ¬ Saglanabilir (hepsi [s347, md100, S28, S29, ayipAciklandi, eskiAyip, yeniAyipKalkti]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s347, md100, S28, S29, ayipAciklandi, bedelEksikligi, eskiAyip, iadeHakki, kusurHakki, riza, yeniAyipKalkti] at *; revert h
  generalize v 35 = x35; generalize v 37 = x37; generalize v 230 = x230; generalize v 232 = x232; generalize v 235 = x235; generalize v 236 = x236; generalize v 237 = x237
  revert x35 x37 x230 x232 x235 x236 x237; decide

-- SÇ47 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat47_cozum :
    Saglanabilir (hepsi [s347k, md100, S28, S29, ayipAciklandi, eskiAyip, yeniAyipKalkti]) := ⟨model [35, 230, 232, 237], by decide⟩

-- SÇ48. s347, md100, S28, S30 — olay: {beraatSarti, eskiAyip, yeniAyipKalkti}
theorem scat48 :
    ¬ Saglanabilir (hepsi [s347, md100, S28, S30, beraatSarti, eskiAyip, yeniAyipKalkti]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s347, md100, S28, S30, bedelEksikligi, beraatSarti, eskiAyip, iadeHakki, kusurHakki, riza, yeniAyipKalkti] at *; revert h
  generalize v 35 = x35; generalize v 37 = x37; generalize v 230 = x230; generalize v 232 = x232; generalize v 235 = x235; generalize v 236 = x236; generalize v 238 = x238
  revert x35 x37 x230 x232 x235 x236 x238; decide

-- SÇ48 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat48_cozum :
    Saglanabilir (hepsi [s347k, md100, S28, S30, beraatSarti, eskiAyip, yeniAyipKalkti]) := ⟨model [35, 230, 232, 238], by decide⟩

-- SÇ49. s347, md100, K9, S28 — olay: {bilgi, eskiAyip, tasarruf, yeniAyipKalkti}
theorem scat49 :
    ¬ Saglanabilir (hepsi [s347, md100, K9, S28, bilgi, eskiAyip, tasarruf, yeniAyipKalkti]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s347, md100, K9, S28, bedelEksikligi, bilgi, eskiAyip, iadeHakki, kusurHakki, riza, tasarruf, yeniAyipKalkti] at *; revert h
  generalize v 33 = x33; generalize v 34 = x34; generalize v 35 = x35; generalize v 37 = x37; generalize v 230 = x230; generalize v 232 = x232; generalize v 235 = x235; generalize v 236 = x236
  revert x33 x34 x35 x37 x230 x232 x235 x236; decide

-- SÇ49 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat49_cozum :
    Saglanabilir (hepsi [s347k, md100, K9k, S28, bilgi, eskiAyip, tasarruf, yeniAyipKalkti]) := ⟨model [33, 34, 35, 230, 232], by decide⟩

-- SÇ50. s347, md100, S28, S31 — olay: {eskiAyip, herAyibiylaKabul, yeniAyipKalkti}
theorem scat50 :
    ¬ Saglanabilir (hepsi [s347, md100, S28, S31, eskiAyip, herAyibiylaKabul, yeniAyipKalkti]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s347, md100, S28, S31, bedelEksikligi, eskiAyip, herAyibiylaKabul, iadeHakki, kusurHakki, riza, yeniAyipKalkti] at *; revert h
  generalize v 35 = x35; generalize v 37 = x37; generalize v 230 = x230; generalize v 232 = x232; generalize v 235 = x235; generalize v 236 = x236; generalize v 239 = x239
  revert x35 x37 x230 x232 x235 x236 x239; decide

-- SÇ50 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat50_cozum :
    Saglanabilir (hepsi [s347k, md100, S28, S31, eskiAyip, herAyibiylaKabul, yeniAyipKalkti]) := ⟨model [35, 230, 232, 239], by decide⟩

-- SÇ51. s348, s349, S27 — olay: {eskiAyip, fazlalik, saticiIadeyeRazi, yeniAyip}
theorem scat51 :
    ¬ Saglanabilir (hepsi [s348, s349, S27, eskiAyip, fazlalik, saticiIadeyeRazi, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s348, s349, S27, bedelEksikligi, eskiAyip, fazlalik, iadeHakki, iadeMumkun, saticiIadeyeRazi, yeniAyip] at *; revert h
  generalize v 36 = x36; generalize v 230 = x230; generalize v 231 = x231; generalize v 233 = x233; generalize v 234 = x234; generalize v 235 = x235; generalize v 236 = x236
  revert x36 x230 x231 x233 x234 x235 x236; decide

-- SÇ51 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat51_cozum :
    Saglanabilir (hepsi [s348k, s349, S27, eskiAyip, fazlalik, saticiIadeyeRazi, yeniAyip]) := ⟨model [35, 230, 231, 233, 234], by decide⟩

-- SÇ52. s348, s354 — olay: {azBozuk, eskiAyip, saticiIadeyeRazi, yeniAyip}
theorem scat52 :
    ¬ Saglanabilir (hepsi [s348, s354, azBozuk, eskiAyip, saticiIadeyeRazi, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s348, s354, azBozuk, bedelEksikligi, eskiAyip, iadeHakki, saticiIadeyeRazi, yeniAyip] at *; revert h
  generalize v 230 = x230; generalize v 231 = x231; generalize v 233 = x233; generalize v 235 = x235; generalize v 236 = x236; generalize v 241 = x241
  revert x230 x231 x233 x235 x236 x241; decide

-- SÇ52 çözümü: S54 olayı imkânsız kılar.
theorem scat52_kopru :
    ¬ Saglanabilir (hepsi [S54, azBozuk, eskiAyip, saticiIadeyeRazi, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S54, azBozuk, eskiAyip, saticiIadeyeRazi, yeniAyip] at *; revert h
  generalize v 230 = x230; generalize v 231 = x231; generalize v 233 = x233; generalize v 241 = x241
  revert x230 x231 x233 x241; decide

-- SÇ53. s348, md42, S32, S33 — olay: {azBozuk, eskiAyip, saticiIadeyeRazi, yeniAyip}
theorem scat53 :
    ¬ Saglanabilir (hepsi [s348, md42, S32, S33, azBozuk, eskiAyip, saticiIadeyeRazi, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s348, md42, S32, S33, azBozuk, bedelEksikligi, eskiAyip, galib, iadeHakki, muteber, nadir, saticiIadeyeRazi, yeniAyip] at *; revert h
  generalize v 160 = x160; generalize v 161 = x161; generalize v 162 = x162; generalize v 230 = x230; generalize v 231 = x231; generalize v 233 = x233; generalize v 235 = x235; generalize v 236 = x236; generalize v 241 = x241
  revert x160 x161 x162 x230 x231 x233 x235 x236 x241; decide

-- SÇ53 çözümü: S54 olayı imkânsız kılar.
theorem scat53_kopru :
    ¬ Saglanabilir (hepsi [S32, S33, S54, azBozuk, eskiAyip, saticiIadeyeRazi, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S32, S33, S54, azBozuk, eskiAyip, iadeHakki, muteber, nadir, saticiIadeyeRazi, yeniAyip] at *; revert h
  generalize v 161 = x161; generalize v 162 = x162; generalize v 230 = x230; generalize v 231 = x231; generalize v 233 = x233; generalize v 235 = x235; generalize v 241 = x241
  revert x161 x162 x230 x231 x233 x235 x241; decide

-- SÇ54. s348, md100, S28, S29 — olay: {ayipAciklandi, eskiAyip, saticiIadeyeRazi, yeniAyip}
theorem scat54 :
    ¬ Saglanabilir (hepsi [s348, md100, S28, S29, ayipAciklandi, eskiAyip, saticiIadeyeRazi, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s348, md100, S28, S29, ayipAciklandi, bedelEksikligi, eskiAyip, iadeHakki, kusurHakki, riza, saticiIadeyeRazi, yeniAyip] at *; revert h
  generalize v 35 = x35; generalize v 37 = x37; generalize v 230 = x230; generalize v 231 = x231; generalize v 233 = x233; generalize v 235 = x235; generalize v 236 = x236; generalize v 237 = x237
  revert x35 x37 x230 x231 x233 x235 x236 x237; decide

-- SÇ54 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat54_cozum :
    Saglanabilir (hepsi [s348k, md100, S28, S29, ayipAciklandi, eskiAyip, saticiIadeyeRazi, yeniAyip]) := ⟨model [35, 230, 231, 233, 237], by decide⟩

-- SÇ55. s348, md100, S28, S30 — olay: {beraatSarti, eskiAyip, saticiIadeyeRazi, yeniAyip}
theorem scat55 :
    ¬ Saglanabilir (hepsi [s348, md100, S28, S30, beraatSarti, eskiAyip, saticiIadeyeRazi, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s348, md100, S28, S30, bedelEksikligi, beraatSarti, eskiAyip, iadeHakki, kusurHakki, riza, saticiIadeyeRazi, yeniAyip] at *; revert h
  generalize v 35 = x35; generalize v 37 = x37; generalize v 230 = x230; generalize v 231 = x231; generalize v 233 = x233; generalize v 235 = x235; generalize v 236 = x236; generalize v 238 = x238
  revert x35 x37 x230 x231 x233 x235 x236 x238; decide

-- SÇ55 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat55_cozum :
    Saglanabilir (hepsi [s348k, md100, S28, S30, beraatSarti, eskiAyip, saticiIadeyeRazi, yeniAyip]) := ⟨model [35, 230, 231, 233, 238], by decide⟩

-- SÇ56. s348, md100, K9, S28 — olay: {bilgi, eskiAyip, saticiIadeyeRazi, tasarruf, yeniAyip}
theorem scat56 :
    ¬ Saglanabilir (hepsi [s348, md100, K9, S28, bilgi, eskiAyip, saticiIadeyeRazi, tasarruf, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s348, md100, K9, S28, bedelEksikligi, bilgi, eskiAyip, iadeHakki, kusurHakki, riza, saticiIadeyeRazi, tasarruf, yeniAyip] at *; revert h
  generalize v 33 = x33; generalize v 34 = x34; generalize v 35 = x35; generalize v 37 = x37; generalize v 230 = x230; generalize v 231 = x231; generalize v 233 = x233; generalize v 235 = x235; generalize v 236 = x236
  revert x33 x34 x35 x37 x230 x231 x233 x235 x236; decide

-- SÇ56 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat56_cozum :
    Saglanabilir (hepsi [s348k, md100, K9k, S28, bilgi, eskiAyip, saticiIadeyeRazi, tasarruf, yeniAyip]) := ⟨model [33, 34, 35, 230, 231, 233], by decide⟩

-- SÇ57. s348, md100, S28, S31 — olay: {eskiAyip, herAyibiylaKabul, saticiIadeyeRazi, yeniAyip}
theorem scat57 :
    ¬ Saglanabilir (hepsi [s348, md100, S28, S31, eskiAyip, herAyibiylaKabul, saticiIadeyeRazi, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s348, md100, S28, S31, bedelEksikligi, eskiAyip, herAyibiylaKabul, iadeHakki, kusurHakki, riza, saticiIadeyeRazi, yeniAyip] at *; revert h
  generalize v 35 = x35; generalize v 37 = x37; generalize v 230 = x230; generalize v 231 = x231; generalize v 233 = x233; generalize v 235 = x235; generalize v 236 = x236; generalize v 239 = x239
  revert x35 x37 x230 x231 x233 x235 x236 x239; decide

-- SÇ57 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat57_cozum :
    Saglanabilir (hepsi [s348k, md100, S28, S31, eskiAyip, herAyibiylaKabul, saticiIadeyeRazi, yeniAyip]) := ⟨model [35, 230, 231, 233, 239], by decide⟩

-- SÇ58. s357, s359 — olay: {gabn, gabnBilgisi, tagrir, tasarruf}
theorem scat58 :
    ¬ Saglanabilir (hepsi [s357, s359, gabn, gabnBilgisi, tagrir, tasarruf]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s357, s359, gabn, gabnBilgisi, gabnHakki, tagrir, tasarruf] at *; revert h
  generalize v 34 = x34; generalize v 250 = x250; generalize v 251 = x251; generalize v 252 = x252; generalize v 254 = x254
  revert x34 x250 x251 x252 x254; decide

-- s357: kısıtlı biçimi gerektirir.
theorem s357_satista_kisitlanir :
    Sonuc [s357] s357k := by
  intro v h
  have h0 := h s357 (by simp)
  simp only [hepsi, tepe, degil, deger, s357, s357k, gabn, gabnBilgisi, gabnHakki, tagrir, tasarruf] at *; revert h0
  generalize v 34 = x34; generalize v 250 = x250; generalize v 251 = x251; generalize v 252 = x252; generalize v 254 = x254
  revert x34 x250 x251 x252 x254; decide

-- SÇ58 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat58_cozum :
    Saglanabilir (hepsi [s357k, s359, gabn, gabnBilgisi, tagrir, tasarruf]) := ⟨model [34, 250, 251, 252], by decide⟩

-- SÇ59. s365, s378, S46 — olay: {fuzuliSatis, icazet, rehinliSatis}
theorem scat59 :
    ¬ Saglanabilir (hepsi [s365, s378, S46, fuzuliSatis, icazet, rehinliSatis]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s365, s378, S46, baskaHak, fuzuliSatis, icazet, malik, rehinliSatis, satisNafiz, yetkili] at *; revert h
  generalize v 119 = x119; generalize v 265 = x265; generalize v 266 = x266; generalize v 267 = x267; generalize v 268 = x268; generalize v 269 = x269; generalize v 270 = x270
  revert x119 x265 x266 x267 x268 x269 x270; decide

-- s365: kısıtlı biçimi gerektirir.
theorem s365_satista_kisitlanir :
    Sonuc [s365] s365k := by
  intro v h
  have h0 := h s365 (by simp)
  simp only [hepsi, tepe, degil, deger, s365, s365k, baskaHak, icazet, malik, satisNafiz, yetkili] at *; revert h0
  generalize v 119 = x119; generalize v 265 = x265; generalize v 266 = x266; generalize v 267 = x267; generalize v 270 = x270
  revert x119 x265 x266 x267 x270; decide

-- SÇ59 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat59_cozum :
    Saglanabilir (hepsi [s365k, s378, S46, fuzuliSatis, icazet, rehinliSatis]) := ⟨model [265, 266, 267, 268, 269, 270], by decide⟩

-- SÇ60. s368, s378 — olay: {fuzuliSatis, icazet}
theorem scat60 :
    ¬ Saglanabilir (hepsi [s368, s378, fuzuliSatis, icazet]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s368, s378, fuzuliSatis, icazet, rehinliSatis, satisKurulur, satisNafiz] at *; revert h
  generalize v 208 = x208; generalize v 265 = x265; generalize v 268 = x268; generalize v 269 = x269; generalize v 270 = x270
  revert x208 x265 x268 x269 x270; decide

-- s368: kısıtlı biçimi gerektirir.
theorem s368_satista_kisitlanir :
    Sonuc [s368] s368k := by
  intro v h
  have h0 := h s368 (by simp)
  simp only [hepsi, tepe, degil, deger, s368, s368k, fuzuliSatis, icazet, rehinliSatis, satisKurulur, satisNafiz] at *; revert h0
  generalize v 208 = x208; generalize v 265 = x265; generalize v 268 = x268; generalize v 269 = x269; generalize v 270 = x270
  revert x208 x265 x268 x269 x270; decide

-- SÇ60 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat60_cozum :
    Saglanabilir (hepsi [s368k, s378, fuzuliSatis, icazet]) := ⟨model [208, 265, 268, 269, 270], by decide⟩

-- SÇ61. s370, s371 — olay: {batilSatis, fasidSatis, izinleAlindi, telef, ¬kusur}
theorem scat61 :
    ¬ Saglanabilir (hepsi [s370, s371, batilSatis, fasidSatis, izinleAlindi, telef, ∼kusur]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s370, s371, batilSatis, fasidSatis, izinleAlindi, kusur, tazmin, telef] at *; revert h
  generalize v 118 = x118; generalize v 255 = x255; generalize v 256 = x256; generalize v 259 = x259; generalize v 260 = x260; generalize v 261 = x261
  revert x118 x255 x256 x259 x260 x261; decide

-- SÇ61 çözümü: S51 olayı imkânsız kılar.
theorem scat61_kopru :
    ¬ Saglanabilir (hepsi [S51, batilSatis, fasidSatis, izinleAlindi, telef, ∼kusur]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S51, batilSatis, fasidSatis, gormekIcinAlindi, izinleAlindi, kusur, sevmIleAlindi, telef] at *; revert h
  generalize v 255 = x255; generalize v 256 = x256; generalize v 257 = x257; generalize v 258 = x258; generalize v 259 = x259; generalize v 260 = x260; generalize v 261 = x261
  revert x255 x256 x257 x258 x259 x260 x261; decide

-- SÇ62. s370, md33 — olay: {batilSatis, gayrinMali, izinleAlindi, mubasir, telef, zaruret, ¬kusur}
theorem scat62 :
    ¬ Saglanabilir (hepsi [s370, md33, batilSatis, gayrinMali, izinleAlindi, mubasir, telef, zaruret, ∼kusur]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s370, md33, batilSatis, gayrinMali, izinleAlindi, kusur, mubasir, tazmin, telef, zaruret] at *; revert h
  generalize v 6 = x6; generalize v 118 = x118; generalize v 126 = x126; generalize v 131 = x131; generalize v 255 = x255; generalize v 256 = x256; generalize v 260 = x260; generalize v 261 = x261
  revert x6 x118 x126 x131 x255 x256 x260 x261; decide

-- SÇ62 çözümü: S39 olayı imkânsız kılar.
theorem scat62_kopru :
    ¬ Saglanabilir (hepsi [S39, batilSatis, gayrinMali, izinleAlindi, mubasir, telef, zaruret, ∼kusur]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S39, batilSatis, gayrinMali, izinleAlindi, kusur, mubasir, telef, zaruret] at *; revert h
  generalize v 6 = x6; generalize v 126 = x126; generalize v 131 = x131; generalize v 255 = x255; generalize v 256 = x256; generalize v 260 = x260; generalize v 261 = x261
  revert x6 x126 x131 x255 x256 x260 x261; decide

-- SÇ63. s370, md92 — olay: {batilSatis, izinleAlindi, mubasir, telef, ¬kusur}
theorem scat63 :
    ¬ Saglanabilir (hepsi [s370, md92, batilSatis, izinleAlindi, mubasir, telef, ∼kusur]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s370, md92, batilSatis, izinleAlindi, kusur, mubasir, tazmin, telef] at *; revert h
  generalize v 118 = x118; generalize v 126 = x126; generalize v 255 = x255; generalize v 256 = x256; generalize v 260 = x260; generalize v 261 = x261
  revert x118 x126 x255 x256 x260 x261; decide

-- SÇ63 çözümü: S39 olayı imkânsız kılar.
theorem scat63_kopru :
    ¬ Saglanabilir (hepsi [S39, batilSatis, izinleAlindi, mubasir, telef, ∼kusur]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, S39, batilSatis, izinleAlindi, kusur, mubasir, telef] at *; revert h
  generalize v 126 = x126; generalize v 255 = x255; generalize v 256 = x256; generalize v 260 = x260; generalize v 261 = x261
  revert x126 x255 x256 x260 x261; decide

-- SÇ64. s371, md90 — olay: {digerMubasir, fasidSatis, izinleAlindi, mutesebbib, telef}
theorem scat64 :
    ¬ Saglanabilir (hepsi [s371, md90, digerMubasir, fasidSatis, izinleAlindi, mutesebbib, telef]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s371, md90, digerMubasir, fasidSatis, izinleAlindi, mutesebbib, tazmin, telef] at *; revert h
  generalize v 118 = x118; generalize v 127 = x127; generalize v 129 = x129; generalize v 255 = x255; generalize v 259 = x259; generalize v 261 = x261
  revert x118 x127 x129 x255 x259 x261; decide

-- SÇ64 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat64_cozum :
    Saglanabilir (hepsi [s371, md90k, digerMubasir, fasidSatis, izinleAlindi, mutesebbib, telef]) := ⟨model [118, 127, 129, 255, 259, 261, 262], by decide⟩

-- SÇ65. s371, md91r, K37, S38 — olay: {fasidSatis, hayvanKendiliginden, izinleAlindi, telef}
theorem scat65 :
    ¬ Saglanabilir (hepsi [s371, md91r, K37, S38, fasidSatis, hayvanKendiliginden, izinleAlindi, telef]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s371, md91r, K37, S38, fasidSatis, hayvanKendiliginden, izinleAlindi, mubah, mubasir, tazmin, telef] at *; revert h
  generalize v 8 = x8; generalize v 118 = x118; generalize v 126 = x126; generalize v 130 = x130; generalize v 255 = x255; generalize v 259 = x259; generalize v 261 = x261
  revert x8 x118 x126 x130 x255 x259 x261; decide

-- md91: kısıtlı biçimi gerektirir.
theorem md91_satista_kisitlanir :
    Sonuc [md91r] md91k := by
  intro v h
  have h0 := h md91r (by simp)
  simp only [hepsi, tepe, degil, deger, md91r, md91k, bedelKarsiligi, mubah, mubasir, tazmin] at *; revert h0
  generalize v 8 = x8; generalize v 118 = x118; generalize v 126 = x126; generalize v 262 = x262
  revert x8 x118 x126 x262; decide

-- SÇ65 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat65_cozum :
    Saglanabilir (hepsi [s371, md91k, K37, S38, fasidSatis, hayvanKendiliginden, izinleAlindi, telef]) := ⟨model [8, 118, 130, 255, 259, 261, 262], by decide⟩

-- SÇ66. s371, md91r, S38, S39 — olay: {fasidSatis, izinleAlindi, telef, ¬kusur}
theorem scat66 :
    ¬ Saglanabilir (hepsi [s371, md91r, S38, S39, fasidSatis, izinleAlindi, telef, ∼kusur]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s371, md91r, S38, S39, fasidSatis, izinleAlindi, kusur, mubah, mubasir, tazmin, telef] at *; revert h
  generalize v 8 = x8; generalize v 118 = x118; generalize v 126 = x126; generalize v 255 = x255; generalize v 256 = x256; generalize v 259 = x259; generalize v 261 = x261
  revert x8 x118 x126 x255 x256 x259 x261; decide

-- SÇ66 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat66_cozum :
    Saglanabilir (hepsi [s371, md91k, S38, S39, fasidSatis, izinleAlindi, telef, ∼kusur]) := ⟨model [8, 118, 255, 259, 261, 262], by decide⟩

-- SÇ67. s371, md93 — olay: {fasidSatis, izinleAlindi, mutesebbib, telef, ¬kast}
theorem scat67 :
    ¬ Saglanabilir (hepsi [s371, md93, fasidSatis, izinleAlindi, mutesebbib, telef, ∼kast]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s371, md93, fasidSatis, izinleAlindi, kast, mutesebbib, tazmin, telef] at *; revert h
  generalize v 118 = x118; generalize v 127 = x127; generalize v 128 = x128; generalize v 255 = x255; generalize v 259 = x259; generalize v 261 = x261
  revert x118 x127 x128 x255 x259 x261; decide

-- SÇ67 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat67_cozum :
    Saglanabilir (hepsi [s371, md93k, fasidSatis, izinleAlindi, mutesebbib, telef, ∼kast]) := ⟨model [118, 127, 255, 259, 261, 262], by decide⟩

-- SÇ68. s371, md94 — olay: {fasidSatis, hayvanKendiliginden, izinleAlindi, telef}
theorem scat68 :
    ¬ Saglanabilir (hepsi [s371, md94, fasidSatis, hayvanKendiliginden, izinleAlindi, telef]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s371, md94, fasidSatis, hayvanKendiliginden, izinleAlindi, tazmin, telef] at *; revert h
  generalize v 118 = x118; generalize v 130 = x130; generalize v 255 = x255; generalize v 259 = x259; generalize v 261 = x261
  revert x118 x130 x255 x259 x261; decide

-- SÇ68 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat68_cozum :
    Saglanabilir (hepsi [s371, md94k, fasidSatis, hayvanKendiliginden, izinleAlindi, telef]) := ⟨model [118, 130, 255, 259, 261, 262], by decide⟩

-- SÇ69. s236, s293, md87 — olay: {akit, ¬teslim}
theorem scat69 :
    ¬ Saglanabilir (hepsi [s236, s293, md87, akit, ∼teslim]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s236, s293, md87, akit, hasarAlici, teslim, yararAlici] at *; revert h
  generalize v 29 = x29; generalize v 30 = x30; generalize v 31 = x31; generalize v 32 = x32
  revert x29 x30 x31 x32; decide

-- md87: kısıtlı biçimi gerektirir.
theorem md87_satista_kisitlanir :
    Sonuc [md87] md87k := by
  intro v h
  have h0 := h md87 (by simp)
  simp only [hepsi, tepe, degil, deger, md87, md87k, hasarAlici, teslim, yararAlici] at *; revert h0
  generalize v 30 = x30; generalize v 31 = x31; generalize v 32 = x32
  revert x30 x31 x32; decide

-- SÇ69 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat69_cozum :
    Saglanabilir (hepsi [s236, s293, md87k, akit, ∼teslim]) := ⟨model [29, 31], by decide⟩

-- SÇ70. s236, s293, md88 — olay: {akit, ¬teslim}
theorem scat70 :
    ¬ Saglanabilir (hepsi [s236, s293, md88, akit, ∼teslim]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s236, s293, md88, akit, hasarAlici, teslim, yararAlici] at *; revert h
  generalize v 29 = x29; generalize v 30 = x30; generalize v 31 = x31; generalize v 32 = x32
  revert x29 x30 x31 x32; decide

-- md88: kısıtlı biçimi gerektirir.
theorem md88_satista_kisitlanir :
    Sonuc [md88] md88k := by
  intro v h
  have h0 := h md88 (by simp)
  simp only [hepsi, tepe, degil, deger, md88, md88k, hasarAlici, teslim, yararAlici] at *; revert h0
  generalize v 30 = x30; generalize v 31 = x31; generalize v 32 = x32
  revert x30 x31 x32; decide

-- SÇ70 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat70_cozum :
    Saglanabilir (hepsi [s236, s293, md88k, akit, ∼teslim]) := ⟨model [29, 31], by decide⟩

-- SÇ71. s293, s369, md87 — olay: {akit, ¬teslim}
theorem scat71 :
    ¬ Saglanabilir (hepsi [s293, s369, md87, akit, ∼teslim]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s293, s369, md87, akit, hasarAlici, teslim, yararAlici] at *; revert h
  generalize v 29 = x29; generalize v 30 = x30; generalize v 31 = x31; generalize v 32 = x32
  revert x29 x30 x31 x32; decide

-- SÇ71 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat71_cozum :
    Saglanabilir (hepsi [s293, s369, md87k, akit, ∼teslim]) := ⟨model [29, 31], by decide⟩

-- SÇ72. s293, s369, md88 — olay: {akit, ¬teslim}
theorem scat72 :
    ¬ Saglanabilir (hepsi [s293, s369, md88, akit, ∼teslim]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s293, s369, md88, akit, hasarAlici, teslim, yararAlici] at *; revert h
  generalize v 29 = x29; generalize v 30 = x30; generalize v 31 = x31; generalize v 32 = x32
  revert x29 x30 x31 x32; decide

-- SÇ72 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat72_cozum :
    Saglanabilir (hepsi [s293, s369, md88k, akit, ∼teslim]) := ⟨model [29, 31], by decide⟩

-- SÇ73. s337, s345, md100, S28 — olay: {eskiAyip, yeniAyip}
theorem scat73 :
    ¬ Saglanabilir (hepsi [s337, s345, md100, S28, eskiAyip, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s337, s345, md100, S28, bedelEksikligi, eskiAyip, iadeHakki, kusurHakki, riza, yeniAyip] at *; revert h
  generalize v 35 = x35; generalize v 37 = x37; generalize v 230 = x230; generalize v 231 = x231; generalize v 235 = x235; generalize v 236 = x236
  revert x35 x37 x230 x231 x235 x236; decide

-- s337: kısıtlı biçimi gerektirir.
theorem s337_satista_kisitlanir :
    Sonuc [s337] s337k := by
  intro v h
  have h0 := h s337 (by simp)
  simp only [hepsi, tepe, degil, deger, s337, s337k, bedelEksikligi, eskiAyip, fazlalik, iadeHakki, riza, yeniAyip] at *; revert h0
  generalize v 35 = x35; generalize v 230 = x230; generalize v 231 = x231; generalize v 234 = x234; generalize v 235 = x235; generalize v 236 = x236
  revert x35 x230 x231 x234 x235 x236; decide

-- SÇ73 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat73_cozum :
    Saglanabilir (hepsi [s337k, s345k, md100, S28, eskiAyip, yeniAyip]) := ⟨model [35, 230, 231], by decide⟩

-- SÇ74. s344, s349, s350, S28 — olay: {bilgi, eskiAyip, fazlalik, tasarruf}
theorem scat74 :
    ¬ Saglanabilir (hepsi [s344, s349, s350, S28, bilgi, eskiAyip, fazlalik, tasarruf]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s344, s349, s350, S28, bedelEksikligi, bilgi, eskiAyip, fazlalik, iadeHakki, iadeMumkun, kusurHakki, saticiIadeyeRazi, tasarruf] at *; revert h
  generalize v 33 = x33; generalize v 34 = x34; generalize v 36 = x36; generalize v 37 = x37; generalize v 230 = x230; generalize v 233 = x233; generalize v 234 = x234; generalize v 235 = x235; generalize v 236 = x236
  revert x33 x34 x36 x37 x230 x233 x234 x235 x236; decide

-- SÇ74 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat74_cozum :
    Saglanabilir (hepsi [s344k, s349, s350, S28, bilgi, eskiAyip, fazlalik, tasarruf]) := ⟨model [33, 34, 37, 230, 234, 235, 236], by decide⟩

-- SÇ75. s348, s349, s350 — olay: {eskiAyip, fazlalik, saticiIadeyeRazi, yeniAyip}
theorem scat75 :
    ¬ Saglanabilir (hepsi [s348, s349, s350, eskiAyip, fazlalik, saticiIadeyeRazi, yeniAyip]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, s348, s349, s350, bedelEksikligi, eskiAyip, fazlalik, iadeHakki, iadeMumkun, saticiIadeyeRazi, yeniAyip] at *; revert h
  generalize v 36 = x36; generalize v 230 = x230; generalize v 231 = x231; generalize v 233 = x233; generalize v 234 = x234; generalize v 235 = x235; generalize v 236 = x236
  revert x36 x230 x231 x233 x234 x235 x236; decide

-- SÇ75 çözümü: kısıtlanmış biçimlerle olay tutarlıdır.
theorem scat75_cozum :
    Saglanabilir (hepsi [s348k, s349, s350, eskiAyip, fazlalik, saticiIadeyeRazi, yeniAyip]) := ⟨model [35, 230, 231, 233, 234, 236], by decide⟩

theorem K9_satista_kisitlanir :
    Sonuc [K9] K9k := by
  intro v h
  have h0 := h K9 (by simp)
  simp only [hepsi, tepe, degil, deger, K9, K9k, bilgi, iadeMumkun, riza, tasarruf] at *; revert h0
  generalize v 33 = x33; generalize v 34 = x34; generalize v 35 = x35; generalize v 36 = x36
  revert x33 x34 x35 x36; decide

/-! ## 8. Birleşik külliyat -/

-- 99 kaide, Satış Kitabı'nın maddeleri ve bütün köprüler birlikte tutarlıdır.
theorem birlesik_tutarli :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri)) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

-- Her maddenin her kuralı, bütün birleşik külliyatla çelişmeden uygulanabilir.
theorem uyg_s168_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [sozluIcap])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 200, 206, 208, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s169_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [gecmisKip])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 200, 206, 208, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s170_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(genisKip ⋀ simdikiKast)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 202, 206, 207, 208, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s170_1 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(genisKip ⋀ ∼simdikiKast)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s171_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [vaatKipi])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 203, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s172_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(emirKipi ⋀ ∼simdikiKast)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 204, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s172_1 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(emirKipi ⋀ simdikiKast)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 202, 204, 206, 207, 208, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s173_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(mukatebe ⋀ icapIcerik)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 200, 205, 206, 208, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s174_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(dilsizIsaret ⋀ icapIcerik)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 200, 205, 206, 208, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s175_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [fiiliTeati])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 207, 208, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s186_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [sartAkitGeregi])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 210, 214, 215, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s187_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [sartPekistirir])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 211, 214, 215, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s188_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [sartMutearef])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 212, 214, 215, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s189_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [sartYararsiz])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 213, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s230_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [orfenKapsamda])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 163, 164, 165, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 216, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s231_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [parcaHukmunde])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s232_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [surekliEklenti])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s233_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(((∼orfenKapsamda ⋀ ∼parcaHukmunde) ⋀ ∼surekliEklenti) ⋀ ∼anildi)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 171, 172, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 221, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s234_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(tabi ⋀ satisaDahil)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s236_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(akit ⋀ ∼teslim)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 29, 31, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s251_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [((mutlak ⋀ ∼tasrih) ⋀ ∼orf)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 26, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 275, 278], by decide⟩

theorem uyg_s251_1 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(((mutlak ⋀ ∼tasrih) ⋀ orf) ⋀ orfVadeli)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 21, 26, 27, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 159, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 223, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 275, 276, 278], by decide⟩

theorem uyg_s281_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [teslimBedelsiz])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 24, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 225, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s285_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(mutlak ⋀ ∼tasrih)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 26, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 275, 278], by decide⟩

theorem uyg_s293_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(akit ⋀ ∼teslim)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 29, 31, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s294_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(akit ⋀ teslim)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 29, 30, 31, 32, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s298_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(sevmIleAlindi ⋀ telef)])) := ⟨model [0, 3, 4, 5, 6, 8, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 255, 256, 258, 261, 262, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s299_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [((gormekIcinAlindi ⋀ telef) ⋀ ∼kusur)])) := ⟨model [0, 3, 4, 5, 6, 8, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 117, 120, 121, 122, 123, 124, 127, 128, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 255, 257, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s310k_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [((vasifSoylendi ⋀ vasifYok) ⋀ ∼tasarruf)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 246, 247, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s312_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(vasifSoylendi ⋀ tasarruf)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 34, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 248, 249, 250, 251, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s320k_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [((gormedenAldi ⋀ ∼tasarruf) ⋀ ∼(onceGordu ⋀ ∼degisimSabit))])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 248, 249, 250, 251, 252, 253, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s332_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [((gormedenAldi ⋀ onceGordu) ⋀ ∼degisimSabit)])) := ⟨model [0, 2, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 248, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s335_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(gormedenAldi ⋀ tasarruf)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 34, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 248, 249, 250, 251, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s336_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(mutlak ⋀ ∼tasrih)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 26, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 275, 278], by decide⟩

theorem uyg_s337k_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(((eskiAyip ⋀ ∼riza) ⋀ ∼yeniAyip) ⋀ ∼fazlalik)])) := ⟨model [0, 3, 4, 5, 6, 10, 12, 16, 20, 25, 27, 28, 30, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 177, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 230, 235, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s337k_1 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [iadeHakki])) := ⟨model [0, 3, 4, 5, 6, 10, 12, 16, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 177, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 235, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s341_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [ayipAciklandi])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 35, 36, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 177, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 230, 237, 238, 239, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s342_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [beraatSarti])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 35, 36, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 177, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 230, 237, 238, 239, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s343_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [herAyibiylaKabul])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 35, 36, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 177, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 230, 237, 238, 239, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s344k_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(((eskiAyip ⋀ bilgi) ⋀ tasarruf) ⋀ iadeMumkun)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 34, 35, 36, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 177, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 230, 237, 238, 239, 240, 245, 248, 249, 250, 251, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s345k_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(((((eskiAyip ⋀ yeniAyip) ⋀ ∼riza) ⋀ ∼yeniAyipKalkti) ⋀ ∼saticiIadeyeRazi) ⋀ ∼fazlalik)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 230, 231, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s347k_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(((eskiAyip ⋀ yeniAyipKalkti) ⋀ ∼riza) ⋀ ∼fazlalik)])) := ⟨model [0, 3, 4, 5, 6, 10, 12, 16, 20, 22, 23, 25, 27, 28, 30, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 177, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 226, 230, 231, 232, 235, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s348k_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [((((eskiAyip ⋀ yeniAyip) ⋀ saticiIadeyeRazi) ⋀ ∼riza) ⋀ ∼fazlalik)])) := ⟨model [0, 3, 4, 5, 6, 10, 12, 16, 20, 22, 23, 25, 27, 28, 30, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 177, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 226, 230, 231, 232, 233, 235, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s349_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [fazlalik])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 234, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s350_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(eskiAyip ⋀ ∼iadeMumkun)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 230, 231, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s350_1 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(∼iadeMumkun ⋀ saticiIadeyeRazi)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 22, 23, 25, 27, 28, 30, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 226, 233, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s354_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [azBozuk])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 159, 161, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 223, 224, 236, 240, 241, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 275, 278], by decide⟩

theorem uyg_s356_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(gabn ⋀ ∼tagrir)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 252, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s357k_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [((gabn ⋀ tagrir) ⋀ ∼(gabnBilgisi ⋀ tasarruf))])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s359_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(((gabn ⋀ tagrir) ⋀ gabnBilgisi) ⋀ tasarruf)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 34, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 248, 249, 250, 251, 252, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s365k_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(satisNafiz ⋀ ∼icazet)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 277, 278], by decide⟩

theorem uyg_s368k_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(fuzuliSatis ⋀ ∼icazet)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 117, 120, 121, 122, 123, 124, 127, 128, 131, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 208, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 260, 261, 268, 277, 278], by decide⟩

theorem uyg_s368k_1 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(rehinliSatis ⋀ ∼icazet)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 167, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 208, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 266, 267, 269, 277, 278], by decide⟩

theorem uyg_s369_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [akit])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 29, 31, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s370_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(((batilSatis ⋀ izinleAlindi) ⋀ telef) ⋀ ∼kusur)])) := ⟨model [0, 3, 4, 5, 6, 8, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 117, 120, 121, 122, 123, 124, 127, 128, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 255, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s371_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [((fasidSatis ⋀ izinleAlindi) ⋀ telef)])) := ⟨model [0, 3, 4, 5, 6, 8, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 255, 256, 259, 261, 262, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s378_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(fuzuliSatis ⋀ icazet)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uyg_s389_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(istisna ⋀ yayginKullanim)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 275, 276, 278], by decide⟩

theorem uyg_s392_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(istisna ⋀ tarifeUygun)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 275, 276, 277], by decide⟩

theorem uyg_s392_1 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(istisna ⋀ ∼tarifeUygun)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 275, 276, 278], by decide⟩

-- Kaidelerin kuralları da Satış Kitabı eklendikten sonra uygulanabilir kalır.
theorem uygK_md2_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [maksat])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md3_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [lafizFarkli])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md4_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(yakin ⋀ sek)])) := ⟨model [0, 1, 2, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md5_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(yakin ⋀ ∼degisimSabit)])) := ⟨model [0, 2, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md6r_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(kadim ⋀ ∼kadimZararli)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 42, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md7_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(kadim ⋀ kadimZararli)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md8_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [∼borcSabit])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md9_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [∼arizSabit])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md10_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(yakin ⋀ ∼degisimSabit)])) := ⟨model [0, 2, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md11_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(hadis ⋀ ∼uzakZamanSabit)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 50, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md12r_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [((hakikiMumkun ⋀ ∼orfMecaz) ⋀ ∼lafizFarkli)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 39, 40, 41, 43, 44, 47, 48, 49, 51, 52, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md13_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [tasrih])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md14_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [nas])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md15_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [kiyasaAykiri])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md16_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(ictihadlaHukum ⋀ yeniIctihad)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 101, 102, 103, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md17_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [mesakkat])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md18_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [mesakkat])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md19_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [mukabele])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md20r_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(zarar ⋀ defMumkun)])) := ⟨model [0, 3, 4, 5, 6, 10, 11, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 152, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md21r_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [((zaruret ⋀ aslenMemnu) ⋀ ∼miktariAsar)])) := ⟨model [0, 3, 4, 5, 6, 7, 8, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md22_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [((zaruret ⋀ aslenMemnu) ⋀ miktariAsar)])) := ⟨model [0, 3, 4, 5, 6, 7, 9, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md23_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(aslenMemnu ⋀ ∼zaruret)])) := ⟨model [0, 3, 4, 5, 7, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 131, 133, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md24_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [maniZail])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 22, 23, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 226, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md25_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [misil])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md26_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [((zarar ⋀ amm) ⋀ has)])) := ⟨model [0, 3, 4, 5, 6, 10, 12, 14, 15, 16, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md27_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(zarar ⋀ ehaf)])) := ⟨model [0, 3, 4, 5, 6, 10, 12, 14, 16, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md28_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(tearuz ⋀ ehaf)])) := ⟨model [0, 3, 4, 5, 6, 10, 12, 14, 16, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 149, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md29_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(tearuz ⋀ ehaf)])) := ⟨model [0, 3, 4, 5, 6, 10, 12, 14, 16, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 149, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md30_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [defMenfaatTearuz])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md31_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(zarar ⋀ defMumkun)])) := ⟨model [0, 3, 4, 5, 6, 10, 11, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 152, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md32_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [hacet])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md33_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [((zaruret ⋀ gayrinMali) ⋀ mubasir)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 131, 133, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md34_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [almakMemnu])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md35_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [∼mubah])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md36r_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [((orf ⋀ ∼tasrih) ⋀ (muttarid ⋁ galib))])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 21, 26, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 236, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 275, 276, 278], by decide⟩

theorem uygK_md37r_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(yayginKullanim ⋀ ∼tasrih)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 21, 26, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 236, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md38_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [adetenImkansiz])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md40_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [orfMecaz])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 56, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md41_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [orfeGore])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 21, 26, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 236, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 275, 276, 278], by decide⟩

theorem uygK_md42_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [galib])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md42_1 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [nadir])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 159, 161, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 223, 224, 236, 240, 241, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 275, 278], by decide⟩

theorem uygK_md43_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [orfenMaruf])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 163, 164, 165, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 216, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md44_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [tuccarMaruf])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 163, 164, 165, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 216, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md45r_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [((orf ⋀ ∼tasrih) ⋀ (muttarid ⋁ galib))])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 21, 26, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 236, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 275, 276, 278], by decide⟩

theorem uygK_md46_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(muktezi ⋀ mani)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 166, 167, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 266, 267, 277, 278], by decide⟩

theorem uygK_md47_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [tabi])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md48_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [tabi])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md49_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(malikX ⋀ zaruriyat)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 173, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md50_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [asilSakit])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md51_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [sakit])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 24, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 225, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md52_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [asilBatil])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md53_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [∼asilIfaMumkun])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md56_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [ibtidaenCaiz])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md57_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(teberru ⋀ ∼kabz)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md58_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(raiyyeTasarruf ⋀ ∼maslahat)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md59_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(hasVelayet ⋀ ammVelayet)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md60_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(hakikiMumkun ⋁ mecazMumkun)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md61r_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(∼hakikiMumkun ⋀ mecazMumkun)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md62_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(∼hakikiMumkun ⋀ ∼mecazMumkun)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 55, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md63_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(bolunmez ⋀ baziZikr)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 58, 59, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md64_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [((mutlak ⋀ ∼tasrih) ⋀ ∼orf)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 26, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 275, 278], by decide⟩

theorem uygK_md65_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [hazir])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md65_1 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [∼hazir])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 61, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md66_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [sualOnay])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md67_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [sukut])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md67_1 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(sukut ⋀ hacetYeri)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 66, 67, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md68_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(batin ⋀ zahirDelil)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md69_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [mukatebe])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md70_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [dilsizIsaret])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md71_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [tercumanKavli])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md72_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(zann ⋀ hataZahir)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 78, 80, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md73_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [ihtimalDelilli])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md74_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [vehim])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 80, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md75_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [burhan])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md76_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [davaci])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md76_1 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [munkir])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md77_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [zahireAykiri])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md77_1 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [asliKoruyor])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md78_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [beyyineIle])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md78_1 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(ikrarIle ⋀ ∼beyyineIle)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 95, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md79_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [ikrarIle])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md80_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [tenakuz])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md80_1 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(tenakuz ⋀ oncekiHukum)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 100, 101, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md82_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [sartSabit])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md83_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(sartliAkit ⋀ riayetMumkun)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 112, 113, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 213, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md84_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(vaad ⋀ talik)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 115, 116, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md85_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [hasarAlici])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 31, 32, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md87k_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(yararAlici ⋀ teslim)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 31, 32, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md88k_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [hasarAlici])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 31, 32, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md88k_1 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(yararAlici ⋀ teslim)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 31, 32, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md89_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [fail])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md89_1 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(emir ⋀ ∼icbar)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md90k_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [((mutesebbib ⋀ digerMubasir) ⋀ ∼bedelKarsiligi)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 117, 120, 121, 122, 123, 124, 127, 128, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md91k_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [((mubah ⋀ ∼mubasir) ⋀ ∼bedelKarsiligi)])) := ⟨model [0, 3, 4, 5, 6, 8, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 117, 120, 121, 122, 123, 124, 127, 128, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md92_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [mubasir])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md93k_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [((mutesebbib ⋀ ∼kast) ⋀ ∼bedelKarsiligi)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 117, 120, 121, 122, 123, 124, 127, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md94k_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(hayvanKendiliginden ⋀ ∼bedelKarsiligi)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 117, 120, 121, 122, 123, 124, 127, 128, 130, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md95_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(gayrinMali ⋀ emir)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 117, 120, 121, 122, 123, 124, 127, 128, 131, 133, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md96r_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [((gayrinMali ⋀ ∼izin) ⋀ ∼zaruret)])) := ⟨model [0, 3, 4, 5, 7, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 131, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md97_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [(gayrinMali ⋀ ∼mesruSebep)])) := ⟨model [0, 3, 4, 5, 7, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 131, 133, 135, 136, 137, 138, 140, 141, 142, 143, 144, 146, 148, 150, 151, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md98_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [sebepDegisti])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md99_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [istical])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 33, 36, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 236, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

theorem uygK_md100_0 :
    Saglanabilir (hepsi (birlesik ++ maddeler ++ koprulerSon ++ satisKopruleri ++ [riza])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 20, 25, 27, 28, 30, 35, 36, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 112, 114, 118, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 168, 169, 170, 172, 174, 175, 176, 177, 181, 182, 183, 184, 185, 186, 187, 188, 189, 201, 214, 217, 218, 220, 222, 224, 230, 237, 238, 239, 240, 245, 249, 250, 251, 252, 254, 256, 260, 261, 265, 266, 267, 268, 269, 270, 277, 278], by decide⟩

end Mecelle.Satis
