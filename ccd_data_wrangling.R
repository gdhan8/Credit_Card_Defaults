
ccd <- CreditCardDefault <- read.csv("~/Downloads/CreditCardDefault.csv")

#subset data to only the well defined dataset
#The original dataset contained information outside of the defined descriptions provided by the source. To handle these, we've narrowed those variables to content and observations that we understand.
ccd<- subset(ccd, (ccd$EDUCATION %in% c(1, 2, 3, 4)))
ccd<- subset(ccd, (ccd$MARRIAGE %in% c(1, 2)))

#Setting categorical variables as factors
#The original dataset was nearly entirely integers. Some categorical factors were converted to factor data type to enable use with R data visualizations and built in linear modeling tools. 
ccd$DEFAULT <- as.factor(ccd$default.payment.next.month)
ccd$SEX <- as.factor(ccd$SEX)
ccd$EDUCATION <- as.factor(ccd$EDUCATION)
ccd$MARRIAGE <- as.factor(ccd$MARRIAGE)

#handle level naming conventions
#To reduce confusion in visualization or reporting and interpretation the levels for the converted factors were renamed
levels(ccd$DEFAULT) <- c("No Default Next Month", "Defaults Next Month")
levels(ccd$SEX) <- c("Male", "Female")
levels(ccd$MARRIAGE) <- c('Married','Single')
levels(ccd$EDUCATION) <- c('Graduate School', 'University','High School', 'Other')

#Feature Generation
#These three features were created after some initial modeling with the belief that inclusion of these three variables may improve the model in some capacity. We speculate that including information about credit user average long run behavior over the five months preceding may reveal useful information in understanding they future bill amounts and accordingly their predicted probability of defaulting in the next month. 

#credit utilization, numerical variable with the average bill amount divided by the limit balance per user
ccd$AVG_UTILIZATION_RATE =(ccd$BILL_AMT2+ccd$BILL_AMT3+ccd$BILL_AMT4+ccd$BILL_AMT5+ccd$BILL_AMT6)/5/ccd$LIMIT_BAL

#Create a logical binary variable for if the average monthly excess balance over the past five months was greater than the limit balance. 
ccd$OVERSPENDER<-as.factor((ccd$BILL_AMT2+ccd$BILL_AMT3+ccd$BILL_AMT4+ccd$BILL_AMT5+ccd$BILL_AMT6)/5 > ccd$LIMIT_BAL)

#Create a numerical variable which captures how much excess balance over the past three months is being carried. The idea here is that users who make payments greater than their statement balance will have a negative excess balance average over three months. Those who are having trouble paying or are carrying revolving credit will 
ccd$TOTAL_EXCESS_BALANCE<-(((ccd$BILL_AMT2-ccd$PAY_AMT2+ccd$BILL_AMT3-ccd$PAY_AMT3+ccd$BILL_AMT4-ccd$PAY_AMT4+ccd$BILL_AMT5-ccd$PAY_AMT5+ccd$BILL_AMT6-ccd$PAY_AMT6)/5)-ccd$LIMIT_BAL)

#For whatever the reason the dataset is unevenly split with different shares of males and females. We do not attempt to speculate why, but simply split the population by gender and resample to head off potential unobserved built in bias.
#handle uneven Male and female data set, split sample by Male and Female and sample from each
ccd_male<- subset(ccd, (ccd$SEX == 'Male'))
ccd_female<- subset(ccd, (ccd$SEX == 'Female'))

#this way everyone gets the same output
set.seed((1234))

#sample for even 50/50 split between males and females, size is determined by the smallest available subset, in this case males with 11616 observations
ccd_male_sample <- sample_n(ccd_male, min(nrow(ccd_male), nrow(ccd_female)))
ccd_female_sample <- sample_n(ccd_female, min(nrow(ccd_male), nrow(ccd_female)))
ccd <- data.frame(rbind(ccd_male_sample,ccd_female_sample))

#handle NANs by only selecting complete observations
ccd<-ccd[complete.cases(ccd),]

#Workspace cleanup
rm(CreditCardDefault)
rm(ccd_female)
rm(ccd_male)
rm(ccd_female_sample)
rm(ccd_male_sample)

#narrow our working dataset to features we will specifically use here
#drop PAY_0, we would not have this information yet
#drop BILL_AMT1, we are modeling this,...but retain for model accuracy checks
#drop PAY_AMT1, we would not have this information yet...but retain for inclusion into logistic Regression.
ccd <- ccd %>% dplyr::select(c(-PAY_0))

#Because we are working with a relatively large dataset,  we choose to split the training and test data 50/50.
set.seed((1234))
#Split Data into train and test, ccd will remain train,  ccd.test will be test data
Split_Data = sample(c(rep(0, 0.5 * nrow(ccd)), rep(1, 0.5 * nrow(ccd))))
ccd.train<- ccd[Split_Data==0,]
ccd.test<- ccd[Split_Data==1,]

write.csv(ccd, "ccd.csv", row.names = FALSE)
write.csv(ccd.train,"ccd.train.csv", row.names = FALSE)
write.csv(ccd.test,"ccd.test.csv", row.names = FALSE)

