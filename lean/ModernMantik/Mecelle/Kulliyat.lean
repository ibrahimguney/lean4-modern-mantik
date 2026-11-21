/-
  Lean 4 ile Modern Mantık — Uygulama
  Mecelle'nin 99 külli kaidesi: bütün külliyat

  Bu dosya kulliyat/lean_uret.py ile üretilmiştir; elle değiştirmeyin.
  Tanımlar kulliyat/spec.py'dedir. İlişkiler önce Python'da aranır,
  sonra burada Lean çekirdeğine kanıtlatılır.

  Atom numaraları Pilot (0-21) ve Uzanti (22-37) ile aynıdır.
-/
import ModernMantik.Bolum10

namespace Mecelle.Kulliyat

open Bolum10 Bolum10.Formul

set_option linter.unusedSimpArgs false

/-! ## 1. Atom sözlüğü (tek bir olay için) -/

def yakin               : Formul := atom 0    -- önceki hâl (A) kesin olarak sabittir
def sek                 : Formul := atom 1    -- A'nın kalktığına dair yalnızca şek vardır
def hukumA              : Formul := atom 2    -- A'nın devam ettiğine hükmolunur
def degisimSabit        : Formul := atom 3    -- A'nın kalktığı delille sabittir
def mesakkat            : Formul := atom 4    -- fiilde meşakkat (darlık) vardır
def teysir              : Formul := atom 5    -- kolaylık (ruhsat, genişlik) tanınır
def zaruret             : Formul := atom 6    -- zaruret (ıztırar) hâli vardır
def aslenMemnu          : Formul := atom 7    -- fiil aslen yasaktır
def mubah               : Formul := atom 8    -- fiil bu olayda caizdir (mübahtır)
def miktariAsar         : Formul := atom 9    -- fiil zaruretin miktarını aşar
def zarar               : Formul := atom 10   -- giderilmesi istenen bir zarar Z vardır
def izale               : Formul := atom 11   -- Z'nin giderilmesine hükmolunur
def tedbirCaiz          : Formul := atom 12   -- Z'yi gidermek için önerilen T tedbiri caizdir
def misil               : Formul := atom 13   -- T'nin doğurduğu zarar Z'nin dengidir
def ehaf                : Formul := atom 14   -- T'nin doğurduğu zarar Z'den hafiftir
def amm                 : Formul := atom 15   -- Z genel (âmm) bir zarardır
def has                 : Formul := atom 16   -- T'nin doğurduğu zarar özel (hâs) bir zarardır
def mukabele            : Formul := atom 17   -- T, zarara zararla karşılık vermektir
def maksat              : Formul := atom 18   -- fiil M maksadıyla yapılmıştır
def hukumM              : Formul := atom 19   -- fiile M maksadına uygun hüküm bağlanır
def orf                 : Formul := atom 20   -- konuda bir örf ve âdet vardır
def orfeGore            : Formul := atom 21   -- hüküm örfe göre verilir
def maniZail            : Formul := atom 22   -- bir hükmü durduran engel kalkmıştır
def avdet               : Formul := atom 23   -- durmuş olan hüküm ya da hak yeniden işler
def sakit               : Formul := atom 24   -- hak düşmüştür (ıskat edilmiştir)
def tasrih              : Formul := atom 25   -- akitte konuya ilişkin açık bir söz vardır
def delaletGore         : Formul := atom 26   -- hüküm bir delâlete (dolaylı anlatıma) göre verilir
def mutlak              : Formul := atom 27   -- söz kayıtsız (mutlak) söylenmiştir
def mutlakGore          : Formul := atom 28   -- hüküm sözün kayıtsız anlamına göre verilir
def akit                : Formul := atom 29   -- satış akdi kurulmuştur
def teslim              : Formul := atom 30   -- satılan mal alıcıya teslim edilmiştir
def yararAlici          : Formul := atom 31   -- malın yararı (nimeti) ele alınan kişiye aittir
def hasarAlici          : Formul := atom 32   -- malın hasarı (külfeti) ele alınan kişiye aittir
def bilgi               : Formul := atom 33   -- alıcı eski ayıbı bilmektedir
def tasarruf            : Formul := atom 34   -- alıcı malda mülkiyet gereği tasarrufta bulunmuştur
def riza                : Formul := atom 35   -- kişi (ayıba, işleme) razı olmuştur
def iadeMumkun          : Formul := atom 36   -- malı geri vermek hâlâ mümkündür
def kusurHakki          : Formul := atom 37   -- alıcının ayıp için bir hakkı vardır
def lafizFarkli         : Formul := atom 38   -- akdin lafzı, amaçlanandan başka bir akdi gösterir
def manayaGore          : Formul := atom 39   -- akde amacına (anlamına) göre sonuç bağlanır
def lafzaGore           : Formul := atom 40   -- akde lafzına göre sonuç bağlanır
def kadim               : Formul := atom 41   -- mevcut durum eskiden beri vardır
def kadimBirakilir      : Formul := atom 42   -- eski durum olduğu gibi bırakılır
def kadimZararli        : Formul := atom 43   -- eski durumun kendisi bir zarardır
def beraat              : Formul := atom 44   -- kişinin borçlu olmadığına hükmolunur
def borcSabit           : Formul := atom 45   -- iddia edilen borç delille sabittir
def arizSabit           : Formul := atom 46   -- sonradan arız olan sıfat (ör. kâr) delille sabittir
def arizYok             : Formul := atom 47   -- arız sıfatın bulunmadığına hükmolunur
def hadis               : Formul := atom 48   -- sonradan meydana gelmiş bir olay söz konusudur
def uzakZamanSabit      : Formul := atom 49   -- olayın daha uzak bir zamana ait olduğu ispat edilmiştir
def yakinZaman          : Formul := atom 50   -- olay en yakın zamana bağlanır
def hakikiMumkun        : Formul := atom 51   -- sözün gerçek (hakiki) anlamı uygulanabilir
def hakikiyeGore        : Formul := atom 52   -- söz gerçek anlamıyla yorumlanır
def mecazMumkun         : Formul := atom 53   -- söze mecazi bir anlam verilebilir
def mecazaGore          : Formul := atom 54   -- söz mecazi anlamıyla yorumlanır
def ihmal               : Formul := atom 55   -- söz boş sayılır (ihmal edilir)
def orfMecaz            : Formul := atom 56   -- âdet, sözün gerçek anlamından başka bir anlamı gösterir
def bolunmez            : Formul := atom 57   -- söz konusu şey bölünmez (mütecezzi değildir)
def baziZikr            : Formul := atom 58   -- o şeyin bir kısmı anılmıştır
def kulluZikr           : Formul := atom 59   -- tamamı anılmış sayılır
def hazir               : Formul := atom 60   -- nitelenen şey hazırdadır (mecliste mevcuttur)
def vasifMuteber        : Formul := atom 61   -- söylenen niteliğe itibar edilir
def sualOnay            : Formul := atom 62   -- soru, onaylanarak cevaplanmıştır
def sorudakiSoylenmis   : Formul := atom 63   -- soruda söylenen, cevaplayanca söylenmiş sayılır
def sukut               : Formul := atom 64   -- kişi susmuştur
def sozIsnad            : Formul := atom 65   -- kişiye bir söz isnat edilir
def hacetYeri           : Formul := atom 66   -- konuşmanın gerektiği bir yerdir
def beyan               : Formul := atom 67   -- susma beyan (ikrar) sayılır
def batin               : Formul := atom 68   -- konu, iç yüzü bilinemeyen gizli bir husustur
def zahirDelil          : Formul := atom 69   -- konuda görünür bir delil vardır
def delileGore          : Formul := atom 70   -- hüküm görünür delile göre verilir
def mukatebe            : Formul := atom 71   -- irade yazışmayla bildirilmiştir
def muhatabeGibi        : Formul := atom 72   -- yazışma yüz yüze konuşma gibi hüküm doğurur
def dilsizIsaret        : Formul := atom 73   -- irade dilsizin bilinen işaretiyle bildirilmiştir
def dilleBeyanGibi      : Formul := atom 74   -- işaret dille beyan gibi hüküm doğurur
def tercumanKavli       : Formul := atom 75   -- söz bir tercüman aracılığıyla aktarılmıştır
def kabul               : Formul := atom 76   -- aktarılan söz kabul olunur
def zann                : Formul := atom 77   -- ileri sürülen şey bir zanna dayanır
def hataZahir           : Formul := atom 78   -- o zannın hatası açıkça görünür
def itibar              : Formul := atom 79   -- ileri sürülen şeye itibar edilir
def vehim               : Formul := atom 80   -- ileri sürülen şey bir vehimdir
def ihtimalDelilli      : Formul := atom 81   -- bir delile dayanan karşı ihtimal vardır
def hucce               : Formul := atom 82   -- ileri sürülen beyan hüccet (delil) sayılır
def burhan              : Formul := atom 83   -- şey delille (burhanla) sabittir
def iyanenGibi          : Formul := atom 84   -- şey gözle görülmüş gibi sabit sayılır
def davaci              : Formul := atom 85   -- taraf davacıdır (müddei)
def munkir              : Formul := atom 86   -- taraf inkâr edendir (münkir)
def beyyineOna          : Formul := atom 87   -- delil getirmek bu tarafa düşer
def yeminOna            : Formul := atom 88   -- yemin bu tarafa düşer
def zahireAykiri        : Formul := atom 89   -- taraf görünen duruma aykırı bir şey iddia eder
def asliKoruyor         : Formul := atom 90   -- taraf asıl durumun sürdüğünü savunur
def degisimIddia        : Formul := atom 91   -- taraf A hâlinin değiştiğini iddia eder
def borcIddia           : Formul := atom 92   -- taraf karşısındakinin (fazla) borçlu olduğunu iddia eder
def arizIddia           : Formul := atom 93   -- taraf arız sıfatın (ör. kârın) bulunduğunu iddia eder
def beyyineIle          : Formul := atom 94   -- hak beyyineyle sabit olmuştur
def ikrarIle            : Formul := atom 95   -- hak ikrarla sabit olmuştur
def baskasiBagli        : Formul := atom 96   -- ikrar edenden başkası da bağlanır
def ikrarEdenBagli      : Formul := atom 97   -- ikrar eden kendi ikrarıyla bağlanır
def tenakuz             : Formul := atom 98   -- tanık ya da taraf çelişkiye düşmüştür
def oncekiHukum         : Formul := atom 100  -- çelişkiden önce verilmiş bir hüküm vardır
def hukumBozulmaz       : Formul := atom 101  -- önceki hüküm bozulmaz
def ictihadlaHukum      : Formul := atom 102  -- bir içtihada dayanılarak hüküm verilmiştir
def yeniIctihad         : Formul := atom 103  -- sonradan farklı bir içtihat ileri sürülmüştür
def asilSabit           : Formul := atom 104  -- asıl (ör. asıl borç) sabittir
def ferSabit            : Formul := atom 105  -- fer' (ör. kefilin borcu) sabittir
def asilSakit           : Formul := atom 106  -- asıl düşmüştür
def ferSakit            : Formul := atom 107  -- fer' düşer
def kefalet             : Formul := atom 108  -- ikrar eden, başkasının borcuna kefildir
def sartSabit           : Formul := atom 109  -- bir şart gerçekleşmiştir
def muallakSabit        : Formul := atom 110  -- şarta bağlanan şey gerçekleşir
def sartliAkit          : Formul := atom 111  -- akitte bir şart vardır
def riayetMumkun        : Formul := atom 112  -- şarta uymak mümkündür
def sartaRiayet         : Formul := atom 113  -- şarta uyulması gerekir
def vaad                : Formul := atom 114  -- bir vaat yapılmıştır
def talik               : Formul := atom 115  -- vaat bir şarta bağlanmıştır
def vaadLazim           : Formul := atom 116  -- vaat bağlayıcıdır
def ucretBorcu          : Formul := atom 117  -- kişi bir ücret borçludur
def tazmin              : Formul := atom 118  -- kişi zararı tazmin eder
def malik               : Formul := atom 119  -- kişi şeyin malikidir
def fail                : Formul := atom 120  -- kişi fiili bizzat yapmıştır
def emir                : Formul := atom 121  -- kişi fiili başkasına emretmiştir
def icbar               : Formul := atom 122  -- emir icbar (zorlama) ile verilmiştir
def amireAit            : Formul := atom 123  -- fiilin hükmü emredene yüklenir
def faileAit            : Formul := atom 124  -- fiilin hükmü yapana yüklenir
def mubasir             : Formul := atom 126  -- kişi zararı doğrudan vermiştir (mübaşir)
def mutesebbib          : Formul := atom 127  -- kişi zarara sebep olmuştur (mütesebbib)
def kast                : Formul := atom 128  -- kişi kasten (taammüden) hareket etmiştir
def digerMubasir        : Formul := atom 129  -- zararı doğrudan veren başka biri vardır
def hayvanKendiliginden : Formul := atom 130  -- zarar bir hayvanın kendiliğinden verdiği zarardır
def gayrinMali          : Formul := atom 131  -- fiil başkasının malı ya da mülkü üzerindedir
def izin                : Formul := atom 133  -- malikin izni vardır
def emirBatil           : Formul := atom 135  -- emir bâtıldır
def istemekMemnu        : Formul := atom 136  -- fiilin istenmesi (talebi) yasaktır
def almakMemnu          : Formul := atom 137  -- bir şeyin alınması yasaktır
def vermekMemnu         : Formul := atom 138  -- o şeyin verilmesi yasaktır
def mesruSebep          : Formul := atom 139  -- alma için meşru bir sebep vardır
def sebepDegisti        : Formul := atom 140  -- şeyin edinilme sebebi değişmiştir
def seyDegismisGibi     : Formul := atom 141  -- şey değişmiş gibi hüküm verilir
def istical             : Formul := atom 142  -- kişi bir şeyi vaktinden önce elde etmeye kalkmıştır
def mahrumiyet          : Formul := atom 143  -- kişi o şeyden mahrum bırakılır
def nas                 : Formul := atom 144  -- konuda açık bir nas vardır
def ictihadCaiz         : Formul := atom 145  -- konuda içtihat caizdir
def kiyasaAykiri        : Formul := atom 146  -- hüküm kıyasa aykırı olarak sabittir
def makisAleyh          : Formul := atom 147  -- hüküm başka şeylere kıyas kaynağı olur
def tearuz              : Formul := atom 148  -- iki zarardan biri, ancak öbürüne katlanarak önlenebilir
def tedbirGerekli       : Formul := atom 149  -- T tedbirine başvurmak gerekir
def defMenfaatTearuz    : Formul := atom 150  -- bir zararı önlemek ile bir yarar sağlamak çatışır
def defOnce             : Formul := atom 151  -- zararı önlemek öne alınır
def defMumkun           : Formul := atom 152  -- Z'yi gidermek mümkündür
def hacet               : Formul := atom 153  -- bir ihtiyaç (hâcet) vardır
def yayginKullanim      : Formul := atom 154  -- insanların yaygın bir kullanımı vardır
def adetenImkansiz      : Formul := atom 155  -- şey âdeten imkânsızdır
def hukmenImkansiz      : Formul := atom 156  -- şey gerçekten imkânsız gibi hüküm görür
def zamanDegisti        : Formul := atom 157  -- zaman (ve onunla örf) değişmiştir
def hukumDegisti        : Formul := atom 158  -- hüküm değişmiştir
def muttarid            : Formul := atom 159  -- âdet süreklidir (muttarid)
def galib               : Formul := atom 160  -- âdet ya da durum yaygındır (gâlib)
def nadir               : Formul := atom 161  -- durum nadirdir
def muteber             : Formul := atom 162  -- duruma itibar edilir
def orfenMaruf          : Formul := atom 163  -- şey örfen bilinmektedir
def sartGibi            : Formul := atom 164  -- şey şart koşulmuş gibi hüküm doğurur
def tuccarMaruf         : Formul := atom 165  -- şey tüccarlar arasında bilinmektedir
def muktezi             : Formul := atom 166  -- hükmü gerektiren bir sebep vardır
def mani                : Formul := atom 167  -- hükme engel bir durum vardır
def hukumVar            : Formul := atom 168  -- hüküm doğar
def tabi                : Formul := atom 169  -- y, varlıkta x'e tâbidir
def tabiHukum           : Formul := atom 170  -- y, hükümde x'e tâbidir
def ayriHukum           : Formul := atom 171  -- y'ye ayrıca hüküm verilir
def malikX              : Formul := atom 172  -- kişi x'e maliktir
def zaruriyat           : Formul := atom 173  -- y, x'in zorunlu gereğidir
def malikY              : Formul := atom 174  -- kişi y'ye de maliktir
def asilBatil           : Formul := atom 175  -- bir işlem bâtıldır
def zimnBatil           : Formul := atom 176  -- onun içindeki (zımnındaki) işlem de bâtıldır
def asilIfaMumkun       : Formul := atom 177  -- aslın ifası mümkündür
def bedelIfa            : Formul := atom 178  -- bedeli ifa olunur
def bizzatCaiz          : Formul := atom 179  -- işlem kendi başına caizdir
def caizHukum           : Formul := atom 180  -- işlem (bu olayda) caizdir
def ibtidaenCaiz        : Formul := atom 181  -- işlem başlangıçta caizdir
def bekaenCaiz          : Formul := atom 182  -- işlemin devamı caizdir
def teberru             : Formul := atom 183  -- bir bağış (teberru) yapılmıştır
def kabz                : Formul := atom 184  -- bağışlanan şey teslim alınmıştır
def teberruTamam        : Formul := atom 185  -- bağış tamamdır
def raiyyeTasarruf      : Formul := atom 186  -- yönetici halk üzerinde tasarrufta bulunmuştur
def maslahat            : Formul := atom 187  -- tasarruf kamu yararına uygundur
def tasarrufNafiz       : Formul := atom 188  -- tasarruf geçerlidir
def hasVelayet          : Formul := atom 189  -- özel bir velayet vardır
def ammVelayet          : Formul := atom 190  -- genel bir velayet vardır
def hasOnce             : Formul := atom 191  -- özel velayet öne alınır

