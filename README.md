# Computational modeling tutorials for cognitive science

## Introduction and setup

This tutorial series is mostly written in R, with the exception of the DDM tutorial that's implemented in HDDM via Python.

For details on how to install software and download the tutorials, [click here](https://jaeyoungson.com/tutorials.html).

If you've already completed the `into-the-tidyverse` tutorial series for learning R/tidyverse, then this should already be familiar to you. It is assumed in this series that you have a working knowledge of R/tidyverse.


## File and folder structure

- Files in the parent folder: Whenever you want to engage with these tutorials, remember to first double-click on `cog-comp-modeling.Rproj` first. This opens up a new R session, so that work you're doing for this project doesn't disturb whatever work you might be doing for other R projects.

- `/tutorials`: This is where you can find the HTML files containing all tutorials. Each one features a self-contained lesson on a particular topic.

- `/data`: All relevant data will be provided here.

- `/code`: This is where you can save your code as you're following along with the tutorials.

- `/tutorial_code`: If you want to peek at the source code, you can find it here. ***Do not modify this code unless you want to deal with merge conflicts.***


## Session descriptions

### Session 1: Risk and ambiguity

1. Expected value.
2. Simulating risk and ambiguity preferences.
3. Using data to fit a model of risk/ambiguity preferences.

### Session 2: Reinforcement learning

1. Expected value, again. Simulating trial-and-error learning.
2. Using data to fit reinforcement learning models.
3. Successor representations.

### Session 3: Regression from scratch

1. Expected value, once more. Generalized linear models.
2. Useful applications of regression-adjacent modeling.

### Session 4: Drift diffusion modeling

This is the sole tutorial in this series that isn't written in R. It isn't *strictly* necessary for you to do this tutorial, but DDM is becoming more and more popular as a computational model of decision making... and it's a gentle introduction to the fact that computational modelers must become comfortable with tools built in many languages (R, Python, Matlab), and even statistical frameworks (maximum likelihood estimation vs Bayesian inference).

HDDM is a Python package that makes it ridiculously easy to fit DDM, and the syntax isn't too bad. In [this repository](https://github.com/psychNerdJae/hddm_tutorial), you can find a short video lecture, slides, Python/package installation notes, and a Python interactive notebook for learning HDDM.

### Session 5: Recap/review

Here, we'll remind ourselves of the core concepts we've learned, and introduce some power tools that will help make it easier for you to build your own computational models in the future.

## Useful resources
1. [Into the tidyverse](https://github.com/psychNerdJae/into-the-tidyverse)
    - An introduction to R and the tidyverse. An essential prerequisite for completing these tutorials.
2. [Learning stats backwards](https://github.com/psychNerdJae/learning-stats-backwards)
    - A bootcamp of sorts for learning about regression and the general linear model.
    - Mathematically, there isn't too much that's different between statistical models and cognitive computational models. Having knowledge of each will help improve your intuitions for both.
3. [HDDM tutorial](https://github.com/psychNerdJae/hddm_tutorial)
    - Learn what DDM is good for, and how to use hierarchical Bayesian parameter estimation to fit the DDM to data.
