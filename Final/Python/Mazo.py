import random

class Carta:
    """
        ! Para leer esto mas legiblemente podemos instalar BetterComments

        * La clase Carta tiene valor y palo, con sus getter respectivamente
        * Es utilizado por el mazoEspanol, y este el el que indica los palos y valores
    """
    def __init__(self,valor, palo):
        self.valor = valor
        self.palo = palo

    def getValor(self):
        return self.valor

    def getPalo(self):
        return self.palo

    def __repr__(self) -> str:
        return " de ".join((self.valor,self.palo))

class MazoEspanol:
    """
        ! Para leer esto mas legiblemente podemos instalar BetterComments

        * La clase MazoEspanol tiene los palos y valores del mazo
        * y funciones basicas de un mazo de este tipo
    """
    PALOS = ["Oro","Copa","Espada","Palo"]    
    VALORES = ["Dos","Cuatro","Cinco","Seis","Siete","Diez","Once","Doce","Tres","Uno"]
    
    def __init__(self):
        # self.mazo = [Carta(v,p) for v in self.VALORES for p in self.PALOS ]
        self.mazo = [Carta(v,p) for p in self.PALOS for v in self.VALORES ]

    def showMazo(self):
        if len(self.mazo) > 0:
            print(self.mazo)

    def mezclarMazo(self):
        if len(self.mazo) > 1:
            random.shuffle(self.mazo)
        
    def dar3Cartas(self):
        if len(self.mazo) > 2:
            cartasJugador = self.mazo[len(self.mazo)-3:len(self.mazo)]
            return cartasJugador

    def descartarCartas(self,cartas):
        if len(self.mazo) > 1 and len(cartas) > 0:
            self.mazo.remove(cartas[0])
            if len(cartas) > 0:
                self.descartarCartas(cartas[1:])

    def getTriunfo(self):
        return self.mazo.pop()