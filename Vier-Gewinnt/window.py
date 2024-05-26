import pygame
#from Spielfeld import Spielfeld as sp

# Define colors
BLAU = (0, 0, 255)
SCHWARZ = (0, 0, 0)
ROT = (255, 0, 0)
GELB = (255, 255, 0)

ANZ_ZEILEN = 6
ANZ_SPALTEN = 7
STANDARTWERT = '.'

SPIELER = 'O'
#AI = 1

EMPTY = 0
PLAYER_PIECE = 1
AI_PIECE = 2

QUADRAT = 100
breite = ANZ_SPALTEN * QUADRAT
höhe = (ANZ_ZEILEN + 1) * QUADRAT
größe = (breite, höhe)
RADIUS = int(QUADRAT / 2 - 5)

# Initialize Pygame
#pygame.init()

# Create the game window
screen = pygame.display.set_mode(größe)
pygame.display.set_caption("Connect Four")  # Set window title

class Window:

    def zeichne_spielfeld():
        # Draw the board grid
        pygame.draw.rect(screen, BLAU, (0, QUADRAT, ANZ_SPALTEN * QUADRAT, ANZ_ZEILEN * QUADRAT))
        for c in range(ANZ_SPALTEN):
            for r in range(ANZ_ZEILEN):
                pygame.draw.circle(screen, SCHWARZ, (int(c * QUADRAT + QUADRAT / 2), int(r * QUADRAT + QUADRAT + QUADRAT / 2)), RADIUS)

        pygame.display.update()

    def update_spielfeld(spieler, zeile, spalte):
        # Draw the player pieces

        if spieler == PLAYER_PIECE:
            pygame.draw.circle(screen, ROT, (int(spalte * QUADRAT + QUADRAT / 2), int(zeile * QUADRAT + QUADRAT + QUADRAT / 2)), RADIUS)
        elif spieler == AI_PIECE:
            pygame.draw.circle(screen, GELB, (int(spalte * QUADRAT + QUADRAT / 2), int(zeile * QUADRAT + QUADRAT + QUADRAT / 2)), RADIUS)

        pygame.display.update()  # Update the display