#!/usr/bin/env python3

"""Uses Scikit's classifiers to give a prediction.
   Uses ensemble classifiers GradientBoostingClassifier and
   RandomForestClassifier to classify the test data after
   having been trained on the training data.
"""

import pandas as pd
from sklearn.pipeline import Pipeline
from sklearn.ensemble import GradientBoostingClassifier, RandomForestClassifier

if __name__ == "__main__":
    # Read the data into a pandas dataframe.

    # Comparison of the two classifiers.
    compareClassifiers()

    # Run the best classifier and write the predictions to a csv file.
    predict(GradientBoostingClassifier)
