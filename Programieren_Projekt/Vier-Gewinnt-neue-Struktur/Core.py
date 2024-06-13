from Spielfeld import Spielfeld
from Computer import Computer 

ANZ_ZEILEN = 6
ANZ_SPALTEN = 7
STANDARTWERT = '.'

sp = Spielfeld(STANDARTWERT, ANZ_SPALTEN, ANZ_ZEILEN)

pc = Computer(sp)







def spieler_input(spieler):
    
    try:
        spalte = int(input(f"Spieler O: An welche Position? ")) - 1
        if 0 <= spalte <= 6:
            if sp.stein_setzen(spieler, spalte):
                return True
        else: raise ValueError

    except ValueError:
        print("Muss eine Zahl zwischen 1 und 7 sein.")
        spieler_input(spieler)


running = True
while running:
    spieler = 'O'
    sp.spielfeld_anz()
    if spieler_input(spieler):
        sp.spielfeld_anz()
        running = False
    else: 
        spieler = 'X'
        sp.spielfeld_anz()
        print('Spieler X:')
        if pc.input():
            sp.spielfeld_anz()
            running = False

