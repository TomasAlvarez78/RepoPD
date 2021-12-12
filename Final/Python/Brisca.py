from os import system
from Mazo import *

class Jugador:
    """
        ! Para leer esto mas legiblemente podemos instalar BetterComments

        * La clase Jugador contiene sus cartas, una funciona que las muestra y getter de las cartas
        * o carta, tambien con una funcion que descarta cierta carta.
    """
    def __init__(self,cartas):
        self.cartasJugador = cartas
    
    def mostrarCartas(self):
        textoCartas = "----> \t" + "\n----> \t".join(map(str, self.cartasJugador))
        print(textoCartas)

    def getCartas(self):
        return self.cartasJugador

    def getCarta(self,i):
        return self.cartasJugador[i]

    def descartarCarta(self,carta):
        self.cartasJugador.remove(carta)


class Brisca:
    """
        ! Para leer esto mas legiblemente podemos instalar BetterComments

        * La clase Brisca maneja todo lo del juego. La creacion del mazo, puntaje
        * el manejo de el turno de un jugador tambien como el mostrar cuales son sus cartas.
        *
        *   ------------------------------------ BRISCA ------------------------------------
        *
        * En el juego de brincan 3 cartas, a cada jugador, y una carta de triunfo debajo de el mazo
        * Dicha carta de triunfo sera la prioridad de Palo.
        * Para jugar los jugadores deben tirar una carta preferentemente del palo de la carta de triunfo
        * Si esta carta es la unica del palo de la carta de triunfo ganara el turno automaticamente
        * En el caso de que dos o mas jugadores pongar el mismo palo de la carta de triunfo se evaluara
        * el valor del mismo, siendo la escala de valores de menor a mayor...
        * Dos -> Cuatro -> Cinco -> Seis -> Siete -> Diez -> Once -> Doce -> Tres -> Uno
        * El jugador con mayor valor ganara el turno
        * En el caso de que ningun jugador juege el mismo palo de la carta de triunfo tambien se evaluara
        * los valores de las cartas.
        * El jugador con mas turnos ganados gana.

        ? El juego representa una mano del juego de Brisca, siendo este 3 turnos.
    """
    def __init__(self):
        print ("A jugar la Brisca!")
        self.mazo = MazoEspanol()
        self.puntaje = 0

    def prepararJuego(self):
        """
            * Esta funcion mezcla el mazo de la Brisca, brinda 3 cartas a 2 jugadores y
            * elige la carta de Triunfo
        """
        print("Empezando mano")
        print("Mezclando mazo...")
        self.mazo.mezclarMazo()
        
        # ! REPARTO DE CARTAS DEL JUGADOR 1
        self.jug1 = Jugador(self.mazo.dar3Cartas())
        print("Cartas del jugador 1:")
        self.jug1.mostrarCartas()
        self.mazo.descartarCartas(self.jug1.getCartas())
        
        # ! REPARTO DE CARTAS DEL JUGADOR 1
        self.jug2 = Jugador(self.mazo.dar3Cartas())
        print("Cartas del jugador 2:")
        self.jug2.mostrarCartas()
        self.mazo.descartarCartas(self.jug2.getCartas())
        
        # ! Extraccion de Triunfo
        self.cartaTriunfo = self.mazo.getTriunfo()
        print("Carta de Triunfo:",self.cartaTriunfo)
        input("Presione ENTER para continuar...")

    def turno(self):
        """
            * Esta funcion es recursiva, el objetivo es que se ejecuta hasta que los jugadores se queden sin cartas
            * Se les mostrara a los jugadores sus cartas, se les dara la opcion de elegir una para jugar.
            * Despues de evaluar las cartas brindadas con el triunfo se decidira un ganador del turno
            * el cual sera notificado y anotado en el sistema de puntaje.
            * Una vez que terminada la mano se mostrara el ganador del juego

            ? Sistema de Puntaje
            ? [-3 -2 -1 0 1 2 3]
            ? Si puntaje > 0 = Gana el jugador 1
            ? Si puntaje < 0 = Gana el jugador 2
            ? Si puntaje == 0 = Es un empate
        """
        system('clear')
        print("-----------------------------------")
        print("Carta de Triunfo:",self.cartaTriunfo)
        print("-----------------------------------")
        print("Turno del jugador 1") 

        self.jug1.mostrarCartas()
        cartaIngreso = int(input("Ingrese el numero de carta que quiere tirar: "))
        cartaJ1 = self.jug1.getCarta(cartaIngreso-1)

        print("La carta elegida es: ", cartaJ1)
        input("Presione ENTER para continuar...")
        print("-----------------------------------")

        print("Turno del jugador 2")   

        self.jug2.mostrarCartas()
        cartaIngreso = int(input("Ingrese el numero de carta que quiere tirar: "))
        cartaJ2 = self.jug2.getCarta(cartaIngreso-1)

        print("La carta elegida es: ", cartaJ2)

        ganador = self.resTurno(cartaJ1,cartaJ2)

        self.jug1.descartarCarta(cartaJ1)
        self.jug2.descartarCarta(cartaJ2)

        self.actualizarPuntaje(ganador)
        self.ganoTurno(ganador)
        
        input("Presione ENTER para continuar...")

        if(len(self.jug1.getCartas()) > 0):
            self.turno()
        else: 
            return 1
    
    def actualizarPuntaje(self,ganador):
        if ganador == 1:
            self.puntaje = self.puntaje + 1
        elif ganador == 2:
            self.puntaje = self.puntaje - 1

    def ganoTurno(self,ganador):
        if ganador > 0:
            print("El turno lo gano el jugador {0}".format(ganador))
        else:
            print("El turno termino en empate")

    def resTurno(self,c1,c2):
        """
            * Esta funcion recibe 2 cartas, siendo de jugadores
            * En esta funcion se decide cual de las dos gana segun las reglas del juego.
            * Siendo prioridad los palos y despues los valores.
        """

        if c1.getPalo() == self.cartaTriunfo.getPalo() and c2.getPalo() != self.cartaTriunfo.getPalo(): return 1
        elif c2.getPalo() == self.cartaTriunfo.getPalo() and c1.getPalo() != self.cartaTriunfo.getPalo(): return 2
        c1Indice = self.mazo.VALORES.index(c1.getValor())
        c2Indice = self.mazo.VALORES.index(c2.getValor())
        if(c1Indice > c2Indice): return 1
        elif(c2Indice > c1Indice): return 2
        else: return 0

    def terminoJuego(self):
        if self.puntaje > 0:
            print("***** Gano el Jugador 1 *****")
        elif self.puntaje < 0:
            print("***** Gano el Jugador 2 *****")
        else:
            print("***** Empate *****")