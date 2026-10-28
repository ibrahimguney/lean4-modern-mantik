// Mecelle makalesi: Word taslağını üretir.  node makale.js
const fs = require("fs");
const path = require("path");
const {
  Document, Packer, Paragraph, TextRun, HeadingLevel, AlignmentType, Table, TableRow,
  TableCell, WidthType, BorderStyle, ShadingType, ImageRun, Footer, Header, PageNumber,
  LevelFormat, PageBreak,
} = require("docx");

const SERIF = "Times New Roman";
const MONO = "Courier New";

// ---------- satır içi biçim: *italik*, **kalın**, `kod` ----------
function runs(text, base = {}) {
  const out = [];
  const re = /(\*\*[^*]+\*\*|\*[^*]+\*|`[^`]+`)/g;
  let last = 0, m;
  while ((m = re.exec(text)) !== null) {
    if (m.index > last) out.push(new TextRun({ text: text.slice(last, m.index), ...base }));
    const t = m[0];
    if (t.startsWith("**")) out.push(new TextRun({ text: t.slice(2, -2), bold: true, ...base }));
    else if (t.startsWith("`")) out.push(new TextRun({ text: t.slice(1, -1), font: MONO, size: 20, ...base }));
    else out.push(new TextRun({ text: t.slice(1, -1), italics: true, ...base }));
    last = m.index + t.length;
  }
  if (last < text.length) out.push(new TextRun({ text: text.slice(last), ...base }));
  return out;
}

const P = (t, o = {}) => new Paragraph({
  children: runs(t), alignment: AlignmentType.JUSTIFIED,
  spacing: { after: 120, line: 360 }, indent: o.noIndent ? undefined : { firstLine: 360 }, ...o.p,
});
const P0 = (t) => P(t, { noIndent: true });
const H1 = (t) => new Paragraph({ heading: HeadingLevel.HEADING_1, children: [new TextRun(t)] });
const H2 = (t) => new Paragraph({ heading: HeadingLevel.HEADING_2, children: [new TextRun(t)] });
const NOTE = (t) => new Paragraph({
  children: runs(t, { color: "9C2A00" }), spacing: { after: 120, line: 300 },
  border: { left: { style: BorderStyle.SINGLE, size: 12, color: "9C2A00", space: 8 } },
  indent: { left: 240 },
});
const BUL = (t) => new Paragraph({
  numbering: { reference: "madde", level: 0 }, children: runs(t),
  alignment: AlignmentType.JUSTIFIED, spacing: { after: 80, line: 340 },
});
const NUM = (t, ref = "sayi") => new Paragraph({
  numbering: { reference: ref, level: 0 }, children: runs(t),
  alignment: AlignmentType.JUSTIFIED, spacing: { after: 80, line: 340 },
});
// Formül ya da kod bloğu
const CODE = (lines) => lines.map((l, i) => new Paragraph({
  children: [new TextRun({ text: l === "" ? " " : l, font: MONO, size: 18 })],
  spacing: { after: i === lines.length - 1 ? 160 : 0, line: 260 },
  indent: { left: 360 },
  shading: { type: ShadingType.CLEAR, fill: "F3F3F3", color: "auto" },
}));
const CAP = (t) => new Paragraph({
  children: runs(t, { size: 20 }), alignment: AlignmentType.LEFT,
  spacing: { before: 60, after: 200, line: 280 },
});

// Tablo
const border = { style: BorderStyle.SINGLE, size: 4, color: "808080" };
const borders = { top: border, bottom: border, left: border, right: border };
function TABLE(widths, rows, opts = {}) {
  const total = widths.reduce((a, b) => a + b, 0);
  return new Table({
    width: { size: total, type: WidthType.DXA }, columnWidths: widths,
    rows: rows.map((r, ri) => new TableRow({
      tableHeader: ri === 0,
      children: r.map((c, ci) => new TableCell({
        borders, width: { size: widths[ci], type: WidthType.DXA },
        shading: ri === 0 ? { type: ShadingType.CLEAR, fill: "E7E6E6", color: "auto" } : undefined,
        margins: { top: 50, bottom: 50, left: 90, right: 90 },
        children: [new Paragraph({
          children: runs(c, { size: opts.size || 18, bold: ri === 0 ? true : undefined }),
          spacing: { line: 240 },
        })],
      })),
    })),
  });
}
function FIG(file, wPx, hPx, widthIn) {
  const w = widthIn * 96, h = Math.round(w * hPx / wPx);
  return new Paragraph({
    alignment: AlignmentType.CENTER, spacing: { before: 120 },
    children: [new ImageRun({
      type: "png", data: fs.readFileSync(path.join(__dirname, "sekiller", file)),
      transformation: { width: w, height: h },
      altText: { title: file, description: file, name: file },
    })],
  });
}
const REF = (t) => new Paragraph({
  children: runs(t), spacing: { after: 100, line: 300 },
  indent: { left: 360, hanging: 360 }, alignment: AlignmentType.LEFT,
});

// ---------------------------------------------------------------------
const body = [];
const add = (...xs) => xs.flat().forEach((x) => body.push(x));

// Başlık sayfası
add(
  new Paragraph({ alignment: AlignmentType.CENTER, spacing: { after: 240 }, children: [
    new TextRun({ text: "Maxims as Formulas: A Machine-Checked Propositional Analysis of the Universal Rules of the Ottoman Mecelle", bold: true, size: 32 }),
  ] }),
  new Paragraph({ alignment: AlignmentType.CENTER, spacing: { after: 60 }, children: [
    new TextRun({ text: "İbrahim GÜNEY", size: 24 }), new TextRun({ text: "1,*", size: 24, superScript: true }),
    new TextRun({ text: "  and  Nuri AKSOY", size: 24 }), new TextRun({ text: "2", size: 24, superScript: true })] }),
  new Paragraph({ alignment: AlignmentType.CENTER, spacing: { after: 0 }, children: [
    new TextRun({ text: "1", size: 20, superScript: true }), new TextRun({ text: " [Affiliation]", size: 22, italics: true })] }),
  new Paragraph({ alignment: AlignmentType.CENTER, spacing: { after: 60 }, children: [
    new TextRun({ text: "2", size: 20, superScript: true }), new TextRun({ text: " [Affiliation]", size: 22, italics: true })] }),
  new Paragraph({ alignment: AlignmentType.CENTER, spacing: { after: 360 }, children: [
    new TextRun({ text: "*", size: 20, superScript: true }), new TextRun({ text: " Corresponding author: ibrahimguney16@gmail.com", size: 22 })] }),
  NOTE("**Working draft v0.1 (28 October 2026). Not for circulation.** This draft reports the pilot study (12 of the 99 maxims). Passages marked [TO EXTEND] will be written once the full corpus and the two books (Sale; Usurpation and Destruction) are formalised; passages marked [VERIFY] depend on sources still to be checked against printed editions. Target length: about 12,000 words."),
);

