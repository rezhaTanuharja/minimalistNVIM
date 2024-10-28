;; extends
(((comment) @comment (#contains? @comment "TODO")) @comment.warning (#set! priority 200))
(((comment) @comment (#contains? @comment "WARN")) @comment.warning (#set! priority 200))
(((comment) @comment (#contains? @comment "BUGS")) @comment.error (#set! priority 200))
(((comment) @comment (#contains? @comment "NOTE")) @comment.note (#set! priority 200))
