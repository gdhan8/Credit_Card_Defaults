# Credit_Card_Defaults

### Background
The project within this repo is from a group project, completed as a part of a Master of Science in Data Science. The project used R and .Rmd and multiple key data science packages useful for analysis, visualization, wrangling, modeling, and statistical analysis. The project insights are communicated through a report and a brief presentation. A report was also generated using R Markdown. 

### Data
We chose to analyze a dataset “Default of Credit Card Clients Dataset”1 from Kaggle.com which contains data related to credit card statements from clients in Taiwan during certain months in 2005. The referenced origin is the Machine Learning repository. The publicly available dataset includes payment and demographic data of credit card holders from an unspecified Taiwanese bank. The raw dataset included 30,000 observations on 24 variables. We will consider The Machine Learning Repository references the first use of the data set by Yeh, I. C., & Lien, C. H. (2009) in comparing techniques for predicting the probability of default of credit card clients. 

### Significance
Credit card defaults can have a significant impact on a lender's financial performance. When a credit card borrower defaults on their payments, the lender may not be able to recover the full amount owed, which can result in a loss. By predicting credit card defaults, lenders can take proactive measures to minimize their risk and potentially avoid losses.

Predicting credit card defaults can help lenders identify customers who may be at higher risk of defaulting, so they can take steps to mitigate that risk. For example, a lender may offer a customer with a high risk of defaulting a lower credit limit, a higher interest rate, or other risk-mitigating measures to reduce the likelihood of default. Additionally, predicting credit card defaults can help lenders improve their credit risk management practices overall. By identifying patterns and trends in credit card default data, lenders can refine their underwriting and lending practices to better assess and manage risk.

### Application and Results 
We predicted credit card default through the use of logistic through meta-analysis of numerous models combined various modeling tuning techniques, resulting in a model selection that we deemed to be acceptable. Our techniques and models provided flexibility to select a final useful in the prediction of the probability of default given specific business decision and costs. Any one of the models we produced can be used to predict the probability of default to varying degrees of accuracy and with tradeoffs in classification error. By creating a variety of models and recording their perfomance in detail across several engineered features, sampling techniques, prediction thresholds, and model formulas, we provide a framework for detailed costs associated with false positives and false negatives to be applied for final model selection. We recommend a model based on ROC, AUC, and relative performance at a particular threshold. 

