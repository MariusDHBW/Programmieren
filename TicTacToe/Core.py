spielfeld = [" ",
            "1", "2", "3",
            "4", "5", "6",
            "7", "8", "9"]

spieler = 'X'
runde = 0

def spielfeld_output():
    print(spielfeld[1] + " " + spielfeld[2] + " " + spielfeld[3])
    print(spielfeld[4] + " " + spielfeld[5] + " " + spielfeld[6])
    print(spielfeld[7] + " " + spielfeld[8] + " " + spielfeld[9])

def spieler_wechsel(spieler):
    if spieler == 'X' :
        return 'O'
    else:
        return 'X'

def spieler_input(spieler):
    """

    """
    try:
        position = int(input(f"Spieler {spieler}: An welche Position? "))
        if 0 < position < 10:
            if spielfeld[position] == str(position) :
                spielfeld[position] = spieler
            else: 
                print("Spielfeld bereits besetzt")
                spieler_input(spieler)
        else:
            raise ValueError('Zahl muss zwischen 1 und 9 liegen.')
            
    except ValueError:
        print("Muss eine Zahl zwischen 1 und 9 sein.")

#Prüfung, ob Spiel gewonnen wurde
def gewonnen_check():
    #horizontale Linien
    if spielfeld[1] == spielfeld[2] == spielfeld[3]:
        print(f"Spieler {spielfeld[1]} hat gewonnen")
    if spielfeld[4] == spielfeld[5] == spielfeld[6]:
        print(f"Spieler {spielfeld[4]} hat gewonnen")
    if spielfeld[7] == spielfeld[8] == spielfeld[9]:
        print(f"Spieler {spielfeld[7]} hat gewonnen")
    #vertikale Linien
    if spielfeld[1] == spielfeld[4] == spielfeld[7]:
        print(f"Spieler {spielfeld[1]} hat gewonnen")
    if spielfeld[2] == spielfeld[5] == spielfeld[8]:
        print(f"Spieler {spielfeld[2]} hat gewonnen")
    if spielfeld[3] == spielfeld[6] == spielfeld[9]:
        print(f"Spieler {spielfeld[3]} hat gewonnen")
    #diagonale Linien
    if spielfeld[1] == spielfeld[5] == spielfeld[9]:
        print(f"Spieler {spielfeld[1]} hat gewonnen")
    if spielfeld[3] == spielfeld[5] == spielfeld[7]:
        print(f"Spieler {spielfeld[3]} hat gewonnen")

while True:
    spielfeld_output()
    spieler_input(spieler)
    spieler = spieler_wechsel(spieler)
    runde += 1
    if runde >= 5:
        gewonnen_check()
    if runde == 9:
        print('Unentschieden')
        break

