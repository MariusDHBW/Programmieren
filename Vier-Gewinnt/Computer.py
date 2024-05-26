'''Komputer als Gegner'''
from Spielfeld import Spielfeld as sp
import random

COMPUTER = 'X'

class Computer:
    '''
    
    '''
    def __init__(self) -> None:
        pass

    def input():
        spalte = random.randint(0, 6)
        if sp.stein_setzen(COMPUTER, spalte):
            return True
        