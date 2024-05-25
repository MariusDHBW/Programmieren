'''Alles zum Spielfeld'''

class Spielfeld:


    def __init__(self) -> None:
        pass

    def spielfeld_generieren():
        anz_zeilen = 6
        anz_spalten = 7
        standartwert = 0
        spielfeld = [[standartwert] * anz_spalten for _ in range(anz_zeilen)]
        return spielfeld

    def spielfeld_anz(spielfeld):
        _ = 0
        while _ < 6:
            print(spielfeld[_])
            _ += 1
        
    def stein_setzen(spielfeld, spieler, spalte):
        zeile = 5
        while True:
            if spielfeld[zeile] [spalte] == 0 :
                spielfeld[zeile] [spalte] = spieler
                gewonnen(spielfeld, spieler, spalte, zeile)
                break
            elif zeile == 0:
                print("Spalte bereits voll")
                #spieler_input(spieler)
                break    
            else:
                zeile = zeile - 1 

def gewonnen(spielfeld, spieler, spalte, zeile):
    '''

    ''' 
    try:  
        if spielfeld[zeile][3] == spieler:    #horizontal
            if (spielfeld[zeile][0] and spielfeld[zeile][1] and spielfeld[zeile][2]) or (spielfeld[zeile][1] and spielfeld[zeile][2] and spielfeld[zeile][4]) or (spielfeld[zeile][2] and spielfeld[zeile][4] and spielfeld[zeile][5]) or (spielfeld[zeile][4] and spielfeld[zeile][5] and spielfeld[zeile][6]) == spieler:
                print('Gewonnen')
                
        if zeile < 3: #vertikal prüfen
            if spielfeld[zeile + 3][spalte] and spielfeld[zeile + 2][spalte] and spielfeld[zeile + 1 ][spalte] == spieler:
                print('Gewonnen')

    except IndexError:
        print('Nicht in Liste')