module Brisca
(   Numero(..),
    Palo(..),
    Carta(..),
    Mazo,
    Jugador,
    paloCarta,
    venceCarta,
    nuevoMazo,
    mezclarMazo,
    empezarJuego,
    descartarCartaMazo,
    descartarCartasJug,
    eliminarItem,
    getTriunfo,
    addPuntaje,
    getPuntaje,
    resTurno,
    mostrarCartas,
    ganoTurno,
    ganoJuego,
    turno) where

import System.Random
import Data.List
import System.Process

data Numero = Dos | Cuatro | Cinco | Seis | Siete | Diez | Once | Doce | Tres | Uno deriving (Read, Enum, Eq, Show, Ord)

data Palo = Copa | Basto | Oro | Espada deriving (Read, Enum, Eq, Show, Ord)

data Carta = Carta Numero Palo deriving (Read, Eq, Show, Ord)

type Mazo = [Carta]
type Jugador = [Carta]

paloCarta :: Carta -> Int
paloCarta (Carta _ Copa) = 1
paloCarta (Carta _ Basto) = 2
paloCarta (Carta _ Oro) = 3
paloCarta (Carta _ Espada) = 4

venceCarta :: Carta -> Carta -> Bool
venceCarta (Carta n1 p1) (Carta n2 p2) = n1 > n2

nuevoMazo :: Mazo
nuevoMazo = [Carta x y | y <- [Copa .. Espada], x <- [Dos .. Uno]]

-- Funcion para mezclar un mazo, recursivo
mezclarMazo :: Mazo -> IO Mazo
mezclarMazo mazo = if not (null mazo)
                       then do
                           let mazoLon = length mazo - 1
                           -- Agarro un numero aleatorio entre 0 y la cantidad de cartas del mazo
                           n <- randomRIO(0,mazoLon) :: IO Int
                           let cartaRandom = mazo !! fromIntegral n
                           mazoMezclado <- mezclarMazo (delete cartaRandom mazo)
                           return (cartaRandom : mazoMezclado)
                       else return mazo

-- Funcion que devuelve una tupla de juego
-- La tupla del juego ( JUGADOR1, JUGADOR2, MAZO, PUNTAJE)
empezarJuego :: Monad m => m Mazo -> m (Jugador, Jugador, Mazo, Int)
empezarJuego m =
    do
    mazo <- m
    return (take 3 mazo, take 3 (drop 3 mazo), drop 6 mazo, 0)

-- Funcion que descarta una carta del mazo tras recibir la tupla del juego
descartarCartaMazo :: [Carta] -> [Carta]
descartarCartaMazo = drop 1

descartarCartasJug :: Jugador-> Int -> Jugador
descartarCartasJug j1 c1 = eliminarItem 0 c1 j1

eliminarItem :: Int -> Int -> [Carta] -> [Carta]
eliminarItem _ _ [] = []
eliminarItem a b (x:xs)
    | a == b = xs
    | otherwise = x : eliminarItem (a+1) b xs

-- Funcion que devuelve una carta, su funcion es devolver la carta de triunfo
getTriunfo :: Mazo -> Carta
getTriunfo = head

addPuntaje :: Int -> Int -> Int
addPuntaje pun ganador
    | ganador == 1 = pun+1
    | ganador == 2 = pun-1
    | otherwise = pun

-- Funcion que devuelve el puntaje segun la tupla del juego
getPuntaje :: (Jugador, Jugador, Mazo, Int) -> Int
getPuntaje (_,_,_,pun) = pun

resTurno :: Carta -> Carta -> Carta -> Int
resTurno c1 c2 triunfo
    | paloCarta c1 == paloCarta triunfo && paloCarta c2 /= paloCarta triunfo = 1
    | paloCarta c2 == paloCarta triunfo && paloCarta c1 /= paloCarta triunfo = 2
    | venceCarta c1 c2 = 1
    | venceCarta c2 c1 = 2
    | otherwise = 0

mostrarCartas :: Jugador -> IO()
mostrarCartas jug1
  | length jug1 == 3 = do
        putStr "Carta 1 -> "
        print(jug1 !! 0)
        putStr "Carta 2 -> "
        print(jug1 !! 1)
        putStr "Carta 3 -> "
        print(jug1 !! 2)
  | length jug1 == 2 = do
   putStr "Carta 1 -> "
   print(jug1 !! 0)
   putStr "Carta 2 -> "
   print(jug1 !! 1)
  | otherwise = do
   putStr "Carta 1 -> "
   print(jug1 !! 0)
    -- putStr "a"

ganoTurno :: Int -> IO()
ganoTurno a
    | a == 0 = putStrLn "Empate!"
    | otherwise = putStrLn ("El jugador " ++ show a ++ " gano el turno!")

ganoJuego :: Int -> IO()
ganoJuego puntaje 
    | puntaje > 0 = putStrLn "\n*** El jugador 1 gano el juego! ***"
    | puntaje < 0 = putStrLn "\n*** El jugador 2 gano el juego! ***"
    | otherwise = putStrLn "\n*** El juego termino en empate! ***"

turno :: (Jugador, Jugador, Mazo, Int) -> IO (Jugador, Jugador, Mazo, Int)
turno (j1,j2,mazo,pun) = do
    
    system "clear"

    putStrLn "============================"
    putStrLn ""
    putStrLn "Cartas del jugador 1: "
    mostrarCartas j1
    
    putStrLn ""
    putStrLn "---------------------------"
    putStrLn ""

    putStrLn "Cartas del jugador 2: "
    mostrarCartas j2
    
    putStrLn ""
    putStrLn "---------------------------"
    putStrLn ""

    let triunfo = getTriunfo mazo
    let mazo' = descartarCartaMazo mazo
    putStr "Carta de Triunfo: "
    print triunfo

    putStrLn ""
    putStrLn "Presione ENTER para continuar..."
    getLine
    system "clear"
    putStrLn "============================"
    putStrLn ""

    putStrLn "Turno del jugador 1: "
    putStrLn ""
    putStr "Carta de Triunfo: "
    print triunfo
    putStrLn ""
    mostrarCartas j1
    putStrLn ""
    putStr "Ingrese el numero de carta que quiere tirar: "
    cartaIngreso <- getLine
    let carta1 = (read cartaIngreso :: Int) - 1
    putStr "La carta elegida es: "
    print(j1 !! carta1)

    putStrLn ""
    putStrLn "Presione ENTER para continuar..."
    getLine
    system "clear"
    putStrLn "============================"
    putStrLn ""

    putStrLn "Turno del jugador 2: "
    putStrLn ""
    putStr "Carta de Triunfo: "
    print triunfo
    putStrLn ""
    mostrarCartas j2
    putStrLn ""

    putStr "Ingrese el numero de carta que quiere tirar: "
    cartaIngreso <- getLine
    let carta2 = (read cartaIngreso :: Int) - 1
    putStr "La carta elegida es: "
    print(j2 !! carta2)

    putStrLn ""
    putStrLn "============================"

    let ganador = resTurno (j1 !! carta1) (j2 !! carta2) triunfo
    let j1' = descartarCartasJug j1 carta1
    let j2' = descartarCartasJug j2 carta2

    let pun' = addPuntaje pun ganador

    putStrLn ""
    ganoTurno ganador

    putStrLn ""
    putStrLn "Presione ENTER para continuar..."
    getLine
    system "clear"
    putStrLn ""

    if not (null j1')
        then turno (j1',j2',mazo',pun')
        else
            return (j1',j2',mazo',pun')
