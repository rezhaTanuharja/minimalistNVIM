;; extends
((atx_heading
  (atx_h2_marker)
  (inline) @heading_content)
 (#match? @heading_content "FAILED")
 (#set! "priority" 150))
@comment.error

((atx_heading
  (atx_h2_marker)
  (inline) @heading_content)
 (#match? @heading_content "WORKING")
 (#set! "priority" 150))
@comment.note
