import pandas as pd
import numpy as np

from scipy.spatial import euclidean
from fastdtw import fastdtw


''' 
Takes in 2 np.arrays representing the two curves to be scored. Uses 
Procrustes Analysis to orient the curves, then finds the similarity 
of the two curves using fastdtw
'''

def score_curves(curve1, curve2, basis='percent') -> float:
    reference1 = fastdtw(curve1, np.zeros(curve1.shape), dist=euclidean)
    reference2 = fastdtw(curve2, np.zeros(curve2.shape), dist=euclidean)

    distance = fastdtw(curve1, curve2, dist=euclidean)

    # visualization?
    
    return distance/min(reference1, reference2)
