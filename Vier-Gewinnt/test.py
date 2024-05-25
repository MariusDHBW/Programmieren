import random

anz_zeilen = 6
anz_spalten = 7
standartwert = '.'
spielfeld = [[standartwert] * anz_spalten for _ in range(anz_zeilen)]

def spielfeld_anz():
    print(spielfeld[0])
    print(spielfeld[1])
    print(spielfeld[2])
    print(spielfeld[3])
    print(spielfeld[4])
    print(spielfeld[5])

spieler = 'O'

def spieler_wechsel(spieler):
    if spieler == 'X' :
        return 'O'
    else:
        return 'X'

def spieler_input(spieler):
    """

    """
    try:
        spalte = int(input(f"Spieler {spieler}: An welche Position? ")) - 1
        stein_setzen(spieler, spalte)

    except ValueError:
        print("Muss eine Zahl zwischen 1 und 7 sein.")
        spieler_input(spieler)

def stein_setzen(spieler, spalte):
    try:
        if 0 <= spalte <= 6:
            zeile = 5
            while True:
                if spielfeld[zeile] [spalte] == '.' :
                    spielfeld[zeile] [spalte] = spieler
                    gewonnen(spieler, spalte, zeile)
                    break
                elif zeile == 0:
                    print("Spalte bereits voll")
                    spieler_input(spieler)
                    break    
                else:
                    zeile = zeile - 1   
        else:
            raise ValueError       
                    
    except ValueError:
        print("Muss eine Zahl zwischen 1 und 7 sein.")
        spieler_input(spieler)
    
def gewonnen(spieler, spalte, zeile):
    '''

    ''' 
    try:  
        if spielfeld[zeile][3] == spieler:    
            if (spielfeld[zeile][0] and spielfeld[zeile][1] and spielfeld[zeile][2]) or (spielfeld[zeile][1] and spielfeld[zeile][2] and spielfeld[zeile][4]) or (spielfeld[zeile][2] and spielfeld[zeile][4] and spielfeld[zeile][5]) or (spielfeld[zeile][4] and spielfeld[zeile][5] and spielfeld[zeile][6]) == spieler:
                print('Gewonnen')
                

        if zeile < 3: #vertikal prüfen
            if spielfeld[zeile + 3][spalte] and spielfeld[zeile + 2][spalte] and spielfeld[zeile + 1 ][spalte] == spieler:
                print('Gewonnen')

    except IndexError:
        print('Nicht in Liste')


def Computer(spalte):
    spalte = random.randint(0, 6)
    stein_setzen(spieler, spalte)



while True:
    spielfeld_anz()
    spieler_input(spieler)
    spieler = spieler_wechsel(spieler)
    spielfeld_anz()
    print('Spieler X')
    Computer(spieler)
    spieler = spieler_wechsel(spieler)
    