/-! ## 2. Kaideler (harfî okuma) -/

def md2   : Formul := maksat ⟹ hukumM
def md3   : Formul := lafizFarkli ⟹ (manayaGore ⋀ ∼lafzaGore)
def md4   : Formul := (yakin ⋀ sek) ⟹ hukumA
def md5   : Formul := (yakin ⋀ ∼degisimSabit) ⟹ hukumA
def md6   : Formul := kadim ⟹ kadimBirakilir
def md7   : Formul := (kadim ⋀ kadimZararli) ⟹ ∼kadimBirakilir
def md8   : Formul := ∼borcSabit ⟹ beraat
def md9   : Formul := ∼arizSabit ⟹ arizYok
def md10  : Formul := (yakin ⋀ ∼degisimSabit) ⟹ hukumA
def md11  : Formul := (hadis ⋀ ∼uzakZamanSabit) ⟹ yakinZaman
def md12  : Formul := hakikiMumkun ⟹ hakikiyeGore
def md13  : Formul := tasrih ⟹ ∼delaletGore
def md14  : Formul := nas ⟹ ∼ictihadCaiz
def md15  : Formul := kiyasaAykiri ⟹ ∼makisAleyh
def md16  : Formul := (ictihadlaHukum ⋀ yeniIctihad) ⟹ hukumBozulmaz
def md17  : Formul := mesakkat ⟹ teysir
def md18  : Formul := mesakkat ⟹ teysir
def md19  : Formul := mukabele ⟹ ∼tedbirCaiz
def md20  : Formul := zarar ⟹ izale
def md21  : Formul := (zaruret ⋀ aslenMemnu) ⟹ mubah
def md22  : Formul := ((zaruret ⋀ aslenMemnu) ⋀ miktariAsar) ⟹ ∼mubah
def md23  : Formul := (aslenMemnu ⋀ ∼zaruret) ⟹ ∼mubah
def md24  : Formul := maniZail ⟹ avdet
def md25  : Formul := misil ⟹ ∼tedbirCaiz
def md26  : Formul := ((zarar ⋀ amm) ⋀ has) ⟹ tedbirCaiz
def md27  : Formul := (zarar ⋀ ehaf) ⟹ tedbirCaiz
def md28  : Formul := (tearuz ⋀ ehaf) ⟹ tedbirGerekli
def md29  : Formul := (tearuz ⋀ ehaf) ⟹ tedbirGerekli
def md30  : Formul := defMenfaatTearuz ⟹ defOnce
def md31  : Formul := (zarar ⋀ defMumkun) ⟹ izale
def md32  : Formul := hacet ⟹ zaruret
def md33  : Formul := ((zaruret ⋀ gayrinMali) ⋀ mubasir) ⟹ tazmin
def md34  : Formul := almakMemnu ⟹ vermekMemnu
def md35  : Formul := ∼mubah ⟹ istemekMemnu
def md36  : Formul := orf ⟹ orfeGore
def md37  : Formul := yayginKullanim ⟹ orfeGore
def md38  : Formul := adetenImkansiz ⟹ hukmenImkansiz
def md40  : Formul := orfMecaz ⟹ ∼hakikiyeGore
def md41  : Formul := orfeGore ⟹ (muttarid ⋁ galib)
def md42  : Formul := (galib ⟹ muteber) ⋀ (nadir ⟹ ∼muteber)
def md43  : Formul := orfenMaruf ⟹ sartGibi
def md44  : Formul := tuccarMaruf ⟹ sartGibi
def md45  : Formul := orf ⟹ orfeGore
def md46  : Formul := (muktezi ⋀ mani) ⟹ ∼hukumVar
def md47  : Formul := tabi ⟹ tabiHukum
def md48  : Formul := tabi ⟹ ∼ayriHukum
def md49  : Formul := (malikX ⋀ zaruriyat) ⟹ malikY
def md50  : Formul := asilSakit ⟹ ferSakit
def md51  : Formul := sakit ⟹ ∼avdet
def md52  : Formul := asilBatil ⟹ zimnBatil
def md53  : Formul := ∼asilIfaMumkun ⟹ bedelIfa
def md56  : Formul := ibtidaenCaiz ⟹ bekaenCaiz
def md57  : Formul := (teberru ⋀ ∼kabz) ⟹ ∼teberruTamam
def md58  : Formul := (raiyyeTasarruf ⋀ ∼maslahat) ⟹ ∼tasarrufNafiz
def md59  : Formul := (hasVelayet ⋀ ammVelayet) ⟹ hasOnce
def md60  : Formul := (hakikiMumkun ⋁ mecazMumkun) ⟹ ∼ihmal
def md61  : Formul := ∼hakikiMumkun ⟹ mecazaGore
def md62  : Formul := (∼hakikiMumkun ⋀ ∼mecazMumkun) ⟹ ihmal
def md63  : Formul := (bolunmez ⋀ baziZikr) ⟹ kulluZikr
def md64  : Formul := ((mutlak ⋀ ∼tasrih) ⋀ ∼orf) ⟹ mutlakGore
def md65  : Formul := (hazir ⟹ ∼vasifMuteber) ⋀ (∼hazir ⟹ vasifMuteber)
def md66  : Formul := sualOnay ⟹ sorudakiSoylenmis
def md67  : Formul := (sukut ⟹ ∼sozIsnad) ⋀ ((sukut ⋀ hacetYeri) ⟹ beyan)
def md68  : Formul := (batin ⋀ zahirDelil) ⟹ delileGore
def md69  : Formul := mukatebe ⟹ muhatabeGibi
def md70  : Formul := dilsizIsaret ⟹ dilleBeyanGibi
def md71  : Formul := tercumanKavli ⟹ kabul
def md72  : Formul := (zann ⋀ hataZahir) ⟹ ∼itibar
def md73  : Formul := ihtimalDelilli ⟹ ∼hucce
def md74  : Formul := vehim ⟹ ∼itibar
def md75  : Formul := burhan ⟹ iyanenGibi
def md76  : Formul := (davaci ⟹ beyyineOna) ⋀ (munkir ⟹ yeminOna)
def md77  : Formul := (zahireAykiri ⟹ beyyineOna) ⋀ (asliKoruyor ⟹ yeminOna)
def md78  : Formul := (beyyineIle ⟹ baskasiBagli) ⋀ ((ikrarIle ⋀ ∼beyyineIle) ⟹ ∼baskasiBagli)
def md79  : Formul := ikrarIle ⟹ ikrarEdenBagli
def md80  : Formul := (tenakuz ⟹ ∼hucce) ⋀ ((tenakuz ⋀ oncekiHukum) ⟹ hukumBozulmaz)
def md82  : Formul := sartSabit ⟹ muallakSabit
def md83  : Formul := (sartliAkit ⋀ riayetMumkun) ⟹ sartaRiayet
def md84  : Formul := (vaad ⋀ talik) ⟹ vaadLazim
def md85  : Formul := hasarAlici ⟹ yararAlici
def md86  : Formul := ∼(ucretBorcu ⋀ tazmin)
def md87  : Formul := yararAlici ⟹ hasarAlici
def md88  : Formul := (hasarAlici ⟹ yararAlici) ⋀ (yararAlici ⟹ hasarAlici)
def md89  : Formul := (fail ⟹ faileAit) ⋀ ((emir ⋀ ∼icbar) ⟹ ∼amireAit)
def md90  : Formul := (mutesebbib ⋀ digerMubasir) ⟹ ∼tazmin
def md91  : Formul := mubah ⟹ ∼tazmin
def md92  : Formul := mubasir ⟹ tazmin
def md93  : Formul := (mutesebbib ⋀ ∼kast) ⟹ ∼tazmin
def md94  : Formul := hayvanKendiliginden ⟹ ∼tazmin
def md95  : Formul := (gayrinMali ⋀ emir) ⟹ emirBatil
def md96  : Formul := (gayrinMali ⋀ ∼izin) ⟹ ∼mubah
def md97  : Formul := (gayrinMali ⋀ ∼mesruSebep) ⟹ ∼mubah
def md98  : Formul := sebepDegisti ⟹ seyDegismisGibi
def md99  : Formul := istical ⟹ mahrumiyet
def md100 : Formul := riza ⟹ ∼kusurHakki

