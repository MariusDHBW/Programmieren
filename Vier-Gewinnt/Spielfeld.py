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

    def setup():  #Generiert das Spelfeld
        global spielfeld
        spielfeld = [[STANDARTWERT] * ANZ_SPALTEN for _ in range(ANZ_SPALTEN)]

    def spielfeld_anz():
        for _ in range(6):
            print(spielfeld[_])
        
    def stein_setzen(spieler, spalte):  
        zeile = 5
        while True: #Prüft ob die Spalte noch frei ist, wenn ja setzt die den Stein
            if spielfeld[zeile] [spalte] == STANDARTWERT :  
                spielfeld[zeile] [spalte] = spieler
                wi.update_spielfeld(spieler, zeile, spalte)
                if gewonnen(spieler, spalte, zeile):
                    print('Gewonnen')
                    return True
                break

            elif zeile == 0:
                print("Spalte bereits voll")
                #Hier ist noch ein fehler, dass wenn die reihe voll ist trotzden der pc dran ist. Habe bisher noch nicht herausgefunden wie das beheben kann.
                break    
            else:
                zeile = zeile - 1 


def gewonnen(spieler, spalte, zeile):

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












 