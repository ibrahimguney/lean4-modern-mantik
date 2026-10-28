# Mecelle pilot çalışması: derlem, atom sözlüğü ve bulgular

*Çalışma notu, 28 Ekim 2026. Lean kodu: `lean/ModernMantik/Mecelle/Pilot.lean`
(Lean 4.35.0 ile derleniyor, `sorry` yok).*

## 1. Kaynaklar ve doğrulama durumu

| Kısaltma | Kaynak | Ne için | Durum |
|---|---|---|---|
| **B** | Mecelle, M. Balcı'nın web baskısı; A. H. Berki, *Açıklamalı Mecelle* esas alınmış (muharrembalci.com, teblig 264) | Türkçe metin: md. 5, 20–22, 25–30 | Ara kaynak. Berki'nin basılı nüshasıyla karşılaştırılacak |
| **K** | Kaya Kartal, "İslâm Hukukunda ve Mecelle'de Küllî Kâideler" (Genç Hukukçular, Hukuk Okumaları) | Türkçe metin: md. 2, 4, 17, 19, 36 | Yıl ve yayın bilgisi eksik `[DOĞRULANACAK]` |
| **M** | majalla.org, "Maxims of Islamic Jurisprudence" | İngilizce metin | Çevirmen belirtilmemiş. Tyser–Demetriades–Haqqi (1901) ile karşılaştırılacak `[DOĞRULANACAK]` |
| **F** | Mecelle, 1887 baskısı (Osmanlıca, Arap harfli), archive.org `mecelleyiahkmiad00turk`, Ohio State Univ. | Asıl metin | Erişilebilir. Pilot metinler henüz bununla karşılaştırılmadı |

> İngilizce bir dergi için asıl atıf C. R. Tyser, D. G. Demetriades ve
> İsmail Haqqı Efendi, *The Mejelle* (Lefkoşa, 1901) olmalı. Bu çevirinin
> taranmış bir nüshası bulunup İngilizce metinler ondan alınacak.

## 2. Derlem (12 kaide)

| Md. | Türkçe metin | İngilizce | Kaynak | Tür | İçerik grubu |
|---|---|---|---|---|---|
| 2 | Bir işten maksad ne ise hüküm ona göredir. | A matter is determined according to intention. | K, M | şema | niyet ★ |
| 4 | Şek ile yakîn zâil olmaz. | Certainty is not dispelled by doubt. | K, M | koşullu kural | yakîn ★ |
| 5 | Bir şeyin bulunduğu hal üzere kalması asıldır. | A thing shall remain as it was originally. | B, M | karine (asıl) | yakîn |
| 17 | Meşakkat teysiri celb eder. | Difficulty begets facility. | K, M | koşullu kural | meşakkat ★ |
| 19 | Zarar ve mukabele-bizzarar yoktur. | Injury may not be met by injury. | K, M | yasak (iki yarım) | zarar |
| 20 | Zarar izâle olunur. | Injury is removed. | B, M | koşullu kural | zarar ★ |
| 21 | Zaruretler, memnu olan şeyleri mübah kılar. | Necessity renders prohibited things permissible. | B, M | koşullu kural | meşakkat / zarar `[?]` |
| 22 | Zaruretler kendi miktarlarınca takdir olunur. | Necessity is estimated by the extent thereof. | B, M | istisna (tahsis) | meşakkat / zarar `[?]` |
| 25 | Bir zarar kendi misli ile izale olunamaz. | An injury cannot be removed by the commission of a similar injury. | B, M | yasak | zarar |
| 26 | Zarar-ı âmmı def için zarar-ı has ihtiyar olunur. | A private injury is tolerated in order to ward off a public injury. | B, M | öncelik kaidesi | zarar |
| 27 | Zarar-ı eşed zarar-ı ehaf ile izâle olunur. | Severe injury is removed by lesser injury. | B, M | öncelik kaidesi | zarar |
| 36 | Âdet muhakkemdir. | Custom is an arbitrator. | K, M | koşullu kural | örf ★ |

★ Geleneğin "beş temel kaide" saydığı maddeler.
`[?]` md. 21–22'nin hangi büyük kaidenin altında sayıldığı kaynaktan kaynağa
değişiyor. Kaynakla doğrulanacak.

## 3. Okuma ilkesi

Bir külli kaide bütün olaylar hakkındadır. Önermeler mantığında onu **tek bir
olay** için yazıyoruz: atomlar, ele alınan bir olayın özelliklerini anlatır.
Her formül, kaide şemasının o olaydaki örneğidir. Kaideler kümesinin
tutarlılığı ve türetilebilirlik ilişkileri bu yüzden "her olay için" sorulur.
Bu sorular `Sonuc` ve `Saglanabilir` ile tam olarak ifade edilebilir.

## 4. Atom sözlüğü