/-! Olanak kaideleri (md. 39, 54, 55, 81) bir formül değil, bir olay
    betiminin tutarlı olduğunu söyler; bkz. §8. -/

/-! ## 3. Köprü ilkeleri -/

def K1  : Formul := sek ⟹ ∼degisimSabit  -- Yalnız şek, değişimi ispat etmez.
def K2  : Formul := zaruret ⟹ mesakkat  -- Zaruret, meşakkatin en ağır derecesidir.
def K3  : Formul := (amm ⋀ has) ⟹ ehaf  -- Özel zarar, genel zarara göre hafiftir.
def K4  : Formul := ∼(misil ⋀ ehaf)  -- Bir zarar hem denk hem hafif olamaz.
def K5  : Formul := mukabele ⟹ misil  -- Misilleme denk zararla karşılıktır.
def K6  : Formul := maniZail ⟹ ∼sakit  -- Engelin kalkması, hakkın düşmediğini gerektirir.
def K7  : Formul := orfeGore ⟹ delaletGore  -- Örfe göre hüküm, delâlete göre hükümdür.
def K8  : Formul := ∼(orfeGore ⋀ mutlakGore)  -- Aynı söz hem örfe hem kayıtsız anlamına göre okunmaz.
def K9  : Formul := (bilgi ⋀ tasarruf) ⟹ riza  -- Bilerek tasarruf ayıba rızadır.
def K10 : Formul := kadimZararli ⟹ zarar  -- Zararlı eski durum bir zarardır.
def K11 : Formul := (kadimZararli ⋀ izale) ⟹ ∼kadimBirakilir  -- Zarar eski durumun kendisiyse, onu gidermek eski durumu bırakmamaktır.
def K12 : Formul := (hukumA ⋀ degisimIddia) ⟹ zahireAykiri  -- Sürdüğüne hükmolunan hâlin değiştiğini iddia etmek zâhire aykırıdır.
def K13 : Formul := (beraat ⋀ borcIddia) ⟹ zahireAykiri  -- Borçsuzluk asılken borç iddiası zâhire aykırıdır.
def K14 : Formul := (arizYok ⋀ arizIddia) ⟹ zahireAykiri  -- Arız sıfat yokken onun varlığını iddia etmek zâhire aykırıdır.
def K15 : Formul := davaci ⟹ zahireAykiri  -- Davacı, zâhire aykırı iddiada bulunandır.
def K16 : Formul := munkir ⟹ asliKoruyor  -- İnkâr eden, asıl durumu savunandır.
def K17 : Formul := mecazaGore ⟹ mecazMumkun  -- Söz ancak mümkünse mecazla yorumlanır.
def K18 : Formul := orfMecaz ⟹ orf  -- Sözün anlamını gösteren âdet bir örftür.
def K19 : Formul := (orfeGore ⋀ orfMecaz) ⟹ ∼hakikiyeGore  -- Âdet başka bir anlam gösterirken örfe göre hüküm, gerçek anlamı bırakmaktır.
def K20 : Formul := (hakikiyeGore ⋀ lafizFarkli) ⟹ lafzaGore  -- Lafız başka akdi gösterirken onu gerçek anlamıyla okumak, akdi lafzına göre yorumlamaktır.
def K21 : Formul := tearuz ⟹ zarar  -- Çatışan iki fesattan büyüğü giderilmesi istenen bir zarardır.
def K22 : Formul := tedbirGerekli ⟹ tedbirCaiz  -- Gerekli olan caizdir.
def K23 : Formul := izale ⟹ defMumkun  -- Giderilmesine hükmolunan zararın giderilmesi mümkündür.
def K24 : Formul := yayginKullanim ⟹ orf  -- İnsanların yaygın kullanımı bir örftür.
def K25 : Formul := ((orfeGore ⋀ ∼muttarid) ⋀ ∼galib) ⟹ nadir  -- Ne sürekli ne yaygın olan âdet nadirdir.
def K26 : Formul := orfeGore ⟹ muteber  -- Hükme esas alınan âdete itibar edilmiştir.
def K27 : Formul := tuccarMaruf ⟹ orfenMaruf  -- Tüccarlar arasında bilinen, örfen bilinendir.
def K28 : Formul := tabiHukum ⟹ ∼ayriHukum  -- Hükümde tâbi olana ayrıca hüküm verilmez.
def K29 : Formul := zaruriyat ⟹ tabi  -- Bir şeyin zorunlu gereği ona tâbidir.
def K30 : Formul := (tabiHukum ⋀ malikX) ⟹ malikY  -- Asla malik olan, hükümde ona tâbi olana da maliktir.
def K31 : Formul := (kefalet ⋀ ikrarEdenBagli) ⟹ ferSabit  -- Kefilin ikrarla bağlanması, fer'in sabit olmasıdır.
def K32 : Formul := (kefalet ⋀ ∼baskasiBagli) ⟹ ∼asilSabit  -- Asıl borçlunun bağlanmaması, aslın sabit olmamasıdır.
def K33 : Formul := (hasarAlici ⋀ ∼malik) ⟹ tazmin  -- Başkasının malının hasarına katlanmak, onu tazmin etmektir.
def K34 : Formul := ∼(mubasir ⋀ mutesebbib)  -- Aynı zarar için kişi hem doğrudan yapan hem sebep olan olamaz.
def K35 : Formul := (istemekMemnu ⋀ emir) ⟹ emirBatil  -- İstenmesi yasak olan bir fiili emretmek bâtıldır.
def K36 : Formul := zaruret ⟹ mesruSebep  -- Zaruret, almak için meşru bir sebeptir.
def K37 : Formul := hayvanKendiliginden ⟹ ∼mubasir  -- Hayvanın kendiliğinden verdiği zararda sahibi mübaşir değildir.
def K38 : Formul := ∼(galib ⋀ nadir)  -- Bir durum hem yaygın hem nadir olamaz.
def K39 : Formul := yayginKullanim ⟹ galib  -- İnsanların yaygın kullanımı gâlib bir âdettir.

-- Benimsenmeyen, yalnızca bir karışıklığın sonucunu göstermek için yazılan varsayımlar:
def H1: Formul := ∼asilSabit ⟹ asilSakit  -- 'Sabit olmamak' ile 'düşmek' aynı sayılırsa.
def H2: Formul := ferSabit ⟹ ∼ferSakit  -- Sabit olan fer' düşmemiştir.

/-! ## 4. Kısıtlanmış (tahsis edilmiş) kaideler -/

-- md. 7'nin öncülü md. 6'nınkini içerir; özel olan genel olanı kısıtlar.
def md6r  : Formul := (kadim ⋀ ∼kadimZararli) ⟹ kadimBirakilir
-- md. 40 (âdet) ve md. 3 (akitte amaç) gerçek anlamın terk edileceği durumları açıkça söyler.
def md12r : Formul := ((hakikiMumkun ⋀ ∼orfMecaz) ⋀ ∼lafizFarkli) ⟹ hakikiyeGore
-- md. 13 açık sözü öne alır (Uzantı U6); md. 41 âdetin ancak sürekli ya da yaygınsa muteber olduğunu söyler.
def md36r : Formul := ((orf ⋀ ∼tasrih) ⋀ (muttarid ⋁ galib)) ⟹ orfeGore
-- md. 36 ile aynı formül; aynı kısıtlamalar.
def md45r : Formul := ((orf ⋀ ∼tasrih) ⋀ (muttarid ⋁ galib)) ⟹ orfeGore
-- md. 13 açık sözü öne alır.
def md37r : Formul := (yayginKullanim ⋀ ∼tasrih) ⟹ orfeGore
-- md. 31 'zarar bi-kadri'l-imkân def olunur' der: md. 20'nin kendi kaydı.
def md20r : Formul := (zarar ⋀ defMumkun) ⟹ izale
-- md. 62, mecaz da mümkün değilse sözün ihmal edileceğini söyler.
def md61r : Formul := (∼hakikiMumkun ⋀ mecazMumkun) ⟹ mecazaGore
-- md. 22'nin öncülü md. 21'inkini içerir (pilot B5).
def md21r : Formul := ((zaruret ⋀ aslenMemnu) ⋀ ∼miktariAsar) ⟹ mubah
-- md. 33'ün örneği aç kalanın başkasının ekmeğini yiyebileceğini varsayar; md. 21 üstün gelir.
def md96r : Formul := ((gayrinMali ⋀ ∼izin) ⋀ ∼zaruret) ⟹ ∼mubah
-- md. 92 'kasti olmasa da' der; md. 33'ün örneğinde fiil caizdir ama tazmin gerekir.
def md91r : Formul := (mubah ⋀ ∼mubasir) ⟹ ∼tazmin

/-! ## 5. Külliyat listeleri -/

def harfi : List Formul :=
  [md2, md3, md4, md5, md6, md7, md8, md9, md10, md11, md12, md13, md14, md15, md16, md17, md18, md19, md20, md21, md22, md23, md24, md25, md26, md27, md28, md29, md30, md31, md32, md33, md34, md35, md36, md37, md38, md40, md41, md42, md43, md44, md45, md46, md47, md48, md49, md50, md51, md52, md53, md56, md57, md58, md59, md60, md61, md62, md63, md64, md65, md66, md67, md68, md69, md70, md71, md72, md73, md74, md75, md76, md77, md78, md79, md80, md82, md83, md84, md85, md86, md87, md88, md89, md90, md91, md92, md93, md94, md95, md96, md97, md98, md99, md100]
def kulliyat : List Formul :=
  [md2, md3, md4, md5, md6r, md7, md8, md9, md10, md11, md12r, md13, md14, md15, md16, md17, md18, md19, md20r, md21r, md22, md23, md24, md25, md26, md27, md28, md29, md30, md31, md32, md33, md34, md35, md36r, md37r, md38, md40, md41, md42, md43, md44, md45r, md46, md47, md48, md49, md50, md51, md52, md53, md56, md57, md58, md59, md60, md61r, md62, md63, md64, md65, md66, md67, md68, md69, md70, md71, md72, md73, md74, md75, md76, md77, md78, md79, md80, md82, md83, md84, md85, md86, md87, md88, md89, md90, md91r, md92, md93, md94, md95, md96r, md97, md98, md99, md100]
def kopruler : List Formul :=
  [K1, K2, K3, K4, K5, K6, K7, K8, K9, K10, K11, K12, K13, K14, K15, K16, K17, K18, K19, K20, K21, K22, K23, K24, K25, K26, K27, K28, K29, K30, K31, K32, K33, K34, K35, K36, K37, K38, K39]

