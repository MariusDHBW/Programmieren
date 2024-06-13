import numpy as np
import random
import pygame
import sys
import math

BLUE = (0, 0, 255)
BLACK = (0, 0, 0)
RED = (255, 0, 0)
YELLOW = (255, 255, 0)

ROW_COUNT = 6
COLUMN_COUNT = 7

PLAYER = 0
AI = 1

EMPTY = 0
PLAYER_PIECE = 1
AI_PIECE = 2

WINDOW_LENGTH = 4

player_wins = 0
ai_wins = 0

def create_board():
    board = np.zeros((ROW_COUNT, COLUMN_COUNT))
    return board

def drop_piece(board, row, col, piece):
    board[row][col] = piece

def is_valid_location(board, col):
    return board[ROW_COUNT-1][col] == 0

def get_next_open_row(board, col):
    for r in range(ROW_COUNT):
        if board[r][col] == 0:
            return r

def print_board(board):
    print(np.flip(board, 0))

def winning_move(board, piece):
    # Check horizontal locations for win
    for c in range(COLUMN_COUNT-3):
        for r in range(ROW_COUNT):
            if board[r][c] == piece and board[r][c+1] == piece and board[r][c+2] == piece and board[r][c+3] == piece:
                return True

    # Check vertical locations for win
    for c in range(COLUMN_COUNT):
        for r in range(ROW_COUNT-3):
            if board[r][c] == piece and board[r+1][c] == piece and board[r+2][c] == piece and board[r+3][c] == piece:
                return True

    # Check positively sloped diagonals
    for c in range(COLUMN_COUNT-3):
        for r in range(ROW_COUNT-3):
            if board[r][c] == piece and board[r+1][c+1] == piece and board[r+2][c+2] == piece and board[r+3][c+3] == piece:
                return True

    # Check negatively sloped diagonals
    for c in range(COLUMN_COUNT-3):
        for r in range(3, ROW_COUNT):
            if board[r][c] == piece and board[r-1][c+1] == piece and board[r-2][c+2] == piece and board[r-3][c+3] == piece:
                return True

def evaluate_window(window, piece):
    score = 0
    opp_piece = PLAYER_PIECE
    if piece == PLAYER_PIECE:
        opp_piece = AI_PIECE

    if window.count(piece) == 4:
        score += 100
    elif window.count(piece) == 3 and window.count(EMPTY) == 1:
        score += 5
    elif window.count(piece) == 2 and window.count(EMPTY) == 2:
        score += 2

    if window.count(opp_piece) == 3 and window.count(EMPTY) == 1:
        score -= 4

    return score