add(
  new Paragraph({ spacing: { before: 240, after: 120 }, children: [new TextRun({ text: "Abstract", bold: true, size: 24 })] }),
  P0("The *Mecelle-i Ahkâm-ı Adliyye* (1868–1876), the Ottoman civil code, opens with ninety-nine universal maxims (*kavâid-i külliye*) that summarise the reasoning of Ḥanafī law. These maxims are usually studied historically or doctrinally. This article asks a different question: what logical structure do they have? We translate a pilot set of twelve maxims, including the five so-called leading maxims, into classical propositional logic. The object language is a deep embedding in the Lean 4 proof assistant, and every claim is checked by Lean’s kernel. The method rests on a *case-indexed reading*: each maxim is read as a schema about a single legal case, and we show that for rules of this shape propositional consequence coincides with first-order consequence. The translation forces every tacit connection between maxims to be stated as an explicit *bridge principle*. Thirteen results follow. Three stand out. First, the maxim of continuance (Art. 5) entails the maxim of certainty (Art. 4) under a single bridge principle, but not conversely; this inverts the dependency usually assumed in the commentaries. Second, Art. 22 restricts Art. 21: read literally, the two are jointly unsatisfiable in any case of excessive necessity. Third, the harm maxims (Arts. 19, 25–27) conflict unless two comparative assumptions about the size and scope of harms are added; propositional logic can state these assumptions but cannot see the ordering they express. We also prove the five leading maxims mutually independent and compare the grouping induced by shared atoms with the traditional thematic grouping. All formalisations are openly available."),
  new Paragraph({ spacing: { before: 120, after: 240 }, children: [
    new TextRun({ text: "Keywords: ", bold: true }),
    new TextRun("Mecelle; Islamic legal maxims; qawāʿid fiqhiyya; propositional logic; Lean 4; computational law; formal verification; legal reasoning"),
  ] }),
);

// 1 Introduction
add(
  H1("1  Introduction"),
  P("Between 1868 and 1876 an Ottoman commission chaired by Ahmed Cevdet Paşa produced the *Mecelle-i Ahkâm-ı Adliyye*, a code of civil law drawn from the Ḥanafī school. It consists of 1,851 articles in sixteen books, preceded by an introduction of one hundred articles. The first article defines jurisprudence; the remaining ninety-nine state universal maxims (*kavâid-i külliye*) such as “certainty is not removed by doubt” and “harm is removed” (Aydın 2003). The Mecelle remained in force in Turkey until the Civil Code of 4 October 1926 and for longer in several successor states of the Empire (Aydın 2003). Its English translation by Tyser, Demetriades and İsmail Haqqı Efendi (1901; reprinted c. 1967) made it a standard reference for Islamic civil law in the English-speaking world."),
  P("The maxims occupy a curious place in the code. They are not operative provisions: a judge may not decide a case on a maxim alone unless it is supported by a more specific rule (Kamali 2006). Yet they are meant to express the reasoning that unifies the specific rules. Already in the twentieth century this collection was criticised for lacking internal system: according to Muṣṭafā al-Zarqāʾ, as reported by Kamali (2006), some of the maxims are secondary and related maxims are scattered rather than grouped. Whether, and how, the maxims hang together is therefore an open question about the code itself."),
  P("This article approaches that question with the tools of modern logic. We ask four concrete questions. Can the maxims be translated into formulas of classical propositional logic without losing their legal content, and which ones resist translation? Is the set of maxims consistent, alone and together with a description of a case? Which maxims follow from which? And does the grouping suggested by the logical structure agree with the traditional thematic grouping?"),
  P("To answer these questions reliably, we do not argue on paper alone. We use a *deep embedding* of propositional logic in the Lean 4 proof assistant (de Moura and Ullrich 2021): formulas are elements of an inductive type, truth is computed by a recursive evaluation function, and consequence and satisfiability are defined by quantifying over valuations. Every positive claim (“Art. 4 follows from Art. 5 and K1”) and every negative claim (“Art. 5 does not follow from Art. 4 and K1”) is a Lean theorem whose proof is checked by the kernel. The embedding is the one developed in the first volume of the textbook *Lean 4 ile Modern Mantık* (Güney 2026), of which the present study is an application."),
  P0("The contributions of the article are as follows."),
  NUM("**A method** for translating legal maxims into propositional logic: an atom dictionary, translation rules for conditionals, prohibitions, priorities and restrictions, and a *case-indexed reading* that justifies the use of propositional rather than first-order logic for rules of this shape (Proposition 1)."),
  NUM("**Bridge principles made explicit.** Every tacit assumption that links two maxims is stated as a separate formula, so that each logical relation between maxims is relative to a named, contestable premise."),
  NUM("**Thirteen machine-checked results** on the pilot maxims, including a dependency between Arts. 4 and 5 that runs against the traditional direction, a restriction of Art. 21 by Art. 22, and a hidden ordering structure in the harm maxims."),
  NUM("**A comparison of groupings**: the grouping induced by shared atoms and by derivability, set against the traditional grouping under the five leading maxims."),
  NUM("**An open artefact**: all definitions and proofs are published with the textbook’s repository."),
  P("Section 2 introduces the Mecelle’s maxims and the Lean embedding. Section 3 reviews related work. Section 4 presents the method, Section 5 the formalisation of the pilot maxims, and Section 6 the results. Section 7 compares groupings, Section 8 discusses limitations, and Section 9 concludes."),
);