-- Model ve birleşim yardımcıları (Pilot'takilerle aynı)
def model (l : List Nat) : Degerleme := fun n => l.contains n
def hepsi : List Formul → Formul
  | []      => tepe
  | A :: Γ  => A ⋀ hepsi Γ

/-! ## 6. Denklikler: aynı formüle düşen kaideler -/

theorem md5_md10_ayni :
    md5 = md10 := rfl

theorem md17_md18_ayni :
    md17 = md18 := rfl

theorem md28_md29_ayni :
    md28 = md29 := rfl

theorem md36_md45_ayni :
    md36 = md45 := rfl

/-! ## 7. Türetmeler -/

-- 7.1 Harfî külliyatta
theorem tur_md4_md5_K1 :
    Sonuc [md5, K1] md4 := by
  intro v h
  have h0 := h md5 (by simp); have h1 := h K1 (by simp)
  simp only [hepsi, tepe, degil, deger, md5, K1, md4, degisimSabit, hukumA, sek, yakin] at *; revert h0 h1
  generalize v 0 = x0; generalize v 1 = x1; generalize v 2 = x2; generalize v 3 = x3
  revert x0 x1 x2 x3; decide

theorem tur_md4_md10_K1 :
    Sonuc [md10, K1] md4 := by
  intro v h
  have h0 := h md10 (by simp); have h1 := h K1 (by simp)
  simp only [hepsi, tepe, degil, deger, md10, K1, md4, degisimSabit, hukumA, sek, yakin] at *; revert h0 h1
  generalize v 0 = x0; generalize v 1 = x1; generalize v 2 = x2; generalize v 3 = x3
  revert x0 x1 x2 x3; decide

theorem tur_md7_md20_K10_K11 :
    Sonuc [md20, K10, K11] md7 := by
  intro v h
  have h0 := h md20 (by simp); have h1 := h K10 (by simp); have h2 := h K11 (by simp)
  simp only [hepsi, tepe, degil, deger, md20, K10, K11, md7, izale, kadim, kadimBirakilir, kadimZararli, zarar] at *; revert h0 h1 h2
  generalize v 10 = x10; generalize v 11 = x11; generalize v 41 = x41; generalize v 42 = x42; generalize v 43 = x43
  revert x10 x11 x41 x42 x43; decide

theorem tur_md19_md25_K5 :
    Sonuc [md25, K5] md19 := by
  intro v h
  have h0 := h md25 (by simp); have h1 := h K5 (by simp)
  simp only [hepsi, tepe, degil, deger, md25, K5, md19, misil, mukabele, tedbirCaiz] at *; revert h0 h1
  generalize v 12 = x12; generalize v 13 = x13; generalize v 17 = x17
  revert x12 x13 x17; decide

theorem tur_md26_md27_K3 :
    Sonuc [md27, K3] md26 := by
  intro v h
  have h0 := h md27 (by simp); have h1 := h K3 (by simp)
  simp only [hepsi, tepe, degil, deger, md27, K3, md26, amm, ehaf, has, tedbirCaiz, zarar] at *; revert h0 h1
  generalize v 10 = x10; generalize v 12 = x12; generalize v 14 = x14; generalize v 15 = x15; generalize v 16 = x16
  revert x10 x12 x14 x15 x16; decide

theorem tur_md31_md20 :
    Sonuc [md20] md31 := by
  intro v h
  have h0 := h md20 (by simp)
  simp only [hepsi, tepe, degil, deger, md20, md31, defMumkun, izale, zarar] at *; revert h0
  generalize v 10 = x10; generalize v 11 = x11; generalize v 152 = x152
  revert x10 x11 x152; decide

theorem tur_md33_md92 :
    Sonuc [md92] md33 := by
  intro v h
  have h0 := h md92 (by simp)
  simp only [hepsi, tepe, degil, deger, md92, md33, gayrinMali, mubasir, tazmin, zaruret] at *; revert h0
  generalize v 6 = x6; generalize v 118 = x118; generalize v 126 = x126; generalize v 131 = x131
  revert x6 x118 x126 x131; decide

theorem tur_md37_md36_K24 :
    Sonuc [md36, K24] md37 := by
  intro v h
  have h0 := h md36 (by simp); have h1 := h K24 (by simp)
  simp only [hepsi, tepe, degil, deger, md36, K24, md37, orf, orfeGore, yayginKullanim] at *; revert h0 h1
  generalize v 20 = x20; generalize v 21 = x21; generalize v 154 = x154
  revert x20 x21 x154; decide

theorem tur_md37_md45_K24 :
    Sonuc [md45, K24] md37 := by
  intro v h
  have h0 := h md45 (by simp); have h1 := h K24 (by simp)
  simp only [hepsi, tepe, degil, deger, md45, K24, md37, orf, orfeGore, yayginKullanim] at *; revert h0 h1
  generalize v 20 = x20; generalize v 21 = x21; generalize v 154 = x154
  revert x20 x21 x154; decide

theorem tur_md40_md36_K18_K19 :
    Sonuc [md36, K18, K19] md40 := by
  intro v h
  have h0 := h md36 (by simp); have h1 := h K18 (by simp); have h2 := h K19 (by simp)
  simp only [hepsi, tepe, degil, deger, md36, K18, K19, md40, hakikiyeGore, orf, orfMecaz, orfeGore] at *; revert h0 h1 h2
  generalize v 20 = x20; generalize v 21 = x21; generalize v 52 = x52; generalize v 56 = x56
  revert x20 x21 x52 x56; decide

theorem tur_md40_md45_K18_K19 :
    Sonuc [md45, K18, K19] md40 := by
  intro v h
  have h0 := h md45 (by simp); have h1 := h K18 (by simp); have h2 := h K19 (by simp)
  simp only [hepsi, tepe, degil, deger, md45, K18, K19, md40, hakikiyeGore, orf, orfMecaz, orfeGore] at *; revert h0 h1 h2
  generalize v 20 = x20; generalize v 21 = x21; generalize v 52 = x52; generalize v 56 = x56
  revert x20 x21 x52 x56; decide

theorem tur_md41_md42_K25_K26 :
    Sonuc [md42, K25, K26] md41 := by
  intro v h
  have h0 := h md42 (by simp); have h1 := h K25 (by simp); have h2 := h K26 (by simp)
  simp only [hepsi, tepe, degil, deger, md42, K25, K26, md41, galib, muteber, muttarid, nadir, orfeGore] at *; revert h0 h1 h2
  generalize v 21 = x21; generalize v 159 = x159; generalize v 160 = x160; generalize v 161 = x161; generalize v 162 = x162
  revert x21 x159 x160 x161 x162; decide

theorem tur_md44_md43_K27 :
    Sonuc [md43, K27] md44 := by
  intro v h
  have h0 := h md43 (by simp); have h1 := h K27 (by simp)
  simp only [hepsi, tepe, degil, deger, md43, K27, md44, orfenMaruf, sartGibi, tuccarMaruf] at *; revert h0 h1
  generalize v 163 = x163; generalize v 164 = x164; generalize v 165 = x165
  revert x163 x164 x165; decide

theorem tur_md48_md47_K28 :
    Sonuc [md47, K28] md48 := by
  intro v h
  have h0 := h md47 (by simp); have h1 := h K28 (by simp)
  simp only [hepsi, tepe, degil, deger, md47, K28, md48, ayriHukum, tabi, tabiHukum] at *; revert h0 h1
  generalize v 169 = x169; generalize v 170 = x170; generalize v 171 = x171
  revert x169 x170 x171; decide

theorem tur_md49_md47_K29_K30 :
    Sonuc [md47, K29, K30] md49 := by
  intro v h
  have h0 := h md47 (by simp); have h1 := h K29 (by simp); have h2 := h K30 (by simp)
  simp only [hepsi, tepe, degil, deger, md47, K29, K30, md49, malikX, malikY, tabi, tabiHukum, zaruriyat] at *; revert h0 h1 h2
  generalize v 169 = x169; generalize v 170 = x170; generalize v 172 = x172; generalize v 173 = x173; generalize v 174 = x174
  revert x169 x170 x172 x173 x174; decide

-- Boşuna türetme: öncüller hedefin hiçbir kuralının öncülüyle tutarlı değil.
theorem tur_md62_md61_K17 :
    Sonuc [md61, K17] md62 := by
  intro v h
  have h0 := h md61 (by simp); have h1 := h K17 (by simp)
  simp only [hepsi, tepe, degil, deger, md61, K17, md62, hakikiMumkun, ihmal, mecazMumkun, mecazaGore] at *; revert h0 h1
  generalize v 51 = x51; generalize v 53 = x53; generalize v 54 = x54; generalize v 55 = x55
  revert x51 x53 x54 x55; decide

theorem tur_md76_md77_K15_K16 :
    Sonuc [md77, K15, K16] md76 := by
  intro v h
  have h0 := h md77 (by simp); have h1 := h K15 (by simp); have h2 := h K16 (by simp)
  simp only [hepsi, tepe, degil, deger, md77, K15, K16, md76, asliKoruyor, beyyineOna, davaci, munkir, yeminOna, zahireAykiri] at *; revert h0 h1 h2
  generalize v 85 = x85; generalize v 86 = x86; generalize v 87 = x87; generalize v 88 = x88; generalize v 89 = x89; generalize v 90 = x90
  revert x85 x86 x87 x88 x89 x90; decide

theorem tur_md85_md88 :
    Sonuc [md88] md85 := by
  intro v h
  have h0 := h md88 (by simp)
  simp only [hepsi, tepe, degil, deger, md88, md85, hasarAlici, yararAlici] at *; revert h0
  generalize v 31 = x31; generalize v 32 = x32
  revert x31 x32; decide

theorem tur_md87_md88 :
    Sonuc [md88] md87 := by
  intro v h
  have h0 := h md88 (by simp)
  simp only [hepsi, tepe, degil, deger, md88, md87, hasarAlici, yararAlici] at *; revert h0
  generalize v 31 = x31; generalize v 32 = x32
  revert x31 x32; decide

theorem tur_md88_md85_md87 :
    Sonuc [md85, md87] md88 := by
  intro v h
  have h0 := h md85 (by simp); have h1 := h md87 (by simp)
  simp only [hepsi, tepe, degil, deger, md85, md87, md88, hasarAlici, yararAlici] at *; revert h0 h1
  generalize v 31 = x31; generalize v 32 = x32
  revert x31 x32; decide

-- 7.2 Kısıtlanmış külliyatta (yalnız 7.1'de olmayanlar)
theorem turR_md37r_md36r_K24_K39 :
    Sonuc [md36r, K24, K39] md37r := by
  intro v h
  have h0 := h md36r (by simp); have h1 := h K24 (by simp); have h2 := h K39 (by simp)
  simp only [hepsi, tepe, degil, deger, md36r, K24, K39, md37r, galib, muttarid, orf, orfeGore, tasrih, yayginKullanim] at *; revert h0 h1 h2
  generalize v 20 = x20; generalize v 21 = x21; generalize v 25 = x25; generalize v 154 = x154; generalize v 159 = x159; generalize v 160 = x160
  revert x20 x21 x25 x154 x159 x160; decide

theorem turR_md37r_md45r_K24_K39 :
    Sonuc [md45r, K24, K39] md37r := by
  intro v h
  have h0 := h md45r (by simp); have h1 := h K24 (by simp); have h2 := h K39 (by simp)
  simp only [hepsi, tepe, degil, deger, md45r, K24, K39, md37r, galib, muttarid, orf, orfeGore, tasrih, yayginKullanim] at *; revert h0 h1 h2
  generalize v 20 = x20; generalize v 21 = x21; generalize v 25 = x25; generalize v 154 = x154; generalize v 159 = x159; generalize v 160 = x160
  revert x20 x21 x25 x154 x159 x160; decide


/-! ## 8. Çatışmalar ve çözümleri -/

-- Ç1. md. 20 (+ K10, K23) — olay: {kadimZararli, ¬defMumkun}
theorem cat1 :
    ¬ Saglanabilir (hepsi [md20, K10, K23, kadimZararli, ∼defMumkun]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md20, K10, K23, defMumkun, izale, kadimZararli, zarar] at *; revert h
  generalize v 10 = x10; generalize v 11 = x11; generalize v 43 = x43; generalize v 152 = x152
  revert x10 x11 x43 x152; decide

-- md20 kısıtlı biçimini gerektirir (yalnız zayıflatma).
theorem md20_kisitlanir :
    Sonuc [md20] md20r := by
  intro v h
  have h0 := h md20 (by simp)
  simp only [hepsi, tepe, degil, deger, md20, md20r, defMumkun, izale, zarar] at *; revert h0
  generalize v 10 = x10; generalize v 11 = x11; generalize v 152 = x152
  revert x10 x11 x152; decide

-- Ç1 çözümü: kısıtlanmış biçimlerle (md20r) olay tutarlıdır.
theorem cat1_cozum :
    Saglanabilir (hepsi [md20r, K10, K23, kadimZararli, ∼defMumkun]) := ⟨model [10, 43], by decide⟩

-- Ç2. md. 32 (+ K2) — olay: {hacet, ¬mesakkat}
theorem cat2 :
    ¬ Saglanabilir (hepsi [md32, K2, hacet, ∼mesakkat]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md32, K2, hacet, mesakkat, zaruret] at *; revert h
  generalize v 4 = x4; generalize v 6 = x6; generalize v 153 = x153
  revert x4 x6 x153; decide

-- Ç2: kısıtlanmış külliyatta da açık kalır (bkz. rapor).

-- Ç3. md. 42 — olay: {galib, nadir}
theorem cat3 :
    ¬ Saglanabilir (hepsi [md42, galib, nadir]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md42, galib, muteber, nadir] at *; revert h
  generalize v 160 = x160; generalize v 161 = x161; generalize v 162 = x162
  revert x160 x161 x162; decide

-- Ç3 çözümü: K38 bu olayı imkânsız kılar (kavram ayrımı).
theorem cat3_kopru :
    ¬ Saglanabilir (hepsi [K38, galib, nadir]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, K38, galib, nadir] at *; revert h
  generalize v 160 = x160; generalize v 161 = x161
  revert x160 x161; decide

-- Ç4. md. 61 (+ K17) — olay: {¬hakikiMumkun, ¬mecazMumkun}
theorem cat4 :
    ¬ Saglanabilir (hepsi [md61, K17, ∼hakikiMumkun, ∼mecazMumkun]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md61, K17, hakikiMumkun, mecazMumkun, mecazaGore] at *; revert h
  generalize v 51 = x51; generalize v 53 = x53; generalize v 54 = x54
  revert x51 x53 x54; decide

-- md61 kısıtlı biçimini gerektirir (yalnız zayıflatma).
theorem md61_kisitlanir :
    Sonuc [md61] md61r := by
  intro v h
  have h0 := h md61 (by simp)
  simp only [hepsi, tepe, degil, deger, md61, md61r, hakikiMumkun, mecazMumkun, mecazaGore] at *; revert h0
  generalize v 51 = x51; generalize v 53 = x53; generalize v 54 = x54
  revert x51 x53 x54; decide

-- Ç4 çözümü: kısıtlanmış biçimlerle (md61r) olay tutarlıdır.
theorem cat4_cozum :
    Saglanabilir (hepsi [md61r, K17, ∼hakikiMumkun, ∼mecazMumkun]) := ⟨model [], by decide⟩

-- Ç5. md. 3, md. 12 (+ K20) — olay: {hakikiMumkun, lafizFarkli}
theorem cat5 :
    ¬ Saglanabilir (hepsi [md3, md12, K20, hakikiMumkun, lafizFarkli]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md3, md12, K20, hakikiMumkun, hakikiyeGore, lafizFarkli, lafzaGore, manayaGore] at *; revert h
  generalize v 38 = x38; generalize v 39 = x39; generalize v 40 = x40; generalize v 51 = x51; generalize v 52 = x52
  revert x38 x39 x40 x51 x52; decide

-- md12 kısıtlı biçimini gerektirir (yalnız zayıflatma).
theorem md12_kisitlanir :
    Sonuc [md12] md12r := by
  intro v h
  have h0 := h md12 (by simp)
  simp only [hepsi, tepe, degil, deger, md12, md12r, hakikiMumkun, hakikiyeGore, lafizFarkli, orfMecaz] at *; revert h0
  generalize v 38 = x38; generalize v 51 = x51; generalize v 52 = x52; generalize v 56 = x56
  revert x38 x51 x52 x56; decide

-- Ç5 çözümü: kısıtlanmış biçimlerle (md12r) olay tutarlıdır.
theorem cat5_cozum :
    Saglanabilir (hepsi [md3, md12r, K20, hakikiMumkun, lafizFarkli]) := ⟨model [38, 39, 51, 56], by decide⟩

-- Ç6. md. 6, md. 7 — olay: {kadim, kadimZararli}
theorem cat6 :
    ¬ Saglanabilir (hepsi [md6, md7, kadim, kadimZararli]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md6, md7, kadim, kadimBirakilir, kadimZararli] at *; revert h
  generalize v 41 = x41; generalize v 42 = x42; generalize v 43 = x43
  revert x41 x42 x43; decide

-- md6 kısıtlı biçimini gerektirir (yalnız zayıflatma).
theorem md6_kisitlanir :
    Sonuc [md6] md6r := by
  intro v h
  have h0 := h md6 (by simp)
  simp only [hepsi, tepe, degil, deger, md6, md6r, kadim, kadimBirakilir, kadimZararli] at *; revert h0
  generalize v 41 = x41; generalize v 42 = x42; generalize v 43 = x43
  revert x41 x42 x43; decide

-- Ç6 çözümü: kısıtlanmış biçimlerle (md6r) olay tutarlıdır.
theorem cat6_cozum :
    Saglanabilir (hepsi [md6r, md7, kadim, kadimZararli]) := ⟨model [41, 43], by decide⟩

-- Ç7. md. 6, md. 20 (+ K10, K11) — olay: {kadim, kadimZararli}
theorem cat7 :
    ¬ Saglanabilir (hepsi [md6, md20, K10, K11, kadim, kadimZararli]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md6, md20, K10, K11, izale, kadim, kadimBirakilir, kadimZararli, zarar] at *; revert h
  generalize v 10 = x10; generalize v 11 = x11; generalize v 41 = x41; generalize v 42 = x42; generalize v 43 = x43
  revert x10 x11 x41 x42 x43; decide

-- Ç7 çözümü: kısıtlanmış biçimlerle (md6r, md20r) olay tutarlıdır.
theorem cat7_cozum :
    Saglanabilir (hepsi [md6r, md20r, K10, K11, kadim, kadimZararli]) := ⟨model [10, 41, 43], by decide⟩

-- Ç8. md. 6, md. 31 (+ K11) — olay: {defMumkun, kadim, kadimZararli, zarar}
theorem cat8 :
    ¬ Saglanabilir (hepsi [md6, md31, K11, defMumkun, kadim, kadimZararli, zarar]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md6, md31, K11, defMumkun, izale, kadim, kadimBirakilir, kadimZararli, zarar] at *; revert h
  generalize v 10 = x10; generalize v 11 = x11; generalize v 41 = x41; generalize v 42 = x42; generalize v 43 = x43; generalize v 152 = x152
  revert x10 x11 x41 x42 x43 x152; decide

-- Ç8 çözümü: kısıtlanmış biçimlerle (md6r) olay tutarlıdır.
theorem cat8_cozum :
    Saglanabilir (hepsi [md6r, md31, K11, defMumkun, kadim, kadimZararli, zarar]) := ⟨model [10, 11, 41, 43, 152], by decide⟩

-- Ç9. md. 12, md. 36 (+ K18, K19) — olay: {hakikiMumkun, orfMecaz}
theorem cat9 :
    ¬ Saglanabilir (hepsi [md12, md36, K18, K19, hakikiMumkun, orfMecaz]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md12, md36, K18, K19, hakikiMumkun, hakikiyeGore, orf, orfMecaz, orfeGore] at *; revert h
  generalize v 20 = x20; generalize v 21 = x21; generalize v 51 = x51; generalize v 52 = x52; generalize v 56 = x56
  revert x20 x21 x51 x52 x56; decide

-- md36 kısıtlı biçimini gerektirir (yalnız zayıflatma).
theorem md36_kisitlanir :
    Sonuc [md36] md36r := by
  intro v h
  have h0 := h md36 (by simp)
  simp only [hepsi, tepe, degil, deger, md36, md36r, galib, muttarid, orf, orfeGore, tasrih] at *; revert h0
  generalize v 20 = x20; generalize v 21 = x21; generalize v 25 = x25; generalize v 159 = x159; generalize v 160 = x160
  revert x20 x21 x25 x159 x160; decide

-- Ç9 çözümü: kısıtlanmış biçimlerle (md12r, md36r) olay tutarlıdır.
theorem cat9_cozum :
    Saglanabilir (hepsi [md12r, md36r, K18, K19, hakikiMumkun, orfMecaz]) := ⟨model [20, 25, 51, 56, 160], by decide⟩

-- Ç10. md. 12, md. 40 — olay: {hakikiMumkun, orfMecaz}
theorem cat10 :
    ¬ Saglanabilir (hepsi [md12, md40, hakikiMumkun, orfMecaz]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md12, md40, hakikiMumkun, hakikiyeGore, orfMecaz] at *; revert h
  generalize v 51 = x51; generalize v 52 = x52; generalize v 56 = x56
  revert x51 x52 x56; decide

-- Ç10 çözümü: kısıtlanmış biçimlerle (md12r) olay tutarlıdır.
theorem cat10_cozum :
    Saglanabilir (hepsi [md12r, md40, hakikiMumkun, orfMecaz]) := ⟨model [51, 56], by decide⟩

-- Ç11. md. 12, md. 45 (+ K18, K19) — olay: {hakikiMumkun, orfMecaz}
theorem cat11 :
    ¬ Saglanabilir (hepsi [md12, md45, K18, K19, hakikiMumkun, orfMecaz]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md12, md45, K18, K19, hakikiMumkun, hakikiyeGore, orf, orfMecaz, orfeGore] at *; revert h
  generalize v 20 = x20; generalize v 21 = x21; generalize v 51 = x51; generalize v 52 = x52; generalize v 56 = x56
  revert x20 x21 x51 x52 x56; decide

-- md45 kısıtlı biçimini gerektirir (yalnız zayıflatma).
theorem md45_kisitlanir :
    Sonuc [md45] md45r := by
  intro v h
  have h0 := h md45 (by simp)
  simp only [hepsi, tepe, degil, deger, md45, md45r, galib, muttarid, orf, orfeGore, tasrih] at *; revert h0
  generalize v 20 = x20; generalize v 21 = x21; generalize v 25 = x25; generalize v 159 = x159; generalize v 160 = x160
  revert x20 x21 x25 x159 x160; decide

-- Ç11 çözümü: kısıtlanmış biçimlerle (md12r, md45r) olay tutarlıdır.
theorem cat11_cozum :
    Saglanabilir (hepsi [md12r, md45r, K18, K19, hakikiMumkun, orfMecaz]) := ⟨model [20, 25, 51, 56, 160], by decide⟩

-- Ç12. md. 13, md. 36 (+ K7) — olay: {orf, tasrih}
theorem cat12 :
    ¬ Saglanabilir (hepsi [md13, md36, K7, orf, tasrih]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md13, md36, K7, delaletGore, orf, orfeGore, tasrih] at *; revert h
  generalize v 20 = x20; generalize v 21 = x21; generalize v 25 = x25; generalize v 26 = x26
  revert x20 x21 x25 x26; decide

-- Ç12 çözümü: kısıtlanmış biçimlerle (md36r) olay tutarlıdır.
theorem cat12_cozum :
    Saglanabilir (hepsi [md13, md36r, K7, orf, tasrih]) := ⟨model [20, 25, 160], by decide⟩

-- Ç13. md. 13, md. 37 (+ K7) — olay: {tasrih, yayginKullanim}
theorem cat13 :
    ¬ Saglanabilir (hepsi [md13, md37, K7, tasrih, yayginKullanim]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md13, md37, K7, delaletGore, orfeGore, tasrih, yayginKullanim] at *; revert h
  generalize v 21 = x21; generalize v 25 = x25; generalize v 26 = x26; generalize v 154 = x154
  revert x21 x25 x26 x154; decide

-- md37 kısıtlı biçimini gerektirir (yalnız zayıflatma).
theorem md37_kisitlanir :
    Sonuc [md37] md37r := by
  intro v h
  have h0 := h md37 (by simp)
  simp only [hepsi, tepe, degil, deger, md37, md37r, orfeGore, tasrih, yayginKullanim] at *; revert h0
  generalize v 21 = x21; generalize v 25 = x25; generalize v 154 = x154
  revert x21 x25 x154; decide

-- Ç13 çözümü: kısıtlanmış biçimlerle (md37r) olay tutarlıdır.
theorem cat13_cozum :
    Saglanabilir (hepsi [md13, md37r, K7, tasrih, yayginKullanim]) := ⟨model [25, 154], by decide⟩

-- Ç14. md. 13, md. 45 (+ K7) — olay: {orf, tasrih}
theorem cat14 :
    ¬ Saglanabilir (hepsi [md13, md45, K7, orf, tasrih]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md13, md45, K7, delaletGore, orf, orfeGore, tasrih] at *; revert h
  generalize v 20 = x20; generalize v 21 = x21; generalize v 25 = x25; generalize v 26 = x26
  revert x20 x21 x25 x26; decide

-- Ç14 çözümü: kısıtlanmış biçimlerle (md45r) olay tutarlıdır.
theorem cat14_cozum :
    Saglanabilir (hepsi [md13, md45r, K7, orf, tasrih]) := ⟨model [20, 25, 160], by decide⟩

-- Ç15. md. 19, md. 26 — olay: {amm, has, mukabele, zarar}
theorem cat15 :
    ¬ Saglanabilir (hepsi [md19, md26, amm, has, mukabele, zarar]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md19, md26, amm, has, mukabele, tedbirCaiz, zarar] at *; revert h
  generalize v 10 = x10; generalize v 12 = x12; generalize v 15 = x15; generalize v 16 = x16; generalize v 17 = x17
  revert x10 x12 x15 x16 x17; decide

-- Ç15 çözümü: K3, K4, K5 bu olayı imkânsız kılar (kavram ayrımı).
theorem cat15_kopru :
    ¬ Saglanabilir (hepsi [K3, K4, K5, amm, has, mukabele, zarar]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, K3, K4, K5, amm, ehaf, has, misil, mukabele, zarar] at *; revert h
  generalize v 10 = x10; generalize v 13 = x13; generalize v 14 = x14; generalize v 15 = x15; generalize v 16 = x16; generalize v 17 = x17
  revert x10 x13 x14 x15 x16 x17; decide

-- Ç16. md. 19, md. 27 — olay: {ehaf, mukabele, zarar}
theorem cat16 :
    ¬ Saglanabilir (hepsi [md19, md27, ehaf, mukabele, zarar]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md19, md27, ehaf, mukabele, tedbirCaiz, zarar] at *; revert h
  generalize v 10 = x10; generalize v 12 = x12; generalize v 14 = x14; generalize v 17 = x17
  revert x10 x12 x14 x17; decide

-- Ç16 çözümü: K4, K5 bu olayı imkânsız kılar (kavram ayrımı).
theorem cat16_kopru :
    ¬ Saglanabilir (hepsi [K4, K5, ehaf, mukabele, zarar]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, K4, K5, ehaf, misil, mukabele, zarar] at *; revert h
  generalize v 10 = x10; generalize v 13 = x13; generalize v 14 = x14; generalize v 17 = x17
  revert x10 x13 x14 x17; decide

-- Ç17. md. 19, md. 28 (+ K22) — olay: {ehaf, mukabele, tearuz}
theorem cat17 :
    ¬ Saglanabilir (hepsi [md19, md28, K22, ehaf, mukabele, tearuz]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md19, md28, K22, ehaf, mukabele, tearuz, tedbirCaiz, tedbirGerekli] at *; revert h
  generalize v 12 = x12; generalize v 14 = x14; generalize v 17 = x17; generalize v 148 = x148; generalize v 149 = x149
  revert x12 x14 x17 x148 x149; decide

-- Ç17 çözümü: K4, K5 bu olayı imkânsız kılar (kavram ayrımı).
theorem cat17_kopru :
    ¬ Saglanabilir (hepsi [K22, K4, K5, ehaf, mukabele, tearuz]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, K22, K4, K5, ehaf, misil, mukabele, tearuz, tedbirCaiz, tedbirGerekli] at *; revert h
  generalize v 12 = x12; generalize v 13 = x13; generalize v 14 = x14; generalize v 17 = x17; generalize v 148 = x148; generalize v 149 = x149
  revert x12 x13 x14 x17 x148 x149; decide

-- Ç18. md. 19, md. 29 (+ K22) — olay: {ehaf, mukabele, tearuz}
theorem cat18 :
    ¬ Saglanabilir (hepsi [md19, md29, K22, ehaf, mukabele, tearuz]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md19, md29, K22, ehaf, mukabele, tearuz, tedbirCaiz, tedbirGerekli] at *; revert h
  generalize v 12 = x12; generalize v 14 = x14; generalize v 17 = x17; generalize v 148 = x148; generalize v 149 = x149
  revert x12 x14 x17 x148 x149; decide

-- Ç18 çözümü: K4, K5 bu olayı imkânsız kılar (kavram ayrımı).
theorem cat18_kopru :
    ¬ Saglanabilir (hepsi [K22, K4, K5, ehaf, mukabele, tearuz]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, K22, K4, K5, ehaf, misil, mukabele, tearuz, tedbirCaiz, tedbirGerekli] at *; revert h
  generalize v 12 = x12; generalize v 13 = x13; generalize v 14 = x14; generalize v 17 = x17; generalize v 148 = x148; generalize v 149 = x149
  revert x12 x13 x14 x17 x148 x149; decide

-- Ç19. md. 21, md. 22 — olay: {aslenMemnu, miktariAsar, zaruret}
theorem cat19 :
    ¬ Saglanabilir (hepsi [md21, md22, aslenMemnu, miktariAsar, zaruret]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md21, md22, aslenMemnu, miktariAsar, mubah, zaruret] at *; revert h
  generalize v 6 = x6; generalize v 7 = x7; generalize v 8 = x8; generalize v 9 = x9
  revert x6 x7 x8 x9; decide

-- md21 kısıtlı biçimini gerektirir (yalnız zayıflatma).
theorem md21_kisitlanir :
    Sonuc [md21] md21r := by
  intro v h
  have h0 := h md21 (by simp)
  simp only [hepsi, tepe, degil, deger, md21, md21r, aslenMemnu, miktariAsar, mubah, zaruret] at *; revert h0
  generalize v 6 = x6; generalize v 7 = x7; generalize v 8 = x8; generalize v 9 = x9
  revert x6 x7 x8 x9; decide

-- Ç19 çözümü: kısıtlanmış biçimlerle (md21r) olay tutarlıdır.
theorem cat19_cozum :
    Saglanabilir (hepsi [md21r, md22, aslenMemnu, miktariAsar, zaruret]) := ⟨model [6, 7, 9], by decide⟩

-- Ç20. md. 21, md. 96 — olay: {aslenMemnu, gayrinMali, zaruret, ¬izin}
theorem cat20 :
    ¬ Saglanabilir (hepsi [md21, md96, aslenMemnu, gayrinMali, zaruret, ∼izin]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md21, md96, aslenMemnu, gayrinMali, izin, mubah, zaruret] at *; revert h
  generalize v 6 = x6; generalize v 7 = x7; generalize v 8 = x8; generalize v 131 = x131; generalize v 133 = x133
  revert x6 x7 x8 x131 x133; decide

-- md96 kısıtlı biçimini gerektirir (yalnız zayıflatma).
theorem md96_kisitlanir :
    Sonuc [md96] md96r := by
  intro v h
  have h0 := h md96 (by simp)
  simp only [hepsi, tepe, degil, deger, md96, md96r, gayrinMali, izin, mubah, zaruret] at *; revert h0
  generalize v 6 = x6; generalize v 8 = x8; generalize v 131 = x131; generalize v 133 = x133
  revert x6 x8 x131 x133; decide

-- Ç20 çözümü: kısıtlanmış biçimlerle (md21r, md96r) olay tutarlıdır.
theorem cat20_cozum :
    Saglanabilir (hepsi [md21r, md96r, aslenMemnu, gayrinMali, zaruret, ∼izin]) := ⟨model [6, 7, 9, 131], by decide⟩

-- Ç21. md. 21, md. 97 — olay: {aslenMemnu, gayrinMali, zaruret, ¬mesruSebep}
theorem cat21 :
    ¬ Saglanabilir (hepsi [md21, md97, aslenMemnu, gayrinMali, zaruret, ∼mesruSebep]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md21, md97, aslenMemnu, gayrinMali, mesruSebep, mubah, zaruret] at *; revert h
  generalize v 6 = x6; generalize v 7 = x7; generalize v 8 = x8; generalize v 131 = x131; generalize v 139 = x139
  revert x6 x7 x8 x131 x139; decide

-- Ç21 çözümü: K36 bu olayı imkânsız kılar (kavram ayrımı).
theorem cat21_kopru :
    ¬ Saglanabilir (hepsi [K36, aslenMemnu, gayrinMali, zaruret, ∼mesruSebep]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, K36, aslenMemnu, gayrinMali, mesruSebep, zaruret] at *; revert h
  generalize v 6 = x6; generalize v 7 = x7; generalize v 131 = x131; generalize v 139 = x139
  revert x6 x7 x131 x139; decide

-- Ç22. md. 24, md. 51 — olay: {maniZail, sakit}
theorem cat22 :
    ¬ Saglanabilir (hepsi [md24, md51, maniZail, sakit]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md24, md51, avdet, maniZail, sakit] at *; revert h
  generalize v 22 = x22; generalize v 23 = x23; generalize v 24 = x24
  revert x22 x23 x24; decide

-- Ç22 çözümü: K6 bu olayı imkânsız kılar (kavram ayrımı).
theorem cat22_kopru :
    ¬ Saglanabilir (hepsi [K6, maniZail, sakit]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, K6, maniZail, sakit] at *; revert h
  generalize v 22 = x22; generalize v 24 = x24
  revert x22 x24; decide

-- Ç23. md. 25, md. 26 — olay: {amm, has, misil, zarar}
theorem cat23 :
    ¬ Saglanabilir (hepsi [md25, md26, amm, has, misil, zarar]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md25, md26, amm, has, misil, tedbirCaiz, zarar] at *; revert h
  generalize v 10 = x10; generalize v 12 = x12; generalize v 13 = x13; generalize v 15 = x15; generalize v 16 = x16
  revert x10 x12 x13 x15 x16; decide

-- Ç23 çözümü: K3, K4 bu olayı imkânsız kılar (kavram ayrımı).
theorem cat23_kopru :
    ¬ Saglanabilir (hepsi [K3, K4, amm, has, misil, zarar]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, K3, K4, amm, ehaf, has, misil, zarar] at *; revert h
  generalize v 10 = x10; generalize v 13 = x13; generalize v 14 = x14; generalize v 15 = x15; generalize v 16 = x16
  revert x10 x13 x14 x15 x16; decide

-- Ç24. md. 25, md. 27 — olay: {ehaf, misil, zarar}
theorem cat24 :
    ¬ Saglanabilir (hepsi [md25, md27, ehaf, misil, zarar]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md25, md27, ehaf, misil, tedbirCaiz, zarar] at *; revert h
  generalize v 10 = x10; generalize v 12 = x12; generalize v 13 = x13; generalize v 14 = x14
  revert x10 x12 x13 x14; decide

-- Ç24 çözümü: K4 bu olayı imkânsız kılar (kavram ayrımı).
theorem cat24_kopru :
    ¬ Saglanabilir (hepsi [K4, ehaf, misil, zarar]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, K4, ehaf, misil, zarar] at *; revert h
  generalize v 10 = x10; generalize v 13 = x13; generalize v 14 = x14
  revert x10 x13 x14; decide

-- Ç25. md. 25, md. 28 (+ K22) — olay: {ehaf, misil, tearuz}
theorem cat25 :
    ¬ Saglanabilir (hepsi [md25, md28, K22, ehaf, misil, tearuz]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md25, md28, K22, ehaf, misil, tearuz, tedbirCaiz, tedbirGerekli] at *; revert h
  generalize v 12 = x12; generalize v 13 = x13; generalize v 14 = x14; generalize v 148 = x148; generalize v 149 = x149
  revert x12 x13 x14 x148 x149; decide

-- Ç25 çözümü: K4 bu olayı imkânsız kılar (kavram ayrımı).
theorem cat25_kopru :
    ¬ Saglanabilir (hepsi [K22, K4, ehaf, misil, tearuz]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, K22, K4, ehaf, misil, tearuz, tedbirCaiz, tedbirGerekli] at *; revert h
  generalize v 12 = x12; generalize v 13 = x13; generalize v 14 = x14; generalize v 148 = x148; generalize v 149 = x149
  revert x12 x13 x14 x148 x149; decide

-- Ç26. md. 25, md. 29 (+ K22) — olay: {ehaf, misil, tearuz}
theorem cat26 :
    ¬ Saglanabilir (hepsi [md25, md29, K22, ehaf, misil, tearuz]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md25, md29, K22, ehaf, misil, tearuz, tedbirCaiz, tedbirGerekli] at *; revert h
  generalize v 12 = x12; generalize v 13 = x13; generalize v 14 = x14; generalize v 148 = x148; generalize v 149 = x149
  revert x12 x13 x14 x148 x149; decide

-- Ç26 çözümü: K4 bu olayı imkânsız kılar (kavram ayrımı).
theorem cat26_kopru :
    ¬ Saglanabilir (hepsi [K22, K4, ehaf, misil, tearuz]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, K22, K4, ehaf, misil, tearuz, tedbirCaiz, tedbirGerekli] at *; revert h
  generalize v 12 = x12; generalize v 13 = x13; generalize v 14 = x14; generalize v 148 = x148; generalize v 149 = x149
  revert x12 x13 x14 x148 x149; decide

-- Ç27. md. 33, md. 90 — olay: {digerMubasir, gayrinMali, mubasir, mutesebbib, zaruret}
theorem cat27 :
    ¬ Saglanabilir (hepsi [md33, md90, digerMubasir, gayrinMali, mubasir, mutesebbib, zaruret]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md33, md90, digerMubasir, gayrinMali, mubasir, mutesebbib, tazmin, zaruret] at *; revert h
  generalize v 6 = x6; generalize v 118 = x118; generalize v 126 = x126; generalize v 127 = x127; generalize v 129 = x129; generalize v 131 = x131
  revert x6 x118 x126 x127 x129 x131; decide

-- Ç27 çözümü: K34 bu olayı imkânsız kılar (kavram ayrımı).
theorem cat27_kopru :
    ¬ Saglanabilir (hepsi [K34, digerMubasir, gayrinMali, mubasir, mutesebbib, zaruret]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, K34, digerMubasir, gayrinMali, mubasir, mutesebbib, zaruret] at *; revert h
  generalize v 6 = x6; generalize v 126 = x126; generalize v 127 = x127; generalize v 129 = x129; generalize v 131 = x131
  revert x6 x126 x127 x129 x131; decide

-- Ç28. md. 33, md. 93 — olay: {gayrinMali, mubasir, mutesebbib, zaruret, ¬kast}
theorem cat28 :
    ¬ Saglanabilir (hepsi [md33, md93, gayrinMali, mubasir, mutesebbib, zaruret, ∼kast]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md33, md93, gayrinMali, kast, mubasir, mutesebbib, tazmin, zaruret] at *; revert h
  generalize v 6 = x6; generalize v 118 = x118; generalize v 126 = x126; generalize v 127 = x127; generalize v 128 = x128; generalize v 131 = x131
  revert x6 x118 x126 x127 x128 x131; decide

-- Ç28 çözümü: K34 bu olayı imkânsız kılar (kavram ayrımı).
theorem cat28_kopru :
    ¬ Saglanabilir (hepsi [K34, gayrinMali, mubasir, mutesebbib, zaruret, ∼kast]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, K34, gayrinMali, kast, mubasir, mutesebbib, zaruret] at *; revert h
  generalize v 6 = x6; generalize v 126 = x126; generalize v 127 = x127; generalize v 128 = x128; generalize v 131 = x131
  revert x6 x126 x127 x128 x131; decide

-- Ç29. md. 33, md. 94 — olay: {gayrinMali, hayvanKendiliginden, mubasir, zaruret}
theorem cat29 :
    ¬ Saglanabilir (hepsi [md33, md94, gayrinMali, hayvanKendiliginden, mubasir, zaruret]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md33, md94, gayrinMali, hayvanKendiliginden, mubasir, tazmin, zaruret] at *; revert h
  generalize v 6 = x6; generalize v 118 = x118; generalize v 126 = x126; generalize v 130 = x130; generalize v 131 = x131
  revert x6 x118 x126 x130 x131; decide

-- Ç29 çözümü: K37 bu olayı imkânsız kılar (kavram ayrımı).
theorem cat29_kopru :
    ¬ Saglanabilir (hepsi [K37, gayrinMali, hayvanKendiliginden, mubasir, zaruret]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, K37, gayrinMali, hayvanKendiliginden, mubasir, zaruret] at *; revert h
  generalize v 6 = x6; generalize v 126 = x126; generalize v 130 = x130; generalize v 131 = x131
  revert x6 x126 x130 x131; decide

-- Ç30. md. 36, md. 41 — olay: {orf, ¬galib, ¬muttarid}
theorem cat30 :
    ¬ Saglanabilir (hepsi [md36, md41, orf, ∼galib, ∼muttarid]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md36, md41, galib, muttarid, orf, orfeGore] at *; revert h
  generalize v 20 = x20; generalize v 21 = x21; generalize v 159 = x159; generalize v 160 = x160
  revert x20 x21 x159 x160; decide

-- Ç30 çözümü: kısıtlanmış biçimlerle (md36r) olay tutarlıdır.
theorem cat30_cozum :
    Saglanabilir (hepsi [md36r, md41, orf, ∼galib, ∼muttarid]) := ⟨model [20, 25], by decide⟩

-- Ç31. md. 37, md. 41 — olay: {yayginKullanim, ¬galib, ¬muttarid}
theorem cat31 :
    ¬ Saglanabilir (hepsi [md37, md41, yayginKullanim, ∼galib, ∼muttarid]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md37, md41, galib, muttarid, orfeGore, yayginKullanim] at *; revert h
  generalize v 21 = x21; generalize v 154 = x154; generalize v 159 = x159; generalize v 160 = x160
  revert x21 x154 x159 x160; decide

-- Ç31 çözümü: K39 bu olayı imkânsız kılar (kavram ayrımı).
theorem cat31_kopru :
    ¬ Saglanabilir (hepsi [K39, yayginKullanim, ∼galib, ∼muttarid]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, K39, galib, muttarid, yayginKullanim] at *; revert h
  generalize v 154 = x154; generalize v 159 = x159; generalize v 160 = x160
  revert x154 x159 x160; decide

-- Ç32. md. 37, md. 64 (+ K8) — olay: {mutlak, yayginKullanim, ¬orf, ¬tasrih}
theorem cat32 :
    ¬ Saglanabilir (hepsi [md37, md64, K8, mutlak, yayginKullanim, ∼orf, ∼tasrih]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md37, md64, K8, mutlak, mutlakGore, orf, orfeGore, tasrih, yayginKullanim] at *; revert h
  generalize v 20 = x20; generalize v 21 = x21; generalize v 25 = x25; generalize v 27 = x27; generalize v 28 = x28; generalize v 154 = x154
  revert x20 x21 x25 x27 x28 x154; decide

-- Ç32 çözümü: K24 bu olayı imkânsız kılar (kavram ayrımı).
theorem cat32_kopru :
    ¬ Saglanabilir (hepsi [K8, K24, mutlak, yayginKullanim, ∼orf, ∼tasrih]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, K8, K24, mutlak, mutlakGore, orf, orfeGore, tasrih, yayginKullanim] at *; revert h
  generalize v 20 = x20; generalize v 21 = x21; generalize v 25 = x25; generalize v 27 = x27; generalize v 28 = x28; generalize v 154 = x154
  revert x20 x21 x25 x27 x28 x154; decide

-- Ç33. md. 41, md. 45 — olay: {orf, ¬galib, ¬muttarid}
theorem cat33 :
    ¬ Saglanabilir (hepsi [md41, md45, orf, ∼galib, ∼muttarid]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md41, md45, galib, muttarid, orf, orfeGore] at *; revert h
  generalize v 20 = x20; generalize v 21 = x21; generalize v 159 = x159; generalize v 160 = x160
  revert x20 x21 x159 x160; decide

-- Ç33 çözümü: kısıtlanmış biçimlerle (md45r) olay tutarlıdır.
theorem cat33_cozum :
    Saglanabilir (hepsi [md41, md45r, orf, ∼galib, ∼muttarid]) := ⟨model [20, 25], by decide⟩

-- Ç34. md. 90, md. 92 — olay: {digerMubasir, mubasir, mutesebbib}
theorem cat34 :
    ¬ Saglanabilir (hepsi [md90, md92, digerMubasir, mubasir, mutesebbib]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md90, md92, digerMubasir, mubasir, mutesebbib, tazmin] at *; revert h
  generalize v 118 = x118; generalize v 126 = x126; generalize v 127 = x127; generalize v 129 = x129
  revert x118 x126 x127 x129; decide

-- Ç34 çözümü: K34 bu olayı imkânsız kılar (kavram ayrımı).
theorem cat34_kopru :
    ¬ Saglanabilir (hepsi [K34, digerMubasir, mubasir, mutesebbib]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, K34, digerMubasir, mubasir, mutesebbib] at *; revert h
  generalize v 126 = x126; generalize v 127 = x127; generalize v 129 = x129
  revert x126 x127 x129; decide

-- Ç35. md. 92, md. 93 — olay: {mubasir, mutesebbib, ¬kast}
theorem cat35 :
    ¬ Saglanabilir (hepsi [md92, md93, mubasir, mutesebbib, ∼kast]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md92, md93, kast, mubasir, mutesebbib, tazmin] at *; revert h
  generalize v 118 = x118; generalize v 126 = x126; generalize v 127 = x127; generalize v 128 = x128
  revert x118 x126 x127 x128; decide

-- Ç35 çözümü: K34 bu olayı imkânsız kılar (kavram ayrımı).
theorem cat35_kopru :
    ¬ Saglanabilir (hepsi [K34, mubasir, mutesebbib, ∼kast]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, K34, kast, mubasir, mutesebbib] at *; revert h
  generalize v 126 = x126; generalize v 127 = x127; generalize v 128 = x128
  revert x126 x127 x128; decide

-- Ç36. md. 92, md. 94 — olay: {hayvanKendiliginden, mubasir}
theorem cat36 :
    ¬ Saglanabilir (hepsi [md92, md94, hayvanKendiliginden, mubasir]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md92, md94, hayvanKendiliginden, mubasir, tazmin] at *; revert h
  generalize v 118 = x118; generalize v 126 = x126; generalize v 130 = x130
  revert x118 x126 x130; decide

-- Ç36 çözümü: K37 bu olayı imkânsız kılar (kavram ayrımı).
theorem cat36_kopru :
    ¬ Saglanabilir (hepsi [K37, hayvanKendiliginden, mubasir]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, K37, hayvanKendiliginden, mubasir] at *; revert h
  generalize v 126 = x126; generalize v 130 = x130
  revert x126 x130; decide

-- Ç37. md. 21, md. 33, md. 91 — olay: {aslenMemnu, gayrinMali, mubasir, zaruret}
theorem cat37 :
    ¬ Saglanabilir (hepsi [md21, md33, md91, aslenMemnu, gayrinMali, mubasir, zaruret]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md21, md33, md91, aslenMemnu, gayrinMali, mubah, mubasir, tazmin, zaruret] at *; revert h
  generalize v 6 = x6; generalize v 7 = x7; generalize v 8 = x8; generalize v 118 = x118; generalize v 126 = x126; generalize v 131 = x131
  revert x6 x7 x8 x118 x126 x131; decide

-- md91 kısıtlı biçimini gerektirir (yalnız zayıflatma).
theorem md91_kisitlanir :
    Sonuc [md91] md91r := by
  intro v h
  have h0 := h md91 (by simp)
  simp only [hepsi, tepe, degil, deger, md91, md91r, mubah, mubasir, tazmin] at *; revert h0
  generalize v 8 = x8; generalize v 118 = x118; generalize v 126 = x126
  revert x8 x118 x126; decide

-- Ç37 çözümü: kısıtlanmış biçimlerle (md21r, md91r) olay tutarlıdır.
theorem cat37_cozum :
    Saglanabilir (hepsi [md21r, md33, md91r, aslenMemnu, gayrinMali, mubasir, zaruret]) := ⟨model [6, 7, 9, 118, 126, 131], by decide⟩

-- Ç38. md. 21, md. 91, md. 92 — olay: {aslenMemnu, mubasir, zaruret}
theorem cat38 :
    ¬ Saglanabilir (hepsi [md21, md91, md92, aslenMemnu, mubasir, zaruret]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md21, md91, md92, aslenMemnu, mubah, mubasir, tazmin, zaruret] at *; revert h
  generalize v 6 = x6; generalize v 7 = x7; generalize v 8 = x8; generalize v 118 = x118; generalize v 126 = x126
  revert x6 x7 x8 x118 x126; decide

-- Ç38 çözümü: kısıtlanmış biçimlerle (md21r, md91r) olay tutarlıdır.
theorem cat38_cozum :
    Saglanabilir (hepsi [md21r, md91r, md92, aslenMemnu, mubasir, zaruret]) := ⟨model [6, 7, 9, 118, 126], by decide⟩

/-! ## 9. Bütün külliyat -/

-- Kısıtlanmış külliyat 39 köprüyle birlikte tutarlıdır.
theorem kulliyat_tutarli :
    Saglanabilir (hepsi (kulliyat ++ kopruler)) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

-- Uygulanabilirlik: her kuralın öncülü, bütün külliyat ve köprülerle birlikte gerçekleşebilir.
theorem uyg_md2_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [maksat])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md3_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [lafizFarkli])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md4_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(yakin ⋀ sek)])) := ⟨model [0, 1, 2, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md5_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(yakin ⋀ ∼degisimSabit)])) := ⟨model [0, 2, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md6r_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(kadim ⋀ ∼kadimZararli)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 42, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md7_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(kadim ⋀ kadimZararli)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md8_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [∼borcSabit])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md9_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [∼arizSabit])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md10_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(yakin ⋀ ∼degisimSabit)])) := ⟨model [0, 2, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md11_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(hadis ⋀ ∼uzakZamanSabit)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 50, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md12r_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [((hakikiMumkun ⋀ ∼orfMecaz) ⋀ ∼lafizFarkli)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 39, 40, 41, 43, 44, 47, 48, 49, 51, 52, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md13_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [tasrih])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md14_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [nas])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md15_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [kiyasaAykiri])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md16_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(ictihadlaHukum ⋀ yeniIctihad)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 101, 102, 103, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md17_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [mesakkat])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md18_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [mesakkat])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md19_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [mukabele])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md20r_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(zarar ⋀ defMumkun)])) := ⟨model [0, 3, 4, 5, 6, 10, 11, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 152, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md21r_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [((zaruret ⋀ aslenMemnu) ⋀ ∼miktariAsar)])) := ⟨model [0, 3, 4, 5, 6, 7, 8, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md22_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [((zaruret ⋀ aslenMemnu) ⋀ miktariAsar)])) := ⟨model [0, 3, 4, 5, 6, 7, 9, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md23_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(aslenMemnu ⋀ ∼zaruret)])) := ⟨model [0, 3, 4, 5, 7, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 131, 133, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md24_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [maniZail])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md25_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [misil])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md26_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [((zarar ⋀ amm) ⋀ has)])) := ⟨model [0, 3, 4, 5, 6, 10, 12, 14, 15, 16, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md27_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(zarar ⋀ ehaf)])) := ⟨model [0, 3, 4, 5, 6, 10, 12, 14, 16, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md28_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(tearuz ⋀ ehaf)])) := ⟨model [0, 3, 4, 5, 6, 10, 12, 14, 16, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 149, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md29_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(tearuz ⋀ ehaf)])) := ⟨model [0, 3, 4, 5, 6, 10, 12, 14, 16, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 149, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md30_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [defMenfaatTearuz])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md31_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(zarar ⋀ defMumkun)])) := ⟨model [0, 3, 4, 5, 6, 10, 11, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 152, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md32_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [hacet])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md33_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [((zaruret ⋀ gayrinMali) ⋀ mubasir)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 131, 133, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md34_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [almakMemnu])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md35_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [∼mubah])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md36r_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [((orf ⋀ ∼tasrih) ⋀ (muttarid ⋁ galib))])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 20, 21, 22, 23, 26, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md37r_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(yayginKullanim ⋀ ∼tasrih)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 20, 21, 22, 23, 26, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md38_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [adetenImkansiz])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md40_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [orfMecaz])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 20, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 56, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 154, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md41_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [orfeGore])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 21, 22, 23, 26, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md42_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [galib])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md42_1 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [nadir])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 159, 161, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md43_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [orfenMaruf])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 163, 164, 165, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md44_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [tuccarMaruf])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 163, 164, 165, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md45r_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [((orf ⋀ ∼tasrih) ⋀ (muttarid ⋁ galib))])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 20, 21, 22, 23, 26, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md46_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(muktezi ⋀ mani)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 167, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md47_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [tabi])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md48_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [tabi])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md49_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(malikX ⋀ zaruriyat)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 173, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md50_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [asilSakit])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md51_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [sakit])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 24, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md52_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [asilBatil])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md53_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [∼asilIfaMumkun])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md56_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [ibtidaenCaiz])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md57_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(teberru ⋀ ∼kabz)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 186, 187, 188, 189], by decide⟩

