'''Komputer als Gegner'''
from Spielfeld import Spielfeld as sp
import random

class Computer:

    '''
    
    '''
    def __init__(self) -> None:
        pass

    
    def input(spielfeld, spieler):
        spalte = random.randint(0, 6)
        sp.stein_setzen(spielfeld, spieler, spalte)