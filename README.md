Sleep and Visuospatial Attention — Behavioral Data Analysis (MATLAB)

Project Overview

This project was developed for a Research Design course and investigates the effect of sleep on visuospatial attention. The analysis was conducted using MATLAB to process behavioral data, perform statistical analyses, and generate visualizations.

The study examines how sleep duration, age, and IQ influence performance in a visual target detection task, and compares healthy participants with individuals with insomnia.

⸻

Experimental Design

Participants performed a visual search task where they detected a triangle target among circle distractors.

Task Conditions
	•	10 distractors
	•	15 distractors
	•	20 distractors

Each participant completed:
	•	40 trials per condition
	•	120 trials total

Participants responded:
	•	Button 1 → Target present
	•	Button 2 → Target absent

Measured variables:
	•	Reaction Time (RT)
	•	Accuracy

⸻

Dataset

Control Group
	•	35 healthy participants
	•	Folder: targetDetect_controls

Insomnia Group
	•	28 participants with sleep disorder
	•	Folder: targetDetect_insomnia

Subject Information

Additional subject-level variables:
	•	Age
	•	IQ
	•	Average sleep duration

File:
	•	subjInfo.csv

⸻

Analysis Goals

1. Behavioral Analysis (Controls)
	•	Compute mean accuracy per condition
	•	Compute mean RT (correct responses only)
	•	Test effect of distractor number on:
	•	Accuracy
	•	Reaction Time
	•	Statistical methods:
	•	Repeated-measures ANOVA
	•	Post-hoc comparisons

⸻

2. Correlation Analysis

Investigate whether individual factors influence distractor effect:

Distractor effect defined as:

RT (20 distractors) − RT (10 distractors)

Test correlations with:
	•	Sleep duration
	•	Age
	•	IQ

Additional analyses:
	•	Multiple regression
	•	Independence of predictors

⸻

3. Group Comparison (Controls vs Insomnia)

Compare:
	•	Reaction times
	•	Accuracy

Across:
	•	10 distractors
	•	15 distractors
	•	20 distractors

Goal:
	•	Identify whether insomnia affects visual detection
	•	Determine at which difficulty level differences emerge

⸻

Methods

Analysis performed in MATLAB:
	•	Data aggregation
	•	Reaction time filtering (correct trials only)
	•	Statistical tests
	•	Correlation analysis
	•	Visualization

Visualizations
	•	Bar plots
	•	Scatter plots
	•	Error bars
	•	Group comparison plots

⸻

Results Summary

Key questions addressed:
	•	Does sleep influence visuospatial attention?
	•	Do age or IQ affect performance?
	•	Are insomnia participants slower or less accurate?
	•	Does task difficulty amplify group differences?

⸻

Files Included
	•	MATLAB scripts for analysis
	•	Behavioral data processing code
	•	Statistical analysis scripts
	•	Figures generated from analysis
	•	Final report (1–2 pages)

⸻

Skills Demonstrated
	•	MATLAB data analysis
	•	Behavioral experiment analysis
	•	Statistical testing
	•	Correlation and regression analysis
	•	Data visualization
	•	Research design interpretation

⸻

Course Context

This project was completed independently as part of a Research Design course assignment. The goal was to apply statistical and analytical methods to real behavioral data and interpret findings within a cognitive neuroscience framework.