theorem uyg_md58_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(raiyyeTasarruf ⋀ ∼maslahat)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 189], by decide⟩

theorem uyg_md59_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(hasVelayet ⋀ ammVelayet)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191], by decide⟩

theorem uyg_md60_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(hakikiMumkun ⋁ mecazMumkun)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md61r_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(∼hakikiMumkun ⋀ mecazMumkun)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md62_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(∼hakikiMumkun ⋀ ∼mecazMumkun)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 55, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md63_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(bolunmez ⋀ baziZikr)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 58, 59, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md64_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [((mutlak ⋀ ∼tasrih) ⋀ ∼orf)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 26, 27, 28, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md65_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [hazir])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md65_1 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [∼hazir])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 61, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md66_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [sualOnay])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md67_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [sukut])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md67_1 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(sukut ⋀ hacetYeri)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 66, 67, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md68_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(batin ⋀ zahirDelil)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md69_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [mukatebe])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md70_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [dilsizIsaret])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md71_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [tercumanKavli])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md72_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(zann ⋀ hataZahir)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 78, 80, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md73_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [ihtimalDelilli])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md74_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [vehim])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 80, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md75_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [burhan])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md76_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [davaci])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md76_1 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [munkir])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md77_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [zahireAykiri])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md77_1 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [asliKoruyor])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md78_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [beyyineIle])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md78_1 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(ikrarIle ⋀ ∼beyyineIle)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 95, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md79_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [ikrarIle])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md80_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [tenakuz])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md80_1 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(tenakuz ⋀ oncekiHukum)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 100, 101, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md82_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [sartSabit])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md83_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(sartliAkit ⋀ riayetMumkun)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 112, 113, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md84_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(vaad ⋀ talik)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 115, 116, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md85_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [hasarAlici])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md87_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [yararAlici])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md88_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [hasarAlici])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md88_1 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [yararAlici])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md89_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [fail])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md89_1 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(emir ⋀ ∼icbar)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md90_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(mutesebbib ⋀ digerMubasir)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 117, 119, 120, 121, 122, 123, 124, 127, 128, 129, 130, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md91r_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(mubah ⋀ ∼mubasir)])) := ⟨model [0, 3, 4, 5, 6, 8, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 117, 119, 120, 121, 122, 123, 124, 127, 128, 130, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md92_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [mubasir])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md93_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(mutesebbib ⋀ ∼kast)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 117, 119, 120, 121, 122, 123, 124, 127, 130, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md94_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [hayvanKendiliginden])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 117, 119, 120, 121, 122, 123, 124, 127, 128, 130, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md95_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(gayrinMali ⋀ emir)])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 117, 119, 120, 121, 122, 123, 124, 127, 128, 130, 131, 133, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md96r_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [((gayrinMali ⋀ ∼izin) ⋀ ∼zaruret)])) := ⟨model [0, 3, 4, 5, 7, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 131, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md97_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [(gayrinMali ⋀ ∼mesruSebep)])) := ⟨model [0, 3, 4, 5, 7, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 131, 133, 135, 136, 137, 138, 140, 141, 142, 143, 144, 146, 148, 150, 151, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md98_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [sebepDegisti])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md99_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [istical])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

