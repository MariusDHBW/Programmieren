"""Ein einfaches Münzwurfspiel."""

import random


def werfe_muenze(*, p_kopf=0.5):
    """Simuliere einen Münzwurf.

    Args:
        p_kopf (float): Wahrscheinlichkeit, dass "kopf" gewinnt;
            muss zwischen 0 und 1 liegen

    Returns:
        seite_oben (str): "kopf" oder "zahl"
    """
    if random.random() < p_kopf:
        return "kopf"
    return "zahl"


def mensch_muss_raten(*, prompt="Kopf oder Zahl?"):
    """Verarbeite die Eingabe des Menschen.

    Args:
        prompt (str): Nachricht, die dem Spieler angezeigt wird

    Returns:
        seite_oben (str / None): "kopf" oder "zahl",
            wenn die Eingabe verständlich ist;
            ansonsten `None`
    """
    geraten = input(prompt)

    # Einfache Schreibfehler handeln
    geraten = geraten.strip().lower()

    if geraten in ["kopf", "heads", "head", "k", "h"]:
        return "kopf"
    elif geraten in ["zahl", "tails", "tail", "z", "t", "number"]:
        return "zahl"

    return None


def spielen():
    """Eine Runde spielen."""
    while True:
    
        geraten = mensch_muss_raten(prompt="Bitten raten! Kopf oder Zahl?")
    
        if geraten == None:
            print("Bitte etwas Sinnvolles eingeben!!!")
            continue
    
        seite_oben = werfe_muenze(p_kopf=0.5)
    
        if seite_oben == geraten:
            print("Juhu, du hast gewonnen! Es war", seite_oben.title())
            break
    
        print("Oops, du hast verloren! Es war", seite_oben.title())


if __name__ == "__main__":  # "wenn diese Datei auf der Kommandozeile ausgeführt wird"
    spielen()