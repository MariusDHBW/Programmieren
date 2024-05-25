"""Eine Matrix-Klasse zum Arbeiten mit Zahlen."""

import random


class Matrix:
    """Eine Matrix aus der linearen Algebra.

    Die Matrizen speichern ihre Einträge intern als `tuple` von `tuple`s von `float`s.
    """

    def __init__(self, entries):
        """Erstelle eine neue Matrix.

        Args:
            entries (Sequenz von Sequenzen von Zahlen): Die Einträge der Matrix;
                die inneren Sequenzen stellen die Reihen der Matrix dar

        Raises:
            - RuntimeError: wenn die Einträge in der Matrix fehlerhalt sind
            - TypeError: wenn die Einträge keine Zahlen sind
        """
        try:
            validated_entries = tuple(tuple(float(entry) for entry in row) for row in entries)
        except ValueError:
            raise TypeError("Matrizen dürfen nur aus Zahlen bestehen!") from None

        if len(validated_entries) == 0:
            raise RuntimeError("Eine Matrix muss mindestens eine Reihe enthalten!")

        if len(validated_entries[0]) == 0:
            raise RuntimeError("Eine Matrix muss mindestens eine Spalte enthalten!")

        n_cols_in_first_row = len(validated_entries[0])

        for row in validated_entries:
            if len(row) != n_cols_in_first_row:
                raise RuntimeError("Jede Reihe muss diesselbe Anzahl an Spalten haben!")
        
        self._entries = validated_entries

    @classmethod
    def from_rows(cls, entries):
        """Synonym für den Klassen-Constructor.
        
        vgl. `.__init__()`
        """
        return cls(entries)

    @classmethod
    def from_cols(cls, entries):
        """Erstelle eine neue Matrix von gegebenen Spalten.

        vgl. `.__init__()`

        Args:
            entries (Sequenz von Sequenzen von Zahlen): Die Einträge der Matrix;
                die inneren Sequenzen stellen die Spalten der Matrix dar

        Raises:
            - RuntimeError: wenn die Einträge in der Matrix fehlerhalt sind
            - TypeError: wenn die Einträge keine Zahlen sind
        """
        return cls(entries).transpose()

    @classmethod
    def random(cls, *, n_rows, n_cols, min_=1, max_=99):
        """Erstelle eine Matrix mit ganzen Zufallszahlen.

        Args:
            n_rows (int): Anzahl der Reihen
            n_cols (int): Anzahl der Spalten
            min_ (int): Kleinste Zahl aus dem Zufallsgenerator
            max_ (int): Größte Zahl aus dem Zufallsgenerator
        """
        return cls(((random.randint(min_, max_) for _ in range(n_cols)) for _ in range(n_rows)))

    def __repr__(self):
        name = self.__class__.__name__
        args = ", ".join(
            "(" + ", ".join(repr(c) for c in r) + ",)" for r in self._entries
        )
        return f"{name}(({args}))"

    def __contains__(self, element):
        for row in self._entries:
            for entry in row:  # if element in row:
                if abs(entry - element) < 1e-12:
                    return True
        return False
    
    def __len__(self):
        return self.n_rows * self.n_cols

    def __iter__(self):
        """Loope über die Einträge der Matrix, Reihen-weise."""
        return (entry for row in self._entries for entry in row)

    def __reversed__(self):
        """Loope rückwärts über die Einträge der Matrix, Reihen-weise."""
        return (entry for row in reversed(self._entries) for entry in reversed(row))

    def rows(self):
        """Loope über die Reihen der Matrix."""
        return (Vector(row) for row in self._entries)

    @property  # => die Methode wird "automatisch" gecalled
    def n_rows(self):
        return len(self._entries)

    @property
    def n_cols(self):
        return len(self._entries[0])

    @property
    def shape(self):
        return (self.n_rows, self.n_cols)

    def transpose(self):
        return self.__class__(zip(*self._entries))

    def __pos__(self):
        return self

    def __neg__(self):
        return self.__class__(-row for row in self.rows())  # wir wollen eigentlich über die Reihen als Ganzes loopen

    def __add__(self, other):
        if isinstance(other, self.__class__):
            if self.shape != other.shape:
                raise RuntimeError("Die Matrizen müssen gleich groß sein!")
            return self.__class__(x + y for x, y in zip(self.rows(), other.rows()))

        elif isinstance(other, (int, float)):  # Broadcasting (vgl. numpy)
            return self.__class__(row + other for row in self.rows())

        return NotImplemented

    __radd__ = __add__

    def __sub__(self, other):
        return self + (-other)

    def __rsub__(self, other):
        return -self + other

    def __truediv__(self, other):
        if isinstance(other, (int, float)):
            return self.__class__(x / other for x in self.rows())

        return NotImplemented

    def __mul__(self, other):
        if isinstance(other, (int, float)):
            return self.__class__(entry * other for entry in self.rows())

        return NotImplemented

    def __eq__(self, other):
        if isinstance(other, self.__class__) and self.shape == other.shape:
            for x, y in zip(self, other):
                # if x != y:  # nicht gut => weil `float`s nicht präzise sind
                if not abs(x - y) < 1e-12:
                    return False
            return True
        return False

from vectors import Vector