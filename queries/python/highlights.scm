;; extends
(((comment) @comment (#contains? @comment "TODO")) @comment.warning (#set! priority 150))
(((comment) @comment (#contains? @comment "WARN")) @comment.warning (#set! priority 150))
(((comment) @comment (#contains? @comment "BUGS")) @comment.error (#set! priority 150))
(((comment) @comment (#contains? @comment "NOTE")) @comment.note (#set! priority 150))

(function_definition
  body: (block
    (expression_statement
      (string) @comment (#set! priority 125)

    )
  )
)

(class_definition
  body: (block
    (expression_statement
      (string) @comment (#set! priority 125)
    )
  )
)
