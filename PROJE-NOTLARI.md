# Lean 4 ile Modern Mantık: proje notları

Bu dosya, kitabın yazıldığı sohbetin özetidir. Yeni bir sohbette ya da bir
Claude projesinin bilgi tabanında kullanılmak üzere hazırlanmıştır.

## Kimlik

- **Kitap:** *Lean 4 ile Modern Mantık. Ders Kitabı ve Araştırmacı El Kitabı*
- **Yazar:** İbrahim GÜNEY
- **Depo:** https://github.com/ibrahimguney/lean4-modern-mantik (herkese açık)
- **Durum:** Cilt I: Temeller, Sürüm 1.0 (Ekim 2026). 233 sayfa, 5 kısım, 17 bölüm.
  CI yeşil: bütün Lean kodu Lean 4.35.0 ve Mathlib v4.35.0 ile derleniyor.
- **Sıradaki iş:** Cilt II: İleri Konular.

## Kitabın omurgası

1. **Curry–Howard:** Önermeler tiplerdir, ispatlar programlardır. Bölüm 2'de
   sezgisel olarak tanıtılır, Bölüm 14'te teorem olarak ispatlanır.
2. **Yapıcı ve klasik mantık:** Bölüm 4'te açılır, Bölüm 16'da Diaconescu
   teoremiyle kapanır.
3. **Sığ ve derin gömme:** Önce Lean'in kendi mantığı kullanılır (Bölüm 1–9).
   Ardından nesne dili `Formul` olarak tanımlanır ve metateorisi kurulur
   (Bölüm 10–13).

## Cilt I'in içindekiler

| Kısım | Bölümler |
|---|---|
| I. Temeller | 1 Mantık ve ispat asistanı · 2 →, ∧, ∨ · 3 ¬, False, ↔ · 4 Yapıcı/klasik · 5 Doğal çıkarım |
| II. Yüklemler ve Tümevarım | 6 ∀, ∃, = · 7 Tümevarım · 8 Kümeler (Mathlib) · 9 Tümevarımsal tipler |
| III. Mantığın Matematiği | 10 Sözdizimi/anlambilim · 11 Geçerlilik · 12 Tamlık (Kalmár) · 13 Ardışık hesap, kesme eleme |
| IV. Tip Kuramı | 14 λ-hesabı, Curry–Howard · 15 Bağımlı tipler, çekirdek · 16 Aksiyomlar, Diaconescu |
| V. Projeler | 17 Projeler P1–P12 · Sonsöz: Cilt II'ye bakış |

## Cilt II'nin planı

Cilt I'deki `\ciltiki{n}` göndermeleri bu numaraları kullanır:

1. Birinci mertebe mantık: sözdizim, anlambilim, Gödel–Henkin tamlığı (Lean'de)
2. Kip mantığı, Kripke anlambilimi, sezgici mantığın S4'e gömülmesi
3. Kanıtlanabilirlik mantığı (GL)
4. Gödel'in eksiklik teoremleri
5. Küme kuramı, modeller, bağımsızlık
6. Karar verilebilirlik ve otomasyon: SAT/SMT, `omega`, `bv_decide`, yansıma
7. Metaprogramlama: kendi taktiğini yazmak
8. Yapay zekâ ve otomatik teorem ispatı
9. Büyük formalizasyon projeleri ve araştırma projeleri

Eski bölüm planları `cilt2-taslak/` klasöründedir.

## Teknik kurallar

**LaTeX**
- XeLaTeX, polyglossia (Türkçe), minted ve özel `stil/leankitap.py` sözcük çözümleyicisi.
- Kod kutuları için tcolorbox, çıkarım ağaçları için ebproof, şekiller için TikZ,
  kaynakça için natbib/plainnat.
- Yazı tipleri: TeX Gyre Pagella ve Heros, DejaVu Sans Mono.
  `⋀ ⋁ ⟹ ⊨` sembolleri için `\sembolkodfont` kullanılır.
- `\lc{...}` içinde bu semboller `{\sembolkodfont ⋀}` biçiminde yazılmalıdır.
- Başlıklarda ve şekil yazılarında Unicode Yunan harfleri kullanılır (`$λ$`, `$β$`).
  `$\lambda$` bölüm başlığında hata verir.

**Kodun tek kaynağı**
- Kitaptaki her kod parçası `lean/ModernMantik/` içindeki Lean dosyalarında durur.
- Kod `-- ANCHOR: ad` ve `-- ANCHOR_END: ad` satırları arasına yazılır.
- LaTeX'te `\leandosya[Başlık]{BolumNN}{ad}` ile çağrılır.
- Lean dosyası değişince `python3 araclar/kesitleri_cikar.py lean/ModernMantik kitap/kesitler`
  çalıştırılır, sonra `latexmk -g` ile derleme zorlanır.

**Bölüm yapısı**
1. `bolumhedefleri`
2. Kâğıt üzerinde anlatım ve ebproof ağaçları
3. `\leandosya` ile Lean kodu
4. TikZ şekilleri
5. `onemlifikir`, `dikkat`, `tarihce` kutuları
6. `arastirmanotu`, `bolumozeti`
7. `alistirmalar`: ★ zorluk dereceleri, `aNN_k` adları

**Lean**
- Her bölüm için üç dosya vardır: `BolumNN.lean`, `Alistirmalar/BolumNN.lean`
  (`sorry`'li) ve `Cozumler/BolumNN.lean`.
- Yeni dosyalar `ModernMantik.lean` içinde içe aktarılmalıdır.
- `Bolum*` ve `Cozumler` dosyalarında `sorry` yasaktır; CI bunu denetler.

**Lean 4.35'te öğrenilenler**
- `∼` (öncelik 40) ile `::` ya da `=` birlikte kullanılırken parantez gerekir:
  `(∼A) :: Γ`.
- `injection h with h'`, sonuç hedefle aynıysa hedefi kendiliğinden kapatır.
- Kendi tanımladığımız ilişkilerde nokta gösterimi (`h.symm`) çalışmaz; `Eq.symm h` yazılır.

**Derleme**
- Mathlib'e bağlı olmayan modüller yerelde Lean 4.35.0 ile derlenebilir.
- Lean, GitHub releases üzerinden indirilip python zstandard ile açılabilir.
- CI: `.github/workflows/derle.yml` iki iş çalıştırır: Lean (elan, `lake update`,
  `cache get`, `build`) ve kitap (Ubuntu 24.04 TeX Live). Lean hataları dosya
  ve satır işaretine dönüştürülür.

## Yazım üslubu

- Türkçe, akademik ama sıcak bir dil.
- Her kavram önce kâğıt üzerinde, sonra Lean'de, sonra bir şekille anlatılır.
- Terimler `ekler/sozluk.tex` içinde Türk alfabesine göre sıralanır; her yeni
  bölümde güncellenir.
- Her bölümde güncel kaynaklar kullanılır: arXiv ve hakemli yayınlar.
  Bibliyografik bilgiler kaynağından doğrulanır.