| Atom | No | Anlamı | Maddeler |
|---|---|---|---|
| `yakin` | 0 | Önceki hâl (A) kesin olarak sabittir | 4, 5 |
| `sek` | 1 | A'nın kalktığına dair yalnızca şek vardır | 4 |
| `hukumA` | 2 | A'nın devam ettiğine hükmolunur | 4, 5 |
| `degisimSabit` | 3 | A'nın kalktığı delille sabittir | 5 |
| `mesakkat` | 4 | Fiilde meşakkat vardır | 17 |
| `teysir` | 5 | Kolaylık (ruhsat) tanınır | 17 |
| `zaruret` | 6 | Zaruret hâli vardır | 21, 22 |
| `aslenMemnu` | 7 | Fiil aslen yasaktır | 21, 22 |
| `mubah` | 8 | Fiil bu olayda mübahtır | 21, 22 |
| `miktariAsar` | 9 | Fiil zaruretin miktarını aşar | 22 |
| `zarar` | 10 | Giderilmesi istenen bir zarar Z vardır | 20, 26, 27 |
| `izale` | 11 | Z'nin giderilmesine hükmolunur | 20 |
| `tedbirCaiz` | 12 | Z'yi gidermek için önerilen T tedbiri caizdir | 19, 25, 26, 27 |
| `misil` | 13 | T'nin zararı Z'nin dengidir | 25 |
| `ehaf` | 14 | T'nin zararı Z'den hafiftir | 27 |
| `amm` | 15 | Z âmm (genel) bir zarardır | 26 |
| `has` | 16 | T'nin zararı hâs (özel) bir zarardır | 26 |
| `mukabele` | 17 | T, zarara zararla karşılık vermektir | 19 |
| `maksat` | 18 | Fiil M maksadıyla yapılmıştır | 2 |
| `hukumM` | 19 | Fiile M maksadına uygun hüküm bağlanır | 2 |
| `orf` | 20 | Konuda yerleşik bir örf vardır | 36 |
| `orfeGore` | 21 | Hüküm örfe göre verilir | 36 |

Kip ifadeleri (caiz, mübah, memnu) bu aşamada atomdur. Bunun bedeli bulgularda
açıkça görülüyor (B7). Deontik mantığa geçiş makalenin "gelecek çalışmalar"
bölümüne kalıyor.

## 5. Formüller ve köprü ilkeleri

| Md. | Formül | Not |
|---|---|---|
| 2 | `maksat ⟹ hukumM` | Şema; her maksat için ayrı bir örnek |
| 4 | `yakin ⋀ sek ⟹ hukumA` | |
| 5 | `yakin ⋀ ∼degisimSabit ⟹ hukumA` | |
| 17 | `mesakkat ⟹ teysir` | |
| 19 | `mukabele ⟹ ∼tedbirCaiz` | Yalnız ikinci yarı. İlk yarı ("zarar yoktur") ayrı bir yasak, bu olay modelinde yok |
| 20 | `zarar ⟹ izale` | |
| 21 | `zaruret ⋀ aslenMemnu ⟹ mubah` | Harfî okuma. Tahsisli hâli B5'te |
| 22 | `zaruret ⋀ aslenMemnu ⋀ miktariAsar ⟹ ∼mubah` | |
| 25 | `misil ⟹ ∼tedbirCaiz` | |
| 26 | `zarar ⋀ amm ⋀ has ⟹ tedbirCaiz` | |
| 27 | `zarar ⋀ ehaf ⟹ tedbirCaiz` | |
| 36 | `orf ⟹ orfeGore` | Nassa aykırı örf istisnası şerhlerde var, metinde yok |

**Köprü ilkeleri.** Bunlar metinde açıkça yazmaz. Her biri bir yorumdur ve
makalede ayrı ayrı gerekçelendirilmelidir.

| Ad | Formül | Okuma |
|---|---|---|
| K1 | `sek ⟹ ∼degisimSabit` | Yalnız şek, değişimi ispat etmez |
| K2 | `zaruret ⟹ mesakkat` | Zaruret, meşakkatin en ağır derecesidir |
| K3 | `amm ⋀ has ⟹ ehaf` | Hâs zarar, âmm zarara göre hafiftir `[şerhte doğrulanacak]` |
| K4 | `∼(misil ⋀ ehaf)` | İki zarar hem denk hem farklı olamaz |
| K5 | `mukabele ⟹ misil` | Misilleme, denk zararla karşılık vermektir |

## 6. Bulgular

Bütün bulgular Lean'de makinece denetlendi.

