# mode: run
# tag: dict, getitem

cimport cython

def test(dict d, index):
    """
    >>> d = { 1: 10 }
    >>> test(d, 1)
    10

    >>> test(d, 2)
    Traceback (most recent call last):
    KeyError: 2

    >>> test(d, (1,2))
    Traceback (most recent call last):
    KeyError: (1, 2)

    >>> class Unhashable:
    ...    def __hash__(self):
    ...        raise ValueError
    >>> test(d, Unhashable())
    Traceback (most recent call last):
    ValueError

    >>> test(None, 1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
    TypeError: ...object...
    """
    return d[index]

def getitem_in_condition(dict d, key, expected_result):
    """
    >>> d = dict(a=1, b=2)
    >>> getitem_in_condition(d, 'a', 1)
    True
    """
    return d[key] is expected_result or d[key] == expected_result

@cython.test_fail_if_path_exists('//NoneCheckNode')
def getitem_not_none(dict d not None, key):
    """
    >>> d = { 1: 10 }
    >>> test(d, 1)
    10

    >>> test(d, 2)
    Traceback (most recent call last):
    KeyError: 2

    >>> test(d, (1,2))
    Traceback (most recent call last):
    KeyError: (1, 2)
    """
    return d[key]
