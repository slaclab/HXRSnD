import logging
from .plans import rocking_curve, maximize_lorentz

from ._version import get_versions
__version__ = get_versions()['version']
del get_versions
