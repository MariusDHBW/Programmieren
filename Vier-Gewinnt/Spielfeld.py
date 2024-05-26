'''Alles zum Spielfeld'''
from Window import Window as wi

#global running 
#running = True

ANZ_ZEILEN = 6
ANZ_SPALTEN = 7
STANDARTWERT = '.'

class Spielfeld:

    def __init__(self) -> None:
        pass

    def setup():
        global spielfeld
        spielfeld = [[STANDARTWERT] * ANZ_SPALTEN for _ in range(ANZ_SPALTEN)]

    def spielfeld_anz():
        for _ in range(6):
            print(spielfeld[_])
        
    def stein_setzen(spieler, spalte):
        zeile = 5
        while True:
            if spielfeld[zeile] [spalte] == STANDARTWERT :
                spielfeld[zeile] [spalte] = spieler
                wi.update_spielfeld(spieler, zeile, spalte)
                if gewonnen(spieler, spalte, zeile):
                    print('Gewonnen')
                    return True
                break

            elif zeile == 0:
                print("Spalte bereits voll")
                #spieler_input(spieler)
                break    
            else:
                zeile = zeile - 1 






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
        spalte = finde_spalte(eigeneFarbe)
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


def tiefste_zeilt(spalte):
    zeile = 5
    while True:
        if spielfeld[zeile] [spalte] == STANDARTWERT :
            return zeile
        elif zeile == 0:
            return zeile    
        else:
            zeile = zeile - 1 


def finde_spalte(spieler):
    for spalte in range(6):
        zeile = tiefste_zeilt(spalte)
        if zeile < 3:
            if spielfeld[zeile + 3][spalte] == spieler and spielfeld[zeile + 2][spalte] == spieler and spielfeld[zeile + 1 ][spalte] == spieler:
                return True
            if spielfeld[zeile + 3][spalte] != spieler and spielfeld[zeile + 2][spalte] != spieler and spielfeld[zeile + 1 ][spalte] != spieler:
                return True

















def gewonnen(spieler, spalte, zeile):
    '''

    ''' 
    #global running
    try:#vertikal prüfen        
        if zeile < 3: 
            if spielfeld[zeile + 3][spalte] == spieler and spielfeld[zeile + 2][spalte] == spieler and spielfeld[zeile + 1 ][spalte] == spieler:
                return True

        #horizontal prüfen
        if spielfeld[zeile][3] == spieler:
            for i in range(4):
                if spielfeld[zeile][i] == spieler and spielfeld[zeile][i + 1] == spieler and spielfeld[zeile][i + 2] == spieler and spielfeld[zeile][i + 3] == spieler :
                    return True

        #diagonal
        for i in range(3):
            for j in range(4):
                if spielfeld[i][j] == spieler and spielfeld[i + 1][j + 1] == spieler and spielfeld[i + 2][j + 2] == spieler and spielfeld[i + 3][j + 3] == spieler :
                    return True
                if spielfeld[i][6 - j] == spieler and spielfeld[i + 1][5 - j] == spieler and spielfeld[i + 2][4 - j] == spieler and spielfeld[i + 3][3 - j] == spieler :
                    return True

    except IndexError:
        print('Nicht in Liste')












 