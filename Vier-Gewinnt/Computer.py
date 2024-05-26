'''Komputer als Gegner'''
from Spielfeld import Spielfeld as sp
import random

class Computer:

    '''
    
    '''
    def __init__(self) -> None:
        pass

    def input(spieler):
        spalte = random.randint(0, 6)
        zeile, spalte = sp.stein_setzen(spieler, spalte)
        return zeile, spalte