theorem uyg_md100_0 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [riza])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 35, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

-- Olanak kaideleri: söyledikleri olay külliyatla tutarlıdır.
-- md. 39: İki zaman arasındaki ilişki; önermeler mantığında yalnızca olanağı yazılabilir.
theorem olanak_md39 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [zamanDegisti, hukumDegisti])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 157, 158, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

-- md. 54: 'Caiz olabilir': bir olanak bildirir.
theorem olanak_md54 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [∼bizzatCaiz, tabi, caizHukum])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

-- md. 55: 'Caiz olabilir': bir olanak bildirir.
theorem olanak_md55 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [∼ibtidaenCaiz, bekaenCaiz])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 104, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

-- md. 81: 'Sabit olabilir': bir olanak bildirir.
theorem olanak_md81 :
    Saglanabilir (hepsi (kulliyat ++ kopruler ++ [∼asilSabit, ferSabit])) := ⟨model [0, 3, 4, 5, 6, 10, 13, 16, 17, 18, 19, 22, 23, 25, 27, 31, 32, 33, 37, 38, 39, 41, 43, 44, 47, 48, 49, 53, 54, 57, 60, 62, 63, 64, 68, 71, 72, 73, 74, 75, 76, 77, 79, 81, 83, 84, 85, 86, 87, 88, 89, 90, 91, 94, 95, 96, 97, 98, 102, 105, 106, 107, 109, 110, 111, 114, 118, 119, 120, 121, 122, 123, 124, 126, 129, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 146, 148, 150, 151, 153, 155, 156, 160, 162, 166, 168, 169, 170, 172, 174, 175, 176, 178, 181, 182, 183, 184, 185, 186, 187, 188, 189], by decide⟩

