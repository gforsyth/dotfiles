;; fix latex preamble
(use-package ox-latex)

(add-to-list 'org-latex-classes
             '("myreport"
"\\documentclass[a4paper,10pt]{report}
\\usepackage[utf8]{inputenc}
\\usepackage{amsmath}
\\usepackage{amsfonts}
\\usepackage{amssymb}
\\usepackage{hyperref}
\\usepackage[left=2.5cm,right=2.5cm,top=2.5cm,bottom=2.5cm]{geometry}
\\usepackage{fontspec}
\\setmainfont{Linux Biolinum}
[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]"
("\\section{%s}" . "\\section*{%s}")
           ("\\subsection{%s}" . "\\subsection*{%s}")
           ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
           ("\\paragraph{%s}" . "\\paragraph*{%s}")
           ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(provide 'init-latex)
