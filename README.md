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

N.B. Lettertypes installeren kan je op zowel Windows, macOS als Linux door te dubbelklikken op het .otf-bestand en op de knop "Installeren" te klikken in het preview-venster. Je kan de bestanden ook kopiëren naar de directory met lettertypes: `C:\Windows\Fonts` voor Windows, `/Library/Fonts` of `~/Library/Fonts` op macOS, `/usr/share/fonts` of `~/.local/share/fonts` op Linux.

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

## Scripts voor compileren, Github Actions

LaTeX correct opzetten vraagt wat moeite en is in het bijzonder op Windows niet altijd even evident. Daarom hebben we enkele scripts voorzien die het proces automatiseren en de meest voorkomende fouten vermijden. Concreet wordt er een **Docker container-image** gebouwd waarin alle nodige packages en lettertypes geïnstalleerd worden zodat de compilatie foutloos kan uitgevoerd worden.

Dat impliceert dus dat je Docker moet geïnstalleerd hebben op jouw laptop!

- Windows, MacOS: [Docker Desktop](https://docs.docker.com/desktop/)
- Ubuntu, Debian, enz.: De Docker engine uit de repositories van de distributie of [de builds van Docker zelf](https://docs.docker.com/engine/install/ubuntu/)
- Fedora: installeer Podman uit de officiële repos

Om je bachelorproef te compileren, voer je dan op Windows het volgende commando uit (in een CMD of PowerShell-console, in de directory met de scripts):

```console
> make_thesis.bat
```

Op Mac of Linux (in een Bash-console):

```console
$ ./make_thesis.sh
```

Om je bachelorproef*voorstel* en poster te compileren zijn er gelijkaardige scripts (`make_voorstel.bat`/`.sh` en `make_poster.bat`/`.sh`).

De resulterende PDF-bestanden vind je in de directory `output/`, die aangemaakt wordt indien nodig.

**Let op!** Als je codefragmenten in je bachelorproef opneemt die opgemaakt worden met `minted`, dan moet je in het hoofddocument zorgen dat de optie `outputdir` van de `minted`-package ingesteld wordt op `../output`. Anders zal de compilatie mislukken. Je kan regel 24 uit commentaar halen (en regel 21 uitcommentariëren of verwijderen):

```latex
\usepackage[section,outputdir=../output]{minted}
```

De eerste keer dat je dit script uitvoert, zal het compilatieproces langer duren: eerst moet immers een Docker-image gebouwd worden waarin de nodige packages geïnstalleerd zijn. Een eerste LaTeX-compilatie duurt ook vaak langer dan de volgende.

### Automatische compilatie op Github Actions

Als je een Github-repository aanmaakt voor je bachelorproef (wat we sterk aanbevelen!), dan zal telkens je nieuwe tekst naar Github pusht, jouw bachelorproef automatisch gecompileerd worden. Dit is geconfigureerd in `.github/workflow/docker-tex-to-pdf.yml`. Het compilatieproces wordt uitgevoerd op de Github-servers en de resulterende PDF- en logbestanden (voor troublehshooting) worden ter beschikking gehouden en kan je [downloaden](https://docs.github.com/en/actions/managing-workflow-runs/downloading-workflow-artifacts).

Deze "artefacten" worden niet onbeperkt bijgehouden: na 2 dagen worden de meesten verwijderd. Je kan vermijden dat een PDF verwijderd wordt door een tag toe te kennen aan de commit. De meest recente versie wordt ook bijgehouden (max. 90 dagen).

## Vragen, fouten, verbeteringen

Bugs, vragen voor verbeteringen, enz. zijn welkom! Je kan die registreren via de Issues. Je kan zelf ook verbeteringen aanbrengen via Pull Requests.

## Bijdragen

- De vormgeving van het bachelorproefsjabloon is gebaseerd op het werk van [Pieter van der Kloet](https://github.com/pvdk/hogent-latex-thesis). Dat sjabloon wordt nu [hier verder onderhouden](https://github.com/HoGentTIN/latex-hogent-report) door Bert Van Vreckem
- Het sjabloon voor het bachelorproefvoorstel [wordt hier bijgehouden](https://github.com/HoGentTIN/latex-hogent-article).

Volgende personen hebben bijgedragen aan deze sjablonen:

- Bert Van Vreckem
- Chantal Teerlinck
- Jan Willem
- Jens Buysse
- Jeroen Maelbrancke
- Jonas Verhofsté
- Matts Devriendt
- Niels Corneille
- Patrick Van Brussel
- Simon Rondelez
