# Lean 4 ile Modern Mantık — Cilt I: Temeller

**İbrahim GÜNEY**

*Ders Kitabı ve Araştırmacı El Kitabı* — kaynak deposu

Bu depo iki ciltlik dizinin **Cilt I**'ini içerir (17 bölüm, 5 kısım).
Cilt II (İleri Konular) için eski taslak planlar `cilt2-taslak/` klasöründedir.

```
lean4-modern-mantik/
├── kitap/                 LaTeX kaynağı
│   ├── ana.tex            ana dosya (kısımlar ve bölümler buradan bağlanır)
│   ├── kaynakca.bib       kaynakça
│   ├── latexmkrc          derleme ayarları
│   ├── stil/
│   │   ├── kitap-stil.tex sayfa düzeni, yazı tipleri, kutular, alıştırmalar
│   │   ├── lean-stil.tex  Lean kod kutuları, hedef durumu, renkler
│   │   └── leankitap.py   kitaba özel Pygments sözcük çözümleyicisi
│   ├── on/                kapak, önsöz, okuma kılavuzu
│   ├── bolumler/          bolum01.tex … bolum17.tex (17: Projeler + Sonsöz)
│   └── ekler/             Lean başvuru tablosu, terim sözlüğü
├── lean/                  eşlik eden Lake projesi
│   ├── ModernMantik/      BolumNN.lean (kitaptaki kod burada yaşar)
│   │   ├── Alistirmalar/  sorry'li alıştırma iskeletleri + Projeler.lean (P1–P12)
│   │   └── Cozumler/      eğitmen çözümleri
│   ├── lakefile.toml
│   └── lean-toolchain
├── cilt2-taslak/          Cilt II için eski bölüm planları (derlenmez)
├── araclar/
│   └── kesitleri_cikar.py Lean dosyalarındaki ANCHOR kesitlerini kitaba aktarır
└── .github/workflows/derle.yml   Lean + kitap için CI
```

## Kitabı derlemek

Gerekenler: TeX Live (XeLaTeX, minted, tcolorbox, polyglossia, ebproof),
Python 3 ve Pygments.

```bash
cd kitap
latexmk          # latexmkrc: XeLaTeX + -shell-escape + BibTeX
```

`-shell-escape`, minted'in Pygments'i çağırabilmesi ve Lean kesitlerinin
derleme başında otomatik olarak çıkarılabilmesi için gereklidir.

## Lean kodunu denetlemek

Bölüm 8'den itibaren proje **Mathlib**'e bağlıdır. Lean sürümü (`lean/lean-toolchain`)
ve Mathlib sürümü (`lean/lakefile.toml` içindeki `rev`) birlikte **v4.35.0**'a
sabitlenmiştir. İlk kurulumda:

```bash
cd lean
lake update          # lake-manifest.json üretir (Mathlib v4.35.0 ve bağımlılıkları)
lake exe cache get   # Mathlib'in önceden derlenmiş dosyaları
lake build           # kitabın bütün kodunu denetle
```

Sürümü yükseltmek için `lean-toolchain` ile `rev` değerini aynı Mathlib
etiketine birlikte çekin ve yukarıdaki üç komutu yeniden çalıştırın.

`lake exe cache get` adımını atlamayın: Mathlib'i sıfırdan derlemek
saatler sürer.

Ana bölüm dosyalarında ve çözümlerde `sorry` bulunmamalıdır; CI bunu denetler.
Alıştırma dosyalarındaki ve `Alistirmalar/Projeler.lean` içindeki `sorry`
uyarıları beklenen durumdur.

## Kod tek bir yerde yaşar

Kitaba basılan her Lean kodu `lean/ModernMantik/` içindeki dosyalarda
işaretlenir:

```lean
-- ANCHOR: hipotetik_kiyas
theorem hipotetik_kiyas ... := by
  ...
-- ANCHOR_END: hipotetik_kiyas
```

LaTeX tarafında şöyle çağrılır:

```latex
\leandosya[Hipotetik kıyas]{Bolum02}{hipotetik_kiyas}
```

Böylece kitapta basılı kod ile `lake build` ile denetlenen kod her zaman
aynıdır. Derlenmesi istenmeyen kodlar (ör. bilerek yazılmış hatalı örnekler)
için `\begin{leankod} ... \end{leankod}` kullanılır.

## Yeni bölüm yazarken

Her bölüm şu yapıyı izler:

1. `bolumhedefleri` kutusu
2. Kâğıt-kalem mantık: tanım, kural, `ebproof` ile çıkarım ağacı
3. Lean karşılığı: `\leandosya`, `hedefdurumu`, `\begin{hedefgecisi}…\sonra…\end{hedefgecisi}`
4. TikZ görseli
5. Taktik ve terim modu yan yana
6. `arastirmanotu`, `bolumozeti`, `alistirmalar`

Kutu ortamları: `tanim`, `teorem`, `ornek` (numaralı); `onemlifikir`,
`gunlukornek`, `dikkat`, `tarihce`, `arastirmanotu` (numarasız).

## Yapılacaklar

- [x] Lean ve Mathlib v4.35.0'a sabitlendi.
- [ ] İlk başarılı CI çalışmasından sonra `lake-manifest.json`'ı depoya ekle.
- [x] Mathlib bağımlılığı eklendi (Bölüm 8).
- [x] Kaynakçadaki doğrulama bekleyen girdiler kontrol edildi (Ekim 2026).
- [x] Cilt I tamamlandı: Kısım I–IV (Bölüm 1–16) ve Kısım V (Bölüm 17: Projeler, Sonsöz).
- [x] Cilt I: bütün Lean kodu Lean 4.35.0 + Mathlib v4.35.0 ile derleniyor (CI yeşil).
- [x] Cilt I: yazar adı eklendi (İbrahim GÜNEY).
- [ ] Cilt II: ayrı bir depo/kök dosya (`cilt2/ana.tex`) olarak başlat;
      Cilt I'deki `\ciltiki{n}` göndermeleri Cilt II'nin bölüm numaralarına uyar.