// 2 Background
add(
  H1("2  Background"),
  H2("2.1  The Mecelle and its maxims"),
  P("The Mecelle was enacted book by book: the Book of Sale (*Kitâbü’l-Büyû’*) came into force in 1869 and the last books, on evidence and judicial procedure, in 1876 (Aydın 2003). The introduction collects ninety-nine maxims without naming their sources (Aydın 2003). The best-known commentary is Ali Haydar Efendi’s *Dürerü’l-Hükkâm Şerhu Mecelleti’l-Ahkâm* (Istanbul, 1310–1314 AH), which discusses each maxim with examples; a widely used modern Turkish edition with notes is Berki (1982)."),
  P("The maxim literature (*qawāʿid fiqhiyya*) predates the Mecelle by centuries. It usually distinguishes five *leading* maxims, under which many others are subsumed: acts are judged by their intentions; certainty is not removed by doubt; hardship brings facility; harm is to be removed; and custom is authoritative (Kamali 2006). In the Mecelle these correspond to Arts. 2, 4, 17, 20 and 36. Subordinate maxims are attached to them. Kamali (2006), for instance, presents the maxim of continuance, “the original state of a thing is presumed to continue”, as a supporting maxim of the certainty maxim, and grounds the necessity maxims in the prophetic tradition on harm. Rabb (2015) gives a historical study of the doubt maxims in criminal law."),
  P("Table 1 lists the twelve maxims of the pilot study. They were chosen to include the five leading maxims and three thematic clusters in which logical relations are expected: certainty (Arts. 4, 5), necessity (Arts. 17, 21, 22) and harm (Arts. 19, 20, 25, 26, 27)."),
  NOTE("[VERIFY] The Turkish wording follows the edition of Berki (1982) as reproduced in secondary sources; the English wording follows the version published at majalla.org, which appears to follow Tyser et al. (1901). Both are to be checked against the printed editions and, where needed, against the 1887 Ottoman-script printing."),
);

add(
  TABLE([700, 3100, 3600, 1626], [
    ["Art.", "Ottoman Turkish (transcription)", "English", "Leading maxim"],
    ["2", "Bir işten maksad ne ise hüküm ona göredir.", "A matter is determined according to intention.", "Intention ★"],
    ["4", "Şek ile yakîn zâil olmaz.", "Certainty is not dispelled by doubt.", "Certainty ★"],
    ["5", "Bir şeyin bulunduğu hal üzere kalması asıldır.", "A thing shall remain as it was originally.", "Certainty"],
    ["17", "Meşakkat teysiri celb eder.", "Difficulty begets facility.", "Hardship ★"],
    ["19", "Zarar ve mukabele-bizzarar yoktur.", "Injury may not be met by injury.", "Harm"],
    ["20", "Zarar izâle olunur.", "Injury is removed.", "Harm ★"],
    ["21", "Zaruretler memnu olan şeyleri mübah kılar.", "Necessity renders prohibited things permissible.", "Harm / Hardship"],
    ["22", "Zaruretler kendi miktarlarınca takdir olunur.", "Necessity is estimated by the extent thereof.", "Harm / Hardship"],
    ["25", "Bir zarar kendi misli ile izale olunamaz.", "An injury cannot be removed by the commission of a similar injury.", "Harm"],
    ["26", "Zarar-ı âmmı def için zarar-ı has ihtiyar olunur.", "A private injury is tolerated in order to ward off a public injury.", "Harm"],
    ["27", "Zarar-ı eşed zarar-ı ehaf ile izâle olunur.", "Severe injury is removed by lesser injury.", "Harm"],
    ["36", "Âdet muhakkemdir.", "Custom is an arbitrator.", "Custom ★"],
  ]),
  CAP("**Table 1.** The pilot maxims. ★ marks the five leading maxims. The placement of Arts. 21–22 varies in the literature (Section 7)."),
);

add(
  H2("2.2  Propositional logic in Lean 4"),
  P("Lean 4 is an interactive theorem prover and programming language based on dependent type theory (de Moura and Ullrich 2021). A small trusted kernel checks every proof; tactics and automation only produce proof terms for that kernel. We work with the object language defined in Chapter 10 of Güney (2026):"),
  CODE([
    "inductive Formul where",
    "  | atom : Nat → Formul                -- p₀, p₁, p₂, …",
    "  | bot  : Formul                      -- ⊥",
    "  | ve   : Formul → Formul → Formul    -- A ∧ B",
    "  | veya : Formul → Formul → Formul    -- A ∨ B",
    "  | ise  : Formul → Formul → Formul    -- A → B",
  ]),
  P0("Negation is defined as `∼A := A ⟹ ⊥`. A valuation is a function `Nat → Bool`, and `deger v A` computes the truth value of `A` under `v` by structural recursion. On top of this the textbook defines"),
  CODE([
    "def Saglanabilir (A : Formul) : Prop := ∃ v, deger v A = true",
    "def Sonuc (Γ : List Formul) (A : Formul) : Prop :=",
    "  ∀ v, (∀ B ∈ Γ, deger v B = true) → deger v A = true",
  ]),
  P0("that is, satisfiability and semantic consequence Γ ⊨ A. The textbook proves soundness and completeness of a natural-deduction system with respect to these notions (Güney 2026, Chs. 11–12), so the results below could equally be stated proof-theoretically. We use the Lean names `Sonuc` and `Saglanabilir` throughout, and write ⊨ in prose."),
);

// 3 Related work
add(
  H1("3  Related work"),
  P("**Logic and legislation.** The classic demonstration that a statute can be executed as a logical theory is the formalisation of the British Nationality Act 1981 as a logic program (Sergot et al. 1986). Lawsky (2018) argues that statutes are best modelled by default logic, because legal rules are typically stated with exceptions that override them. Prakken and Sartor (2015) survey the logical study of law from the perspective of argumentation, where conflicting rules and priorities between them are central."),
  P("**Programming languages for law.** Catala (Merigoux, Chataing and Protzenko 2021) is a programming language whose semantics is built on a default calculus, designed so that a statute and its exceptions can be transcribed article by article. L4 (Lim et al. 2022) offers rule modifiers such as “subject to” and “despite” and gives them semantics both in classical logic, through SMT solvers, and in answer set programming. Our treatment of Art. 22 as a restriction of Art. 21 (Section 6.3) is a minimal, explicit instance of the same phenomenon, carried out in plain classical logic."),
  P("**Proof assistants and law.** Recent work uses Lean 4 to certify parts of legal analysis, for example the computation of patent claim coverage (Koomullil 2026). [TO EXTEND: survey of Coq/Rocq and Isabelle formalisations of legal rules.]"),
  P("**Islamic law and formal logic.** Nabavi (2009), a doctoral dissertation in Persian, develops a deontic logic for Islamic jurisprudence. [TO EXTEND: systematic search of Arabic, Persian, Turkish and English literature on formal treatments of *qawāʿid*.] To our knowledge, no previous work has formalised the Mecelle’s maxims in a proof assistant or studied their mutual consistency and derivability by machine."),
);

