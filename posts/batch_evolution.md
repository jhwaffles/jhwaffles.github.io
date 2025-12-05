---
layout: page
title: "Batch Evolution"
permalink: /posts/batch_evolution/
---

# Batch Evolution Modeling: Determining what's a good batch.

## Overview

In this post, I go over applications of batch evolution modeling for process monitoring. What is batch evolution modeling? Batch evolution modeling a framework of methods that allow us to track processes holistically, and evaluate batches in progress. It incorporates concepts from data science/machine learning as well as statistical process control that allows us to solve real world problems. Although the context is in biomanufacturing and bioprocess engineering, the concepts can be applied to other fields (anomaly detection, manufacturing, any type of process monitoring.)

Let's say we have an established process that we are running periodically. With enough runs, we've established how runs are supposed to trend. How do we evaluate whats 'normal' for the process? How do we tell if a batch in-progress is behaving 'normally' or deviating? And if it is a deviating, do we have enough evidence to determine whether we 'scrap' the batch, saving time and costs? We can answer all of these with batch evolution modeling! Existing software (SIMCA) lets you do this, but I implement this in Python.

Data and code as well as reference literatures can be found on Github.

## Introduction

We work with a synthetic dataset of 17 runs, based off real world bioprocesses where we are making antibody as a product in a bioreactor. Along the way, samples are taken and measured for the product (titer, or concentration in mg/mL), as well as metabolites. It is common to collect sensor data such as dO%, pH, agitation speed, temperature, etc. In this example, we monitor 5 metabolites (acetate, glucose, ammonia, phosphate, pyruvate)

[image of sensors]

The first step is to do exploratory data analysis.

[image]

While its important to view the trends, we can use batch evolution modeling is useful for looking at holistically. In these types of scenarios, we are workign with high dimensinoal data (Lots of features vs observations), and often features are heavily correlated with each other. Batch evolution modeling allows us to compress the data so we can easily track the most important components by utilizing Partial Least Squares (PLS). Furthermore it is interpretable in that we can pull out the most important contributors to a 'bad' or 'deviated' batch. How is this done?

Data must be prepared. We collect and label all historical 'good' batches.

["/images/df_input2.png"]

## Step 1 - Model Batch Maturity on Time Series 

Get data into matrix where samples points (this includes each batch and sample point) make up rows while features make up columns. Let's call batches N, sample points J, and measurement columns K. We define Y as process maturity - in this instance we use batch_time.

### Data Preprocessing



        [import numpy as np
        import pandas as pd
        import matplotlib.pyplot as plt
        from sklearn.preprocessing import StandardScaler
        from sklearn.cross_decomposition import PLSRegression
        import sklearn.model_selection as skm
        import plotly.graph_objects as go

        df = pd.read_excel("synthesized_data.xlsx")
        X_cols = ['acetate_mM', 'glucose_g_L', 'magnesium_mM', 'nh3_mM', 'phosphate_mM']
        batch_col='batch_id',
        time_col='batch_time_h',
        y_time_col='batch_time_h',
        df_model = df_train[[self.time_col, self.batch_col] + self.X_cols].copy()
        df_model = df_model.sort_values([self.batch_col, self.time_col])
        X = df_model[self.X_cols].to_numpy()
        y = df_model[[self.y_time_col]].to_numpy()  # time as y
        ]

Center and scale. This is important because different features have different magnitudes and we want to avoid features with high values from dominating. There is an added bonus in centering at 0 since it makes subtracting the mean (0) easier. We can use sklearn library here.

        self.scaler_X = StandardScaler()
        X_scaled = self.scaler_X.fit_transform(X)

Next we initialize the Partial Least Squares (PLS) Model.

### What is PLS?

Partial Least Squares (PLS) is a supervised regression method used when you have many, often correlated predictors (X) and want to predict one or more responses (Y). It's commonly used in chemometrics, spectral analysis, and omics/gene work because it handles high dimensional data and collinearity well.
Like PCA, PLS builds latent components (scores and loadings) that are linear combinations of the original X-variables. However, instead of just capturing the variance in X, PLS chooses these components to maximize the covariance between X and Y, meaning it finds the variation in X that is most useful for predicting Y.

