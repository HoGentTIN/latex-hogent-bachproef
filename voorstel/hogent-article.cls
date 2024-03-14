%% -----------------------------------------------------------------------------
%% hogent-article --- Article class to be used in the bachelor
%%   programme of applied computer science at Ghent University of
%%   Applied Sciences.
%% Email: bert.vanvreckem at hogent.be
%%
%% This class was inspired by:
%%
%% - hogentreport.cls - HOGENT report/thesis class by Pieter van der Kloet
%%   (pvdkloet at gmail.com)
%% - cup-journal.cls - Cambridge University Press article class by Paul
%%   Gessler (paul.gessler at overleaf.com)
%% -----------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\def\@classname{hogent-article}
\ProvidesClass{hogent-article}
[2022/09/01 v2.1 Artikel voor gebruik in de opleiding toegepaste informatica aan HOGENT]
\LoadClass[10pt,a4paper]{article}

%% Check compiler - issue an error if XeLaTeX was not used
\RequirePackage{ifxetex}

\ifxetex
\else
  \ClassError{\@classname}
  {Incompatible LaTeX compiler was used!}
  {Please use XeLaTeX.}
\fi

%% -----------------------------------------------------------------------------
%% Processing Package options

\RequirePackage{xkeyval} % Processing of documentclass options

% Select a language: add option english or dutch, default=dutch
\newif\if@dutch
\newif\if@english
\DeclareOptionX{dutch}{\@dutchtrue\@englishfalse}
\DeclareOptionX{english}{\@dutchfalse\@englishtrue}
\ExecuteOptionsX{dutch} %% Default language

% Number of columns: onecolumn/twocolumn
\newif\if@onecolumn
\newif\if@twocolumn
\DeclareOptionX{onecolumn}{\@onecolumntrue\@twocolumnfalse}
\DeclareOptionX{twocolumn}{\@onecolumnfalse\@twocolumntrue}
\ExecuteOptionsX{twocolumn}

%% Pass unknown options to the parent class (article)
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptionsX\relax


%% -----------------------------------------------------------------------------
%% Language selection

%% Dutch is the default language, but this can be changed to English by
%% specifying the 'english' option to the document class
\if@english
  \RequirePackage[english]{babel}
  \RequirePackage[backend=biber,style=apa]{biblatex}
  \DeclareLanguageMapping{english}{british-apa}
\else
  \RequirePackage[dutch]{babel}
  \RequirePackage[style=apa,backend=biber]{biblatex}
  \DeclareLanguageMapping{dutch}{dutch-apa}
\fi

%% -----------------------------------------------------------------------------
%% Variables for document metadata

\let\@studyprogramme\@empty  % e.g. applied informatics, office management, etc.
\let\@course\@empty          % e.g. research methods, data science, etc.
\let\@assignmenttype\@empty  % e.g. paper, research proposal, etc.
\let\@academicyear\@empty    % e.g. 2022--2023
\let\@email\@empty           % e.g. ernst.aarden@student.hogent.be
\let\@supervisor\@empty      % specifically for bachelor thesis proposal
\let\@supervisor@role\@empty
\let\@projectrepo\@empty     % e.g. https://github.com/hogenttin/some-repo
\let\@specialisation\@empty  % e.g. System and Network Admin, Data engineering
\let\@keywords\@empty