/-! ## 10. Kaide metinlerinin kendi örnekleri -/

-- Md. 8'in örneği: fazla borç iddia eden mal sahibi ispat eder.
theorem ornek8 :
    Sonuc [md8, md77, K13] ((∼borcSabit ⋀ borcIddia) ⟹ beyyineOna) := by
  intro v h
  have h0 := h md8 (by simp); have h1 := h md77 (by simp); have h2 := h K13 (by simp)
  simp only [hepsi, tepe, degil, deger, md8, md77, K13, asliKoruyor, beraat, beyyineOna, borcIddia, borcSabit, yeminOna, zahireAykiri] at *; revert h0 h1 h2
  generalize v 44 = x44; generalize v 45 = x45; generalize v 87 = x87; generalize v 88 = x88; generalize v 89 = x89; generalize v 90 = x90; generalize v 92 = x92
  revert x44 x45 x87 x88 x89 x90 x92; decide

-- Md. 9'un örneği: kâr iddia eden sermaye sahibi ispat eder.
theorem ornek9 :
    Sonuc [md9, md77, K14] ((∼arizSabit ⋀ arizIddia) ⟹ beyyineOna) := by
  intro v h
  have h0 := h md9 (by simp); have h1 := h md77 (by simp); have h2 := h K14 (by simp)
  simp only [hepsi, tepe, degil, deger, md9, md77, K14, arizIddia, arizSabit, arizYok, asliKoruyor, beyyineOna, yeminOna, zahireAykiri] at *; revert h0 h1 h2
  generalize v 46 = x46; generalize v 47 = x47; generalize v 87 = x87; generalize v 88 = x88; generalize v 89 = x89; generalize v 90 = x90; generalize v 93 = x93
  revert x46 x47 x87 x88 x89 x90 x93; decide

