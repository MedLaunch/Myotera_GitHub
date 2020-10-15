from Visualization import newVis
import pandas as pd
import numpy as np

from scipy.spatial.distance import directed_hausdorff


'''
General code structure:
Class for receiving data and adjusting if necessary.
Additional files in directory corresponding to methods required 
for data visualization and curve-fitting. 

In general, try to maximize and maintain modularity, as this 
could eventually become an open-source project. Use a unit-testing
suite such as pytest, and configure a pre-commit linter to improve
readability. 

Include a better description of the requirements and an overview
of the functionality and motivation of the code in the README file.
'''


def score_curves(curve1, curve2, basis='percent') -> float:
    # aligned = align(curve1, curve2)
    # TODO: implement everything

    return curve1/curve2
