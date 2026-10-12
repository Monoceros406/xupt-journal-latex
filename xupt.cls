% !TeX program = xelatex
% =============================================================
%  xupt.cls —— 《西安邮电大学学报》论文模板文档类
%  ---------------------------------------------------------
%  编译引擎：XeLaTeX（需要 TeX Live / MiKTeX，自带 ctex 宏包）
%  说明：本类尽力还原《西安邮电大学学报》稿件模版的版式，包括：
%        · 标题/摘要通栏、正文两栏、参考文献通栏
%        · 页面边距、中英文字体字号、标题层级、摘要关键词
%        · 短横线分隔、带边框的算法框、三线表、参考文献
%  版本：v1.1  2026-10
% =============================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{xupt}[2026/10/12 v1.1 西安邮电大学学报论文模板]

%% ------------------------------------------------------------------
%% 0. 基础类与依赖宏包
%% ------------------------------------------------------------------
% 基于 ctexart，获得中文排版能力（\songti / \heiti / \kaishu / \fangsong）
% fontset=windows：调用 Windows 自带的中文字体（宋体/黑体/楷体/仿宋）
\LoadClass[zihao=5, scheme=plain, fontset=windows]{ctexart}

\RequirePackage{geometry}
\RequirePackage{amsmath, amssymb, amsfonts}
\RequirePackage{graphicx}
\RequirePackage{booktabs}      % 三线表
\RequirePackage{array}
\RequirePackage{tabularx}      % 表格占满栏宽
\RequirePackage{multirow}
\RequirePackage{multicol}      % 正文两栏
\RequirePackage{float}         % 图表的 [H] 固定位置（配合两栏）
\RequirePackage{caption}
\RequirePackage{fancyhdr}
\RequirePackage{xcolor}
\RequirePackage{etoolbox}
\RequirePackage{hyperref}      % 超链接（不改变颜色）
\hypersetup{hidelinks, bookmarksopen=false}

% 拉丁字体设为 Times New Roman（与 Word 默认西文字体一致）
\setmainfont{Times New Roman}

% 补全 zhsong（宋体）家族的粗体映射：让 \textbf{中文} 正确显示为黑体
\setCJKfamilyfont{zhsong}{SimSun}[BoldFont = SimHei, ItalicFont = KaiTi]

%% ------------------------------------------------------------------
%% 1. 页面设置（还原 docx 的 sectPr）
%%    A4；上 3.7cm、下 2.0cm、左 2.7cm、右 2.0cm
%%    header 距正文 1.5cm（还原 w:header=851 twips）
%% ------------------------------------------------------------------
\geometry{
  a4paper,
  top    = 3.7cm,
  bottom = 2.0cm,
  left   = 2.7cm,
  right  = 2.0cm,
  headheight = 15pt,
  headsep    = 1.5cm,
}

% 两栏间距：425 twips ≈ 0.75cm，无栏间竖线
\setlength{\columnsep}{0.75cm}
\setlength{\columnseprule}{0pt}

%% ------------------------------------------------------------------
%% 2. 字号辅助命令
%% ------------------------------------------------------------------
\newcommand{\zihaoer}   {\zihao{2}}   % 二号   22pt
\newcommand{\zihaosi}   {\zihao{4}}   % 四号   14pt
\newcommand{\zihaoxsi}  {\zihao{-4}}  % 小四   12pt
\newcommand{\zihaowu}   {\zihao{5}}   % 五号   10.5pt
\newcommand{\zihaoxw}   {\zihao{-5}}  % 小五   9pt
\newcommand{\zihaoliu}  {\zihao{6}}   % 六号   7.5pt

%% ------------------------------------------------------------------
%% 3. 正文默认样式
%%    宋体五号（10.5pt），首行缩进 2 字符，行距固定 18pt（还原 w:line=360）
%% ------------------------------------------------------------------
\renewcommand{\normalsize}{\zihao{5}\setlength{\baselineskip}{18pt}}
\setlength{\parindent}{2em}
\setlength{\parskip}{0pt plus 0pt minus 0pt}
% 缓解两栏窄栏中英文断行造成的行间空白过松
\emergencystretch = 2em
\AtBeginDocument{\normalsize}

%% ------------------------------------------------------------------
%% 4. 标题层级样式（还原 docx）
%%    一级标题：黑体四号加粗，段前段后 13pt（Heading2 样式 before/after=260）
%%    二级标题：黑体五号，无额外间距
%%    三级标题：宋体五号，无额外间距
%% ------------------------------------------------------------------
\ctexset{
  section = {
    format      = {\zihao{4}\bfseries},
    name        = {},
    number      = \arabic{section},
    aftername   = \quad,
    beforeskip  = 13pt,
    afterskip   = 13pt,
    indent      = 0pt,
    afterindent = true,     % 标题后第一段仍首行缩进 2 字
  },
  subsection = {
    format      = {\zihao{5}\heiti},
    name        = {},
    number      = \thesection.\arabic{subsection},
    aftername   = \quad,
    beforeskip  = 0pt,
    afterskip   = 0pt,
    indent      = 0pt,
    afterindent = true,
  },
  subsubsection = {
    format      = {\zihao{5}\songti},
    name        = {},
    number      = \thesubsection.\arabic{subsubsection},
    aftername   = \quad,
    beforeskip  = 0pt,
    afterskip   = 0pt,
    indent      = 0pt,
    afterindent = true,
  },
}

