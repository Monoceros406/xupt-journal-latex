# 《西安邮电大学学报》LaTeX 模板 (xupt-journal-latex)

根据《西安邮电大学学报》稿件模版（.docx）尽力还原的 LaTeX 模板项目，支持中文排版。

## 环境要求

- **TeX 发行版**：TeX Live 2022+ 或 MiKTeX（本项目在 TeX Live 2025 下测试通过）
- **编译引擎**：XeLaTeX（必须）
- **中文字体**：Windows 自带的 宋体(SimSun)、黑体(SimHei)、楷体(KaiTi)、仿宋(FangSong)

## 快速开始

**Windows：**

```bat
cd xupt-journal-latex
build.bat
```

**Linux / macOS：**

```bash
cd xupt-journal-latex
chmod +x build.sh
./build.sh
```

两个脚本都会用 XeLaTeX 编译两遍（生成交叉引用）并自动删除 `.aux`/`.log`/`.out`/`.synctex.gz` 等中间文件，只保留 `main.pdf`。

也可以手动编译，或在 VS Code (LaTeX Workshop) 中将编译器设为 `xelatex` 后一键编译。

## 项目结构（模块化）

```
xupt-journal-latex/
├── main.tex                 # 主文件：通栏标题区 → multicols 两栏正文+文献 → 通栏附录
├── xupt.cls                 # 文档类：全部版式定义（边距/字号/标题/图表/文献）
├── metadata.tex             # 稿件元信息：中英文题目、作者、单位、摘要、关键词等
├── sections/                # 正文各章节（可自由增删、重命名）
│   ├── 0-intro.tex          #   0 引言
│   ├── 1-architecture.tex   #   1 系统网络架构（含图、公式）
│   ├── 2-algorithm.tex      #   2 算法（含带边框伪代码框）
│   ├── 3-simulation.tex     #   3 仿真（含三线表）
│   ├── 4-conclusion.tex     #   4 结语
│   ├── references.tex       #   参考文献（GB/T 7714，两栏）
│   ├── bio.tex              #   作者简介（两栏，参考文献之后）
│   └── appendix.tex         #   附录：其他文献著录格式标准（通栏，可选）
├── figures/                 # 图片目录（\includegraphics{figures/xxx.pdf}）
└── README.md
```

**main.tex 的三段布局**（对应 docx 的三个 section）：

1. 通栏：中文标题/摘要/关键词/分类号 + 英文标题/摘要/Keywords + 短横线 + 收稿信息
2. `multicols{2}` 两栏：正文 0~4 章 + 参考文献（图、表、算法均占一栏宽，用 `[H]` 固定位置）
3. 通栏：附录（其他文献著录格式标准，默认注释，按需开启）

## 版式还原要点

| 元素 | 还原格式 |
|------|----------|
| 页面 | A4；上 3.7cm / 下 2.0cm / 左 2.7cm / 右 2.0cm |
| **整体布局** | 标题/摘要区**通栏** → 正文+参考文献**两栏**（栏距 0.75cm）→ 附录**通栏** |
| 页眉 | 无（原稿无页眉）；页码在页脚中央 |
| 中文题目 | 黑体二号居中（标题前留 14pt 空行） |
| 作者 | 楷体四号居中，单位编号上标 |
| 单位 | 仿宋小五居中，**单倍行距**（约 12pt） |
| 摘 要 / 关键词 / 中图分类号 | 标签黑体，内容小五宋体；摘要行距 15pt、关键词 18pt |
| 英文题目 | 20pt 加粗居中，**单倍行距**（约 24pt）；作者小四；单位五号 |
| 短横线 | Keywords 与收稿信息之间一条约 3.1cm 短横线（`\shortrule`） |
| 引言 | “0 引言”黑体四号，不参与编号（`\introduction`） |
| 一级标题 | 黑体四号加粗，段前段后 13pt |
| 二级标题 | 黑体五号，如 “1.1 MEC子系统” |
| 三级标题 | 宋体五号，如 “1.2.1 请求” |
| 正文 | 宋体五号（10.5pt），**首行缩进 2 字符**，**行距固定 18pt** |
| 图题 | 图下方，黑体小五居中，图占栏宽 |
| 表题 | 表上方，黑体小五居中；三线表，**占满一栏宽度**（`tabularx`），表头居中 |
| 算法框 | 仅上下三条横线（无左右边框），占满栏宽，小五号（`simplealgo`） |
| 参考文献 | 标题居中黑体五号；条目六号字，GB/T 7714 格式，**两栏** |
| 作者简介 | 参考文献之后，左侧一寸照片占位 + 右侧示例文字（`sections/bio.tex`） |

## 常用命令速查

### 元信息（写在 metadata.tex）

```latex
\cntitle{...}      \entitle{...}
\cnauthor{...}     \enauthor{...}    % 上标用 \textsuperscript{1,2}
\cnaffil{...}      \enaffil{...}     % 多行用 \\ 分隔
\cnabstract{...}   \enabstract{...}
\cnkeywords{...}   \enkeywords{...}
\clc{TN929.5；TP18}
\received{2023-09-29}  \funding{...}  \corresponding{...}
\jvol{31} \jnum{2} \jyear{2026}     % 页眉卷期
```

### 正文

```latex
\introduction                    % “0 引言”
\section{系统网络架构}            % 一级标题
\subsection{MEC子系统}           % 二级标题
\subsubsection{请求}             % 三级标题
\begin{equation} ... \end{equation}   % 编号公式，\eqref 引用
\begin{figure}[H] ... \caption{系统场景} \end{figure}   % [H] 固定位置（两栏内）
\begin{table}[H]
  \begin{tabularx}{\linewidth}{X c} ... \end{tabularx}  % 占满一栏宽
\end{table}
\begin{simplealgo}{算法名} ... \end{simplealgo}   % 伪代码框（仅上下横线）
\begin{reflist} \item[{[1]}] ... \end{reflist}    % 参考文献条目
% 作者简介见 sections/bio.tex：左侧一寸照片占位 + 右侧示例文字
\textbf{加粗中文}                 % 中文加粗（自动映射为黑体）
\dotsline                        % 省略号占位段
```

## 注意事项

1. **必须用 XeLaTeX 编译**，pdfLaTeX 不支持本模板。
2. 图片建议使用 PDF/PNG，放在 `figures/` 下，通过 `\includegraphics` 插入；
   示例中的灰色方框为占位图，替换成 `\includegraphics{...}` 即可。
3. 参考文献采用**手工条目**（符合学报著录样例），如需使用 BibTeX，
   可自行引入 `gbt7714` 宏包并替换 `sections/references.tex`。
4. 若需修改版式（字号、行距、边距等），直接编辑 `xupt.cls` 中对应注释分区。
5. `hyperref` 已加载并隐藏链接颜色；交叉引用使用 `\ref` / `\eqref`。