// 4 Method
add(
  H1("4  Method"),
  H2("4.1  The case-indexed reading"),
  P("A maxim speaks about all cases. “Harm is removed” means: in every case in which there is harm, the harm is to be removed. Its natural form is therefore a universally quantified conditional ∀c (Harm(c) → Remove(c)), where c ranges over cases. All twelve pilot maxims have this shape: a quantifier-free formula built from unary predicates applied to one and the same case variable."),
  P("We read each maxim as the instance of such a schema for a single, arbitrary case, and represent each predicate by a propositional atom. The atom `zarar` stands for “in this case there is harm”, and Art. 20 becomes `zarar ⟹ izale`. This *case-indexed reading* loses nothing for the questions we ask, by the following elementary fact."),
  new Paragraph({ spacing: { before: 60, after: 120, line: 340 }, alignment: AlignmentType.JUSTIFIED, children: runs("**Proposition 1.** Let φ₁, …, φₙ, ψ be quantifier-free formulas whose only atomic subformulas are of the form P(c) for unary predicates P and a single variable c, and let φ̂ denote the propositional formula obtained by replacing each P(c) by an atom p. Then ∀c φ₁, …, ∀c φₙ ⊨ ∀c ψ in first-order logic if and only if φ̂₁, …, φ̂ₙ ⊨ ψ̂ in propositional logic. Likewise, {∀c φᵢ} ∪ {χ(a)} is satisfiable for a constant a if and only if {φ̂ᵢ} ∪ {χ̂} is.") }),
  P("*Proof sketch.* If a propositional valuation v satisfies every φ̂ᵢ but not ψ̂, the one-element structure whose single case satisfies exactly the predicates that v makes true is a first-order countermodel. Conversely, a first-order countermodel contains a case c₀ falsifying ψ; reading off which predicates hold of c₀ gives a propositional countervaluation, since every φᵢ holds of c₀ in particular. The satisfiability clause is proved the same way. ∎"),
  P("Proposition 1 is not yet formalised in Lean [TO EXTEND]; it is standard and its proof is short. It tells us exactly where the method stops: maxims that relate *two* cases, or that compare quantities across cases, fall outside its scope. We return to this in Section 8."),
  H2("4.2  Atoms"),
  P("Each atom names one factual or normative feature of the case and keeps the same meaning throughout. Facts and legal consequences are always separate atoms; we never let one atom stand for “there is harm and it must be removed”. Normative qualifications (permitted, prohibited, valid) are, at this stage, also atoms. This is a deliberate simplification: it keeps the logic classical and decidable, and its cost becomes visible in the results (Section 6.4). Table 2 gives the atom dictionary of the pilot."),
);

add(
  TABLE([1700, 600, 4826, 1900], [
    ["Atom", "No.", "Meaning (for the case under consideration)", "Arts."],
    ["`yakin`", "0", "A prior state A is established with certainty", "4, 5"],
    ["`sek`", "1", "There is only doubt that A has ceased", "4"],
    ["`hukumA`", "2", "It is held that A continues", "4, 5"],
    ["`degisimSabit`", "3", "The cessation of A is established by evidence", "5"],
    ["`mesakkat`", "4", "The act involves hardship", "17"],
    ["`teysir`", "5", "Facility (a dispensation) is granted", "17"],
    ["`zaruret`", "6", "There is necessity", "21, 22"],
    ["`aslenMemnu`", "7", "The act is prohibited in principle", "21, 22"],
    ["`mubah`", "8", "The act is permitted in this case", "21, 22"],
    ["`miktariAsar`", "9", "The act exceeds what the necessity requires", "22"],
    ["`zarar`", "10", "There is a harm Z to be removed", "20, 26, 27"],
    ["`izale`", "11", "It is held that Z is to be removed", "20"],
    ["`tedbirCaiz`", "12", "The proposed remedy T is permissible", "19, 25–27"],
    ["`misil`", "13", "The harm caused by T is equal to Z", "25"],
    ["`ehaf`", "14", "The harm caused by T is lighter than Z", "27"],
    ["`amm`", "15", "Z is a public (general) harm", "26"],
    ["`has`", "16", "The harm caused by T is private (particular)", "26"],
    ["`mukabele`", "17", "T consists in answering harm with harm", "19"],
    ["`maksat`", "18", "The act was done with purpose M", "2"],
    ["`hukumM`", "19", "The ruling attached to the act follows purpose M", "2"],
    ["`orf`", "20", "There is an established custom on the matter", "36"],
    ["`orfeGore`", "21", "The ruling is given according to the custom", "36"],
  ]),
  CAP("**Table 2.** Atom dictionary of the pilot study. Atom names are the Lean identifiers (transliterated Turkish legal terms)."),
);

add(
  H2("4.3  Translation rules"),
  P("Four patterns cover the pilot maxims."),
  BUL("**Conditional rules** become implications from conditions to consequence: Art. 17, *hardship ⟹ facility*."),
  BUL("**Prohibitions on remedies** become implications to a negated permission: Art. 25, *equal harm ⟹ ¬ permissible*."),
  BUL("**Priority rules** state that a remedy is permissible under a comparative condition: Art. 27, *harm ∧ lighter ⟹ permissible*."),
  BUL("**Restrictions** are written into the antecedent of the restricted rule as a negated exception: *condition ∧ ¬exception ⟹ consequence*. This is the price of monotonicity, and we pay it visibly (Section 6.3)."),
  P("Two maxims are only partly captured. Art. 2 is a schema over purposes; we formalise one instance. Art. 19 has two halves, a ban on causing harm and a ban on retaliation; only the second is expressible in our model of a case with one harm and one remedy. We list such partial translations as findings rather than defects; the full list for the 99 maxims will be given in an appendix [TO EXTEND]."),
  H2("4.4  Bridge principles"),
  P("Two maxims that share no atom cannot entail one another. When the tradition relates them, it does so through an assumption that the text leaves unstated. We make every such assumption a separate formula, a *bridge principle* (Table 3). Each bridge is an interpretation, to be justified from the commentaries, and each result below states which bridges it uses. A reader who rejects a bridge rejects exactly the results that depend on it, and nothing else."),
  TABLE([700, 2900, 5426], [
    ["Name", "Formula", "Reading"],
    ["K1", "`sek ⟹ ∼degisimSabit`", "Mere doubt does not establish that the prior state has ceased."],
    ["K2", "`zaruret ⟹ mesakkat`", "Necessity is the gravest degree of hardship."],
    ["K3", "`amm ⋀ has ⟹ ehaf`", "A private harm is lighter than a public harm. [VERIFY in commentary]"],
    ["K4", "`∼(misil ⋀ ehaf)`", "A harm cannot be both equal to and lighter than another."],
    ["K5", "`mukabele ⟹ misil`", "Retaliation answers a harm with an equal harm."],
  ]),
  CAP("**Table 3.** Bridge principles used in the pilot."),
  H2("4.5  Proof method"),
  P("All pilot formulas mention at most twenty-two atoms, and each individual result mentions at most five. Positive results (Γ ⊨ A, or unsatisfiability) are proved by unfolding the definitions, generalising the atoms that occur to Boolean variables, and letting Lean’s `decide` tactic check all rows of the resulting truth table. Negative results (Γ ⊭ A) are proved by exhibiting a concrete countervaluation, written `model [i, j, …]` for the valuation that makes exactly the atoms i, j, … true. For example:"),
  CODE([
    "theorem md4_md5ten : Sonuc [md5, K1] md4 := by",
    "  intro v h",
    "  have h1 := h md5 (by simp); have h2 := h K1 (by simp)",
    "  ac; revert h1 h2",
    "  generalize v 0 = a; generalize v 1 = b",
    "  generalize v 2 = c; generalize v 3 = d",
    "  revert a b c d; decide",
    "",
    "theorem md5_md4ten_cikmaz : ¬ Sonuc [md4, K1] md5 := by",
    "  intro h; have := h (model [0]) (by decide); revert this; decide",
  ]),
  P("Here `ac` unfolds the definitions of maxims, bridges and atoms. Because `decide` evaluates a decision procedure inside the kernel, a mistaken claim fails with a message stating which proposition was found false; we tested this by attempting to prove the false claim Art. 27 ⊨ Art. 26. The pilot file compiles with Lean 4.35.0 and contains no unproved statements (`sorry`)."),
);

