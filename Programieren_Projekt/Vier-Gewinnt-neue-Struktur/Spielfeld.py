'''Alles zum Spielfeld'''



class Spielfeld:

    def __init__(self, STANDARTWERT, ANZ_SPALTEN, ANZ_ZEILEN):
        spielfeld = [[STANDARTWERT] * ANZ_SPALTEN for _ in range(ANZ_ZEILEN)]
        self.spielfeld = spielfeld
        self.STANDARTWERT = STANDARTWERT


    def __repr__(self):
        # return "Vector(" + repr(self._entries) + ")"
        return f"{self.__class__.__name__}({repr(self.spielfeld)})"

    def spielfeld_anz(self):
        for _ in range(6):
            print(self.spielfeld[_])

    def tiefste_zeile(self, spalte):
        zeile = 5
        while True: #Prüft ob die Spalte noch frei ist, wenn ja setzt die den Stein
            if self.spielfeld[zeile] [spalte] == self.STANDARTWERT :  
                return zeile
            elif zeile == -1:
                return zeile
            else:
                zeile = zeile - 1 


    def stein_setzen(self, spieler, spalte):
        zeile = self.tiefste_zeile(spalte)  
        if zeile >= 0:
            self.spielfeld[zeile] [spalte] = spieler
            if self.gewonnen(spieler, zeile, spalte):
                print('Gewonnen')
                return True

    def is_spieler(self, spieler, zeile, spalte):
        if self.spielfeld[zeile][spalte] == spieler:
            return True
        

    def vertikal(self, spieler, zeile, spalte, anz_zeile_prüfen):
        #anz_steine = 0
        for i in range(1, anz_zeile_prüfen + 1):
            if self.is_spieler(spieler, zeile + i, spalte):
                pass #anz_steine += 1
            else:
                return False
        return True #anz_steine

    
    def horizontal(self, spieler, zeile, spalte, anz_spalten_prüfen):
        if spalte  == 0:
            if self.horizontal_1_win(spieler, zeile):
                return True
        if spalte  == 1:
            if self.horizontal_1_win(spieler, zeile) or self.horizontal_2_win(spieler, zeile):
                return True
        if spalte  == 2:
            if self.horizontal_1_win(spieler, zeile) or self.horizontal_2_win(spieler, zeile) or self.horizontal_3_win(spieler, zeile):
                return True
        if spalte  == 3:
            if self.horizontal_1_win(spieler, zeile) or self.horizontal_2_win(spieler, zeile) or self.horizontal_3_win(spieler, zeile) or self.horizontal_4_win(spieler, zeile):
                return True
        if spalte  == 4:
            if self.horizontal_2_win(spieler, zeile) or self.horizontal_3_win(spieler, zeile) or self.horizontal_4_win(spieler, zeile):
                return True
        if spalte  == 5:
            if self.horizontal_3_win(spieler, zeile) or self.horizontal_4_win(spieler, zeile):
                return True
        if spalte  == 6:
            if self.horizontal_4_win(spieler, zeile):
                return True
          
        
    def horizontal_1_win(self, spieler, zeile):
        if self.spielfeld[zeile][0] == spieler and self.spielfeld[zeile][1] == spieler and self.spielfeld[zeile][2] == spieler and self.spielfeld[zeile][3] == spieler and self.spielfeld[zeile][3] == spieler:
            return True
        
    def horizontal_2_win(self, spieler, zeile):
        if self.spielfeld[zeile][4] == spieler and self.spielfeld[zeile][1] == spieler and self.spielfeld[zeile][2] == spieler and self.spielfeld[zeile][3] == spieler and self.spielfeld[zeile][3] == spieler:
            return True

    def horizontal_3_win(self, spieler, zeile):
        if self.spielfeld[zeile][4] == spieler and self.spielfeld[zeile][5] == spieler and self.spielfeld[zeile][2] == spieler and self.spielfeld[zeile][3] == spieler and self.spielfeld[zeile][3] == spieler:
            return True

    def horizontal_4_win(self, spieler, zeile):
        if self.spielfeld[zeile][4] == spieler and self.spielfeld[zeile][5] == spieler and self.spielfeld[zeile][6] == spieler and self.spielfeld[zeile][3] == spieler and self.spielfeld[zeile][3] == spieler:
            return True

                    
        




    def gewonnen(self, spieler, zeile, spalte):

        try:#vertikal prüfen 
            if zeile < 3:
                if self.vertikal(spieler, zeile, spalte, 3):
                    return True 

            if self.horizontal(spieler, zeile, spalte, 3):
                return True
                  
            '''
            #horizontal prüfen
            if self.spielfeld[zeile][3] == spieler:
                for i in range(4):
                    if self.spielfeld[zeile][i] == spieler and self.spielfeld[zeile][i + 1] == spieler and self.spielfeld[zeile][i + 2] == spieler and self.spielfeld[zeile][i + 3] == spieler :
                        return True

            #diagonal
            for i in range(3):
                for j in range(4):
                    if self.spielfeld[i][j] == spieler and self.spielfeld[i + 1][j + 1] == spieler and self.spielfeld[i + 2][j + 2] == spieler and self.spielfeld[i + 3][j + 3] == spieler :
                        return True
                    if self.spielfeld[i][6 - j] == spieler and self.spielfeld[i + 1][5 - j] == spieler and self.spielfeld[i + 2][4 - j] == spieler and self.spielfeld[i + 3][3 - j] == spieler :
                        return True
                '''
        except IndexError:
            print('Nicht in Liste')
