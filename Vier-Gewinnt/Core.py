import pygame
import math
from Computer import Computer as pc
from Spielfeld import Spielfeld as sp
from Window import Window as wi

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


#while True:
#    spieler = 'O'
#    sp.spielfeld_anz()
#    spieler_input(spieler)
#    spieler = 'X'
#    sp.spielfeld_anz()
#    print('Spieler X:')
#    pc.input(spieler)

# Define colors
BLAU = (0, 0, 255)
SCHWARZ = (0, 0, 0)
ROT = (255, 0, 0)
GELB = (255, 255, 0)

ANZ_ZEILEN = 6
ANZ_SPALTEN = 7
#STANDARTWERT = '.'

#SPIELER = 'O'
#AI = 1

EMPTY = 0
PLAYER_PIECE = 'O'
AI_PIECE = 'X'

QUADRAT = 100
breite = ANZ_SPALTEN * QUADRAT
höhe = (ANZ_ZEILEN + 1) * QUADRAT
größe = (breite, höhe)
RADIUS = int(QUADRAT / 2 - 5)

# Initialize Pygame
pygame.init()

# Create the game window
screen = pygame.display.set_mode(größe)
pygame.display.set_caption("Connect Four")  # Set window title

spalte = 0

def update_spielfeld(zeile, spalte):
    # Draw the player pieces

    if spieler == PLAYER_PIECE:
        pygame.draw.circle(screen, ROT, (int(spalte * QUADRAT + QUADRAT / 2), int(zeile * QUADRAT + QUADRAT + QUADRAT / 2)), RADIUS)
    elif spieler == AI_PIECE:
        pygame.draw.circle(screen, GELB, (int(spalte * QUADRAT + QUADRAT / 2), int(zeile * QUADRAT + QUADRAT + QUADRAT / 2)), RADIUS)

    pygame.display.update()  # Update the display

# Draw the initial board
wi.zeichne_spielfeld()

# Main loop (keeps the program running and handles events)
running = True
while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False  # Exit the loop when the user closes the window

    # Update the display at the end of each loop
    pygame.display.flip()

    if event.type == pygame.MOUSEMOTION:
        pygame.draw.rect(screen, SCHWARZ, (0,0, breite, QUADRAT))
        posx = event.pos[0]
        pygame.draw.circle(screen, ROT, (posx, int(QUADRAT/2)), RADIUS)

        pygame.display.update()

    if event.type == pygame.MOUSEBUTTONDOWN:
        pygame.draw.rect(screen, SCHWARZ, (0,0, breite, QUADRAT))
        posx = event.pos[0]
        spalte = int(math.floor(posx/QUADRAT))
        spieler = 'O'
        sp.spielfeld_anz()
        zeile, spalte = sp.stein_setzen(spieler, spalte)
        #wi.update_spielfeld(spieler, zeile, spalte)
        update_spielfeld(zeile, spalte)
        spieler = 'X'
        sp.spielfeld_anz()
        print('Spieler X:')
        zeile, spalte = pc.input(spieler)
        #wi.update_spielfeld(spieler, zeile, spalte)
        update_spielfeld(zeile, spalte)
        pygame.time.wait(300)

# Quit Pygame
pygame.quit()