| No | Sonuç | Lean adı |
|---|---|---|
| B1 | 12 kaide birlikte tutarlıdır. Bu sonuç önemsizdir, çünkü hiçbir koşulun gerçekleşmediği boş olay bir modeldir. Asıl sorular olay betimleriyle sorulur. | `pilot_tutarli` |
| B2 | **md. 4, md. 5 ile K1'den çıkar.** | `md4_md5ten` |
| B3 | Tersi doğru değildir: md. 5, md. 4 ile K1'den çıkmaz. | `md5_md4ten_cikmaz` |
| B4 | md. 21 harfiyen okunursa, zaruret miktarını aşan bir olayda md. 22 ile çatışır. | `md21_md22_catisir` |
| B5 | md. 22, md. 21'i tahsis eder. İstisna md. 21'in koşuluna yazılınca çatışma kalkar. md. 21 tahsisli hâlini gerektirir. | `tahsis_tutarli`, `md21_md21tyi_gerektirir` |
| B6 | md. 21, md. 17'nin bir örneği değildir. K2 kabul edilse bile çıkmaz. | `md21_md17den_cikmaz` |
| B7 | md. 25 ile md. 27, tedbirin zararı hem denk hem hafif sayılırsa çatışır. Önermeler mantığı bu iki kavramın birbirini dışladığını bilmez; bunu K4 eklemek gerekir. | `md25_md27_catisir` |
| B8 | md. 25 ile md. 26 da çatışabilir: âmm bir zararı, ona denk bir hâs zararla gidermek. | `md25_md26_catisir` |
| B9 | K3 ile K4 bu çatışma olayını dışlar. | `K3_K4_catismayi_dislar` |
| B10 | md. 26, md. 27'den K3 ile çıkar. K3 olmadan çıkmaz. | `md26_md27den`, `md26_yalniz_md27den_cikmaz` |
| B11 | md. 19'un ikinci yarısı, md. 25'ten K5 ile çıkar. Tersi çıkmaz. | `md19_md25ten`, `md25_md19dan_cikmaz` |
| B12 | Beş temel kaide (md. 2, 4, 17, 20, 36) birbirinden bağımsızdır. | `md2_bagimsiz` … `md36_bagimsiz` |
| B13 | md. 20, bütün pilot kaidelerden ve köprülerden bile çıkmaz. | `md20_her_seyden_bagimsiz` |
| Vaka | Ehil olmayan hekimin men edilmesi: zarar kaideleri ve köprülerle tedbirin caiz olduğu sonucu çıkar, olay betimi tutarlıdır. | `hekim_men_caiz`, `hekim_olayi_tutarli` |

### Makale için en ilgi çekici iki sonuç

1. **Yön tersine dönüyor (B2–B3).** Gelenek md. 5'i (istishab) md. 4'ün
   (yakîn) altında bir alt kaide olarak sayar `[şerhte doğrulanacak]`. Bizim okumamızda ise md. 4,
   md. 5'ten tek bir köprüyle çıkıyor. Tersi ise çıkmıyor. Bu sonuç atom
   seçimine bağlıdır ve bu açıkça yazılmalıdır. Yine de gelenekteki
   "kapsayan–kapsanan" ilişkisinin mantıksal türetilebilirlikle örtüşmediğini
   gösteren somut bir örnek.
2. **Öncelik kaideleri gizli bir sıralama yapısı taşıyor (B7–B10).**
   md. 25–27 arasındaki çatışmaları çözmek için zararların karşılaştırılmasına
   dair varsayımlar (K3, K4) gerekiyor. Önermeler mantığı bunları ifade
   edebilir, ama yapıyı göremez. "Denk", "hafif" ve "ağır" bir sıralama
   ilişkisidir. Bu, birinci mertebe mantığa ya da tercih mantığına geçişin
   doğal gerekçesi.

## 7. Mantıksal gruplandırma (ortak atom bileşenleri)

| | Bileşenler |
|---|---|
| Köprüsüz | {2} · {4, 5} · {17} · {21, 22} · {19, 20, 25, 26, 27} · {36} |
| Köprülü | {2} · {4, 5} · {17, 21, 22} · {19, 20, 25, 26, 27} · {36} |

İçerik gruplandırmasıyla karşılaştırma: Beş temel kaidenin her biri ayrı bir
bileşende duruyor. md. 21–22 ise yalnızca K2 köprüsüyle meşakkat grubuna
bağlanıyor. Köprüsüz hâlde ayrı bir grup oluşturuyorlar. Bu durum,
gelenekteki yerleştirme tartışmasıyla (§2, `[?]`) karşılaştırılmaya değer.

## 8. Sıradaki adımlar

1. İngilizce metinleri Tyser (1901) nüshasından al, Türkçe metinleri Berki'den
   ya da 1887 baskısından doğrula.
2. K1–K5'i Ali Haydar Efendi'nin *Dürerü'l-Hükkâm* şerhiyle gerekçelendir.
3. Derlemi 99 kaideye genişlet. Önce md. 28–30 (öncelik), md. 85–93
   (tazmin), md. 74–77 (delil). Bunlar Gasb ve İtlâf kitabına köprü olacak.
4. Gruplandırmayı otomatikleştir: Lean'de atomları `#eval` ile çıkaran ve
   türetilebilirlik grafiğini kuran bir araç yaz.