-- Md. 5 ile md. 77: değişimi iddia eden ispat eder.
theorem ornek5 :
    Sonuc [md5, md77, K12] (((yakin ⋀ ∼degisimSabit) ⋀ degisimIddia) ⟹ beyyineOna) := by
  intro v h
  have h0 := h md5 (by simp); have h1 := h md77 (by simp); have h2 := h K12 (by simp)
  simp only [hepsi, tepe, degil, deger, md5, md77, K12, asliKoruyor, beyyineOna, degisimIddia, degisimSabit, hukumA, yakin, yeminOna, zahireAykiri] at *; revert h0 h1 h2
  generalize v 0 = x0; generalize v 2 = x2; generalize v 3 = x3; generalize v 87 = x87; generalize v 88 = x88; generalize v 89 = x89; generalize v 90 = x90; generalize v 91 = x91
  revert x0 x2 x3 x87 x88 x89 x90 x91; decide

-- Md. 81'in örneği: kefilin ikrarı kefili bağlar, asıl borç sabit olmaz.
theorem ornek81 :
    Sonuc [md78, md79, K31, K32] (((kefalet ⋀ ikrarIle) ⋀ ∼beyyineIle) ⟹ (ferSabit ⋀ ∼asilSabit)) := by
  intro v h
  have h0 := h md78 (by simp); have h1 := h md79 (by simp); have h2 := h K31 (by simp); have h3 := h K32 (by simp)
  simp only [hepsi, tepe, degil, deger, md78, md79, K31, K32, asilSabit, baskasiBagli, beyyineIle, ferSabit, ikrarEdenBagli, ikrarIle, kefalet] at *; revert h0 h1 h2 h3
  generalize v 94 = x94; generalize v 95 = x95; generalize v 96 = x96; generalize v 97 = x97; generalize v 104 = x104; generalize v 105 = x105; generalize v 108 = x108
  revert x94 x95 x96 x97 x104 x105 x108; decide

-- Md. 33'ün örneği: aç kalan başkasının ekmeğini yer; fiil caizdir ama tazmin gerekir.
theorem ornek33 :
    Sonuc [md21r, md33] (((((zaruret ⋀ aslenMemnu) ⋀ ∼miktariAsar) ⋀ gayrinMali) ⋀ mubasir) ⟹ (mubah ⋀ tazmin)) := by
  intro v h
  have h0 := h md21r (by simp); have h1 := h md33 (by simp)
  simp only [hepsi, tepe, degil, deger, md21r, md33, aslenMemnu, gayrinMali, miktariAsar, mubah, mubasir, tazmin, zaruret] at *; revert h0 h1
  generalize v 6 = x6; generalize v 7 = x7; generalize v 8 = x8; generalize v 9 = x9; generalize v 118 = x118; generalize v 126 = x126; generalize v 131 = x131
  revert x6 x7 x8 x9 x118 x126 x131; decide

-- md. 81'in olayı, 'sabit olmamak' düşmek sayılırsa md. 50 ile çelişir.
theorem md81_md50_karisirsa :
    ¬ Saglanabilir (hepsi [md50, H1, H2, ∼asilSabit, ferSabit]) := by
  intro ⟨v, h⟩; simp only [hepsi, tepe, degil, deger, md50, H1, H2, asilSabit, asilSakit, ferSabit, ferSakit] at *; revert h
  generalize v 104 = x104; generalize v 105 = x105; generalize v 106 = x106; generalize v 107 = x107
  revert x104 x105 x106 x107; decide

-- Bu karışıklık olmadan md. 81'in olayı md. 50 ile tutarlıdır.
theorem md81_md50_ayrilinca :
    Saglanabilir (hepsi [md50, ∼asilSabit, ferSabit]) := ⟨model [105, 106, 107], by decide⟩

end Mecelle.Kulliyat