Each component has scores (where each sample sits on that component) and loadings/weights (how each variable contributes). Using these, you can both approximate X and build a prediction model for Y.

In batch evolution, local time is used as the Y-variable: it forces the PLS model to find the specific variation in the process variables (X) that describes the evolution of the batch over time.

### Choosing number of components

To determine the number of components to use, we use cross validation and fit models with 1,2,3..components, and plot prediction error vs number of components. We choose the point where error stops improving meaningful (the "elbow"), balancing good prediction performance against overfitting. 

        [kfold = skm.KFold(n_splits, random_state=0, shuffle=True)
        pls = PLSRegression()
        param_grid = {'n_components': range(1, max_components + 1)}

        grid = skm.GridSearchCV(
            pls,
            param_grid,
            cv=kfold,
            scoring='neg_mean_squared_error'
        )
        grid.fit(X_scaled, y)
        ]

["step1_cv_n_components"]

### Finalize model and get scores

After choosing number of components, we can rerun the model and

        [self.pls_scores = PLSRegression(n_components=self.n_components)
        self.pls_scores.fit(self._X_scaled_scores, self._y_scores)
        X_scaled=self._X_scaled_scores
        T = self.pls_scores.transform(X_scaled)  #these are scores.
        P = self.pls_scores.x_loadings_ #loadings
        ]

The scores output in T. The dimensions are (NxJ)xA.

["/images/df_scores"]

## Step 2 - Batch Traces.

Next, we rearrange the scores matrix to wide form. (Nx(AxJ)

    long = pls_scores_df.melt(
        id_vars=[batch_col, time_col],
        value_vars=comp_cols,
        var_name='component',
        value_name='score'
    )

    wide = (
        long
        .pivot(index=batch_col, columns=['component', time_col], values='score')
        .sort_index(axis=1, level=[0, 1])
    )

There should be 1 row for each batch, and 1 column for each component x time point.

["/images/df_X_t.png"]
    
From here we can calculate metrics such as average and standard deviations to use in our control charts. We do this for each component and time point.

With this format, we've established averages and upper/lower bounds for 'good' batches, as they evolve. For the bounds, we use +/-3 SD (other bounds can be chosen), 

This is useful as now we have a way to evaluate incoming batches and determine whether they are behaving or deviating! For example, if an incoming batch deviates by crossing the threshold, it's very likely not a 'good' batch.  allowing the engineering supervisor to make the decision to scrap the batch. 

["new_batch_monitor_comp1"]

## Step 3 - Predict outcome of batches (titer)

Predict titer. DmodX, T2. out of scope for this post.

To see if we see batch drift, or model drift. Update the training set with new batches.

### Key Challenges encountered:

### What happens if time points dont line up? 

It can be done. or a new batch, use the pls.predict to get y_pred, even if we have timestamps logged for the samples (these are mismatched like i m entioned). then we take that y_pred (which is a measure of maturity), and we do the same workflow for getting scores and plotting scores, but use the y_pred to plot.

### prediction with incomplete batches? Early predictions? yes!  
he rearranged score vectors derived from the Level 1 model are accumulated only up to the current time j. This partial trace forms the XT portion of the predictor matrix for the new batch. Since the batch is incomplete, the score vector (XT row vector) contains only the scores corresponding to time points 1 through j (i.e., A×j scores). The remaining columns are missing.

### Why is there 3 SD chosen as intervals?
but 3 SD bounds are used in BEM because they define the boundary of the "normal pattern of evolution" with a high degree of certainty, ensuring that batches flagged outside this limit are strong candidates for being classified as "definite deviators

### When is this NOT applicable?
good at handling continuous, numerical data such as pr 
ategorical variables must be transformed into a numerical representation, typically through dummy variables or one-hot encoding
x

## Ending Thoughts (What did we accomplish)?

We learned how to use multivariate analysis to monitor batches in summarized way (latent variables). Good for high dimensional data!
We learned how to use build a model based off a training set, then apply new batches to evaluate their health.
We did using Python, sklearn, numpy, open source tools.

You can how see how useful this is for something with aLOT of signals.
