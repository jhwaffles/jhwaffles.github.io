---
layout: page
title: "Evaluating Randomness"
permalink: /posts/random/
---

# Evaluating Randomness

How do we know if a random number generator (RNG) is 'good'? In this project we test a number of Unif(0,1) generators. We evaluate these RNG with formal statistical tests as well as visual checks. The RNGs we will explore include:

- Numpy BitGenerator (PCG64)
- RANDU
- Middle Squares
- Other (Atmospheric Noise)

## Background - Random Number Generators

### Numpy BitGenerator (PCG64)

This is the default RNG used in Python's numpy module. It is a PCG, which is short for permuted congruential generator. Developed in 2014 by Dr. M.E. O'Neill, it uses linear congruential generator as well as a permutation function to 'shuffle' and improve statistical properties. Why is it used in numpy? It is fast, less predictable (and more secure), and easy to use!

### Randu

Randu is a linear congruential pseudorandom number generator of the Park–Miller type, and was developed in the 1960s. As mentioned in the course, drawbacks of the generator include correlation between points. In fact, each point lies in one of a set of 15 parallel planes $$2^{31}$$ apart.

$$V_{j+1} = 65539\cdot V_j\, \bmod\, 2^{31}$$

$$X_j = \frac{V_{j}}{2^{31}}$$

### Middle Squares

The midsquares method was developed by Von Neumann in 1949. It is an arithmetic method that takes a seed number and generates the next number by taking the middle n digits of the seed number, and squaring it. In this example, we use n=4:

$$X_0 = 6100, X_0^2 = 37 \mathbf{2100} 00$$

$$X_1 = 2100, X_1^2 = 04 \mathbf{4100} 00$$

$$R_{i}=\frac{X_{i}}{1000}$$

### Atmospheric Noise/Other

Random numbers can come from all kinds of sources! Some have described using a lava lamp, using physical phenomena to generate numbers. Another source is from 'atmospheric noise', compiled from random.org.

## Background - Statistical Tests

The statistical tests we will use are:

- Chi Squared for goodness of fit (Uniforms)
- Means run test for independence
- Autocorrelation test for independence

### Chi-Squared Goodness of Fit Test

This basically compares if an observed data set aligns with an expected distribution (uniform in this case). Here we start with a hypothesis that the numbers are uniform. The test statistic is $$\chi_{0}^2$$ which is calculated by dividing the numbers into n bins and counting how many numbers fall into the individual bins and comparing these to the expected amount in each bin. The probability associated with a $$\chi_{0}^2$$ can be found in reference table with associated significance and degree of freedom inputs. From this we can determine if there is evidence that supports that the numbers are uniform.

$$H_0: R_{1},R_{2}...R_{n} \text{  Unif(0,1)}$$

$$\chi_{0}^{2} = \sum_{i=1}^{k}\frac{(O_{i}-E_{i})^2}{E_{i}}$$

$$\text{If  }\chi_{0}^{2}>\chi_{a,k-1}^{2} \text{  we reject  } H_0$$

$$\text{If  }\chi_{0}^{2}<=\chi_{a,k-1}^{2} \text{  we fail to reject  } H_0$$

### Runs Test Means

This test compares the number of runs against the number expected in independent series. Here, a run is single or consecutive values above the mean or below the mean before switching. For example if values above the mean are '+' and values below the means are '-', then a sequence of '-++--+++' would be broken down to '-','++','--','+++' (4 runs). We begin with a hypothesis that the sequence of numbers are independent. The test statistic is $$Z_0$$ which is calculated in the equations below. The probability associated with $$Z_0$$ is determined by the significance level and the normal distribution. From this we can determine if there is evidence that supports that the numbers are independent.

$$H_0: R_{1},R_{2}...R_{n} \text{  are independent.}$$

$$E[B]=\frac{2*n1n2}{2} + 0.5$$

$$Var[B]=\frac{2*n1n2(2*n1n2-n}{n^{2}(n-1)}$$

$$Z_0=\frac{B-E[B]}{\sqrt{Var(B)}}$$

$$\text{If  }|Z_0|>z_{a/2} \text{  we reject  } H_0$$

$$\text{If  }|Z_0|<=z_{a/2} \text{  we fail to reject  } H_0$$

### Autocorrelation

This test provides another way to determine **independence** by looking at correlation between consecutive numbers. Essentially it tests a sequence for correlation by comparing values against previous values (usually a determined lag) in the series.

$$H_0: R_{1},R_{2}...R_{n} \text{ are independent} $$

$$\rho=(\frac{12}{n-1}\sum_{k=1}^{n-1}R_{k}R_{1+k})-3$$

$$Z_0=\frac{\rho}{\sqrt{Var(\rho)}}$$

$$\text{If  }|Z_0|>z_{a/2} \text{ we reject  } H_0$$

$$\text{If  }|Z_0|<=z_{a/2} \text{ we fail to reject  } H_0$$

## Results

10000 Pseudo Random numbers (PRNs) were generated from each generator and run through the statistical tests. Significance level of a=0.05 was used for all relevant tests. A summary table of results can be seen below (**bold** means values were past threshold and null hypothesis is **rejected**.)

| Test            | Statistic | PCG64     | RANDU  | Mid Squares  | Atmospheric |
| --------------- | --------- | --------- | ------ | ------------ | ----------- |
| Chi Squared     | $$X_0^2$$ | 7.124     | 4.376  | **14855.42** | 8.294       |
| Means Run       | $$Z_0$$   | **2.291** | 1.19   | 0.21         | 0.594       |
| Autocorrelation | $$Z_0$$   | -0.824    | -0.614 | **3.364**    | 0.528       |

Unsurprisingly the mid squares generator did not pass the chi squared test for uniform fit, nor the autocorrelation test. Surprisingly the PCG generator from numpy did not pass the means run test for uniform fit. It also seems the PCG generator did worse on the chi squared test as the number of PRNs went up. Surprisingly, no tests were rejected for RANDU, which is infamous for NOT being a good generator.

### How about a visual check?

Bitmaps were generated for each generator. The 10000 random numbers were fit to a 100x100 grid, and mapped to black or white pixels depending on the PRN values.

<div class="image-grid">
  <figure>
    <img src="/images/PCG64bitmap.png" alt="PCG64 bitmap" width="250" />
    <figcaption>PCG64 bitmap</figcaption>
  </figure>
  <figure>
    <img src="/images/RANDUbitmap.png" alt="RANDU bitmap" width="250" />
    <figcaption>RANDU bitmap</figcaption>
  </figure>
  <figure>
    <img src="/images/MidSquaresbitmap.png" alt="MidSquares bitmap" width="250" />
    <figcaption>MidSquares bitmap</figcaption>
  </figure>
  <figure>
    <img src="/images/atmosphericbitmap.png" alt="Atmospheric bitmap" width="250" />
    <figcaption>Atmospheric bitmap</figcaption>
  </figure>
</div>

From this it is very apparent that the mid squares is a 'bad' generator. The numbers don't seem random at all! RANDU is infamous for forming hyperplanes in 3D plot. It didnt seem like those characteristics were captured in the 2D bitmaps.

It is apparent that there is no one size fits all test to determine if a random number generator (RNG) is 'good' or 'bad'. The most rigorous approach would be to run a battery of statistical tests on each generator. This is just a sample of some of the tests available - other relevant tests include a permutations test, reverse arrangements test, and ranking tests. In addition to statistical tests, visualization of the data can be a powerful tool to determine the quality of a RNG.
