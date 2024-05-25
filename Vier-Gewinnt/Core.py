from Computer import Computer as pc
from Spielfeld import Spielfeld as sp

def spieler_input(spieler):
    """

    """
    try:
        spalte = int(input(f"Spieler {spieler}: An welche Position? ")) - 1
        if 0 <= spalte <= 6:
            sp.stein_setzen(spielfeld, spieler, spalte)
        else: raise ValueError

    except ValueError:
        print("Muss eine Zahl zwischen 1 und 7 sein.")
        spieler_input(spieler)


spielfeld = sp.spielfeld_generieren()
while True:
    spieler = 'O'
    sp.spielfeld_anz(spielfeld)
    spieler_input(spieler)
    spieler = 'X'
    sp.spielfeld_anz(spielfeld)
    print('Spieler X:')
    pc.input(spielfeld, spieler)