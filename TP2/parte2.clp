(deffacts hombres
    (hombre Alberto)
    (hombre Enrique)
    (hombre Carlos)
    (hombre Gabriel)
    (hombre Hilario)
)

(deffacts mujeres
    (mujer Belinda)
    (mujer Diana)
    (mujer Florina)
)

(deffacts padres
    (padre Alberto)
    (padre Carlos)
    (padre Enrique)
)

(deffacts madres
    (madre Belinda)
    (madre Diana)
    (madre Florina)
)

(deffacts padres-de
    (padre-de Alberto Diana)
    (padre-de Alberto Enrique)
    (padre-de Carlos Gabriel)
    (padre-de Enrique Hilario)
)

(deffacts madres-de
    (madre-de Belinda Diana)
    (madre-de Belinda Enrique)
    (madre-de Diana Gabriel)
    (madre-de Florina Hilario)
)

(deffacts esposos
    (esposo Alberto)
    (esposo Carlos)
    (esposo Enrique)
)

(deffacts esposas
    (esposa Belinda)
    (esposa Diana)
    (esposa Florina)
)

(deffacts hijos
    (hijo Diana)
    (hijo Enrique)
    (hijo Gabriel)
    (hijo Hilario)
)

(deffacts mujeres-de
    (mujer-de Belinda Alberto)
    (mujer-de Diana Carlos)
    (mujer-de Florina Enrique)
)

(deffacts maridos-de
    (marido-de Alberto Belinda)
    (marido-de Carlos Diana)
    (marido-de Enrique Florina)
)

(defrule Abuelo
    (hombre Alberto)
    (padre Alberto)
    (marido-de Alberto Belinda)
    (padre-de Alberto Diana)
    (padre-de Alberto Enrique)
    (madre Diana)
    (madre-de Diana Gabriel)
    (hijo Gabriel)
    (padre Enrique)
    (padre-de Enrique Hilario)
    (hijo Hilario)
=>
    (printout t "Alberto es abuelo de dos nietos" crlf)
)

(defrule Abuela
    (mujer Belinda)
    (madre Belinda)
    (mujer-de Belinda Alberto)
    (madre-de Belinda Diana)
    (madre-de Belinda Enrique)
    (madre Diana)
    (madre-de Diana Gabriel)
    (hijo Gabriel)
    (padre Enrique)
    (padre-de Enrique Hilario)
    (hijo Hilario)
=>
    (printout t "Belinda es abuela de dos nietos" crlf)
)

(defrule Abuelos
    (hombre Alberto)
    (mujer Belinda)
    (marido-de Alberto Belinda)
    (mujer-de Belinda Alberto)
=>
    (printout t "Los abuelos estan casados" crlf)
)

(defrule Hermanos-padre
    (padre-de Alberto Diana)
    (padre-de Alberto Enrique)
=>
    (printout t "Diana y Enrique son hermanos de padre" crlf)
)

(defrule Hermanos-madre
    (madre-de Belinda Diana)
    (madre-de Belinda Enrique)
=>
    (printout t "Diana y Enrique son hermanos de madre" crlf)
)

(defrule Primos
    (padre-de Alberto Diana)
    (padre-de Alberto Enrique)
    (madre-de Diana Gabriel)
    (padre-de Enrique Hilario)
=>
    (printout t "Gabriel e Hilario son primos" crlf)
)

(defrule Tio
    (padre-de Alberto Diana)
    (padre-de Alberto Enrique)
    (madre-de Diana Gabriel)
=>
    (printout t "Enrique es tio de Gabriel" crlf)
)

(defrule Tia
    (padre-de Alberto Diana)
    (padre-de Alberto Enrique)
    (padre-de Enrique Hilario)
=>
    (printout t "Diana es tia de Hilario" crlf)
)