// 5 Formalisation
add(
  H1("5  Formalisation of the pilot maxims"),
  P("Table 4 lists the formulas. We comment on each cluster, first on paper and then, where it matters, in Lean."),
  TABLE([700, 4600, 3726], [
    ["Art.", "Formula", "Remark"],
    ["2", "`maksat ⟹ hukumM`", "One instance of a schema over purposes"],
    ["4", "`yakin ⋀ sek ⟹ hukumA`", ""],
    ["5", "`yakin ⋀ ∼degisimSabit ⟹ hukumA`", "Continuance (istishab)"],
    ["17", "`mesakkat ⟹ teysir`", ""],
    ["19", "`mukabele ⟹ ∼tedbirCaiz`", "Second half only"],
    ["20", "`zarar ⟹ izale`", ""],
    ["21", "`zaruret ⋀ aslenMemnu ⟹ mubah`", "Literal reading; restricted form in §6.3"],
    ["22", "`zaruret ⋀ aslenMemnu ⋀ miktariAsar ⟹ ∼mubah`", ""],
    ["25", "`misil ⟹ ∼tedbirCaiz`", ""],
    ["26", "`zarar ⋀ amm ⋀ has ⟹ tedbirCaiz`", ""],
    ["27", "`zarar ⋀ ehaf ⟹ tedbirCaiz`", ""],
    ["36", "`orf ⟹ orfeGore`", "Exception for custom contrary to text is in the commentaries, not in the article"],
  ]),
  CAP("**Table 4.** Propositional translations of the pilot maxims (Lean syntax: ⋀ conjunction, ⟹ implication, ∼ negation)."),
  P("**Certainty.** Art. 4 says that a state established with certainty is not removed by doubt. We read it as: if A was established and there is only doubt about its cessation, it is held that A continues. Art. 5, the presumption of continuance, says that A continues unless its cessation is established. The two maxims share the atoms for the prior state and for the ruling, and differ in their second condition: Art. 4 speaks of doubt, Art. 5 of the absence of proof."),
  P("**Necessity.** Art. 21 says that necessity makes the prohibited permissible; Art. 22 says that necessity is measured by its extent. We read Art. 22 as: what exceeds the necessity remains prohibited. The classic illustration is that a starving person may eat what is otherwise forbidden, but only as much as averts death [VERIFY wording of the commentary example]. Art. 17, *hardship brings facility*, is the leading maxim with which the necessity maxims are often associated."),
  P("**Harm.** We model a case with one harm Z to be removed and one proposed remedy T, which itself causes some harm. Art. 20 requires Z to be removed. Arts. 25–27 regulate T by comparing its harm with Z: an equal harm may not be used (Art. 25), a private harm may be accepted to ward off a public one (Art. 26), and a severe harm is removed by a lighter one (Art. 27). Art. 19 forbids answering harm with harm."),
  P("**Intention and custom.** Arts. 2 and 36 are translated as simple conditionals. They share no atom with any other pilot maxim."),
);