\newcommand{\studyprogramme}[1]{\def\@studyprogramme{#1}}
\newcommand{\course}[1]{\def\@course{#1}}
\newcommand{\assignmenttype}[1]{\def\@assignmenttype{#1}}
\newcommand{\academicyear}[1]{\def\@academicyear{#1}}
\newcommand{\supervisor}[2][]{%
  \def\@supervisor{#2}%
  \def\@supervisor@role{#1}%
}
\newcommand{\projectrepo}[1]{\def\@projectrepo{#1}}

\newcommand{\specialisation}[1]{\def\@specialisation{#1}}
\newcommand{\keywords}[1]{\def\@keywords{#1}}

\@onlypreamble\studyprogramme
\@onlypreamble\course
\@onlypreamble\assignmenttype
\@onlypreamble\academicyear
\@onlypreamble\supervisor
\@onlypreamble\projectrepo
\@onlypreamble\keywords

%% List of authors.
%%   Each author is specified separately with \author{name}
%%   You can add an email address with \email{address}

\newcount\hga@author@cnt % counter for authors
\newcount\hga@email@cnt

\renewcommand*\author[1]{%
  \global\advance\hga@author@cnt\@ne\relax
  \expandafter\gdef\csname @author@\@roman\hga@author@cnt\endcsname{#1}%
}
\newcommand*\email[1]{%
  \ifnum\hga@author@cnt>\z@\relax
    \global\advance\hga@email@cnt\@ne\relax
    \expandafter\gdef\csname @email@\@roman\hga@email@cnt\endcsname{#1}%
  \else
    \ClassWarning{\@classname}{Email with no author}
  \fi
}
\@onlypreamble\author
\@onlypreamble\email

%% Command that checks whether the necessary information is present
\newcommand{\@checkvariables}{
  \ifnum\hga@author@cnt=0
    \ClassError{\@classname}
    {No authors defined!}
    {Use the 'author' command to define at least one author.}
  \fi
  \ifx\@title\@empty{%
      \ClassError{\@classname}
      {Title is undefined!}
      {Use the 'title' command to define it.}
    }\fi

  \ifnum\hga@email@cnt=0
    \ClassWarning{\@classname}{No e-mail addresses specified! You should specify an e-mail address for each author with the 'email' command}
  \fi
}

%% Series of commands to print a list of all authors
\newcommand*\author@list{%
  \@tempcnta\z@\relax
  \ifnum\hga@author@cnt=\z@\relax\else
    \expandafter\author@list@main
  \fi
}
\newcommand*\author@list@main{%
  \advance\@tempcnta\@ne\relax
  \author@list@and
  \space
  \@nameuse{@author@\@roman\@tempcnta}%
  \author@list@comma
  \ifnum\@tempcnta<\hga@author@cnt\relax
    \expandafter\author@list@main
  \fi
}
\newcommand*\author@list@and{%
  \ifnum\hga@author@cnt=\@ne\relax\else
    \ifnum\@tempcnta=\hga@author@cnt\relax
      \space \if@english and\else en\fi%
    \fi
  \fi
}
\newcommand*\author@list@comma{%
  \ifnum\hga@author@cnt>\tw@\relax
    \ifnum\@tempcnta<\hga@author@cnt\relax
      ,%
    \fi
  \fi
}

% Series of commands to print a list of email addresses
\newcommand*\email@list{%
  \@tempcnta\z@\relax
  \ifnum\hga@email@cnt=\z@\relax\else
    \expandafter\email@list@main
  \fi
}
\newcommand*\email@list@main{%
  \advance\@tempcnta\@ne\relax
  \email@list@and
  \space
  \href{mailto:\@nameuse{@email@\@roman\@tempcnta}}{\nolinkurl{\@nameuse{@email@\@roman\@tempcnta}}}%
  \email@list@comma
  \ifnum\@tempcnta<\hga@email@cnt\relax
    \expandafter\email@list@main
  \fi
}
\newcommand*\email@list@and{%
  \ifnum\hga@email@cnt=\@ne\relax\else
    \ifnum\@tempcnta=\hga@email@cnt\relax
      \space \if@english and\else en\fi%
    \fi
  \fi
}
\newcommand*\email@list@comma{%
  \ifnum\hga@email@cnt>\tw@\relax
    \ifnum\@tempcnta<\hga@email@cnt\relax
      ,%
    \fi
  \fi
}
%% -----------------------------------------------------------------------------
%% Colors

\RequirePackage{xcolor}

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

%% For now, make colors hard-coded, we'll add customization later
\colorlet{links}{hogent-blue}
\colorlet{title}{hogent-blue}

%% -----------------------------------------------------------------------------
%% Fonts

\RequirePackage{fontspec}     % Support for TTF fonts
\RequirePackage{unicode-math}

\newfontfamily\montserratblack{Montserrat}[BoldFont={Montserrat Black}]
\newfontfamily\montserratextrabold{Montserrat}%
[BoldFont={Montserrat ExtraBold}]

\def\titlefont{\montserratblack\bfseries}
\def\tocfont{\montserratblack}

\setmainfont{Montserrat}      % Font selection
\setmathfont{Fira Math}
\setmonofont{Fira Code}

%% -----------------------------------------------------------------------------
%% Page setup

\RequirePackage{geometry}
\geometry{a4paper,bottom=2.1cm,left=1.7cm,right=1.7cm,top=2.1cm,footskip=37pt,headheight=13pt}

% It seems that using the Montserrat font screws up hyphenation. With the
% default settings, we get a lot of overfull \hbox warnings and text overflowing
% in the margin on the right. Setting \tolerance to a higher value than the
% default (200) improves the result.
\tolerance 1000

%% -----------------------------------------------------------------------------
%% Title

\renewcommand{\@maketitle}{
  \@checkvariables

  \begingroup
  \ifx\@assignmenttype\@empty
  \else
    \raggedright\titlefont\color{title}\Large\textsc{\@assignmenttype}
    \medskip
  \fi
  \endgroup

  \begingroup
  \raggedright\titlefont\color{title}\LARGE\@title\@addpunct{.}
  \endgroup

  \begingroup
  \medskip
  \raggedright\titlefont\color{title}\large
  \ifx\@course\@empty
    \ifx\@academicyear\@empty\today\else\@academicyear\fi
  \else
    \@course
    \ifx\@academicyear\@empty, \today\else, \@academicyear\fi
  \fi
  \endgroup

  \bigskip

  \begingroup
  \raggedright\Large\author@list

  \medskip
  \endgroup

  \begingroup
  \small
  \ifnum\hga@email@cnt>0
    \raggedright E-mail: \email@list
  \fi

  \ifx\@projectrepo\@empty\else
    Project repo: \url{\@projectrepo}
  \fi

  \ifx\@supervisor\@empty\else
    \ifx\@supervisor@role\@empty
      \if@english Supervisor: \else Begeleider: \fi
    \else
      \@supervisor@role:
    \fi
    \@supervisor
  \fi

  \medskip
  \hrule
  \medskip
  \endgroup
}

%% -----------------------------------------------------------------------------
%% Abstract

\RequirePackage{mdframed}
\RequirePackage{environ}

\newmdenv[
  hidealllines=true,
  leftmargin=0mm,rightmargin=0mm,
  innerleftmargin=0mm,innerrightmargin=0mm,
  innertopmargin=0mm,innerbottommargin=0mm,
  frametitle={\large\titlefont\color{title} \if@english Abstract \else Samenvatting \fi},
  frametitleaboveskip=0pt,
  frametitlebelowskip=6pt]{hga@abstract@box}

\let\abstract@org\abstract
\def\abstract{\hga@abstract@box\small}
\def\endabstract{\endhga@abstract@box}
\let\oldabstract\abstract
\let\endoldabstract\endabstract
\newcommand{\makeabstract}{%
  \maketitle%
  \begin{oldabstract}%
    \protecting{\BODY}%
  \end{oldabstract}%
  \begingroup
  \ifx\@specialisation\@empty\else
    \noindent\small\bfseries\if@english Specialisation: \else Keuzerichting: \fi
    \normalfont\@specialisation
  \fi
  \endgroup

  \begingroup
  \ifx\@keywords\@empty\else
    \noindent\small\bfseries\if@english Keywords: \else Sleutelwoorden: \fi
    \normalfont\@keywords
  \fi
  \endgroup
  \bigskip
  \hrule
  \bigskip
}
\RenewEnviron{abstract}{%
  \if@twocolumn
    \twocolumn[%
      \begin{@twocolumnfalse}
        \makeabstract
      \end{@twocolumnfalse}]
  \else
    \makeabstract
  \fi
}

%% -----------------------------------------------------------------------------
%% Heading and toc format

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

%% In the table of contents, section names are followed by a line of dots 8pt
%% apart
\titlecontents{section}[1.8em]
{\tocfont}
{\contentslabel[\thecontentslabel]{1.8em}}
{}
{\titlerule*[8pt]{.}\ \thecontentspage}

%% Subsection headers
\titleformat{\subsection}
{\large\titlefont}
{\bfseries\thesubsection.\ }
{1.8pt}
{\bfseries}
\titlespacing{\subsection}{0pt}{.75\baselineskip}{3pt}
\titlecontents{subsection}[3.6em]
{\tocfont}
{\contentslabel[\thecontentslabel]{1.8em}}
{}
{\hfill\thecontentspage}

%% Subsubsection headers
\titleformat{\subsubsection}
{\normalsize\titlefont}
{\bfseries\thesubsubsection.\ }
{1.8pt}
{\bfseries}
\titlespacing{\subsubsection}{0pt}{.5\baselineskip}{3pt}
\titlecontents{subsubsection}[5.4em]
{\tocfont}
{\contentslabel[\thecontentslabel]{2.4em}}
{}
{\hfill\thecontentspage}

%% -----------------------------------------------------------------------------
%% Page header and footer

\RequirePackage{fancyhdr}
\RequirePackage{lastpage}  % Reference to last page in the document

\pagestyle{fancy}          % Enables the custom headers/footers

% Headers
\fancyhead[L]{%
  \small\bfseries
  \ifx\@course\@empty
    \@assignmenttype
  \else
    \@course
    \ifx\@assignmenttype\@empty\else: \@assignmenttype\fi
  \fi}
\fancyhead[R]{\thepage/\pageref{LastPage}}

% Footers
\fancyfoot[L]{\small\bfseries\@studyprogramme}%
\fancyfoot[C]{}
\fancyfoot[R]{\includegraphics[height=1.1cm]{HOGENT_Logo_Pos_rgb.png}}%

% First page
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyfoot[L]{\small\bfseries\@studyprogramme}%
  \fancyfoot[C]{}
  \fancyfoot[R]{\includegraphics[height=1.1cm]{HOGENT_Logo_Pos_rgb.png}}%
}

\renewcommand{\headrulewidth}{0pt}% % No header rule
\renewcommand{\footrulewidth}{0pt}% % No footer rule

%% -----------------------------------------------------------------------------
%% Packages for general use
\RequirePackage{graphicx}
\graphicspath{{../graphics/}}
\RequirePackage{amsmath}
\RequirePackage{eurosym}
\RequirePackage{url}
\RequirePackage[breaklinks]{hyperref}
\hypersetup{
  unicode=true,
  colorlinks=true,
  linkcolor=links,
  urlcolor=links,
  citecolor=links,
  filecolor=links,
  pdftitle=\@title,
  pdfauthor=\@author
}
\RequirePackage{booktabs}
\RequirePackage{csquotes}
