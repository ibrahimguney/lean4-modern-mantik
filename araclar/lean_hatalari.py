#!/usr/bin/env python3
"""
`lake build` çıktısındaki hataları GitHub Actions'ın anlayacağı biçime çevirir:
  * her hata için bir `::error file=…,line=…,col=…::…` satırı (dosyada işaretlenir)
  * iş özetine ($GITHUB_STEP_SUMMARY) okunaklı bir tablo

Kullanım:  python3 araclar/lean_hatalari.py lean/build.log
"""
import os
import re
import sys

BAS = re.compile(r"^(error|warning): (?:\./)*(?:.*?/)?(ModernMantik/.*?\.lean):(\d+):(\d+): (.*)$")
SINIR = 50  # GitHub bir adımda en çok 50 hata işaretini saklar


def oku(yol):
    hatalar, simdiki = [], None
    for satir in open(yol, encoding="utf-8", errors="replace"):
        satir = satir.rstrip("\n")
        m = BAS.match(satir)
        if m:
            if simdiki:
                hatalar.append(simdiki)
            tur, dosya, sat, sut, mesaj = m.groups()
            simdiki = [tur, "lean/" + dosya, int(sat), int(sut), [mesaj]] if tur == "error" else None
        elif simdiki is not None:
            if satir.startswith(("✖", "⚠", "✔", "info:", "Some required", "error: Lean exited", "error: build failed")):
                hatalar.append(simdiki)
                simdiki = None
            else:
                simdiki[4].append(satir)
    if simdiki:
        hatalar.append(simdiki)
    return hatalar


def main():
    hatalar = oku(sys.argv[1])
    for _, dosya, sat, sut, mesaj in hatalar[:SINIR]:
        govde = "\n".join(mesaj).strip().replace("%", "%25").replace("\r", "").replace("\n", "%0A")
        print(f"::error file={dosya},line={sat},col={sut}::{govde}")
    ozet = os.environ.get("GITHUB_STEP_SUMMARY")
    if ozet:
        with open(ozet, "a", encoding="utf-8") as f:
            f.write(f"## Lean derleme hataları: {len(hatalar)}\n\n")
            for _, dosya, sat, sut, mesaj in hatalar[:200]:
                f.write(f"**{dosya}:{sat}:{sut}**\n```\n" + "\n".join(mesaj).strip() + "\n```\n")
    print(f"{len(hatalar)} hata bulundu.", file=sys.stderr)


if __name__ == "__main__":
    main()