// 6 Results
add(
  H1("6  Results"),
  P("All results in this section are Lean theorems; Table 5 at the end of the section lists their names."),
  H2("6.1  Consistency"),
  P("**B1.** The twelve pilot maxims are jointly satisfiable. This is unsurprising: every maxim is a conditional, so the “empty” case in which no condition holds satisfies all of them. Consistency becomes informative only together with a *case description*, a set of atoms stating the facts of a case. The interesting question is therefore which case descriptions are inconsistent with which maxims. Sections 6.3 and 6.4 answer it for the necessity and harm clusters."),
  H2("6.2  Certainty: the direction of dependence"),
  P("**B2.** Art. 4 follows from Art. 5 and the bridge K1:  Art. 5, K1 ⊨ Art. 4."),
  P("*On paper:* assume A was established and there is only doubt that it ceased. By K1, doubt alone does not establish cessation. So A is established and its cessation is not; by Art. 5, A continues."),
  P("**B3.** The converse fails:  Art. 4, K1 ⊭ Art. 5. A countervaluation is the case in which A was established, there is no doubt and no proof of cessation, and yet it is not held that A continues. Art. 4 is vacuously satisfied, since its doubt condition is false; Art. 5 is violated."),
  P("This inverts the usual presentation, in which the presumption of continuance is a subsidiary of the certainty maxim (Kamali 2006). On our reading, the presumption of continuance is the *stronger* principle: it covers every case without proof of change, whether or not doubt has arisen, while the certainty maxim covers only the cases with doubt. The result depends on two choices that should be made explicit: the reading of *şek* as “mere doubt, unsupported by proof”, encoded in K1, and the identification of “certainty” in Art. 4 with “the prior state” in Art. 5. A reading on which Art. 4 also covers certainty about present facts would weaken B2. We regard the result not as a correction of the tradition but as evidence that the traditional relation of “subsumption” between maxims is not logical entailment, and that it deserves a separate analysis."),
  H2("6.3  Necessity: restriction and its cost"),
  P("**B4.** Read literally, Arts. 21 and 22 are jointly unsatisfiable with the case description {necessity, prohibited in principle, exceeds the necessity}: Art. 21 makes the act permitted and Art. 22 makes it not permitted."),
  P("**B5.** The conflict disappears when the exception is written into Art. 21. Let Art. 21′ be `zaruret ⋀ aslenMemnu ⋀ ∼miktariAsar ⟹ mubah`. Then Art. 21′ together with Art. 22 is satisfiable with the same case description, and Art. 21 ⊨ Art. 21′: the restriction only weakens Art. 21 and licenses nothing that the literal maxim did not."),
  P("B4 and B5 are the propositional shadow of what legal theory calls *lex specialis derogat legi generali*, and of the exception mechanisms of Catala and L4 (Section 3). In a monotonic logic the exception cannot be added beside the general rule; it has to be moved into the rule. This is easy for one pair of maxims, but it means that the formula for a maxim depends on which other maxims are in the corpus, and it is the clearest argument for a non-monotonic treatment of the full collection [TO EXTEND]."),
  P("**B6.** Art. 21 does not follow from Art. 17, even with K2:  Art. 17, K2 ⊭ Art. 21. Necessity may be the gravest hardship, and hardship brings facility, but “facility is granted” does not say that a prohibited act becomes permitted. To derive Art. 21 one would need a further bridge from facility to permission in the case of prohibited acts, and that bridge is essentially Art. 21 itself. The necessity maxims are therefore logically independent of the hardship maxim, whatever their thematic affinity."),
  H2("6.4  Harm: a hidden ordering"),
  P("**B7.** Arts. 25 and 27 are jointly unsatisfiable with the case description {harm, the remedy’s harm is equal, the remedy’s harm is lighter}: Art. 27 permits the remedy and Art. 25 forbids it."),
  P("The case description is, of course, absurd: a harm cannot be both equal to and lighter than another. But propositional logic does not know this. The atoms `misil` and `ehaf` are logically independent unless we add K4, which states that they exclude one another."),
  P("**B8.** Arts. 25 and 26 conflict in the same way on the case description {harm, public harm, private remedy, equal harm}."),
  P("**B9.** K3 and K4 together exclude the case description of B8: if a public harm is removed by a private one, the private one is lighter (K3), hence not equal (K4)."),
  P("**B10.** Art. 26 follows from Art. 27 and K3:  Art. 27, K3 ⊨ Art. 26, and not from Art. 27 alone. The maxim of public and private harm is thus a special case of the maxim of severe and lighter harm, *given* that a private harm counts as lighter than a public one."),
  P("**B11.** The second half of Art. 19 follows from Art. 25 and K5:  Art. 25, K5 ⊨ Art. 19; the converse fails."),
  P("Taken together, B7–B11 show that the harm maxims presuppose a comparison of harms: *equal*, *lighter* and *heavier* behave like the relations of a total preorder, and *public* and *private* are positions in it. The maxims use this structure without stating it. Propositional logic can express each needed consequence of the structure (K3, K4) as a separate axiom, and it can show by machine that these axioms are exactly what removes the conflicts. What it cannot do is represent the ordering itself. This is the most natural point at which the analysis should move to first-order logic with an order relation, or to a logic of preference [TO EXTEND]."),
  H2("6.5  Independence of the leading maxims"),
  P("**B12.** None of the five leading maxims follows from the other four. Each countervaluation makes the antecedent of the maxim in question true and its consequent false; since the five maxims share no atoms, the other four are unaffected."),
  P("**B13.** Art. 20 does not follow even from all other pilot maxims together with all five bridge principles."),
  P("B12 is the formal counterpart of the traditional claim that the leading maxims are foundational. It is a modest result, since in our dictionary independence is guaranteed by the absence of shared atoms; but B13 shows that adding the bridges does not destroy it for Art. 20, whereas for Art. 4 it does (by B2). On our reading, Art. 4 is the one leading maxim that is not logically basic within the pilot set."),
  H2("6.6  A worked case"),
  P("Commentaries illustrate Art. 26 with the restraint of an incompetent physician from practice: the private harm to the physician is accepted to ward off the public harm to patients (Berki 1982) [VERIFY page]. We describe the case by {harm, public harm, private remedy, no retaliation} and prove that, under Arts. 19, 20, 25, 26, 27 and the bridges K3–K5, the remedy is permissible, and that the case description together with these maxims and bridges is satisfiable. Art. 25 does not block the remedy, because by K3 and K4 the remedy’s harm is not equal to the harm it removes."),
  TABLE([700, 5226, 3100], [
    ["No.", "Result", "Lean name"],
    ["B1", "Pilot maxims jointly satisfiable", "`pilot_tutarli`"],
    ["B2", "Art. 5, K1 ⊨ Art. 4", "`md4_md5ten`"],
    ["B3", "Art. 4, K1 ⊭ Art. 5", "`md5_md4ten_cikmaz`"],
    ["B4", "Arts. 21, 22 + excess case unsatisfiable", "`md21_md22_catisir`"],
    ["B5", "Art. 21 ⊨ Art. 21′; Art. 21′, 22 + excess case satisfiable", "`md21_md21tyi_gerektirir`, `tahsis_tutarli`"],
    ["B6", "Art. 17, K2 ⊭ Art. 21", "`md21_md17den_cikmaz`"],
    ["B7", "Arts. 25, 27 + equal-and-lighter case unsatisfiable", "`md25_md27_catisir`"],
    ["B8", "Arts. 25, 26 + equal public/private case unsatisfiable", "`md25_md26_catisir`"],
    ["B9", "K3, K4 exclude the case of B8", "`K3_K4_catismayi_dislar`"],
    ["B10", "Art. 27, K3 ⊨ Art. 26; Art. 27 ⊭ Art. 26", "`md26_md27den`, `md26_yalniz_md27den_cikmaz`"],
    ["B11", "Art. 25, K5 ⊨ Art. 19; Art. 19, K5 ⊭ Art. 25", "`md19_md25ten`, `md25_md19dan_cikmaz`"],
    ["B12", "The five leading maxims are mutually independent", "`md2_bagimsiz` … `md36_bagimsiz`"],
    ["B13", "Art. 20 independent of all other maxims and bridges", "`md20_her_seyden_bagimsiz`"],
    ["Case", "Incompetent physician: remedy permissible; case consistent", "`hekim_men_caiz`, `hekim_olayi_tutarli`"],
  ]),
  CAP("**Table 5.** Summary of results and the corresponding Lean theorems in `ModernMantik/Mecelle/Pilot.lean`."),
);