def score_position(board, piece):
    score = 0

    ## Score center column
    center_array = [int(i) for i in list(board[:, COLUMN_COUNT//2])]
    center_count = center_array.count(piece)
    score += center_count * 3

    ## Score Horizontal
    for r in range(ROW_COUNT):
        row_array = [int(i) for i in list(board[r, :])]
        for c in range(COLUMN_COUNT-3):
            window = row_array[c:c+WINDOW_LENGTH]
            score += evaluate_window(window, piece)

    ## Score Vertical
    for c in range(COLUMN_COUNT):
        col_array = [int(i) for i in list(board[:, c])]
        for r in range(ROW_COUNT-3):
            window = col_array[r:r+WINDOW_LENGTH]
            score += evaluate_window(window, piece)

    ## Score positive sloped diagonal
    for r in range(ROW_COUNT-3):
        for c in range(COLUMN_COUNT-3):
            window = [board[r+i][c+i] for i in range(WINDOW_LENGTH)]
            score += evaluate_window(window, piece)

    for r in range(ROW_COUNT-3):
        for c in range(COLUMN_COUNT-3):
            window = [board[r+3-i][c+i] for i in range(WINDOW_LENGTH)]
            score += evaluate_window(window, piece)

    return score

def is_terminal_node(board):
    return winning_move(board, PLAYER_PIECE) or winning_move(board, AI_PIECE) or len(get_valid_locations(board)) == 0

def minimax(board, depth, alpha, beta, maximizingPlayer):
    valid_locations = get_valid_locations(board)
    is_terminal = is_terminal_node(board)
    if depth == 0 or is_terminal:
        if is_terminal:
            if winning_move(board, AI_PIECE):
                return (None, 100000000000000)
            elif winning_move(board, PLAYER_PIECE):
                return (None, -10000000000000)
            else: # Game is over, no more valid moves
                return (None, 0)
        else: # Depth is zero
            return (None, score_position(board, AI_PIECE))
    if maximizingPlayer:
        value = -math.inf
        column = random.choice(valid_locations)
        for col in valid_locations:
            row = get_next_open_row(board, col)
            b_copy = board.copy()
            drop_piece(b_copy, row, col, AI_PIECE)
            new_score = minimax(b_copy, depth-1, alpha, beta, False)[1]
            if new_score > value:
                value = new_score
                column = col
            alpha = max(alpha, value)
            if alpha >= beta:
                break
        return column, value

    else: # Minimizing player
        value = math.inf
        column = random.choice(valid_locations)
        for col in valid_locations:
            row = get_next_open_row(board, col)
            b_copy = board.copy()
            drop_piece(b_copy, row, col, PLAYER_PIECE)
            new_score = minimax(b_copy, depth-1, alpha, beta, True)[1]
            if new_score < value:
                value = new_score
                column = col
            beta = min(beta, value)
            if alpha >= beta:
                break
        return column, value

def get_valid_locations(board):
    valid_locations = []
    for col in range(COLUMN_COUNT):
        if is_valid_location(board, col):
            valid_locations.append(col)
    return valid_locations

def pick_best_move(board, piece):

    valid_locations = get_valid_locations(board)
    best_score = -10000
    best_col = random.choice(valid_locations)
    for col in valid_locations:
        row = get_next_open_row(board, col)
        temp_board = board.copy()
        drop_piece(temp_board, row, col, piece)
        score = score_position(temp_board, piece)
        if score > best_score:
            best_score = score
            best_col = col

    return best_col

def draw_board(board):
    for c in range(COLUMN_COUNT):
        for r in range(ROW_COUNT):
            pygame.draw.rect(screen, BLUE, (c*SQUARESIZE, r*SQUARESIZE+SQUARESIZE, SQUARESIZE, SQUARESIZE))
            pygame.draw.circle(screen, BLACK, (int(c*SQUARESIZE+SQUARESIZE/2), int(r*SQUARESIZE+SQUARESIZE+SQUARESIZE/2)), RADIUS)
    
    for c in range(COLUMN_COUNT):
        for r in range(ROW_COUNT):        
            if board[r][c] == PLAYER_PIECE:
                pygame.draw.circle(screen, RED, (int(c*SQUARESIZE+SQUARESIZE/2), height-int(r*SQUARESIZE+SQUARESIZE/2)), RADIUS)
            elif board[r][c] == AI_PIECE: 
                pygame.draw.circle(screen, YELLOW, (int(c*SQUARESIZE+SQUARESIZE/2), height-int(r*SQUARESIZE+SQUARESIZE/2)), RADIUS)
    pygame.display.update()

def welcome_screen():
    global screen
    screen.fill(BLACK)
    welcome_font = pygame.font.SysFont("monospace", 30)
    small_font = pygame.font.SysFont("monospace", 20)
    
    welcome_label = welcome_font.render("Willkommen bei Vier Gewinnt!", 1, (255, 255, 255))
    welcome_label_rect = welcome_label.get_rect(center=(width // 2, height // 2 - 100))
    
    player_label = welcome_font.render("Du spielst als die Farbe Rot.", 1, (255, 0, 0))
    player_label_rect = player_label.get_rect(center=(width // 2, height // 2 - 50))
    
    ai_label = welcome_font.render("Die KI spielt als die Farbe Gelb.", 1, (255, 255, 0))
    ai_label_rect = ai_label.get_rect(center=(width // 2, height // 2))
    
    rules_label1 = small_font.render("Ziel: Vier deiner Spielsteine in einer", 1, (255, 255, 255))
    rules_label1_rect = rules_label1.get_rect(center=(width // 2, height // 2 + 50))
    
    rules_label2 = small_font.render("waagerechten, senkrechten oder diagonalen", 1, (255, 255, 255))
    rules_label2_rect = rules_label2.get_rect(center=(width // 2, height // 2 + 80))
    
    rules_label3 = small_font.render("Reihe zu platzieren.", 1, (255, 255, 255))
    rules_label3_rect = rules_label3.get_rect(center=(width // 2, height // 2 + 110))
    
    start_label = welcome_font.render("Drücke eine beliebige Taste,", 1, (255, 255, 255))
    start_label_rect = start_label.get_rect(center=(width // 2, height // 2 + 150))

    start_label2 = welcome_font.render("um zu beginnen.", 1, (255,255,255))
    start_label2_rect = start_label2.get_rect(center=(width // 2, height // 2+ 180))

    
    screen.blit(welcome_label, welcome_label_rect)
    screen.blit(player_label, player_label_rect)
    screen.blit(ai_label, ai_label_rect)
    screen.blit(rules_label1, rules_label1_rect)
    screen.blit(rules_label2, rules_label2_rect)
    screen.blit(rules_label3, rules_label3_rect)
    screen.blit(start_label, start_label_rect)
    screen.blit(start_label2, start_label2_rect)
    pygame.display.update()
    
    waiting = True
    while waiting:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                sys.exit()
            if event.type == pygame.KEYDOWN:
                waiting = False

def game_over_screen(winner):
    global screen, player_wins, ai_wins
    screen.fill(BLACK)
    end_font = pygame.font.SysFont("monospace", 50)
    small_font = pygame.font.SysFont("monospace", 30)
    
    if winner == PLAYER:
        end_label = end_font.render("Spieler gewinnt!", 1, RED)
        player_wins += 1
    else:
        end_label = end_font.render("KI gewinnt!", 1, YELLOW)
        ai_wins += 1
    
    end_label_rect = end_label.get_rect(center=(width // 2, height // 2 - 50))
    
    player_wins_label = small_font.render(f"Spieler Siege: {player_wins}", 1, (255, 255, 255))
    player_wins_label_rect = player_wins_label.get_rect(center=(width // 2, height // 2 + 50))
    
    ai_wins_label = small_font.render(f"KI Siege: {ai_wins}", 1, (255, 255, 255))
    ai_wins_label_rect = ai_wins_label.get_rect(center=(width // 2, height // 2 + 100))
    
    restart_label = small_font.render("Drücke R, um neu zu starten.", 1, (255, 255, 255))
    restart_label_rect = restart_label.get_rect(center=(width // 2, height // 2 + 150))
    
    quit_label = small_font.render("Drücke Q, um zu beenden.", 1, (255, 255, 255))
    quit_label_rect = quit_label.get_rect(center=(width // 2, height // 2 + 200))
    
    screen.blit(end_label, end_label_rect)
    screen.blit(player_wins_label, player_wins_label_rect)
    screen.blit(ai_wins_label, ai_wins_label_rect)
    screen.blit(restart_label, restart_label_rect)
    screen.blit(quit_label, quit_label_rect)
    pygame.display.update()
    
    waiting = True
    while waiting:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                sys.exit()
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_r:
                    main()
                    waiting = False
                if event.key == pygame.K_q:
                    pygame.quit()
                    sys.exit()

def main():
    global screen, width, height, SQUARESIZE, RADIUS
    pygame.init()
    
    SQUARESIZE = 100
    width = COLUMN_COUNT * SQUARESIZE
    height = (ROW_COUNT + 1) * SQUARESIZE
    size = (width, height)
    RADIUS = int(SQUARESIZE / 2 - 5)
    screen = pygame.display.set_mode(size)
    
    welcome_screen()
    board = create_board()
    print_board(board)
    game_over = False

    draw_board(board)
    pygame.display.update()

    myfont = pygame.font.SysFont("monospace", 75)

    turn = random.randint(PLAYER, AI)

    while not game_over:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                sys.exit()

            if event.type == pygame.MOUSEMOTION:
                pygame.draw.rect(screen, BLACK, (0, 0, width, SQUARESIZE))
                posx = event.pos[0]
                if turn == PLAYER:
                    pygame.draw.circle(screen, RED, (posx, int(SQUARESIZE/2)), RADIUS)

            pygame.display.update()

            if event.type == pygame.MOUSEBUTTONDOWN:
                pygame.draw.rect(screen, BLACK, (0, 0, width, SQUARESIZE))
                if turn == PLAYER:
                    posx = event.pos[0]
                    col = int(math.floor(posx/SQUARESIZE))

                    if is_valid_location(board, col):
                        row = get_next_open_row(board, col)
                        drop_piece(board, row, col, PLAYER_PIECE)

                        if winning_move(board, PLAYER_PIECE):
                            label = myfont.render("Spieler gewinnt!", 1, RED)
                            screen.blit(label, (40, 10))
                            game_over = True

                        turn += 1
                        turn = turn % 2

                        print_board(board)
                        draw_board(board)

        if turn == AI and not game_over:
            col, minimax_score = minimax(board, 5, -math.inf, math.inf, True)

            if is_valid_location(board, col):
                row = get_next_open_row(board, col)
                drop_piece(board, row, col, AI_PIECE)

                if winning_move(board, AI_PIECE):
                    label = myfont.render("KI gewinnt!", 1, YELLOW)
                    screen.blit(label, (40, 10))
                    game_over = True

                print_board(board)
                draw_board(board)

                turn += 1
                turn = turn % 2

        if game_over:
            game_over_screen(PLAYER if winning_move(board, PLAYER_PIECE) else AI)

if __name__ == "__main__":
    main()
