; From https://wiki.archlinux.org/title/Xbindkeys#Mouse_Chording
;
; Modifications:
;  - The original behavior was to trigger the command when the modifier
;    was released. I changed it to do the command as soon as the key is
;    released (not the modifier), so you can hold the modifier and trigger
;    the command multiple times.
;  - Added support to run a command when just the modifier key is pressed

(define (define-mouse-chords chord-key mod-single-cmd . definitions)
  (define (start-mouse-chord)
    (let ((userPressedKey 0))
      (for-each
        (lambda (definition)
          (let ((key (list-ref definition 0)) (binding (list-ref definition 1)))
            (xbindkey-function key 
                (lambda ()
                  (set! userPressedKey 1)
                  (run-command binding)
                  )
                  )))
        definitions)
      (xbindkey-function `(release ,chord-key)
        (lambda ()
          (remove-xbindkey `(release ,chord-key))
          (for-each
            (lambda (definition)
              (let ((key (list-ref definition 0)))
                (remove-xbindkey key)))
            definitions)
          (if (= userPressedKey 0)
                (run-command mod-single-cmd)
              (set! userPressedKey 0) ;else
              )
          ))))
  (xbindkey-function chord-key start-mouse-chord))

(define-mouse-chords "b:13"
  "xdotool key alt+super+equal"
  (list '(release "b:8") "xdotool key alt+super+minus")
  (list '(release "b:9") "xdotool key alt+super+Escape")
)
