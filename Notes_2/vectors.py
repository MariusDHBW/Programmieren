"""Eine Vector-Klasse zum Arbeiten mit Zahlen."""

from matrix import Matrix


class Vector:
    """Ein Vector aus der linearen Algebra.

    Die Vektoren speichern ihre Einträge intern als `tuple`s von `float`s.
    """

    def __init__(self, entries):
        """Erstelle einen neuen Vector.

        Args:
            entries (Sequenz von Zahlen): Die Einträge des Vectors

        Raises:
            - TypeError: wenn nicht-Zahlen gegeben sind
            - ValueError: wenn eine leere Sequenz gegeben ist
        """
        try:
            entries = tuple(float(entry) for entry in entries)
        except ValueError:
            raise TypeError("Vektoren dürfen nur aus Zahlen bestehen!") from None

        if len(entries) == 0:
            raise ValueError("Ein Vektor muss mindestens eine Zahl enthalten!")

        # "_" => "private" in anderen Sprachen
        self._entries = entries

    def __repr__(self):
        # return "Vector(" + repr(self._entries) + ")"
        return f"{self.__class__.__name__}({repr(self._entries)})"

    def __contains__(self, element):
        return element in self._entries

    def __len__(self):
        return len(self._entries)

    def __iter__(self):
        return iter(self._entries)

    def __reversed__(self):
        return reversed(self._entries)
    
    def __getitem__(self, index):
        return self._entries[index]

    def _assert_same_length(self, other):
        if len(self) != len(other):  # len(self) ->  self.__len__()  |  len(other) -> other.__len__() -> Vector.__len__(other)
            raise RuntimeError("Die Vektoren müssen gleich lang sein!")

    def __pos__(self):
        return self  # keine Kopie (weil unsere `Vector`en per Design immutable sind)

    def __neg__(self):
        return self.__class__(-x for x in self)  # Kopie!

    def __add__(self, other):
        if isinstance(other, self.__class__):
            self._assert_same_length(other)
            return self.__class__(x + y for x, y in zip(self, other))

        elif isinstance(other, (int, float)):  # Broadcasting (vgl. numpy)
            return self.__class__(entry + other for entry in self)

        return NotImplemented

    __radd__ = __add__

    def __sub__(self, other):  # self - other
        return self + (-other)  # self.__add__(other.__neg__())

    # __rsub__ = __sub__  # wäre falsch, da nicht symmetrisch

    def __rsub__(self, other):  # other - self
        return -self + other

    def __mul__(self, other):
        if isinstance(other, self.__class__):
            self._assert_same_length(other)
            return sum(x * y for x, y in zip(self, other))

        elif isinstance(other, (int, float)):
            return self.__class__(entry * other for entry in self)

        return NotImplemented

    __rmul__ = __mul__

    def __truediv__(self, other):  # self / other
        if isinstance(other, (int, float)):
            return self.__class__(x / other for x in self)

        return NotImplemented

    # def __rtruediv__(self, other):  # other / self      Wenn nur `return NotImplemented` => weglassen
    #     return NotImplemented

    def __eq__(self, other):
        if isinstance(other, self.__class__) and len(self) == len(other):
            for x, y in zip(self, other):
                # if x != y:  # nicht gut => weil `float`s nicht präzise sind
                if not abs(x - y) < 1e-12:
                    return False
            return True
        return False

    # def __ne__(self, other):
    #     if isinstance(other, self.__class__) and len(self) == len(other):
    #         for x, y in zip(self, other):
    #             if not abs(x - y) > 1e-12:
    #                  return True
    #          return False
    #      return True

    def as_matrix(self, *, column=True):
        """Erzeuge eine Matrix aus dem Vector."""
        if column:
            return Matrix([[x] for x in self])
        return Matrix([self._entries])









