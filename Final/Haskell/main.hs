import Brisca
import System.Random
import Data.List

main :: IO ()
main = do
    putStrLn "A jugar a la Brisca!"
    putStrLn "Mezclando mazo..."
    let mazoMezclado = mezclarMazo nuevoMazo
    putStrLn "Dando cartas..."

    let estadoPartida = empezarJuego mazoMezclado

    estadoPartida <- estadoPartida

    estadoPartida <- turno estadoPartida

    let puntaje = getPuntaje estadoPartida
    ganoJuego puntaje

    putStrLn "======== Termino el juego ========"
