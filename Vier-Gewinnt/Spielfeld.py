'''Alles zum Spielfeld'''

ANZ_ZEILEN = 6
ANZ_SPALTEN = 7
STANDARTWERT = '.'
spielfeld = [[STANDARTWERT] * ANZ_SPALTEN for _ in range(ANZ_SPALTEN)]

class Spielfeld:

    def __init__(self) -> None:
        pass

    def spielfeld_anz():
        for _ in range(6):
            print(spielfeld[_])
        
    def stein_setzen(spieler, spalte):
        zeile = 5
        while True:
            if spielfeld[zeile] [spalte] == STANDARTWERT :
                spielfeld[zeile] [spalte] = spieler
                gewonnen(spieler, spalte, zeile)
                return zeile, spalte
            elif zeile == 0:
                print("Spalte bereits voll")
                #spieler_input(spieler)
                break    
            else:
                zeile = zeile - 1 

def gewonnen(spieler, spalte, zeile):
    '''

    ''' 
    try:#vertikal prüfen        
        if zeile < 3: 
            if spielfeld[zeile + 3][spalte] == spieler and spielfeld[zeile + 2][spalte] == spieler and spielfeld[zeile + 1 ][spalte] == spieler:
                print('Gewonnen')

        #horizontal prüfen
        if spielfeld[zeile][3] == spieler:
            for i in range(4):
                if spielfeld[zeile][i] == spieler and spielfeld[zeile][i + 1] == spieler and spielfeld[zeile][i + 2] == spieler and spielfeld[zeile][i + 3] == spieler :
                    print('Gewonnen')

        #diagonal
        for i in range(3):
            for j in range(4):
                if spielfeld[i][j] == spieler and spielfeld[i + 1][j + 1] == spieler and spielfeld[i + 2][j + 2] == spieler and spielfeld[i + 3][j + 3] == spieler :
                    print('Gewonnen')
                if spielfeld[i][6 - j] == spieler and spielfeld[i + 1][5 - j] == spieler and spielfeld[i + 2][4 - j] == spieler and spielfeld[i + 3][3 - j] == spieler :
                    print('Gewonnen')

    except IndexError:
        print('Nicht in Liste')