%% ------------------------------------------------------------------
%% 5. 稿件元信息命令（在 metadata.tex 中填写）
%% ------------------------------------------------------------------
\newcommand{\cntitle}[1]{\def\@cntitle{#1}}      % 中文题目
\newcommand{\entitle}[1]{\def\@entitle{#1}}      % 英文题目
\newcommand{\cnauthor}[1]{\def\@cnauthor{#1}}    % 中文作者
\newcommand{\enauthor}[1]{\def\@enauthor{#1}}    % 英文作者
\newcommand{\cnaffil}[1]{\def\@cnaffil{#1}}      % 中文单位
\newcommand{\enaffil}[1]{\def\@enaffil{#1}}      % 英文单位
\newcommand{\cnabstract}[1]{\def\@cnabstract{#1}} % 中文摘要
\newcommand{\enabstract}[1]{\def\@enabstract{#1}} % 英文摘要
\newcommand{\cnkeywords}[1]{\def\@cnkeywords{#1}} % 中文关键词
\newcommand{\enkeywords}[1]{\def\@enkeywords{#1}} % 英文关键词
\newcommand{\clc}[1]{\def\@clc{#1}}              % 中图分类号
\newcommand{\received}[1]{\def\@received{#1}}    % 收稿日期
\newcommand{\funding}[1]{\def\@funding{#1}}      % 基金项目
\newcommand{\corresponding}[1]{\def\@corresponding{#1}} % 通信作者

% 卷 / 期 / 年份（页眉）
\newcommand{\jvol}[1]{\def\@jvol{#1}}
\newcommand{\jnum}[1]{\def\@jnum{#1}}
\newcommand{\jyear}[1]{\def\@jyear{#1}}

\jvol{31}\jnum{2}\jyear{2026}

%% ------------------------------------------------------------------
%% 6. 页眉页脚（原稿无页眉；页码放页脚中央）
%% ------------------------------------------------------------------
\pagestyle{fancy}
\fancyhf{}
\fancyfoot[C]{\zihao{-5}\songti \thepage}
\renewcommand{\headrulewidth}{0pt}

%% ------------------------------------------------------------------
%% 7. 中文标题区（题目 / 作者 / 单位）
%%    标题上方留 14pt 空行（还原 docx 标题前的空段落）
%% ------------------------------------------------------------------
\newcommand{\maketitlecn}{%
  \begingroup
  \centering
  \vspace*{14pt}%
  {\zihao{2}\heiti \@cntitle \par}
  \vspace{8pt}
  {\zihao{4}\kaishu \@cnauthor \par}
  \vspace{4pt}
  {\zihao{-5}\fangsong \baselineskip 12pt\relax \@cnaffil \par}
  \endgroup
}

%% ------------------------------------------------------------------
%% 8. 摘要 / 关键词 / 中图分类号（均局部化，避免影响正文缩进/行距）
%%    摘要行距固定 15pt（w:line=300）；关键词/分类号行距 18pt（w:line=360）
%% ------------------------------------------------------------------
\newcommand{\printcnabstract}{%
  \par\vspace{8pt}%
  \begingroup
  \zihao{-5}\setlength{\parindent}{0pt}\baselineskip 15pt\relax
  {\heiti 摘\quad 要：}\songti \@cnabstract\par
  \endgroup
}
\newcommand{\printcnkeywords}{%
  \par\vspace{2pt}%
  \begingroup
  \zihao{-5}\setlength{\parindent}{0pt}\baselineskip 18pt\relax
  {\heiti 关键词：}\songti \@cnkeywords\par
  \endgroup
}
\newcommand{\printclc}{%
  \par\vspace{2pt}%
  \begingroup
  \zihao{-5}\setlength{\parindent}{0pt}\baselineskip 18pt\relax
  {\heiti 中图分类号：}\songti \@clc\par
  \endgroup
}

%% ------------------------------------------------------------------
%% 9. 英文标题 / 摘要 / 关键词
%%    英文标题 20pt 加粗，单倍行距（原稿无显式 spacing）
%% ------------------------------------------------------------------
\newcommand{\maketitleen}{%
  \begingroup
  \centering
  {\fontsize{20pt}{23pt}\selectfont\bfseries \@entitle \par}
  \vspace{8pt}
  {\zihao{-4} \@enauthor \par}
  \vspace{4pt}
  {\zihao{5}\baselineskip 13pt\relax \@enaffil \par}
  \endgroup
}
\newcommand{\printenabstract}{%
  \par\vspace{8pt}%
  \begingroup
  \zihao{-5}\setlength{\parindent}{0pt}\baselineskip 15pt\relax
  {\bfseries Abstract:} \@enabstract\par
  \endgroup
}
\newcommand{\printenkeywords}{%
  \par\vspace{2pt}%
  \begingroup
  \zihao{-5}\setlength{\parindent}{0pt}\baselineskip 18pt\relax
  {\bfseries Keywords:} \@enkeywords\par
  \endgroup
}

%% ------------------------------------------------------------------
%% 10. 短横线 + 收稿信息
%%     还原 docx 中 Keywords 与收稿日期之间的短横线（VML Line，约 3.1cm）
%% ------------------------------------------------------------------
\newcommand{\shortrule}{\par\noindent\rule{3.1cm}{0.5pt}\par}
\newcommand{\printfootinfo}{%
  \par\vspace{2pt}%
  \begingroup
  \zihao{-5}\setlength{\parindent}{0pt}\baselineskip 12pt\relax
  \ifdefvoid{\@received}{}{\heiti 收稿日期：\songti \@received\par}%
  \ifdefvoid{\@funding}{}{\heiti 基金项目：\songti \@funding\par}%
  \ifdefvoid{\@corresponding}{}{\heiti 通信作者：\songti \@corresponding\par}%
  \endgroup
}

%% ------------------------------------------------------------------
%% 11. 引言标题（还原“0 引言”，不参与编号）
%% ------------------------------------------------------------------
\newcommand{\introduction}{%
  \par\vspace{12pt}%
  \noindent{\zihao{4}\bfseries 0\quad 引言}\par\nopagebreak
}

%% ------------------------------------------------------------------
%% 12. 图表题注
%%    图题在下方、表题在上方，黑体小五居中
%% ------------------------------------------------------------------
\DeclareCaptionLabelSeparator{space}{\ }
\renewcommand{\figurename}{图}
\renewcommand{\tablename}{表}
\DeclareCaptionFont{xuptcap}{\zihao{-5}\heiti}
\captionsetup{
  font        = xuptcap,
  labelsep    = space,
  justification = centering,
}
\captionsetup[figure]{position = bottom}
\captionsetup[table]{position = top}

%% ------------------------------------------------------------------
%% 13. 参考文献
%%    标题居中黑体五号（还原 docx：无显式 sz，继承 Normal 10.5pt；
%%    ascii=Times New Roman MT Extra Bold、eastAsia=黑体），段前段后 9pt
%%    条目六号字，行距固定 15pt
%% ------------------------------------------------------------------
\newcommand{\refheading}{%
  \par\vspace{9pt}%
  \begin{center}
    {\zihao{5}\heiti 参\quad 考\quad 文\quad 献}
  \end{center}
  \vspace{9pt}
}
\newenvironment{reflist}{%
  \zihao{6}%
  \setlength{\parindent}{0pt}%
  \baselineskip 15pt\relax
  \begin{list}{}{%
    \setlength{\labelwidth}{2em}%
    \setlength{\labelsep}{0.5em}%
    \setlength{\itemindent}{0pt}%
    \setlength{\leftmargin}{2.5em}%
    \setlength{\itemsep}{0pt}%
    \setlength{\parsep}{0pt}%
  }%
}{\end{list}}

%% ------------------------------------------------------------------
%% 14. 算法环境（伪代码）
%%     还原 docx：只有上下横线（无左右边框，单元格 tcBorders 的
%%     left/right 为 nil），标题上下各一条横线，占满栏宽，
%%     小五号字，行距固定 15pt
%% ------------------------------------------------------------------
\newenvironment{simplealgo}[1]{%
  \par\vspace{8pt}%
  \begingroup
  \zihao{-5}\songti\setlength{\parindent}{0pt}\baselineskip 15pt\relax
  \noindent\rule{\linewidth}{0.4pt}\par\vspace{-6pt}
  {\heiti 算法：#1}\par\vspace{-6pt}
  \noindent\rule{\linewidth}{0.4pt}\par\vspace{-1pt}
}{%
  \noindent\rule{\linewidth}{0.4pt}\par
  \endgroup
  \par
}

%% ------------------------------------------------------------------
%% 15. 作者简介
%%     还原 docx 的 a1 样式：黑体小五，行距至少 12pt（w:line=240）
%%     位于参考文献之后（两栏内），每个作者一条
%% ------------------------------------------------------------------
\newcommand{\authorbio}[1]{%
  {\heiti\zihao{-5}\baselineskip 12pt\relax 作者简介：#1\par}%
}

%% ------------------------------------------------------------------
%% 16. 其他小工具
%% ------------------------------------------------------------------
\newcommand{\dotsline}{\par\noindent \ldots\par}
\newcommand{\email}[1]{\texttt{#1}}

\endinput
