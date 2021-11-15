animal(perro).
animal(lobo).
animal(vaca).
animal(caballo).
animal(oveja).
animal(guanaco).
animal(gallina).
animal(rana).
animal(X) :- criaDe(X,Y) , animal(Y).

/**
    Ejercicio 1 . 1
**/
comeCarne(perro).
comeCarne(lobo).
comeCarne(X) :- criaDe(X,Y) , comeCarne(Y).

comeHierba(vaca).
comeHierba(caballo).
comeHierba(oveja).
comeHierba(guanaco).
comeHierba(gallina).
comeHierba(rana).
comeHierba(X) :- criaDe(X,Y) , comeHierba(Y).

/**
    Ejercicio 1 . 2
**/
plumas(gallina).
plumas(X) :- criaDe(X,Y) , plumas(Y).

pelo(perro).
pelo(lobo).
pelo(caballo).
pelo(oveja).
pelo(guanaco).
pelo(X) :- criaDe(X,Y) , pelo(Y).

piel(rana).
piel(X) :- criaDe(X,Y) , piel(Y).

/**
    Ejercicio 1 . 3
**/

criaDe(cachorro,perro).
criaDe(lobezno,lobo).
criaDe(ternero,oveja).
criaDe(potrillo,caballo).
criaDe(cordero,oveja).
criaDe(chulengo,guanaco).
criaDe(pollo,gallina).
criaDe(renacuajo,rana).

/**
    Ejercicio 1 . 4
**/

puedeComer(A,B) :- comeCarne(A) , animal(B).

/**
    Ejercicio 1 . 5
**/

dosPatas(A) :- plumas(A).

cuatroPatas(A) :- pelo(A).
cuatroPatas(A) :- piel(A).

