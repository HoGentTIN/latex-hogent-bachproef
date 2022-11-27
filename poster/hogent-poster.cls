%% -----------------------------------------------------------------------------
%% hogent-poster.cls --- Conference poster for use at HOGENT
%% 
%% Based on `a0poster.cls', Copyright (C) 07.05.97 Gerlinde Kettl and
%%    Matthias Weiser
%% This template has been downloaded from: http://www.LaTeXTemplates.com
%%
%% Adapter by Jens Buysse and Bert Van Vreckem for Hogeschool Gent
%%
%% License:
%% CC BY-NC-SA 3.0 (http://creativecommons.org/licenses/by-nc-sa/3.0/)

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hogent-poster}[2022/11/27 Poster voor de bachelorproef toegepaste informatica @HOGENT]
\LoadClass{article}

%%============================================================================
%% Required packages
%%============================================================================

\RequirePackage[xetex,footskip=12cm]{geometry}
\RequirePackage[xetex]{graphicx}
\graphicspath{{figures/}} % Location of the graphics files

\RequirePackage[xetex,plainpages=false,breaklinks]{hyperref}
\RequirePackage{booktabs} % Top and bottom rules for table
\RequirePackage[font=small,labelfont=bf]{caption} % Required for specifying captions to tables and figures
\RequirePackage{wrapfig} % Allows wrapping text around tables and figures
\RequirePackage[export]{adjustbox}

%%============================================================================
%% Process options
%%============================================================================

\newif\ifportrait
\newif\ifanullb
\newif\ifanull
\newif\ifaeins
\newif\ifazwei
\newif\ifadrei
\newif\ifpreview

\newcount\xkoord
\newcount\ykoord
\newcount\xscale
\newcount\yscale

\DeclareOption{a0b}{
\anullbtrue
\xkoord=2592 % big points (1 bp=1/72 inch)
\ykoord=3666 % big points (1 bp=1/72 inch)
\xscale=23
\yscale=23
}
\DeclareOption{a0}{
\anulltrue\anullbfalse
\xkoord=2380 % big points (1 bp=1/72 inch)
\ykoord=3368 % big points (1 bp=1/72 inch)
\xscale=25
\yscale=25
}
\DeclareOption{a1}{
\aeinstrue\anullbfalse
\xkoord=1684 % big points (1 bp=1/72 inch)
\ykoord=2380 % big points (1 bp=1/72 inch)
\xscale=3
\yscale=3
}
\DeclareOption{a2}{
\azweitrue\anullbfalse
\xkoord=1190 % big points (1 bp=1/72 inch)
\ykoord=1684 % big points (1 bp=1/72 inch)
\xscale=4
\yscale=4

}
\DeclareOption{a3}{
\adreitrue\anullbfalse
\xkoord=842  % big points (1 bp=1/72 inch)
\ykoord=1190 % big points (1 bp=1/72 inch)
\xscale=6
\yscale=6
}
\DeclareOption{landscape}{
\portraitfalse
}
\DeclareOption{portrait}{
\portraittrue
}
\DeclareOption{preview}{
\previewtrue
}
\DeclareOption{final}{
\previewfalse
}

% Select a language: add option english or dutch, default=dutch
\newif\if@dutch
\newif\if@english
\DeclareOption{dutch}{\@dutchtrue\@englishfalse}
\DeclareOption{english}{\@dutchfalse\@englishtrue}

\DeclareOption*{\PackageWarning{hogent-poster}{Unknown Option \CurrentOption}}
\ExecuteOptions{dutch,landscape,a0b,final}
\ProcessOptions\relax

\if@english
  \RequirePackage[english]{babel}
\else
  \RequirePackage[dutch]{babel}
\fi

%%============================================================================
%% Variabelen voor documentmetadata
%%============================================================================

\let\@subtitle\@empty
\let\@studyprogramme\@empty  % e.g. applied informatics, office management, etc.
\let\@course\@empty          % e.g. research methods, data science, etc.
\let\@academicyear\@empty    % e.g. 2022--2023
\let\@email\@empty           % e.g. ernst.aarden@student.hogent.be
\let\@supervisor\@empty      % specifically for bachelor thesis proposal
\let\@institution\@empty
\let\@projectrepo\@empty     % e.g. https://github.com/user/some-repo
\let\@specialisation\@empty  % e.g. System and Network Admin, Data engineering
\let\@keywords\@empty

\newcommand{\subtitle}[1]{\def\@subtitle{#1}}
\newcommand{\email}[1]{\def\@email{#1}}
\newcommand{\studyprogramme}[1]{\def\@studyprogramme{#1}}
\newcommand{\course}[1]{\def\@course{#1}}
\newcommand{\academicyear}[1]{\def\@academicyear{#1}}
\newcommand{\supervisor}[1]{\def\@supervisor{#1}}
\newcommand{\cosupervisor}[1]{\def\@cosupervisor{#1}}
\newcommand{\projectrepo}[1]{\def\@projectrepo{#1}}
\newcommand{\institution}[1]{\def\@institution{#1}}

\newcommand{\specialisation}[1]{\def\@specialisation{#1}}
\newcommand{\keywords}[1]{\def\@keywords{#1}}

\@onlypreamble\studyprogramme
\@onlypreamble\course
\@onlypreamble\academicyear
\@onlypreamble\supervisor
\@onlypreamble\cosupervisor
\@onlypreamble\projectrepo
\@onlypreamble\keywords
\@onlypreamble\institution

%%============================================================================
%% Kleuren HoGent huisstijl
%%============================================================================

\usepackage[dvipsnames]{xcolor}

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

\colorlet{links}{hogent-blue}
\colorlet{title}{hogent-blue}

%%============================================================================
%% Grootte papier
%%============================================================================

\ifanullb
   \setlength{\paperwidth}{129.3cm} %% 36 * sqrt(2) in
   \setlength{\paperheight}{91.4cm} %% 36 in
   \setlength{\textwidth}{119.3cm} %% paperwidth - (5cm + 5cm)
   \setlength{\textheight}{81.4cm} %% paperheight - (5cm + 5cm)
\else\ifanull
        \setlength{\paperwidth}{118.9cm}
        \setlength{\paperheight}{84.1cm}
        \setlength{\textwidth}{108.9cm} %% paperwidth - (5cm + 5cm)
        \setlength{\textheight}{74.1cm} %% paperheight - (5cm + 5cm)
     \else\ifaeins
             \setlength{\paperwidth}{84.1cm}
             \setlength{\paperheight}{59.4cm}
             \setlength{\textwidth}{74.1cm}
             \setlength{\textheight}{49.4cm}
          \else\ifazwei
                  \setlength{\paperwidth}{59.4cm}
                  \setlength{\paperheight}{42.0cm}
                  \setlength{\textwidth}{53.4cm}
                  \setlength{\textheight}{36.0cm}
               \else\ifadrei
                       \setlength{\paperwidth}{42.0cm}
                       \setlength{\paperheight}{29.7cm}
                       \setlength{\textwidth}{37.0cm}
                       \setlength{\textheight}{24.7cm}
                    \else\relax
                    \fi
               \fi
          \fi
     \fi
\fi

\ifportrait
   \newdimen\tausch
   \setlength{\tausch}{\paperwidth}
   \setlength{\paperwidth}{\paperheight}
   \setlength{\paperheight}{\tausch}
   \setlength{\tausch}{\textwidth}
   \setlength{\textwidth}{\textheight}
   \setlength{\textheight}{\tausch}
\else\relax
\fi

%% Setting proper dimensions for the HP2500CP printer (height = 36 in)
%%   Landscape: unprintable areas
%%   	L: 27.6mm
%%   	R: 27.1mm
%%   	T: 18.4mm
%%   	B: 18.1mm

\voffset -1in
\hoffset -1in

\setlength{\headheight}{0 cm}
\setlength{\headsep}{0 cm}
\ifadrei
\setlength{\topmargin}{2.5 cm}
\setlength{\oddsidemargin}{2.5 cm}
\else\ifazwei
\setlength{\topmargin}{3 cm}
\setlength{\oddsidemargin}{3 cm}
\else
\setlength{\topmargin}{5 cm} %% 3 cm for unprintable at top
                             %% (landscape) + 2 cm from border
\setlength{\oddsidemargin}{5 cm} %% 3 cm for unprintable at left
                                 %% (landscape) + 2 cm from border
\fi
\setlength{\topskip}{0 cm}

\input{a0size.sty}

%%============================================================================
%% Layout
%%============================================================================

\usepackage{multicol} % This is so we can have multiple columns of text side-by-side
\columnsep=100pt % This is the amount of white space between the columns in the poster
\columnseprule=3pt % This is the thickness of the black line between the columns in the poster

%% -----------------------------------------------------------------------------
%% Titel

\renewcommand{\@maketitle}{%
  \begingroup
    \raggedright\titlefont\color{title}\Large
    \textsc{\@course\ \@studyprogramme\ (\@academicyear)}
  \endgroup

  \begingroup
    \medskip
    \raggedright\titlefont\color{title}\VeryHuge\@title

    \if\@subtitle\@empty\else
      \raggedright\titlefont\Huge\textit{\@subtitle}
    \fi
  \endgroup

  \begingroup
    \bigskip
    \raggedright\huge\textbf{\@author}

    \if\@email\@empty\else
      \medskip
      \raggedright\@email
    \fi
  \endgroup

  \begingroup
    \if\@supervisor\@empty\else
      \medskip
      \raggedright\Large Promotor: \@supervisor
    \fi

    \if\@cosupervisor\@empty\else
      \medskip
      \raggedright\Large Co-promotor: \@cosupervisor
    \fi
  \endgroup

  \begingroup
    \bigskip
    \raggedright\Large\@institution
  \endgroup
   
  \bigskip
}

%%============================================================================
%% Header/footer
%%============================================================================

\RequirePackage{tikz}
\RequirePackage{fancyhdr}
\usetikzlibrary{calc}
\RequirePackage{tikzpagenodes}
\pagestyle{fancy}

% Clear default definitions
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}

%% Use the length of the 'HO' part of the logo to set the padding of the logo
\newsavebox{\logopart}
\savebox{\logopart}{\includegraphics[height=7cm]{logopart}}

% First page footer
\fancypagestyle{plain}{%
  %\newgeometry{bottom=\wd\logopart}
  \fancyhf{}%
  \fancyfoot[L]{}%
  \fancyfoot[C]{}
  \fancyfoot[R]{%
  \begin{tikzpicture}[remember picture, overlay]
    \node [anchor=south east, shift={(-\the\wd\logopart, \the\wd\logopart)}, inner sep=0, outer sep=0] (logo) at (current page.south east)%
    {%
      \includegraphics[height=\the\ht\logopart]{hogent_logo}%
    };%
  \end{tikzpicture}
  }%
}

%%============================================================================
%% Lettertypes
%%============================================================================

\RequirePackage{fontspec}
\RequirePackage{unicode-math}

\newfontfamily\montserratblack{Montserrat}[BoldFont={Montserrat Black}]
\newfontfamily\montserratextrabold{Montserrat}%
    [BoldFont={Montserrat ExtraBold}]

\def\titlefont{\montserratblack\bfseries}
\def\tocfont{\montserratblack}

\setmainfont{Montserrat}      % Font selection
\setmathfont{Fira Math}
\setmonofont{Fira Code}

\renewcommand{\tiny}{\fontsize{12}{14}\selectfont}
\renewcommand{\scriptsize}{\fontsize{14.4}{18}\selectfont}   
\renewcommand{\footnotesize}{\fontsize{17.28}{22}\selectfont}
\renewcommand{\small}{\fontsize{20.74}{25}\selectfont}
\renewcommand{\normalsize}{\fontsize{24.88}{30}\selectfont}
\renewcommand{\large}{\fontsize{29.86}{37}\selectfont}
\renewcommand{\Large}{\fontsize{35.83}{45}\selectfont}
\renewcommand{\LARGE}{\fontsize{43}{54}\selectfont}
\renewcommand{\huge}{\fontsize{51.6}{64}\selectfont}
\renewcommand{\Huge}{\fontsize{61.92}{77}\selectfont}
\newcommand{\veryHuge}{\fontsize{74.3}{93}\selectfont}
\newcommand{\VeryHuge}{\fontsize{89.16}{112}\selectfont}
\newcommand{\VERYHuge}{\fontsize{107}{134}\selectfont}

\setlength\smallskipamount{6pt plus 2pt minus 2pt}
\setlength\medskipamount{12pt plus 4pt minus 4pt}
\setlength\bigskipamount{24pt plus 8pt minus 8pt}

\setlength\abovecaptionskip{25pt}
\setlength\belowcaptionskip{0pt}
\setlength\abovedisplayskip{25pt plus 6pt minus 15 pt}
\setlength\abovedisplayshortskip{0pt plus 6pt}
\setlength\belowdisplayshortskip{13pt plus 7pt minus 6pt}
\setlength\belowdisplayskip\abovedisplayskip

\normalsize

\AtBeginDocument{
\ifanullb
   \ifportrait\special{papersize=91.4cm,129.3cm}\else\special{papersize=129.3cm,91.4cm}\fi
\else\ifanull
        \ifportrait\special{papersize=83.96cm,118.82cm}\else\special{papersize=118.82cm,83.96cm}\fi
     \else\ifaeins
             \ifportrait\special{papersize=59.4cm,83.96cm}\else\special{papersize=83.96cm,59.4cm}\fi
          \else\ifazwei
                  \ifportrait\special{papersize=41.98cm,59.4cm}\else\special{papersize=59.4cm,41.98cm}\fi
               \else\ifadrei
                      \ifpreview
                       \ifportrait\special{papersize=29.7cm,41.35cm}\else\special{papersize=41.98cm,29.0cm}\fi
                      \else
                       \ifportrait\special{papersize=29.7cm,41.98cm}\else\special{papersize=41.98cm,29.7cm}\fi
                      \fi
                    \else\relax
                    \fi
               \fi
          \fi
     \fi
\fi
\pagestyle{empty}}


%% -----------------------------------------------------------------------------
%% Heading format

\RequirePackage{titlesec}
\RequirePackage{titletoc}

%% Section headers
\titleformat{\section}
    {\Large\titlefont}
    {\bfseries\thesection.\ }
    {0pt}
    {\bfseries\color{title}}

%% Sections are preceded by an empty line.
\titlespacing{\section}{0pt}{\baselineskip}{3pt}

%% Subsection headers
\titleformat{\subsection}
    {\large\titlefont}
    {\bfseries\thesubsection.\ }
    {1.8pt}
    {\bfseries}
\titlespacing{\subsection}{0pt}{.75\baselineskip}{3pt}

%% Subsubsection headers
\titleformat{\subsubsection}
    {\normalsize\titlefont}
    {\bfseries\thesubsubsection.\ }
    {1.8pt}
    {\bfseries}
\titlespacing{\subsubsection}{0pt}{.5\baselineskip}{3pt}

%% -----------------------------------------------------------------------------
%% Abstract

\renewenvironment{abstract}
{%
  \bigskip\bigskip
  \addtolength{\leftmargin}{1em}

  \begin{center}
    {\Large\titlefont\abstractname}
  \end{center}
  \list{}{%
    \setlength{\leftmargin}{2cm}
    \setlength{\rightmargin}{\leftmargin}}%
  \item\relax\normalfont\itshape
}{%
  
  \if\@specialisation\@empty\else
    \medskip
    \normalfont\noindent\if@english Specialisation: \else Keuzerichting: \fi
    \@specialisation
  \fi
  
  \if\@keywords\@empty\else
    \medskip
    \normalfont\noindent\if@english Keywords: \else Sleutelwoorden: \fi
    \@keywords
  \fi
  
  \if\@projectrepo\@empty\else
    \medskip
    \normalfont\noindent\if@english Source code: \else Broncode: \fi
    \url{\@projectrepo}
  \fi
  \endlist

  \bigskip
}

\endinput
%% End of file `hogent-poster.cls'.