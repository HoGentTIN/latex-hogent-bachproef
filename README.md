# Bachelorproef toegepaste informatica

Deze repository bevat LaTeX sjablonen voor gebruik bij het opmaken van je bachelorproef toegepaste informatica:

- [Het onderzoeksvoorstel](./voorstel/)
- [De bachelorproef zelf](./bachproef/)
- [Een poster](./poster/)

**LET OP.** Voor het academiejaar 2022-2023 zijn er nieuwe sjablonen gepubliceerd die conform zijn met de huidige huisstijl van HOGENT.

## Aan de slag

Om deze sjablonen te gebruiken, kan je de repository downloaden via de groene knop rechtsboven deze pagina. Het is beter een ZIP te downloaden en zelf een Github repository te initialiseren dan deze repository te klonen. In het laatste geval neem je dan immers ook de gehele historiek van wijzigingen in het sjabloon zelf mee en dat is niet relevant voor jouw werk. Maak daarna een Github-repository voor jezelf aan (`git init .`). Gebruik altijd een versiebeheersysteem om een LaTeX-document bij te houden! Creëer een Github-repository die je deelt met je promotor en/of andere belanghebbenden.

Gebruik deze repository ook om andere artefacten/deelresultaten van je bachelorproef bij te houden, zoals nota's, ruwe resultaten, scripts/programmacode, enz. Gebruik bij voorkeur tekstgebaseerde bestandsformaten, bijvoorbeeld Markdown ipv Word-documenten of CSV (Comma Separated Values) ipv Excel-werkbladen.

## Lettertypes

Je hebt de volgende lettertypes nodig. Ze zijn meegeleverd [in deze repository](fonts/), dus je kan ze makkelijk installeren.

- Montserrat (officieel hoofdlettertype van de HOGENT huisstijl)
- Fira Code (monogespatieerde tekst)
- Fira Math (wiskundige formules)

## LaTeX editor, bibliografie

Qua editors voor LaTeX zijn er verschillende keuzemogelijkheden. We raden [TeXstudio](https://www.texstudio.org/) aan en [Jabref](https://www.jabref.org/) voor het bijhouden van een bibliografische databank. Ook Visual Studio Code is een zeer goede LaTeX-editor (via de plugin LaTeX Workshop van James Yu).

### TeXstudio configureren

Kies in het menu voor Options > Configure TeXstudio en pas volgende instellingen aan:

- Build:
    - Default compiler: "xelatex"
    - Default Bibliography Tool: "Biber"
- Commands:
    - Latexmk: `xelatex -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error %`
- Editor:
    - Indentation mode: Indent and Unindent Automatically
    - Replace Indentation Tab by Spaces: Aanvinken
    - Replace Tab in Text by spaces: Aanvinken
    - Replace Double Quotes: English Quotes: ‘‘’’

Tips:

- Gebruik functietoets **F5** om het document te compileren en het resultaat te bekijken.
- Als na compilatie de bibliografie niet zichtbaar is, probeer die dan expliciet te compileren met **F8** en daarna opnieuw **F5**

### Jabref

Kies voor Options > Preferences en pas volgende instellingen aan:

- General:
    - Default encoding: UTF-8
    - Default library mode: biblatex
- File:
    - (optioneel) Main file directory: geef hier de directory waar je de PDFs van gevonden bronnen bijhoudt. Als je dezelfde bestandsnaam gebruikt als je BibtexKey, dan vindt JabRef de PDF en kan je die openen vanuit het overzicht.

## Bachelorproef in het Engels

Het bachelorproefsjabloon is voorzien op tekst in hetzij Nederlands, hetzij Engels. Wanneer je je bachelorproef in het Engels schrijft, pas je de instellingen van de documentclass aan. Nu staat er:

```latex
\documentclass[dutch,dit,thesis]{hogentreport}
```

Je kan `dutch` verwijderen of vervangen door `english`.

Aandachtspunten:

- Het voorblad blijft in het Nederlands (behalve je titel), en dit is ook de bedoeling
- Pas de naam van het diploma aan (regel met commando`\degreesought{}`) in *Bachelor in applied computer science*.
- Je moet in dit geval ook een Nederlandse vertaling van je samenvatting voorzien. Het sjabloon houdt daar ook rekening mee:
    - De samenvatting in de hoofdtaal van het document komt [op lijn 40 van het LaTeX-bestand](https://github.com/HoGentTIN/bachproef-latex-sjabloon/blob/master/bachproef/samenvatting.tex#L40)
    - De Nederlandse vertaling ervan komt [op lijn 31](https://github.com/HoGentTIN/bachproef-latex-sjabloon/blob/master/bachproef/samenvatting.tex#L31)

## Vragen, fouten, verbeteringen

Bugs, vragen voor verbeteringen, enz. zijn welkom! Je kan die registreren via de Issues. Je kan zelf ook verbeteringen aanbrengen via Pull Requests.

## Bijdragen

- De vormgeving van het bachelorproefsjabloon is gebaseerd op het werk van [Pieter van der Kloet](https://github.com/pvdk/hogent-latex-thesis). Dat sjabloon wordt nu [hier verder onderhouden](https://github.com/HoGentTIN/latex-hogent-report) door Bert Van Vreckem
- Het sjabloon voor het bachelorproefvoorstel [wordt hier bijgehouden](https://github.com/HoGentTIN/latex-hogent-article).

Volgende personen hebben bijgedragen aan deze sjablonen:

- Bert Van Vreckem
- Jens Buysse
- Chantal Teerlinck
- Jeroen Maelbrancke
- Matts Devriendt
- Niels Corneille
- Patrick Van Brussel
- Simon Rondelez
