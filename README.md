# Understanding Apartment Evaluation in Toronto: Age, Size, and Location Influenced Score with Property Standards

## Overview
This repository contains the analysis of building evaluation scores in Toronto, as reported under the RentSafeTO program. Using a Bayesian regression model, we examined the impact of building characteristics such as year built, number of units, and geographic location (ward) on compliance with property standards.

To use this folder, click the green "Code" button, then "Download ZIP". Move the downloaded folder to your desired location on your computer, and then modify it as needed.

## File Structure

The repo is structured as:
-   `data/raw_data` contains the raw RentSafeTO dataset as obtained from Open Data Toronto.
-   `data/analysis_data` contains the cleaned dataset prepared for analysis.
-   `model` contains fitted Bayesian models used in the analysis.
-   `other` contains notes on interactions with large language models (LLMs) and sketches.
-   `paper` includes the files used to generate the paper, such as the Quarto document, reference bibliography file, and the PDF of the final paper.
-   `scripts` contains R scripts for data cleaning, model building, and analysis.

## Statement on LLM usage

**Statement on LLM Usage: Aspects of the code and paper were written with the help of ChatGPT. The entire chat history is available in `others/llms/usage.txt`**