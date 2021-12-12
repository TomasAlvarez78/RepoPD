"""
    ! Paginas
    * Functional Programming https://mymasterdesigner.com/2021/10/10/functional-programming-with-python/

    * Lambda Functions https://mymasterdesigner.com/2021/06/17/lambda-functions-in-python/

    * Iteraciones https://mymasterdesigner.com/2021/06/04/fastest-python-with-iterator-tools/

    * https://dev.to/nexttech/build-a-blackjack-command-line-game-3o4b

"""
from Brisca import *

def main():
    brisca = Brisca()
    brisca.prepararJuego()
    brisca.turno()
    brisca.terminoJuego()

main()