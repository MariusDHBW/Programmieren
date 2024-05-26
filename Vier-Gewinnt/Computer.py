'''Komputer als Gegner'''
from Spielfeld import Spielfeld as sp
import random

COMPUTER = 'X'
STANDARTWERT = '.'

'''Ist der Plan

    Priorität: im nächsten Zug selbst gewinnen --> 3er Reihe vervollständigen
    Priorität: verhindern, dass Spieler im nächsten Zug gewinnt --> 3er Reihe des Spielers mit eigenen Stein vervollständigen
    Priorität: verhindern, dass Spieler im nächsten Zug 3er Reihe bekommen kann
    Priorität: eigene 2er Reihe verlängern
    sonst: zufälligen Zug ausführen

'''

class Computer:
    '''
    
    '''
    def __init__(self) -> None:
        pass

    def input():
        spalte = random.randint(0, 6)
        if sp.stein_setzen(COMPUTER, spalte):
            return True