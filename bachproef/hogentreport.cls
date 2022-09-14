%% University College Ghent (HOGENT) report/thesis class
%%
%% hogentreport.cls
%%
%% Based on the TU Delft LaTeX template for reports and theses.
%% (https://www.tudelft.nl/en/tu-delft-corporate-design/downloads/)
%%
%% Inspired by the LaTeX template for the Bachelor of Applied
%% Computer Science of the Faculty of Business and Information Management
%% at the University College Ghent, authored by Bert Van Vreckem.
%% (https://github.com/HoGentTIN/bachproef-latex-sjabloon)
%%
%% Best suited for compiling using XeLaTeX or LuaTeX,
%% but there is support for native fonts, automatically when using
%% LaTeX/PDFLaTeX, or forced by specifying the 'nativefonts' option.
%%
%% Author: Pieter van der Kloet (pvdkloet at gmail.com)
%%
%% License: MIT license
%% (See LICENSE for more information)
%%

\NeedsTeXFormat{LaTeX2e}
\def\@classname{hogentreport}
\ProvidesClass{hogentreport}[2022/06/20 Hogeschool Gent report/thesis class]

\RequirePackage{xkeyval}
\RequirePackage{iflang}

%% Ensure the variables can be checked with \ifx\@variable\@empty
\let\@author\@empty
\let\@title\@empty
\let\@supervisor\@empty
\let\@cosupervisor\@empty
\let\@institution\@empty
\let\@academicyear\@empty
\let\@examperiod\@empty
\let\@degreesought\@empty

\let\@department\@empty
\let\@department@nr\@empty

\newcommand{\supervisor}[1]{\def\@supervisor{#1}}
\newcommand{\cosupervisor}[1]{\def\@cosupervisor{#1}}
\newcommand{\institution}[1]{\def\@institution{#1}}
\newcommand{\academicyear}[1]{\def\@academicyear{#1}}
\newcommand{\examperiod}[1]{\def\@examperiod{#1}}
\newcommand{\degreesought}[1]{\def\@degreesought{#1}}

\define@choicekey*+{hogentreport}{department}[\@department\@department@nr]
{dbo,dbt,dgz,dit,dlo,dog,dsa,soa}{}{%
    \ClassError{\@classname}{The department parameter is undefined}
    {One of the following options for the department must be added to the class%
        options: dbo, dbt, dgz, dit, dlo, dog, dsa, soa}}

\def\@DeclareDept#1{\DeclareOptionX{#1}{\setkeys{hogentreport}{department=#1}}}
\@DeclareDept{dbo}
\@DeclareDept{dbt}
\@DeclareDept{dgz}
\@DeclareDept{dit}
\@DeclareDept{dlo}
\@DeclareDept{dog}
\@DeclareDept{dsa}
\@DeclareDept{soa}

%% Redefine the title command to accept an optional subtitle
\renewcommand*\title[2][]{%
    \def\@title{#2}%
    \def\@subtitle{#1}%
}

%% Thesis or report?
\newif\if@thesis
\newif\if@report
\DeclareOptionX{thesis}{\@thesistrue\@reportfalse}
\DeclareOptionX{report}{\@thesisfalse\@reporttrue}
\ExecuteOptionsX{report} %% Default document type

%% Check the variables that need to be defined for the title page
\newcommand{\@checkvariables}{%

    \ifx\@author\@empty{%
        \ClassError{\@classname}{Author is undefined!}%
        {Use the \author command to define it}
    }\fi

    \ifx\@title\@empty{%
        \ClassError{\@classname}{Title is undefined!}%
            {Use the \title command to define it}
    }\fi
    \ifx\@academicyear\@empty{%
      \ClassError{\@classname}{Academic year is undefined!}%
      {Use the \academicyear command to define it}
    }\fi  
  
    %% The following variables only need to be defined for a thesis
    \if@thesis
      \ifx\@supervisor\@empty{%
          \ClassError{\@classname}{Student supervisor is undefined!}%
              {Use the \supervisor command to define it}
      }\fi
      \ifx\@examperiod\@empty{%
          \ClassError{\@classname}{Exam period is undefined!}%
              {Use the \examperiod command to define it}
      }\fi
      \ifx\@degreesought\@empty{%
          \ClassError{\@classname}{Degree sought is undefined!}%
              {Use the \degreesought command to define it}
      }\fi
    \fi
  
    %% Since the input is there, set the PDF info
    \hypersetup{%
        pdftitle=\@title,
        pdfauthor=\@author
    }
}

\newif\if@dutch
\newif\if@english
\DeclareOptionX{dutch}{\@dutchtrue\@englishfalse}
\DeclareOptionX{english}{\@dutchfalse\@englishtrue}
\ExecuteOptionsX{english} %% Default language

\newif\if@partial
\define@boolkey+{hogentreport}{partial}[false]{%
    \ifKV@hogentreport@partial
        \@partialtrue
    \else
        \@partialfalse
    \fi
}{%
    \ClassWarning{\@classname}{Input not boolean, ignored}
}
\DeclareOptionX{partial}{\setkeys{\@classname}{partial}}
%% Allows the partial boolean to be set with a command
\newcommand{\partialthesis}[1]{\setkeys{\@classname}{partial=#1}}

\newif\if@nativefonts
\DeclareOptionX{nativefonts}{\@nativefontstrue}

\newif\if@print
\DeclareOptionX{print}{\@printtrue}

\DeclareOption{twocolumn}{
    \OptionNotUsed
    \ClassError{\@classname}{Only single column documents supported!}%
        {Please remove the option 'twocolumn'}
}

%% Pass the unknown options to the class
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{book}}

\ProcessOptionsX\relax
\LoadClass[11pt]{book}

%% English is the default language, but this can be changed to Dutch by
%% specifying the 'dutch' option to the document class
\if@dutch
    \RequirePackage[dutch]{babel}
    \RequirePackage[style=apa,natbib,backend=biber]{biblatex}
    \DeclareLanguageMapping{dutch}{dutch-apa}
\else
    %% We need Dutch for English theses, e.g. on the translated title page
    \RequirePackage[main=english,dutch]{babel}
    \RequirePackage[backend=biber,style=apa]{biblatex}
    \DeclareLanguageMapping{english}{british-apa}
\fi
\RequirePackage{csquotes}

\RequirePackage[small,bf,nooneline,footnotesize]{caption}
\RequirePackage[flushmargin,hang]{footmisc}
\RequirePackage{ifpdf}
\RequirePackage{ifxetex}
\RequirePackage{ifluatex}

\ifxetex
    \RequirePackage[xetex]{geometry}
    \RequirePackage[xetex]{graphicx}
    \RequirePackage[xetex,plainpages=false,breaklinks]{hyperref}
    \RequirePackage[no-math]{fontspec}
    \RequirePackage[mathrm=sym]{unicode-math}
    \unimathsetup{math-style=ISO,bold-style=ISO,sans-style=upright,mathrm=sym}
    \RequirePackage{realscripts}
    \defaultfontfeatures{Ligatures=TeX}
\else
    \ifluatex
        \RequirePackage[luatex]{geometry}
        \RequirePackage[luatex]{graphicx}
        \RequirePackage[luatex,plainpages=false]{hyperref}
        \RequirePackage[no-math]{fontspec}

        \RequirePackage[mathrm=sym]{unicode-math}
        \unimathsetup{math-style=ISO,bold-style=ISO,sans-style=upright,
        mathrm=sym}
        \RequirePackage{lualatex-math}
        \RequirePackage{realscripts}
    \else
        \@nativefontstrue %% Force native font rendering
        \ifpdf
            \RequirePackage[pdftex]{geometry}
            \RequirePackage[pdftex]{graphicx}
            \RequirePackage[pdftex,plainpages=false,breaklinks]{hyperref}
        \else
            \RequirePackage[dvips]{geometry}
            \RequirePackage[dvips]{graphicx}
            \RequirePackage[hypertex,plainpages=false,breaklinks]{hyperref}
        \fi
    \fi
\fi

\if@print
    \RequirePackage[gray]{xcolor}
\else
    \RequirePackage[dvipsnames]{xcolor}
\fi

% Graphics related packages
\RequirePackage{tikz}
\usetikzlibrary{backgrounds}
\usetikzlibrary{positioning}
\RequirePackage{standalone}
\RequirePackage{wrapfig}

% Page layout & document structure
\RequirePackage{appendix}
\RequirePackage{booktabs}
\RequirePackage{enumitem}
%\setlist{noitemsep}
%\setlist[enumerate]{itemsep=1pt}
%\setlist[itemize]{itemsep=1pt}
%\setlist{parsep=\topskip}
%\setlist{topsep=\topskip}
%\setlist{partopsep=\topskip}
\RequirePackage{fancyhdr}
\RequirePackage{makeidx}
\RequirePackage{makecell}
\RequirePackage{pdfpages}
\RequirePackage{rotating}
\RequirePackage{tabularx}
\RequirePackage{tcolorbox}
\RequirePackage[noindentafter]{titlesec}
\RequirePackage{titletoc}
\RequirePackage[nottoc]{tocbibind}
\RequirePackage{url}

\captionsetup[figure]{labelformat=parens, labelsep=newline}

% Typography & Symbols
\RequirePackage{eurosym}
\RequirePackage{microtype}
\RequirePackage{textcomp}
\RequirePackage{xspace}
\RequirePackage{csquotes}

%% Accent colors:
\definecolor{hogent-darkgreen}{RGB}{22,176,165}
\definecolor{hogent-pink}{RGB}{241,157,160}
\definecolor{hogent-ochre}{RGB}{250,188,50}
\definecolor{hogent-orange}{RGB}{239,135,103}
\definecolor{hogent-purple}{RGB}{187,144,189}
\definecolor{hogent-blue}{RGB}{76,162,213}
\definecolor{hogent-lightgreen}{RGB}{165,202,114}
\definecolor{hogent-brown}{RGB}{216,176,131}
\definecolor{hogent-grey}{RGB}{195,187,175}
\definecolor{hogent-yellow}{RGB}{244,222,0}

\colorlet{links}{hogent-blue} %% The color to be used for urls and references

%% Setting of the department text and title color based on the class option
\ifx\@department\@empty{%
    \ClassError{\@classname}{Department parameter is undefined!}%
    {One of the following options must be added to the class options:%
        dbo, dgz, dit, dlo, dog, dsa, soa}%
}\fi

\ifcase\@department@nr%
\relax
    \colorlet{title}{hogent-purple}% dbo
\or
    \colorlet{title}{hogent-darkgreen}% dbt
\or
    \colorlet{title}{hogent-pink}% dgz
\or
    \colorlet{title}{hogent-orange}% dit
\or
    \colorlet{title}{hogent-blue}% dlo
\or
    \colorlet{title}{hogent-lightgreen}% dog
\or
    \colorlet{title}{hogent-grey}% dsa
\else
    \colorlet{title}{black}% soa
\fi

\newcommand{\@departmentname}{%
    \ifcase\@department@nr%
    \relax %dbo
        \IfLanguageName{dutch}{Departement Bedrijf en Organisatie}%
            {School of Business Management}%
    \or % dbt
        \IfLanguageName{dutch}{Departement Biowetenschappen en Industriële Technologie}%
            {School of Bioscience and Industrial Technology}%
    \or %dgz
        \IfLanguageName{dutch}{Departement Gezondheidszorg}%
            {School of Healthcare}
    \or %dit
        \IfLanguageName{dutch}{Departement IT en Digitale Innovatie}%
            {School of IT and Digital Innovation}
    \or %dlo
        \IfLanguageName{dutch}{Departement Lerarenopleiding}%
            {School of Teacher Training}
    \or %dog
        \IfLanguageName{dutch}{Departement Omgeving}%
            {School of Built Environment}
    \or %dsa
        \IfLanguageName{dutch}{Departement Sociaal-Agogisch Werk}%
            {School of Social Welfare}
    \else %soa
        School of Arts%
    \fi
}

%% No title and link colors in print mode
\if@print
    \colorlet{title}{black}
    \colorlet{links}{black}
\fi

%% Font setup
\if@nativefonts
    \let\titlefont\@undefined
    \let\subtitlefont\@undefined
    \let\tocfont\@undefined

    \ClassInfo{\@classname}{Option 'nativefonts' set or
        not running XeLaTeX/LuaLaTeX: using native fonts}

    \RequirePackage[defaultfam,tabular,lining]{montserrat}
    \RequirePackage{firamath}
    \RequirePackage{sfmath} % Fallback sans serif math font

    \RequirePackage[T1]{fontenc}
    \renewcommand*\oldstylenums[1]{{\fontfamily{Montserrat-TOsF}\selectfont #1}}

    \def\titlefont{\fontseries{k}\selectfont} %% Set the black family for titles
    \def\subtitlefont{\fontseries{eb}\selectfont}
    \def\tocfont{\fontseries{m}\selectfont}
    \def\titlestyle{\titlefont\bfseries}
\else
    %% Using fontspec for font rendering, first check system paths
    %% for font availability, if not fall back to local .otf files
    \IfFontExistsTF{Montserrat}{%
        \newfontfamily\montserratblack{Montserrat}[BoldFont={Montserrat Black}]
        \newfontfamily\montserratextrabold{Montserrat}%
            [BoldFont={Montserrat ExtraBold}]

        \def\titlefont{\montserratblack\bfseries}
        \def\subtitlefont{\montserratextrabold\bfseries}
        \def\tocfont{\montserratblack}

        \setmainfont{Montserrat}
        \setsansfont{Montserrat}
    }{%
        \newfontfamily\titlefont{Montserrat}[
            Path = fonts/Montserrat/,
            Extension = .otf,
            UprightFont = *-Black, %% Force black
            BoldFont=*-Black,
            ItalicFont=*-BlackItalic,
            BoldItalicFont= *-BlackItalic]

        \newfontfamily\subtitlefont{Montserrat}[
            Path = fonts/Montserrat/,
            Extension = .otf,
            UprightFont = *-ExtraBold, %% Force extra bold
            BoldFont=*-ExtraBold,
            ItalicFont=*-ExtraBoldItalic,
            BoldItalicFont= *-ExtraBoldItalic]

        \newfontfamily\tocfont{Montserrat}[
            Path = fonts/Montserrat/,
            Extension = .otf,
            UprightFont = *-Regular,
            BoldFont=*-Bold,
            ItalicFont=*-Italic,
            BoldItalicFont= *-BoldItalic]

        \setmainfont{Montserrat}[
            Path = fonts/Montserrat/,
            Extension = .otf,
            UprightFont = *-Regular,
            BoldFont=*-Bold,
            ItalicFont=*-Italic,
            BoldItalicFont= *-BoldItalic]

        \setsansfont{Montserrat}[
            Path = fonts/Montserrat/,
            Extension = .otf,
            UprightFont = *-Regular,
            BoldFont=*-Bold,
            ItalicFont=*-Italic,
            BoldItalicFont= *-BoldItalic]
    }

    \IfFontExistsTF{Fira Code}{%
            \setmonofont{Fira Code}[StylisticSet={1,3}]
            %% Shapely l, upright quotes, striked zeroes

    }{%
            \setmonofont{Fira Code}[
                Path = fonts/FiraCode/,
                Extension = .otf,
                UprightFont = *-Regular,
                BoldFont=*-Bold,
                ItalicFeatures = FakeSlant,
                BoldItalicFeatures = FakeSlant]
    }

    % Use a unicode-compliant sans serif math font
    \IfFontExistsTF{Fira Math Regular}{%
        \setmathfont{Fira Math Regular}[BoldFont=Fira Math Bold]
        \setmathfont{Fira Math Regular}[FakeSlant, range={bfit->it}]
    }{%
        \setmathfont{FiraMath-Regular.otf}[
            Path = fonts/FiraMath/,
            BoldFont=FiraMath-Bold.otf]
        \setmathfont{FiraMath-Regular.otf}[
            Path = fonts/FiraMath/,
            FakeSlant,
            range={bfit->it}]
    }

    \def\titlestyle{\titlefont\bfseries}

\fi

%% Use the length of the 'HO' part of the logo to set the padding of the logo
\newsavebox{\logopart}
\savebox{\logopart}{\includegraphics[height=2cm]{graphics/logopart}}

%% We use A4 paper with slightly smaller margins than the default (scale = 0.7)
\geometry{a4paper,hscale=0.75,vscale=0.8,headheight=14pt,asymmetric}

%% Page layout settings
\setlength{\parindent}{0cm}              %% Don't indent paragraph text
\renewcommand{\baselinestretch}{1.2}     %% Increase line height
\raggedbottom                            %% Don't equalize content on pages


%% Redefine maketitle for our custom title page
\if@titlepage%
  \renewcommand{\maketitle}{\thispagestyle{empty}\begin{titlepage}%
    \@checkvariables
    
    %% Change the geometry so the notes section doesn't bother us
    \newgeometry{top=2cm,bottom=\wd\logopart,left=1.5cm,right=1.5cm}
    
    %% Add whitespace at the top
    %\addvspace{10\bigskipamount}
    
    \begingroup
      %% Print the title in the faculty color
      \titlefont\color{title}\Huge\@title\@addpunct{.}\\
      %% Optionally print a subtitle
      \ifx\@subtitle\@empty\else
        \bigskip
        \subtitlefont\LARGE\@subtitle\@addpunct{.}
      \fi
      \hrule
    \endgroup
    \bigskip
    \begingroup
      %% Print the name of the author
      \subtitlefont\Large\bfseries \@author\@addpunct{.}
    \endgroup
    
    \vfill
    
    \if@thesis
      \begingroup
        \IfLanguageName{dutch}{%
          Scriptie voorgedragen tot het bekomen van de graad van\\
          \@degreesought\\
        }{%
          Thesis submitted in \if@partial{partial }\fi
          fulfilment of the requirements for the degree of\\ \@degreesought\\
        }
      \endgroup
    \fi
    
    \bigskip
    \bigskip
    
    \if@thesis
      \begingroup
          \IfLanguageName{dutch}{%
            \textbf{Promotor:}}{\textbf{Supervisor:}} \@supervisor\\
          \ifx\@cosupervisor\@empty\else
            \IfLanguageName{dutch}{%
              \textbf{Co-promotor:}}{%
              \textbf{Co-Supervisor:}} \@cosupervisor\\
          \fi
          \ifx\@institution\@empty\else
            \IfLanguageName{dutch}{%
              \textbf{Instelling:}}{\textbf{Institution:}} \@institution\\
          \fi
          \IfLanguageName{dutch}{%
            \textbf{Academiejaar:}}{\textbf{Academic year:}} \@academicyear\\
            \textbf{%
              \ifcase\@examperiod
              \or
                \IfLanguageName{dutch}{Eerste}{First}
              \or
                \IfLanguageName{dutch}{Tweede}{Second}
              \else
                \IfLanguageName{dutch}{Derde}{Third}
              \fi
          \IfLanguageName{dutch}{examenperiode}{exam period} } \\
      \endgroup
      
      \bigskip
    \else
        \IfLanguageName{dutch}{%
          \textbf{Academiejaar:}}{\textbf{Academic year:}} \@academicyear\\
    \fi
    \begingroup
      \subtitlefont\bfseries\@departmentname\@addpunct{.}
    \endgroup
    
    %% Insert the HoGent logo
    \begin{tikzpicture}[remember picture, overlay]
      \node [anchor=south east, shift={(-\the\wd\logopart, \the\wd\logopart)}, inner sep=0, outer sep=0] (logo) at (current page.south east)%
      {%
        \includegraphics[height=\the\ht\logopart]{hogent_logo}%
      };%
    \end{tikzpicture}

    \end{titlepage}%
    
    \thispagestyle{empty}
    \null\clearpage\restoregeometry
  }
\fi

%% Page style for title pages
\fancypagestyle{plain}{%
    \fancyhf{}
    \renewcommand*\headrulewidth{0pt}
    \renewcommand*\footrulewidth{0pt}
    \fancyfoot[C]{\thepage}
}

%% Fancy style for the main matter
\fancypagestyle{mainmatter}{%
    \fancyhf{}
    %% Page numbers on the top left and top right
    \fancyhead[LE,RO]{\thepage}
    %% Chapter name on the left (even) page
    \fancyhead[RE]{\titlefont\bfseries\nouppercase{\leftmark}}
    %% Section name on the right (odd) page
    \fancyhead[LO]{\titlefont\bfseries\nouppercase{\rightmark}}
}

%% The mainmatter style is default for normal pages
\pagestyle{mainmatter}

%% Print the current chapter and section at the top of the page
\renewcommand*\chaptermark[1]{\markboth{\thechapter.\ \color{title}#1}{}}
\renewcommand*\sectionmark[1]{\markright{\thesection.\ \color{title}#1}}

%% The setheader command can be used to print the title of unnumbered chapters
%% in the page header
\newcommand*\setheader[1]{\markboth{\color{title}#1}{\color{title}#1}}

%% Change the headrule command (from fancyhdr.sty) to draw the line below the
%% header in the title color
\renewcommand*\headrule{%
    \if@fancyplain%
        \let\headrulewidth\plainheadrulewidth%
    \fi%
    {\color{title}\hrule\@height\headrulewidth\@width\headwidth}%
    \vskip-\headrulewidth%
}

%% Change the style of paragraphs, normally text comes directly after the
%% paragraph title
\titleformat{\paragraph}[hang]{\normalfont\normalsize\bfseries}{\theparagraph}
{0pt}{}
\titlespacing\paragraph{0pt}{\baselineskip}{0pt}

%% Draw the line above a footnote in the title color as well
\renewcommand*\footnoterule{%
    \vspace*{-3pt}%
    {\color{title}\hrule width 0.5\textwidth height 0.4pt}%
    \vspace*{2.6pt}%
}

%% A part title starts with a huge (96pt) bold black number, flushed to the
%% right, followed by the part name on the next line in the title color
\titleformat{\part}[display]
    {\flushright\titlestyle}
    {\fontsize{96pt}{96pt}\selectfont\bfseries\thepart}
    {0pt}
    {\Huge\color{title}}
%% Separate the title from the text by two empty lines
\titlespacing{\part}{0pt}{0pt}{2\baselineskip}
%% In the table of contents, the part name is preceded by an empty line, printed
%% in bold, and not followed by a line of dots
\dottedcontents{part}[0em]{%
    \vspace{\baselineskip}\subtitlefont\bfseries}{1.5em}{0pc}

%% Chapter titles have the same layout as parts
\titleformat{\chapter}[display]
    {\flushright\titlestyle}
    {\fontsize{96pt}{96pt}\selectfont\bfseries\thechapter}
    {0pt}
    {\Huge\color{title}}
\titlespacing{\chapter}{0pt}{0pt}{2\baselineskip}
%% In the table of contents, a chapter is similar to a part, except that it is
%% preceded by half an empty line
\dottedcontents{chapter}[1.5em]{%
    \vspace{0.5\baselineskip}\subtitlefont\bfseries}{1.5em}{0pc}

%% Section titles start with the number in bold, followed by the name printed
%% in the title color
\titleformat{\section}
    {\Large\titlestyle}
    {\bfseries\thesection.\ }
    {0pt}
    {\color{title}}
%% Sections are preceded by an empty line.
\titlespacing{\section}{0pt}{\baselineskip}{3pt}
%% In the table of contents, section names are followed by a line of dots 8pt
%% apart
\dottedcontents{section}[3.8em]{\tocfont}{2.3em}{8pt}

%% Subsection titles have the same layout as section titles, except in a smaller
%% font
\titleformat{\subsection}
    {\large\titlestyle}
    {\bfseries\thesubsection.\ }
    {0pt}
    {\color{title}}
\titlespacing{\subsection}{0pt}{\baselineskip}{1.5pt}
\dottedcontents{subsection}[7em]{\tocfont}{3.2em}{8pt}

%% Subsubsections have the same font and color as sections and subsections, but
%% are not preceded by a number
\titleformat{\subsubsection}
    {\titlestyle}
    {}
    {0pt}
    {\color{title}}
%% Subsubsections are preceded by an empty line and do not appear in the table
%% of contents
\titlespacing{\subsubsection}{0pt}{\bigskipamount}{0pt}

%% Hyperlinks are blue, except in print mode, when they are all black
\hypersetup{%
    colorlinks = true,
    citecolor = links,
    linkcolor = title,
    urlcolor = links
}