// 7 Grouping
add(
  H1("7  Logical and traditional groupings"),
  P("A formalisation induces two natural groupings of the maxims. The first is by *shared vocabulary*: two maxims are linked if they share an atom, and the groups are the connected components of the resulting graph (Figure 1). The second is by *derivability and conflict* (Figure 2)."),
  FIG("fig1.png", 1720, 1300, 5.8),
  CAP("**Figure 1.** Maxims linked by shared atoms. Solid edges are labelled with the shared atoms; the dotted edge exists only when the bridge K2 is added. Without bridges there are six components, {2}, {4, 5}, {17}, {21, 22}, {19, 20, 25, 26, 27} and {36}; with all bridges, Art. 17 joins Arts. 21–22."),
  FIG("fig2.png", 1730, 570, 6.2),
  CAP("**Figure 2.** Derivability (solid arrows, labelled with the bridges used), non-derivability (dotted) and conflict (dashed, double-headed) among the pilot maxims."),
  P("Three observations follow. First, each of the five leading maxims lies in a different component, which matches their traditional role as heads of separate families. Second, within the certainty family the direction of derivability runs from the subordinate maxim to the leading one (Section 6.2). Third, the necessity maxims are the point where the groupings diverge. Kamali (2006) ties them to the prophetic tradition on harm, and the Mecelle itself places them immediately after Art. 20. In our formalisation they form a separate component, which joins the hardship maxim only through K2 and the harm family not at all."),
  P("The third observation has a general lesson. Whether Arts. 21–22 belong with hardship or with harm is not settled by their text, but by which bridge one accepts: “necessity is extreme hardship” (K2) or, say, “necessity is the threat of a harm”, which would link `zaruret` to `zarar`. The question of grouping, which the tradition answers by placement and which al-Zarqāʾ found unsatisfactory (Kamali 2006), becomes a question about bridge principles, and those can be stated, compared and justified one by one. [TO EXTEND: grouping of the full corpus.]"),
);

// 8 Discussion
add(
  H1("8  Discussion and limitations"),
  P("**Monotonicity.** Classical consequence is monotonic, while legal rules are defeasible. We have handled the one restriction in the pilot by rewriting the general rule (Section 6.3). For the full corpus, where a maxim may be restricted by several others and by the specific rules of the books, this will not scale, and a default or argumentation-based logic (Lawsky 2018; Prakken and Sartor 2015) will be needed."),
  P("**Quantification and comparison.** Proposition 1 covers maxims about a single case. Maxims that compare two harms, two claims or two acts need relations between objects, and the harm maxims already show that their comparisons carry an ordering structure (Section 6.4). First-order logic with an order relation is the natural next step."),
  P("**Deontic qualifications.** Permission and prohibition are atoms here. This is enough to detect conflicts between a maxim that permits and one that forbids, but it cannot express the logical relations between the qualifications themselves, for example that what is obligatory is permitted. A deontic extension, in the direction of Nabavi (2009), is left for future work."),
  P("**Interpretive choices.** The atom dictionary and the bridges are interpretations. The method does not remove interpretation; it isolates it. Every result is relative to named premises, and a different reading of a maxim changes exactly the results that use it. The bridges K1–K5 still have to be justified from Ali Haydar Efendi’s commentary [VERIFY]."),
  P("**Sources.** The pilot texts have been taken from secondary editions. Before submission they will be checked against Tyser et al. (1901) for English and against Berki (1982) and the 1887 Ottoman-script printing for Turkish [VERIFY]."),
  P("**Scale.** Truth tables grow exponentially in the number of atoms. The pilot results use at most five atoms each. For the full corpus we expect a few hundred atoms, which calls for SAT-based decision procedures with proof certificates rather than exhaustive evaluation [TO EXTEND]."),
);

// 9 Conclusion
add(
  H1("9  Conclusion and future work"),
  P("We have shown, on a pilot set of twelve maxims, that the universal rules of the Mecelle can be translated into propositional logic in a way that is faithful to their surface form, precise about its own assumptions and checkable by machine. The translation is informative in both directions. It reproduces traditional judgements, such as the independence of the five leading maxims, and it also produces results that sit uneasily with tradition: the presumption of continuance is logically stronger than the certainty maxim it is said to serve, and the harm maxims are consistent only under comparative assumptions that the text never states."),
  P("The next steps follow from the limitations. The corpus will be extended to all ninety-nine maxims, beginning with the priority maxims (Arts. 28–30), the evidence maxims (Arts. 74–77) and the liability maxims (Arts. 85–93). These lead into the two books selected for the second stage: the Book of Sale and the Book of Usurpation and Destruction (*Gasb ve İtlâf*). There we will test whether the specific rules of the code can be derived from the maxims together with stated bridges, which is the strongest sense in which a maxim can be said to “govern” a book. [TO EXTEND]"),
);

// Data availability
add(
  H1("Data availability"),
  P0("All Lean definitions and proofs are available in the repository of *Lean 4 ile Modern Mantık*, https://github.com/ibrahimguney/lean4-modern-mantik, branch `mecelle-pilot`, file `lean/ModernMantik/Mecelle/Pilot.lean`. The file compiles with Lean 4.35.0 and uses only the Lean core library."),
);

