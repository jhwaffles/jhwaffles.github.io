---
layout: page
title: "Batch Evolution"
permalink: /posts/batch_evolution/
---

# Batch Evolution Modeling: Determining what's a good batch.

## Overview

In this post, I go over applications of batch evolution modeling for process monitoring. What is batch evolution modeling? It's a framework of methods that allow us to track processes holistically, and evaluate batches in progress. It incorporates concepts from data science/machine learning as well as statistical process control to solve problems. Although the context is in biomanufacturing and bioprocess engineering, the concepts can be applied to other fields (anomaly detection, manufacturing, any type of process monitoring.)

Let's say we have an established process that we are running periodically. With enough runs, we've established how runs are supposed to trend. How do evaluate whats 'normal' for the process? How do we tell if a batch in-progress is behaving 'normally'? If there is a deviation, do we have enough evidence to determine whether we 'scrap' the batch, saving time and costs? We can answer all of these with batch evolution modeling! Existing software (SIMCA) lets you do this, but I will show that it's possible to do it in Python!

Data and code as well as reference literatures can be found on Github.

## Introduction

We work with a synthetic dataset of 17 runs, based off real world bioprocesses where we are making some kind of product, such as antibody, in a bioreactor. Along the way, samples are taken and measured for the product (titer, mg/mL), as well as metabolites (acetate, glucose, ammonia, phosphate, pyruvate).

Data in bioprocesses are generally very high dimensional. In this example, we monitor 5 metbolites, but there can be many more measurements through sensor data such as dO%, pH.
[image]

The first step is to do exploratory data analysis.

[image]

While its important to view the trends, we can use batch evolution modeling is useful for looking at holistically. In these types of scenarios, we are workign with high dimensinoal data (Lots of features vs observations), where features are heavily correlated with each other. Batch evolution modeling allows us to compress the data so we can easily track the most important components by utilizing Partial Least Squares (PLS). Furthermore it is interpretable in that we can pull out the most important contributors to a 'bad' or 'deviated' batch. How is this done?

## Step 1 - Data cleaning and Build PLS Model on 'good' batches

Data must be prepared. We gather all historical 'good' batches.

Get data into matrix in the form of

Center and scale. This is important because \_\_.

[code]

Define Y. It's a measure of a process maturity. in this instance its time.

Build PLS Model.

Get Scores.

[DataFrame]

### What is PLS?

USed in chemometrics, and similar industries.
Like PCA, it uses principal components  
Where scores and loadings are determined. Loadings are the principal compeonets, or vectors, that maximize the variance in the data set. Scores are the coefficient. These two can be used to get a reconstructed X.
Unlike PCA, it is predicting on y.
To determine the number of components to use, we can use an elbow plot.

## Step 2 - Plot

Rearrange the matrix. To
Calculate metrics.
[dataframe]

Plots.

## Step 3 - Entering new data.

Predict titer. DmodX, T2. out of scope for this post.

Monitor incoming batches, determine if things are deviating!

### Key Challenges encountered:

### What happens if time points dont line up? It can be done due the nature of solvin for y time first (Not shown here explicitly)

### prediction with incomplete batches? Early predictions? yes!

### Why is there 3 SD chosen as intervals?

### When is this NOT good?

x

## Ending Thoughts (What did we accomplish)?

We learned how to use multivariate analysis to monitor batches in summarized way (latent variables). Good for high dimensional data!
We learned how to use build a model based off a training set, then apply new batches to evaluate their health.
We did using Python, sklearn, numpy, open source tools.

You can how see how useful this is for something with aLOT of signals.
