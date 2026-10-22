#!/usr/bin/env python3
"""
Lean dosyalarındaki işaretli kesitleri kitap için ayrı dosyalara çıkarır.

    -- ANCHOR: ad
    ...kod...
    -- ANCHOR_END: ad

Kullanım:  python3 kesitleri_cikar.py <lean_kök_dizini> <çıktı_dizini>
Örnek:     python3 araclar/kesitleri_cikar.py lean/ModernMantik kitap/kesitler

Kitap derlenirken (minted için -shell-escape açıkken) bu betik
otomatik olarak çalıştırılır; elle çalıştırmak da mümkündür.
"""
import pathlib
import re
import sys

BAS = re.compile(r"^\s*--\s*ANCHOR:\s*(\S+)\s*$")
SON = re.compile(r"^\s*--\s*ANCHOR_END:\s*(\S+)\s*$")


def cikar(kok: pathlib.Path, cikti: pathlib.Path) -> int:
    sayac = 0
    for dosya in sorted(kok.rglob("*.lean")):
        goreli = dosya.relative_to(kok).with_suffix("")
        acik: dict[str, list[str]] = {}
        for satir in dosya.read_text(encoding="utf-8").splitlines():
            if m := BAS.match(satir):
                acik[m.group(1)] = []
                continue
            if m := SON.match(satir):
                ad = m.group(1)
                if ad not in acik:
                    sys.exit(f"HATA: {dosya}: '{ad}' için ANCHOR yok")
                hedef = cikti / goreli / f"{ad}.lean"
                hedef.parent.mkdir(parents=True, exist_ok=True)
                hedef.write_text("\n".join(acik.pop(ad)) + "\n", encoding="utf-8")
                sayac += 1
                continue
            for satirlar in acik.values():
                satirlar.append(satir)
        if acik:
            sys.exit(f"HATA: {dosya}: kapanmamış ANCHOR: {', '.join(acik)}")
    return sayac


if __name__ == "__main__":
    kok, cikti = map(pathlib.Path, sys.argv[1:3])
    n = cikar(kok, cikti)
    print(f"{n} kesit çıkarıldı -> {cikti}")
