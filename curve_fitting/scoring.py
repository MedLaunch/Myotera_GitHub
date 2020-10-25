import pandas as pd
import numpy as np

from scipy.spatial import euclidean
from fastdtw import fastdtw


''' 
Uses fastdtw to find distance between curves, then converts this distance
measure to a number on the scale [0, 100]
'''

def score_curves(curve1, curve2, standardized=True) -> float:
    ''' return the distance between 2 time series without approximation
        Parameters
        ----------
        curve1 : array_like
            input array 1
        curve2 : array_like
            input array 2
        basis : bool
            If true, score_curves will return 100 times the ratio of the 
            distance between the two curves and the size of the smaller of the
            two curves. Otherwise, returns the unprocessed ratio. 

        Returns
        -------
        score : float
            the score of the two curves
    '''

    reference1 = fastdtw(curve1, np.zeros(curve1.shape), dist=euclidean)
    reference2 = fastdtw(curve2, np.zeros(curve2.shape), dist=euclidean)

    distance = fastdtw(curve1, curve2, dist=euclidean)

    # visualization?

    ratio = distance/max(reference1, reference2)

    return ratio*100 if standardized else ratio
