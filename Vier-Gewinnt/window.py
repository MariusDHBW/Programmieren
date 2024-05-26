import pygame

# Define colors
BLAU = (0, 0, 255)
SCHWARZ = (0, 0, 0)
ROT = (255, 0, 0)
GELB = (255, 255, 0)

ANZ_ZEILEN = 6
ANZ_SPALTEN = 7

PLAYER_PIECE = 'O'
AI_PIECE = 'X'

QUADRAT = 100
breite = ANZ_SPALTEN * QUADRAT
höhe = (ANZ_ZEILEN + 1) * QUADRAT
größe = (breite, höhe)
RADIUS = int(QUADRAT / 2 - 5)

screen = pygame.display.set_mode(größe)

player_wins, ai_wins = 0, 0

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




    def welcome_screen():
        global screen
        screen.fill(SCHWARZ)
        welcome_font = pygame.font.SysFont("monospace", 30)
        small_font = pygame.font.SysFont("monospace", 20)

        welcome_label = welcome_font.render("Willkommen bei Vier Gewinnt!", 1, (255, 255, 255))
        welcome_label_rect = welcome_label.get_rect(center=(breite // 2, höhe // 2 - 100))

        player_label = welcome_font.render("Du spielst als die Farbe Rot.", 1, (255, 0, 0))
        player_label_rect = player_label.get_rect(center=(breite // 2, höhe // 2 - 50))

        ai_label = welcome_font.render("Die KI spielt als die Farbe Gelb.", 1, (255, 255, 0))
        ai_label_rect = ai_label.get_rect(center=(breite // 2, höhe // 2))

        rules_label1 = small_font.render("Ziel: Vier deiner Spielsteine in einer", 1, (255, 255, 255))
        rules_label1_rect = rules_label1.get_rect(center=(breite // 2, höhe // 2 + 50))

        rules_label2 = small_font.render("waagerechten, senkrechten oder diagonalen", 1, (255, 255, 255))
        rules_label2_rect = rules_label2.get_rect(center=(breite // 2, höhe // 2 + 80))

        rules_label3 = small_font.render("Reihe zu platzieren.", 1, (255, 255, 255))
        rules_label3_rect = rules_label3.get_rect(center=(breite // 2, höhe // 2 + 110))

        start_label = welcome_font.render("Drücke eine beliebige Taste,", 1, (255, 255, 255))
        start_label_rect = start_label.get_rect(center=(breite // 2, höhe // 2 + 150))

        start_label2 = welcome_font.render("um zu beginnen.", 1, (255,255,255))
        start_label2_rect = start_label2.get_rect(center=(breite // 2, höhe // 2+ 180))


        screen.blit(welcome_label, welcome_label_rect)
        screen.blit(player_label, player_label_rect)
        screen.blit(ai_label, ai_label_rect)
        screen.blit(rules_label1, rules_label1_rect)
        screen.blit(rules_label2, rules_label2_rect)
        screen.blit(rules_label3, rules_label3_rect)
        screen.blit(start_label, start_label_rect)
        screen.blit(start_label2, start_label2_rect)
        pygame.display.update()


    def game_over_screen(winner):
        global screen, player_wins, ai_wins
        screen.fill(SCHWARZ)
        end_font = pygame.font.SysFont("monospace", 50)
        small_font = pygame.font.SysFont("monospace", 30)

        if winner == PLAYER_PIECE:
            end_label = end_font.render("Spieler gewinnt!", 1, ROT)
            player_wins += 1
        else:
            end_label = end_font.render("KI gewinnt!", 1, GELB)
            ai_wins += 1

        end_label_rect = end_label.get_rect(center=(breite // 2, höhe // 2 - 50))

        player_wins_label = small_font.render(f"Spieler Siege: {player_wins}", 1, (255, 255, 255))
        player_wins_label_rect = player_wins_label.get_rect(center=(breite // 2, höhe // 2 + 50))

        ai_wins_label = small_font.render(f"KI Siege: {ai_wins}", 1, (255, 255, 255))
        ai_wins_label_rect = ai_wins_label.get_rect(center=(breite // 2, höhe // 2 + 100))

        restart_label = small_font.render("Drücke R, um neu zu starten.", 1, (255, 255, 255))
        restart_label_rect = restart_label.get_rect(center=(breite // 2, höhe // 2 + 150))

        quit_label = small_font.render("Drücke Q, um zu beenden.", 1, (255, 255, 255))
        quit_label_rect = quit_label.get_rect(center=(breite // 2, höhe // 2 + 200))

        screen.blit(end_label, end_label_rect)
        screen.blit(player_wins_label, player_wins_label_rect)
        screen.blit(ai_wins_label, ai_wins_label_rect)
        screen.blit(restart_label, restart_label_rect)
        screen.blit(quit_label, quit_label_rect)
        pygame.display.update()

#        waiting = True
#        while waiting:
#            for event in pygame.event.get():
#                if event.type == pygame.QUIT:
#                    pygame.quit()
#                if event.type == pygame.KEYDOWN:
#                    if event.key == pygame.K_r:
#                        #main()
#                        waiting = False
#                    if event.key == pygame.K_q:
#                        pygame.quit()
#