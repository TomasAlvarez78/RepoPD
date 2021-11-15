;(load parte2.clp)

; (assert (hay sol)) hace un fact

; (retract x) x es un num es para sacar un fact

(defrule jugo-naranja
    (naranjas)
=>
   (assert (hay jugo-naranja))
)

(defrule chocolatada
    (leche)
    (chocolate)
=>
   (assert (hay leche-chocolatada))
)

; (watch activation)
; envia mensajes cuando se activa un activation

; (agenda)
; (run)
; (facts)
; (rules)


(defrule menu
    (hay ?bebida)
=>
    (printout t ?bebida crlf)
)

(defrule ingr
=>
    (assert (ingr (read)))
)