// References
add(
  H1("References"),
  NOTE("Bibliographic data were checked against publisher, library or repository records on 28 October 2026. Missing details are marked."),
  REF("Aydın, Mehmet Âkif. 2003. “Mecelle-i Ahkâm-ı Adliyye.” In *TDV İslâm Ansiklopedisi*, vol. 28, 231–235. Ankara: TDV İslâm Araştırmaları Merkezi."),
  REF("Ali Haydar Efendi. 1310–1314 AH. *Dürerü’l-Hükkâm Şerhu Mecelleti’l-Ahkâm*. 4 vols. Istanbul."),
  REF("Berki, Ali Himmet, ed. 1982. *Açıklamalı Mecelle: Mecelle-i Ahkâm-ı Adliyye*. 3rd ed. Istanbul: Hikmet Yayınları."),
  REF("de Moura, Leonardo, and Sebastian Ullrich. 2021. “The Lean 4 Theorem Prover and Programming Language.” In *Automated Deduction – CADE 28*, edited by A. Platzer et al., 625–635. Lecture Notes in Computer Science 12699. Cham: Springer. https://doi.org/10.1007/978-3-030-79876-5_37."),
  REF("Güney, İbrahim. 2026. *Lean 4 ile Modern Mantık. Cilt I: Temeller*. Version 1.0. https://github.com/ibrahimguney/lean4-modern-mantik."),
  REF("Kamali, Mohammad Hashim. 2006. “Legal Maxims and Other Genres of Literature in Islamic Jurisprudence.” *Arab Law Quarterly* 20 (1): 77–101."),
  REF("Koomullil, George. 2026. “Formally Verified Patent Analysis via Dependent Type Theory: Machine-Checkable Certificates from a Hybrid AI + Lean 4 Pipeline.” arXiv:2604.18882."),
  REF("Lawsky, Sarah B. 2018. “A Logic for Statutes.” *Florida Tax Review* 21 (1): 2–[pages]."),
  REF("Lim, Khang, Avishkar Mahajan, Martin Strecker, and Meng Weng Wong. 2022. “Automating Defeasible Reasoning in Law.” arXiv:2205.07335."),
  REF("Merigoux, Denis, Nicolas Chataing, and Jonathan Protzenko. 2021. “Catala: A Programming Language for the Law.” *Proceedings of the ACM on Programming Languages* 5 (ICFP). https://doi.org/10.1145/3473582."),
  REF("*Mecelle-yi Ahkâm-ı Adliye*. 1887. Istanbul [printer to be confirmed]. Digitised copy, Ohio State University Libraries, Internet Archive identifier mecelleyiahkmiad00turk."),
  REF("Nabavi, Fateme. 2009. “A Deontic Logic for the Islamic Jurisprudence.” PhD diss., Sharif University of Technology, Tehran. (In Persian.)"),
  REF("Prakken, Henry, and Giovanni Sartor. 2015. “Law and Logic: A Review from an Argumentation Perspective.” *Artificial Intelligence* 227: 214–245."),
  REF("Rabb, Intisar A. 2015. *Doubt in Islamic Law: A History of Legal Maxims, Interpretation, and Islamic Criminal Law*. Cambridge: Cambridge University Press."),
  REF("Sergot, Marek J., Fariba Sadri, Robert A. Kowalski, Frank Kriwaczek, Peter Hammond, and H. Terese Cory. 1986. “The British Nationality Act as a Logic Program.” *Communications of the ACM* 29 (5): 370–386. https://doi.org/10.1145/5689.5920."),
  REF("Tyser, C. R., D. G. Demetriades, and İsmail Haqqı Efendi, trans. 1901. *The Mejelle: Being an English Translation of Majallah el-Ahkam-i-Adliya and a Complete Code on Islamic Civil Law*. Nicosia. Reprint, Lahore: Law Publishing Company, [1967?]."),
);

// Appendix
add(
  new Paragraph({ children: [new PageBreak()] }),
  H1("Appendix A.  Lean definitions of the pilot maxims"),
  CODE([
    "def md2  : Formul := maksat ⟹ hukumM",
    "def md4  : Formul := yakin ⋀ sek ⟹ hukumA",
    "def md5  : Formul := yakin ⋀ ∼degisimSabit ⟹ hukumA",
    "def md17 : Formul := mesakkat ⟹ teysir",
    "def md19 : Formul := mukabele ⟹ ∼tedbirCaiz",
    "def md20 : Formul := zarar ⟹ izale",
    "def md21 : Formul := zaruret ⋀ aslenMemnu ⟹ mubah",
    "def md22 : Formul := zaruret ⋀ aslenMemnu ⋀ miktariAsar ⟹ ∼mubah",
    "def md25 : Formul := misil ⟹ ∼tedbirCaiz",
    "def md26 : Formul := zarar ⋀ amm ⋀ has ⟹ tedbirCaiz",
    "def md27 : Formul := zarar ⋀ ehaf ⟹ tedbirCaiz",
    "def md36 : Formul := orf ⟹ orfeGore",
    "",
    "def K1 : Formul := sek ⟹ ∼degisimSabit",
    "def K2 : Formul := zaruret ⟹ mesakkat",
    "def K3 : Formul := amm ⋀ has ⟹ ehaf",
    "def K4 : Formul := ∼(misil ⋀ ehaf)",
    "def K5 : Formul := mukabele ⟹ misil",
    "",
    "-- worked case (Section 6.6)",
    "theorem hekim_men_caiz :",
    "    Sonuc (zararKaideleri ++ hekimOlayi) tedbirCaiz := …",
  ]),
);

// ---------------------------------------------------------------------
const doc = new Document({
  creator: "İbrahim GÜNEY; Nuri AKSOY",
  title: "Maxims as Formulas",
  styles: {
    default: { document: { run: { font: SERIF, size: 24 } } },
    paragraphStyles: [
      { id: "Heading1", name: "Heading 1", basedOn: "Normal", next: "Normal", quickFormat: true,
        run: { size: 26, bold: true, font: SERIF },
        paragraph: { spacing: { before: 360, after: 160 }, outlineLevel: 0, keepNext: true } },
      { id: "Heading2", name: "Heading 2", basedOn: "Normal", next: "Normal", quickFormat: true,
        run: { size: 24, bold: true, italics: true, font: SERIF },
        paragraph: { spacing: { before: 240, after: 120 }, outlineLevel: 1, keepNext: true } },
    ],
  },
  numbering: {
    config: [
      { reference: "madde", levels: [{ level: 0, format: LevelFormat.BULLET, text: "•", alignment: AlignmentType.LEFT,
        style: { paragraph: { indent: { left: 720, hanging: 360 } } } }] },
      { reference: "sayi", levels: [{ level: 0, format: LevelFormat.DECIMAL, text: "(%1)", alignment: AlignmentType.LEFT,
        style: { paragraph: { indent: { left: 720, hanging: 420 } } } }] },
    ],
  },
  sections: [{
    properties: { page: { size: { width: 11906, height: 16838 }, margin: { top: 1440, right: 1440, bottom: 1440, left: 1440 } } },
    headers: { default: new Header({ children: [new Paragraph({ alignment: AlignmentType.RIGHT, children: [
      new TextRun({ text: "Maxims as Formulas — working draft v0.1", size: 18, italics: true, color: "666666" })] })] }) },
    footers: { default: new Footer({ children: [new Paragraph({ alignment: AlignmentType.CENTER, children: [
      new TextRun({ children: [PageNumber.CURRENT], size: 20 })] })] }) },
    children: body,
  }],
});

Packer.toBuffer(doc).then((buf) => {
  fs.writeFileSync(path.join(__dirname, "mecelle-makale-taslak.docx"), buf);
  console.log("yazıldı");
});
