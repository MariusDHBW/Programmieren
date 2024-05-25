from Computer import Computer as pc
from Spielfeld import Spielfeld as sp

def spieler_input(spieler):
    """

    """
    try:
        spalte = int(input(f"Spieler {spieler}: An welche Position? ")) - 1
        if 0 <= spalte <= 6:
            sp.stein_setzen(spieler, spalte)
        else: raise ValueError

    except ValueError:
        print("Muss eine Zahl zwischen 1 und 7 sein.")
        spieler_input(spieler)


while True:
    spieler = 'O'
    sp.spielfeld_anz()
    spieler_input(spieler)
    spieler = 'X'
    sp.spielfeld_anz()
    print('Spieler X:')
    pc.input(spieler)
