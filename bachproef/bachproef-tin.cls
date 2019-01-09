%===============================================================================
% LaTeX Documentklasse voor de bachelorproef toegepaste informatica aan HOGENT.
%
% Deze klasse bepaalt de algemene vormgeving en structuur. In principe zijn er
% hier geen wijzigingen nodig.
%
% Vormgeving gebaseerd op "The Legrand Orange Book", version 2.0 (9/2/15)
% door Mathias Legrand (legrand.mathias@gmail.com) met aanpassingen door Vel
% (vel@latextemplates.com). Het oorspronkelijke sjabloon is te vinden op
% http://www.LaTeXTemplates.com
%
% Aanpassingen voor HOGENT toegepaste informatica:
%   Bert Van Vreckem <bert.vanvreckem@hogent.be>
% Licentie: 
%   CC BY-NC-SA 3.0 (http://creativecommons.org/licenses/by-nc-sa/3.0/)
%===============================================================================

\ProvidesClass{bachproef-tin}[2019/01/09 Bachelorproef HOGENT toegepaste informatica]
\NeedsTeXFormat{LaTeX2e}

% Overerven van de ``book''-klasse
\LoadClass[12pt,fleqn]{book}

%-------------------------------------------------------------------------------
% Algemene vormgeving, pagina-indeling
%-------------------------------------------------------------------------------

% Paginagrootte en marges
\RequirePackage[top=3cm,bottom=3cm,left=3cm,right=3cm,headsep=10pt,a4paper]{geometry}
% Paragraafstijl
\setlength{\parindent}{0em} % Eerste regel niet inspringen
\setlength{\parskip}{1em}   % Ruimte tussen paragrafen laten
\RequirePackage{enumitem}   % Vormgeving lijsten aanpassen
\setlist{nolistsep}         % Geen ruimte tussen elementen in een lijst

\RequirePackage{booktabs}   % Mooier opgemaakte tabellen
\RequirePackage{multirow}   % Cellen in tabellen samenvoegen
\RequirePackage{rotating}   % Tabellen en figuren roteren

\RequirePackage{listings}   % Broncode mooi opmaken

\RequirePackage{graphicx}   % Invoegen van afbeeldingen
\graphicspath{{img/}}       % Map met in te voegen afbeeldingen
\RequirePackage{tikz}       % Grafische taal voor maken van afbeeldingen

%-------------------------------------------------------------------------------
% Lettertypes, bestandscodering
%-------------------------------------------------------------------------------

\RequirePackage[utf8]{inputenc}  % Accenten gebruiken in tekst (vb. é ipv \'e)
\RequirePackage[T1]{fontenc}     % Gebruik modernere 8-bit fonts met 256 tekens
\RequirePackage{amsfonts}        % AMS math packages: extra wiskundige
\RequirePackage{amsmath}         %   symbolen (o.a. getallen-
\RequirePackage{amssymb}         %   verzamelingen N, R, Z, Q, etc.)

\RequirePackage{avant}           % Gebruik Avantgarde voor titels
\RequirePackage{mathptmx}        % Gebruik Adobe Times Roman als basislettertype
                                 % met ondersteuning voor wiskundige symbolen

\RequirePackage{microtype}       % Verbeteringen voor typografische perfectie

%-------------------------------------------------------------------------------
% Taal, lokalisatie
%-------------------------------------------------------------------------------

% Taalinstellingen: woordsplitsingen, commando's voor speciale karakters
\RequirePackage[english,dutch]{babel}
\RequirePackage{iflang}
\RequirePackage{eurosym}         % Euro-symbool €

%-------------------------------------------------------------------------------
% Kleuren
%-------------------------------------------------------------------------------

\RequirePackage{xcolor}

% Bepaal de hoofdkleur doorheen heel het document
\definecolor{maincolor}{RGB}{0,147,208}
% 0, 147, 208 = officiële kleur HoGent FBO

% HOGENT huisstijlkleuren
% Bron: https://hnet.hogent.be/themas/communicatie/huisstijl-logo-s-en-sjablonen/kleurgebruik/
\definecolor{hgdarkgreen}{RGB}{22,176,165}
\definecolor{hgpink}{RGB}{241,157,160}
\definecolor{hgochre}{RGB}{250,188,50}
\definecolor{hgorange}{RGB}{239,135,103}
\definecolor{hgpurple}{RGB}{187,144,189}
\definecolor{hgblue}{RGB}{76,162,213}
\definecolor{hglightgreen}{RGB}{165,202,114}
\definecolor{hgbrown}{RGB}{216,176,131}
\definecolor{hggrey}{RGB}{195,187,175}
\definecolor{hgyellow}{RGB}{244,222,0}

%-------------------------------------------------------------------------------
% Inhoudstafel
%-------------------------------------------------------------------------------

\RequirePackage{titletoc}
\contentsmargin{0cm} % Verwijder de standaardmarge

% Hieronder volgen de tekststijlen voor elk niveau in de inhoudstafel. De
% structuur is telkens:
% \titlecontents{NIVEAU}[INSPRINGEN]
% {LETTERTYPE}
% {NUMMERING}
% {VULLING} -> vb. ruimte tussen titel en pagina opvullen met puntjes
% {PAGINANR}

% Tekststijl voor \part
\titlecontents{part}[0cm]
{\addvspace{20pt}\centering\large\bfseries}
{}
{}
{}

% Tekststijl voor \chapter
\titlecontents{chapter}[1.25cm]
{\addvspace{12pt}\large\sffamily\bfseries}
{\color{maincolor!60}\contentslabel[\Large\thecontentslabel]{1.25cm}\color{maincolor}}
{\color{maincolor}}
{\color{maincolor!60}\normalsize\;\titlerule*[.5pc]{.}\;\thecontentspage}

% Tekststijl voor \section
\titlecontents{section}[1.25cm]
{\addvspace{3pt}\sffamily\bfseries}
{\contentslabel[\thecontentslabel]{1.25cm}}
{}
{\hfill\color{black}\thecontentspage}

% Tekststijl voor \subsection
\titlecontents{subsection}[1.25cm]
{\addvspace{1pt}\sffamily\small}
{\contentslabel[\thecontentslabel]{1.25cm}}
{}
{\ \titlerule*[.5pc]{.}\;\thecontentspage}

% Tekststijl voor lijst van figuren
\titlecontents{figure}[0em]
{\addvspace{-5pt}\sffamily}
{\thecontentslabel\hspace*{1em}}
{}
{\ \titlerule*[.5pc]{.}\;\thecontentspage}

% Tekststijl voor lijst van tabellen
\titlecontents{table}[0em]
{\addvspace{-5pt}\sffamily}
{\thecontentslabel\hspace*{1em}}
{}
{\ \titlerule*[.5pc]{.}\;\thecontentspage}

%-------------------------------------------------------------------------------
% Mini-inhoudstafel per hoofdstuk
%-------------------------------------------------------------------------------

% Tekststijl hoofdstuktitel
\titlecontents{lchapter}[0em]
{\addvspace{15pt}\large\sffamily\bfseries}
{\color{maincolor}\contentslabel[\Large\thecontentslabel]{1.25cm}\color{maincolor}}
{}
{\color{maincolor}\normalsize\sffamily\bfseries\;\titlerule*[.5pc]{.}\;\thecontentspage}

% Tekststijl \section
\titlecontents{lsection}[0em]
{\sffamily\small}
{\contentslabel[\thecontentslabel]{1.25cm}}
{}
{}

% Tekststijl \subsection
\titlecontents{lsubsection}[.5em]
{\normalfont\footnotesize\sffamily}
{}
{}
{}

%-------------------------------------------------------------------------------
% Paginahoofdingen
%-------------------------------------------------------------------------------

\RequirePackage{fancyhdr}

\pagestyle{fancy}
% Tekststijl hoofdstuk
\renewcommand{\chaptermark}[1]
{\markboth{\sffamily\normalsize\bfseries\chaptername\ \thechapter.\ #1}{}} % 
% Tekststijl sectie
\renewcommand{\sectionmark}[1]
{\markright{\sffamily\normalsize\thesection\hspace{5pt}#1}{}}
% Tekststijl paginanummer
\fancyhf{} \fancyhead[LE,RO]{\sffamily\normalsize\thepage}

\fancyhead[LO]{\rightmark} % Oneven pagina's: sectietitel aan de linkerkant
\fancyhead[RE]{\leftmark} % Even pagina's: Hoofdstuktitel aan de rechterkant
\renewcommand{\headrulewidth}{0.5pt} % Lijn onder de hoofding
\addtolength{\headheight}{2.5pt} % Meer ruimte voor hoofding

\renewcommand{\footrulewidth}{0pt} % Geen lijn boven voettekst

% Hoofdingstijl voor een ``plain'' pagina
\fancypagestyle{plain}{\fancyhead{}\renewcommand{\headrulewidth}{0pt}}

% Verwijder de hoofding van oneven pagina's aan het einde van een hoofstuk
\renewcommand{\cleardoublepage}{
  \clearpage\ifodd\c@page\else
  \hbox{}
  \vspace*{\fill}
  \thispagestyle{empty}
  \newpage
  \fi}

%-------------------------------------------------------------------------------
% Stijl voor wiskundige stellingen & bewijzen/voorbeelden/...
%-------------------------------------------------------------------------------
% Er zijn vier ``theorem''-omgevingen gedefinieerd:
%
% - theorem (Stelling + bewijs)
% - corollary (Gevolg + bewijs)
% - definition (Definitie van een begrip)
% - exercise (Opgave van een oefening)
% - example (Voorbeeld)
%
% Elk heeft een specifieke stijl, hetzij met een kader, dikke rand links of
% gekleurde achtergrond. Voorbeeld gebruik:
%
% \begin{theorem}[titel]
%   hoofdtekst
% \end{theorem}

\RequirePackage{amsthm}   % Stijlen voor theorem-omgeving aanpassen
\RequirePackage{mdframed} % Tekstkaders

%---------- Theorem (bewijs) ---------------------------------------------------
% Een bewijs staat in een kader met de hoofdkleur van het document en een grijze
% achtergrond.

% Lettertypestijl voor theorem-omgeving: ``Stelling x.y'' in het blauw, en de
% titel in het vet.
\newtheoremstyle{maincolornumbox}
{12pt}         % Ruimte erboven
{12pt}         % Ruimte eronder
{\normalfont}  % Lettertype inhoud
{}             % Inspringen
{\small\bf\sffamily\color{maincolor}} % Lettertype ``hoofding''
{\;}           % Leesteken tussen hoofding en ``body''
{0.25em}       % Ruimte na hoofding
{\small\sffamily\color{maincolor}\thmname{#1}\nobreakspace\thmnumber{\@ifnotempty{#1}{}\@upn{#2}}  % Aanduiding, b.v. ``Stelling 2.1''
  \thmnote{\nobreakspace\the\thm@notefont\sffamily\bfseries\color{black}---\nobreakspace#3.}} % Optionele naam van de stelling (in vet)

\theoremstyle{maincolornumbox}
\newtheorem{theoremT}{\IfLanguageName{dutch}{Stelling}{Theorem}}[chapter]

% Kader rond de tekst
\newmdenv[%
backgroundcolor=black!5,
innerbottommargin=5pt,
innerleftmargin=5pt,
innerrightmargin=5pt,
innertopmargin=5pt,
leftmargin=0cm,
linecolor=maincolor,
rightmargin=0cm,
skipabove=12pt,
skipbelow=7pt
]{tBox}

% Definitie theorem-omgeving, gebaseerd op de hierboven gedefinieerde stijlen
\newenvironment{theorem}{\begin{tBox}\begin{theoremT}}{\hfill{\tiny\ensuremath{\blacksquare}}\end{theoremT}\end{tBox}}

%---------- Corollary (gevolg) -------------------------------------------------
% Een gevolg is gelijkaardig opgemaakt als een stelling, maar er wordt enkel
% zwart gebruikt, niet de hoofdkleur

% Lettertypestijl: ``Gevolg x.y'' in het zwart, de titel in het vet
\newtheoremstyle{blacknumbox}
{12pt}
{12pt}
{\normalfont}
{}
{\small\bf\sffamily}
{\;}
{0.25em}
{\small\sffamily\thmname{#1}\nobreakspace\thmnumber{\@ifnotempty{#1}{}\@upn{#2}}
  \thmnote{\nobreakspace\the\thm@notefont\sffamily\bfseries---\nobreakspace#3.}}

\theoremstyle{blacknumbox}
\newtheorem{corollaryT}{\IfLanguageName{dutch}{Gevolg}{Corollary}}[chapter]

% Randen rond de corollary-omgeving
\newmdenv[%
backgroundcolor=black!5,
innerbottommargin=5pt,
innerleftmargin=5pt,
innerrightmargin=5pt,
innertopmargin=5pt,
leftmargin=0cm,
linecolor=black,
rightmargin=0cm,
skipabove=12pt,
skipbelow=7pt
]{corollaryBox}

% Definitie corollary-omgeving, gebaseerd op de hierboven gedefinieerde stijlen
\newenvironment{corollary}{\begin{corollaryBox}\begin{corollaryT}}{\hfill{\tiny\ensuremath{\blacksquare}}\end{corollaryT}\end{corollaryBox}}

%---------- Definition (definitie) ---------------------------------------------
% Een definitie heeft geen kader, maar een achtergrond gebaseerd op de
% hoofdkleur en dikke rand links.

% Randen rond de definitie-omgeving
\newmdenv[%
backgroundcolor=maincolor!10,
bottomline=false,
innerbottommargin=5pt,
innerleftmargin=5pt,
innerrightmargin=5pt,
innertopmargin=5pt,
leftline=true,
leftmargin=0cm,
linecolor=maincolor,
linewidth=4pt,
rightline=false,
rightmargin=0cm,
skipabove=7pt,
skipbelow=7pt,
topline=false
]{defBox}

\theoremstyle{blacknumbox}
\newtheorem{definitionT}{\IfLanguageName{dutch}{Definitie}{Definition}}[chapter]

% Definitie definition-omgeving, gebaseerd op de hierboven gedefinieerde stijlen
\newenvironment{definition}{\begin{defBox}\begin{definitionT}}{\end{definitionT}\end{defBox}}

%---------- Exercise (oefening) ------------------------------------------------
% Een oefening heeft geen kader, maar een achtergrond gebaseerd op de
% hoofdkleur en dikke rand links.

% We hergebruiken de stijl voor een Theorem: ``Oefening x.y'' in het blauw
\theoremstyle{maincolornumbox}
\newtheorem{exerciseT}{\IfLanguageName{dutch}{Oefening}{Exercise}}[chapter]

% Randen rond de exercise-omgeving
\newmdenv[%
bottomline=false,
innerbottommargin=5pt,
innerleftmargin=5pt,
innerrightmargin=5pt,
innertopmargin=5pt,
leftline=true,
leftmargin=0cm,
linecolor=maincolor,
linewidth=4pt,
rightline=false,
rightmargin=0cm,
skipabove=7pt,
skipbelow=7pt,
topline=false
]{exerciseBox}

% Definitie exercise-omgeving, gebaseerd op de hierboven gedefinieerde stijlen
\newenvironment{exercise}{\begin{exerciseBox}\begin{exerciseT}}{\end{exerciseT}\end{exerciseBox}}

%---------- Example (voorbeeld) ------------------------------------------------
% Een voorbeeld is opgemaakt zoals een oefening maar alles in het zwart.

% We hergebruiken de stijl voor een Corollary (alle tekst in het zwart)
\theoremstyle{blacknumbox}
\newtheorem{exampleT}{\IfLanguageName{dutch}{Voorbeeld}{Example}}[chapter]

% Randen rond de example-omgeving
\newmdenv[%
bottomline=false,
innerbottommargin=5pt,
innerleftmargin=5pt,
innerrightmargin=5pt,
innertopmargin=5pt,
leftline=true,
leftmargin=0cm,
linecolor=black,
linewidth=4pt,
rightline=false,
rightmargin=0cm,
skipabove=7pt,
skipbelow=7pt,
topline=false
]{exampleBox}

% Definitie example-omgeving, gebaseerd op de hierboven gedefinieerde stijlen
\newenvironment{example}{\begin{exampleBox}\begin{exampleT}}{\end{exampleT}\end{exampleBox}}

%-------------------------------------------------------------------------------
% remark-omgeving
%-------------------------------------------------------------------------------
% Omgeving voor opmerkingen. Deze worden aangeduid door een cirkel links van
% de tekst in de hoofdkleur, met daarin een letterteken. Standaard is dat de 
% hoofdletter O van opmerking, maar je kan dit zelf aanpassen.
%
% Voorbeeld:                    Of met een gekozen letterteken (uitroepteken):
% \begin{remark}                \begin{remark}[!]
%   Tekst                         Tekst
% \end{remark}                  \end{remark}

\newenvironment{remark}[1][O]{%
  \par\vspace{10pt}\small
  \begin{list}{}{\leftmargin=35pt \rightmargin=25pt}
    \item\ignorespaces
    \makebox[-2.5pt]{%
      \begin{tikzpicture}[overlay]
        \node[draw=maincolor!60,line width=1pt,circle,fill=maincolor!25,
              font=\sffamily\bfseries,inner sep=2pt,outer sep=0pt]
          at (-15pt,0pt) {\textcolor{maincolor}{#1}};
      \end{tikzpicture}}
    \advance\baselineskip -1pt}{%
  \end{list}\vskip5pt
}

%-------------------------------------------------------------------------------
% Sectienummering in de marges
%-------------------------------------------------------------------------------

\renewcommand{\@seccntformat}[1]{\llap{\textcolor{maincolor}{\csname the#1\endcsname}\hspace{1em}}}
\renewcommand{\section}{\@startsection{section}{1}{\z@}
  {-4ex \@plus -1ex \@minus -.4ex}
  {1ex \@plus.2ex }
  {\normalfont\large\sffamily\bfseries}}
\renewcommand{\subsection}{\@startsection {subsection}{2}{\z@}
  {-3ex \@plus -0.1ex \@minus -.4ex}
  {0.5ex \@plus.2ex }
  {\normalfont\sffamily\bfseries}}
\renewcommand{\subsubsection}{\@startsection {subsubsection}{3}{\z@}
  {-2ex \@plus -0.1ex \@minus -.2ex}
  {.2ex \@plus.2ex }
  {\normalfont\small\sffamily\bfseries}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}
  {-2ex \@plus-.2ex \@minus .2ex}
  {.1ex}
  {\normalfont\small\sffamily\bfseries}}

%-------------------------------------------------------------------------------
% Hoofdingen van delen (\part)
%-------------------------------------------------------------------------------

\RequirePackage{calc} % For simpler calculation - used for spacing the index letter headings correctly
% numbered part in the table of contents
\newcommand{\@mypartnumtocformat}[2]{%
  \setlength\fboxsep{0pt}%
  \noindent\colorbox{maincolor!20}{\strut\parbox[c][.7cm]{\ecart}{\color{maincolor!70}\Large\sffamily\bfseries\centering#1}}\hskip\esp\colorbox{maincolor!40}{\strut\parbox[c][.7cm]{\linewidth-\ecart-\esp}{\Large\sffamily\centering#2}}}%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% unnumbered part in the table of contents
\newcommand{\@myparttocformat}[1]{%
  \setlength\fboxsep{0pt}%
  \noindent\colorbox{maincolor!40}{\strut\parbox[c][.7cm]{\linewidth}{\Large\sffamily\centering#1}}}%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newlength\esp
\setlength\esp{4pt}
\newlength\ecart
\setlength\ecart{1.2cm-\esp}
\newcommand{\thepartimage}{}%
\newcommand{\partimage}[1]{\renewcommand{\thepartimage}{#1}}%
\def\@part[#1]#2{%
  \ifnum \c@secnumdepth >-2\relax%
  \refstepcounter{part}%
  \addcontentsline{toc}{part}{\texorpdfstring{\protect\@mypartnumtocformat{\thepart}{#1}}{\partname~\thepart\ ---\ #1}}
  \else%
  \addcontentsline{toc}{part}{\texorpdfstring{\protect\@myparttocformat{#1}}{#1}}%
  \fi%
  \startcontents%
  \markboth{}{}%
  {\thispagestyle{empty}%
    \begin{tikzpicture}[remember picture,overlay]%
    \node at (current page.north west){\begin{tikzpicture}[remember picture,overlay]%
      \fill[maincolor!20](0cm,0cm) rectangle (\paperwidth,-\paperheight);
      \node[anchor=north] at (4cm,-3.25cm){\color{maincolor!40}\fontsize{220}{100}\sffamily\bfseries\@Roman\c@part};
      \node[anchor=south east] at (\paperwidth-1cm,-\paperheight+1cm){\parbox[t][][t]{8.5cm}{
          \printcontents{l}{0}{\setcounter{tocdepth}{1}}%
      }};
      \node[anchor=north east] at (\paperwidth-1.5cm,-3.25cm){\parbox[t][][t]{15cm}{\strut\raggedleft\color{white}\fontsize{30}{30}\sffamily\bfseries#2}};
      \end{tikzpicture}};
\end{tikzpicture}}%
\@endpart}
\def\@spart#1{%
\startcontents%
\phantomsection
{\thispagestyle{empty}%
  \begin{tikzpicture}[remember picture,overlay]%
  \node at (current page.north west){\begin{tikzpicture}[remember picture,overlay]%
    \fill[maincolor!20](0cm,0cm) rectangle (\paperwidth,-\paperheight);
    \node[anchor=north east] at (\paperwidth-1.5cm,-3.25cm){\parbox[t][][t]{15cm}{\strut\raggedleft\color{white}\fontsize{30}{30}\sffamily\bfseries#1}};
    \end{tikzpicture}};
\end{tikzpicture}}
\addcontentsline{toc}{part}{\texorpdfstring{%
  \setlength\fboxsep{0pt}%
  \noindent\protect\colorbox{maincolor!40}{\strut\protect\parbox[c][.7cm]{\linewidth}{\Large\sffamily\protect\centering #1\quad\mbox{}}}}{#1}}%
\@endpart}
\def\@endpart{\vfil\newpage
\if@twoside
\if@openright
\null
\thispagestyle{empty}%
\newpage
\fi
\fi
\if@tempswa
\twocolumn
\fi}

%-------------------------------------------------------------------------------
% Opmaak hoofdstuktitels
%-------------------------------------------------------------------------------
% Je kan optioneel een afbeelding invoegen als achtergrond van de titel door de
% boolean \usechapterimage in te stellen en de te gebruiken afbeelding op te
% geven:
%
% \usechapterimagetrue
% \chapterimage{background-image}

\newif\ifusechapterimage
\usechapterimagetrue
\newcommand{\thechapterimage}{}%
\newcommand{\chapterimage}[1]{\ifusechapterimage\renewcommand{\thechapterimage}{#1}\fi}%
\def\@makechapterhead#1{%
{\parindent \z@ \raggedright \normalfont
\ifnum \c@secnumdepth >\m@ne
\if@mainmatter
\begin{tikzpicture}[remember picture,overlay]
\node at (current page.north west)
{\begin{tikzpicture}[remember picture,overlay]
  \node[anchor=north west,inner sep=0pt] at (0,0) {\ifusechapterimage\includegraphics[width=\paperwidth]{\thechapterimage}\fi};
  \draw[anchor=west] (\Gm@lmargin,-9cm) node [line width=2pt,rounded corners=15pt,draw=maincolor,fill=white,fill opacity=0.5,inner sep=15pt]{\strut\makebox[22cm]{}};
  \draw[anchor=west] (\Gm@lmargin+.3cm,-9cm) node {\huge\sffamily\bfseries\color{black}\thechapter. #1\strut};
  \end{tikzpicture}};
\end{tikzpicture}
\else
\begin{tikzpicture}[remember picture,overlay]
\node at (current page.north west)
{\begin{tikzpicture}[remember picture,overlay]
\node[anchor=north west,inner sep=0pt] at (0,0) {\ifusechapterimage\includegraphics[width=\paperwidth]{\thechapterimage}\fi};
\draw[anchor=west] (\Gm@lmargin,-9cm) node [line width=2pt,rounded corners=15pt,draw=maincolor,fill=white,fill opacity=0.5,inner sep=15pt]{\strut\makebox[22cm]{}};
\draw[anchor=west] (\Gm@lmargin+.3cm,-9cm) node {\huge\sffamily\bfseries\color{black}#1\strut};
\end{tikzpicture}};
\end{tikzpicture}
\fi\fi\par\vspace*{270\p@}}}

\def\@makeschapterhead#1{%
\begin{tikzpicture}[remember picture,overlay]
\node at (current page.north west)
{\begin{tikzpicture}[remember picture,overlay]
\node[anchor=north west,inner sep=0pt] at (0,0) {\ifusechapterimage\includegraphics[width=\paperwidth]{\thechapterimage}\fi};
\draw[anchor=west] (\Gm@lmargin,-9cm) node [line width=2pt,rounded corners=15pt,draw=maincolor,fill=white,fill opacity=0.5,inner sep=15pt]{\strut\makebox[22cm]{}};
\draw[anchor=west] (\Gm@lmargin+.3cm,-9cm) node {\huge\sffamily\bfseries\color{black}#1\strut};
\end{tikzpicture}};
\end{tikzpicture}
\par\vspace*{270\p@}}

%-------------------------------------------------------------------------------
% Hyperlinks
%-------------------------------------------------------------------------------

\RequirePackage{hyperref}
\hypersetup{hidelinks,colorlinks=false,breaklinks=true,urlcolor=maincolor,bookmarksopen=false}

\RequirePackage{bookmark}
\bookmarksetup{
open,
numbered,
addtohook={%
\ifnum\bookmarkget{level}=0 % chapter
\bookmarksetup{bold}%
\fi
\ifnum\bookmarkget{level}=-1 % part
\bookmarksetup{color=maincolor,bold}%
\fi
}
}

%-------------------------------------------------------------------------------
% Broncode
%-------------------------------------------------------------------------------
% Commando voor invoegen broncodebestanden (dank aan Niels Corneille). Het
% neemt 3 verplichte parameters:
% 1. programmeertaal
% 2. pad naar broncodebestand
% 3. bijschrijft met uitleg over de code
%
% Voorbeeld:
%   \codefragment{java}{source/MijnKlasse.java}{Bijschrift met uitleg}
%
\newcommand{\codefragment}[3]{ \lstset{%
language={#1},
breaklines=true,
float=th,
caption={#3},
basicstyle=\scriptsize,
frame=single,
extendedchars=\true
}
\lstinputlisting{#2}}

%-------------------------------------------------------------------------------
% Bibliografie en index
%-------------------------------------------------------------------------------

\RequirePackage[style=apa,backend=biber]{biblatex}
\RequirePackage{csquotes}
\DeclareLanguageMapping{dutch}{dutch-apa}
\addbibresource{bachproef-tin.bib} % BibTeX bibliography file
\addbibresource{../voorstel/voorstel.bib}
\defbibheading{bibempty}{}

\RequirePackage{makeidx} % Required to make an index
\makeindex % Tells LaTeX to create the files required for indexing

%-------------------------------------------------------------------------------
% Andere packages
%-------------------------------------------------------------------------------

\RequirePackage{lipsum}          % Voor vultekst (lorem ipsum)

\endinput