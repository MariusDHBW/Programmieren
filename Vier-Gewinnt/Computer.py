'''Komputer als Gegner'''
from Spielfeld import Spielfeld as sp
import random

COMPUTER = 'X'
STANDARTWERT = '.'

class Computer:
    '''
    
    '''
    def __init__(self) -> None:
        pass

    def input(spieler):
        spalte = sp.findeBestenZug(spieler)
        if sp.stein_setzen(COMPUTER, spalte):
            return True
        


def findeBestenZug(eigeneFarbe):
        """
        Zweck:
            Finde beste Spalte, um einen Stein zu setzen
        Parameter:
            spielfeld: Spielspielfeld
            eigeneFarbe: Farbe der eigenen Steine
            gegnerFarbe: Farbe der gegnerischen Steine
        Rückgabe:
            ermittelte Spalte
            -1 - wenn es keine gute Spalte gab
        """

        ''' Prüfe, ob es 3 Steine der eigenen Farbe nebeneinander gibt (Spalte, Zeile, Diagonale)
             --> setzen und gewinnen
        '''
        # Prüfe, ob es eine Spalte mit 3 Steinen der eigenen Farbe zum Verlängern gibt
        spalte = finde_spalte(spielfeld, eigeneFarbe, 3)
        if spalte != -1:
            return spalte

    # Prüfe, ob es eine Zeile mit 3 Steinen der eigenen Farbe zum Verlängern gibt
#    spalte = findeZeile(spielfeld, eigeneFarbe, 3)
#    if spalte != -1:
#        return spalte
#
#    # Prüfe, ob es eine Diagonale mit 3 Steinen der eigenen Farbe zum Verlängern gibt
#    spalte = findeDiagonale(spielfeld, eigeneFarbe, 3)
#    if spalte != -1:
#        return spalte
#
#    ''' Prüfe, ob es 3 Steine der gegnerischen Farbe nebeneinander gibt (Spalte, Zeile, Diagonale)
#        --> setzen und gewinnen des Gegners verhindern
#    '''
#    # Prüfe, ob es eine Spalte mit 3 Steinen der gegnerischen Farbe zum Verhindern gibt
#    spalte = findeSpalte(spielfeld, gegnerFarbe, 3)
#    if spalte != -1:
#        return spalte
#
#    # Prüfe, ob es eine Zeile mit 3 Steinen der gegnerischen Farbe zum Verhindern gibt
#    spalte = findeZeile(spielfeld, gegnerFarbe, 3)
#    if spalte != -1:
#        return spalte
#
#    # Prüfe, ob es eine Diagonale mit 3 Steinen der gegnerischen Farbe zum Verhindern gibt
#    spalte = findeDiagonale(spielfeld, gegnerFarbe, 3)
#    if spalte != -1:
#        return spalte
#
#    ''' Prüfe, ob es 2 Steine der gegnerischen Farbe nebeneinander gibt (Spalte, Zeile, Diagonale)
#        --> setzen und verhindern, dass der Gegner 3 nebeneinander bekommt
#    '''
#    # Prüfe, ob es eine Spalte mit 2 Steinen der gegnerischen Farbe zum Verhindern gibt
#    spalte = findeSpalte(spielfeld, gegnerFarbe, 2)
#    if spalte != -1:
#        return spalte
#
#    # Prüfe, ob es eine Zeile mit 2 Steinen der gegnerischen Farbe zum Verhindern gibt
#    spalte = findeZeile(spielfeld, gegnerFarbe, 2)
#    if spalte != -1:
#        return spalte
#
#    # Prüfe, ob es eine Diagonale mit 2 Steinen der gegnerischen Farbe zum Verhindern gibt
#    spalte = findeDiagonale(spielfeld, gegnerFarbe, 2)
#    if spalte != -1:
#        return spalte
#
#    ''' Prüfe, ob es 2 Steine der eigenen Farbe nebeneinander gibt (Diagonale, Spalte, Zeile)
#     --> setzen und selber 3 nebeneinander bekommen
#    '''
#    # Prüfe, ob es eine Spalte mit 2 Steinen der eigenen Farbe zum Verlängern gibt
#    spalte = findeSpalte(spielfeld, eigeneFarbe, 2)
#    if spalte != -1:
#        return spalte
#
#    # Prüfe, ob es eine Zeile mit 2 Steinen der eigenen Farbe zum Verlängern gibt
#    spalte = findeZeile(spielfeld, eigeneFarbe, 2)
#    if spalte != -1:
#        return spalte
#
#    # Prüfe, ob es eine Diagonale mit 2 Steinen der eigenen Farbe zum Verlängern gibt
#    spalte = findeDiagonale(spielfeld, eigeneFarbe, 2)
#    if spalte != -1:
#        return spalte
#
#    # wenn keine Spalte gefunden
#    return -1
#   


def tiefste_zeilt(spielfeld, spalte):
    zeile = 5
    while True:
        if spielfeld[zeile] [spalte] == STANDARTWERT :
            return zeile
        elif zeile == 0:
            return zeile    
        else:
            zeile = zeile - 1 


def finde_spalte(spielfeld, spieler, anz_steine):
    for spalte in range(6):
        zeile = tiefste_zeilt(spalte)
        if zeile < 3:
            if spielfeld[zeile + 3][spalte] == spieler and spielfeld[zeile + 2][spalte] == spieler and spielfeld[zeile + 1 ][spalte] == spieler:
                return True
            if spielfeld[zeile + 3][spalte] != spieler and spielfeld[zeile + 2][spalte] != spieler and spielfeld[zeile + 1 ][spalte] != spieler:
                return True