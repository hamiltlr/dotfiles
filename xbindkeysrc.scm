; From https://wiki.archlinux.org/title/Xbindkeys#Mouse_Chording

(define (define-mouse-chords chord-key . definitions)
  (define (start-mouse-chord)
    (let ((cmd #f))
      (for-each
        (lambda (definition)
          (let ((key (list-ref definition 0)) (binding (list-ref definition 1)))
            (xbindkey-function key (lambda () (set! cmd binding)))))
        definitions)
      (xbindkey-function `(release ,chord-key)
        (lambda ()
          (remove-xbindkey `(release ,chord-key))
          (for-each
            (lambda (definition)
              (let ((key (list-ref definition 0)))
                (remove-xbindkey key)))
            definitions)
          (if cmd
            (begin
              (run-command cmd)
              (set! cmd #f))
          )))))
  (xbindkey-function chord-key start-mouse-chord))

(define-mouse-chords "b:10"
  (list '(release "b:1") "xdotool click 8")
  (list '(release "b:2") "xdotool click 9")
)
