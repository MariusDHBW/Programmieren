import pygame
from Computer import Computer as pc
from Spielfeld import Spielfeld as sp
from Window import Window as wi

# Farben
BLAU = (0, 0, 255)
SCHWARZ = (0, 0, 0)
ROT = (255, 0, 0)
GELB = (255, 255, 0)

# Spielfeld Terminal
ANZ_ZEILEN = 6
ANZ_SPALTEN = 7
STANDARTWERT = '.'

SPIELER = 'O'

# Spielfeld Fenster
QUADRAT = 100
breite = ANZ_SPALTEN * QUADRAT
höhe = (ANZ_ZEILEN + 1) * QUADRAT
größe = (breite, höhe)
RADIUS = int(QUADRAT / 2 - 5)

# Initialize Pygame
pygame.init()

# Fenster erstellen
screen = pygame.display.set_mode(größe)
pygame.display.set_caption("Connect Four")


def setup():
    wi.zeichne_spielfeld()
    sp.setup()
    sp.spielfeld_anz()

    

wi.welcome_screen()
waiting = True
while waiting:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
        if event.type == pygame.KEYDOWN:
            waiting = False

setup()

# Hauptloop
def spiel_läuft():
    running = True
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False  # Schließt das Fenster

            if event.type == pygame.MOUSEMOTION:
                pygame.draw.rect(screen, SCHWARZ, (0,0, breite, QUADRAT))
                posx = event.pos[0]
                pygame.draw.circle(screen, ROT, (posx, int(QUADRAT/2)), RADIUS)

                pygame.display.update()

            if event.type == pygame.MOUSEBUTTONDOWN:
                pygame.draw.rect(screen, SCHWARZ, (0,0, breite, QUADRAT))
                posx = event.pos[0]
                spalte = posx // QUADRAT            
                sp.spielfeld_anz()
                print('Spieler O:')
                sp.stein_setzen(SPIELER, spalte)
                sp.spielfeld_anz()
                print('Spieler X:')
                pc.input()
                pygame.time.wait(300)

        # Updated das Fenster nach jedem Durchgang
        pygame.display.flip()

spiel_läuft ()

# Quit Pygame
pygame.quit()
