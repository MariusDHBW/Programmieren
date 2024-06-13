spiel_aktiv = True
spieler_aktiv = "X"
spielfeld = [" ",
            "1", "2", "3",
            "4", "5", "6",
            "7", "8", "9"]

#Spielfeld generieren
def spielfeld_output():
    print(spielfeld[1] + " " + spielfeld[2] + " " + spielfeld[3])
    print(spielfeld[4] + " " + spielfeld[5] + " " + spielfeld[6])
    print(spielfeld[7] + " " + spielfeld[8] + " " + spielfeld[9])

#Spieler wechseln
def spieler_wechsel(spieler_aktiv):
    if spieler_aktiv == "X":
        spieler_aktiv = "O"
    else:
        spieler_aktiv = "X"
    return spieler_aktiv

#Spieler Eingabe
def spieler_input(spieler_aktiv):
    try:
        spieler = int(input(f"Spieler {spieler_aktiv}: An welche Position? "))
        if spieler >= 1 and spieler <= 9:
            if spielfeld[spieler] == "X" or spielfeld[spieler] == "O":
                print("Spielfeld bereits besetzt")
                spieler_input(spieler_aktiv)
            else:
                spielfeld[spieler] = spieler_aktiv
        else:
            print("Zahl muss zwischen 1 und 9 sein!")
            spieler_input(spieler_aktiv)
    except ValueError:
        print("Bitte nur Zahlen eingeben!")
        spieler_input(spieler_aktiv)

#Prüfung, ob Spiel gewonnen wurde
def gewonnen_check(spiel_aktiv):
    #horizontale Linien
    if spielfeld[1] == spielfeld[2] == spielfeld[3]:
        print(f"Spieler {spielfeld[1]} hat gewonnen")
        spiel_aktiv = False
    if spielfeld[4] == spielfeld[5] == spielfeld[6]:
        print(f"Spieler {spielfeld[4]} hat gewonnen")
        spiel_aktiv = False
    if spielfeld[7] == spielfeld[8] == spielfeld[9]:
        print(f"Spieler {spielfeld[7]} hat gewonnen")
        spiel_aktiv = False
    #vertikale Linien
    if spielfeld[1] == spielfeld[4] == spielfeld[7]:
        print(f"Spieler {spielfeld[1]} hat gewonnen")
        spiel_aktiv = False
    if spielfeld[2] == spielfeld[5] == spielfeld[8]:
        print(f"Spieler {spielfeld[2]} hat gewonnen")
        spiel_aktiv = False
    if spielfeld[3] == spielfeld[6] == spielfeld[9]:
        print(f"Spieler {spielfeld[3]} hat gewonnen")
        spiel_aktiv = False 
    #diagonale Linien
    if spielfeld[1] == spielfeld[5] == spielfeld[9]:
        print(f"Spieler {spielfeld[1]} hat gewonnen")
        spiel_aktiv = False
    if spielfeld[3] == spielfeld[5] == spielfeld[7]:
        print(f"Spieler {spielfeld[3]} hat gewonnen")
        spiel_aktiv = False  
    spiel_aktiv = unentschieden(spiel_aktiv)
    return spiel_aktiv  

#Prüfung, ob Spiel unentschieden
def unentschieden(spiel_aktiv):
    if (spielfeld[1] == "X" or spielfeld[1] == "O") \
      and (spielfeld[2] == "X" or spielfeld[2] == "O") \
      and (spielfeld[3] == "X" or spielfeld[3] == "O") \
      and (spielfeld[4] == "X" or spielfeld[4] == "O") \
      and (spielfeld[5] == "X" or spielfeld[5] == "O") \
      and (spielfeld[6] == "X" or spielfeld[6] == "O") \
      and (spielfeld[7] == "X" or spielfeld[7] == "O") \
      and (spielfeld[8] == "X" or spielfeld[8] == "O") \
      and (spielfeld[9] == "X" or spielfeld[9] == "O"):
        print("UNENTSCHIEDEN")
        spiel_aktiv = False
    return spiel_aktiv

######################SPIEL###########################
print("Spieler1 ist X. Spieler2 ist O")
print("X beginnt!")

spielfeld_output()

while spiel_aktiv:
    spieler_input(spieler_aktiv)
    spieler_aktiv = spieler_wechsel(spieler_aktiv)
    spiel_aktiv = gewonnen_check(spiel_aktiv)
    spielfeld_output()
    