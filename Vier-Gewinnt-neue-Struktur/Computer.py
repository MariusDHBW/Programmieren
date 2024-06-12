'''Komputer als Gegner'''
from Spielfeld import Spielfeld 
import random

COMPUTER = 'X'
STANDARTWERT = '.'

'''Ist der Plan

    Priorität: im nächsten Zug selbst gewinnen --> 3er Reihe vervollständigen
    Priorität: verhindern, dass Spieler im nächsten Zug gewinnt --> 3er Reihe des Spielers mit eigenen Stein vervollständigen
    Priorität: verhindern, dass Spieler im nächsten Zug 3er Reihe bekommen kann
    Priorität: eigene 2er Reihe verlängern
    sonst: zufälligen Zug ausführen

    Bin bei der Umsetzung bisher kläglich gescheitert. Anders gesagt ich hab versucht den erten Punkt von oben unzuseten und habe dabei einiges geschrottet,
    weshalb ich wieder nur bei random bin, da es so immerhin funktioniert.
    Ein großes Problem war für mich die Klassen und Datei Struktur. (War das erste mal mit Klassen unmehreren Dateien für mich.)

'''

class Computer:
    '''
    
    '''
    def __init__(self, spielfeld):
        self.sp = spielfeld

    def input(self):
        spalte = random.randint(0, 6)
        if self.sp.stein_setzen(COMPUTER, spalte):
            return True