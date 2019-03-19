
# -*- coding: utf-8 -*-
"""
Created on Sat Mar  17 03:01:27 2019
@author: Ishwor Bhusal
Purpose : Assignment 2 for Machine Learning in Python
University : Hult International Business School, San Francisco, California, United States
Degree : Masters of Science in Business Analytics (Dual Degree)
Professor in-charge : Chase Kusterer

Topic : Final and Best Model Prediction
"""

#Importing required packages
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split # train/test split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import cross_val_score
from sklearn.metrics import confusion_matrix
from sklearn import metrics
from sklearn.metrics import roc_auc_score


#importing data file into terminal with the dataframe name "char_pred"
char_pred = pd.read_excel("GOT_character_predictions.xlsx")



#Exploring the Dataset one by one
char_pred.info() #Brief information about the dataset with rows, columns and null values
char_pred.head() #Looking out first five rows of the dataset
char_pred.columns #Printing out just column names of the dataset
char_pred.describe() #Analyzing Count, Mean, Std, min, first quartile, mean, third Quartile and max values of each columns
char_pred.shape #Looking for rows and column counts of the dataset



#Missing value research                 
print(
      char_pred.columns
      .isnull()
      .sum()
      )


#Flagging missing values and creating seperate column with missing value impute
for col in char_pred:

    """ Create columns that are 0s if a value was not missing and 1 if
    a value is missing. """
    
    if char_pred[col].isnull().any():
        char_pred['m_'+col] = char_pred[col].isnull().astype(int)



#Correlation Analysis
df_corr = char_pred.corr().round(2)

print(df_corr)

df_corr.loc['isAlive'].sort_values(ascending = False)



###############################################################################
            #Filling out dummies in each of the variables
###############################################################################


#Filling out na and dummies for culture
char_pred['culture'] = char_pred['culture'].fillna('unknown')

culture_dummies = pd.get_dummies((char_pred['culture']), 
                                 drop_first=True)


#Filling na and dummies for house
char_pred['house'] = char_pred['house'].fillna('unknown')

house_dummies = pd.get_dummies((char_pred['house']), 
                               drop_first=True)


#Filling na and dummies for mother
char_pred['mother'] = char_pred['mother'].fillna('unknown')

mother_dummies = pd.get_dummies((char_pred['mother']), 
                                drop_first=True)


#Filling na and dummies for father
char_pred['father'] = char_pred['father'].fillna('unknown')

father_dummies = pd.get_dummies((char_pred['father']), 
                                drop_first=True)


#Filling na and dummies for heir

char_pred['heir'] = char_pred['heir'].fillna('unknown')

heir_dummies = pd.get_dummies((char_pred['heir']), 
                              drop_first=True)



#Filling na and dummies for spouse
char_pred['spouse'] = char_pred['spouse'].fillna('unknown')

spouse_dummies = pd.get_dummies((char_pred['spouse']), 
                                drop_first=True)


#Time to work for age
char_pred['age'][char_pred['age'] < 0] = 0

char_pred['age'] = char_pred['age'].fillna(pd.np.mean(char_pred['age']))



#Working on Date of Birth
char_pred['dateOfBirth'][char_pred['dateOfBirth'] < 0] = 0

char_pred['dateOfBirth'] = char_pred['dateOfBirth'].fillna(pd.np.mean(char_pred['dateOfBirth']))



#Now Checking if there is missing values
print(
      char_pred.columns
      .isnull()
      .any()
      )


###############################################################################
#                         Train Test Split : Building Base Model
###############################################################################


# Preparing our model for train test split
char_pred_data_1   = char_pred.loc[:,['male',
                                    'book1_A_Game_Of_Thrones',
                                    'book2_A_Clash_Of_Kings',
                                    'book3_A_Storm_Of_Swords',
                                    'book4_A_Feast_For_Crows',
                                    'book5_A_Dance_with_Dragons',
                                    'isMarried',
                                    'isNoble',
                                    'numDeadRelations',
                                    'popularity',
                                    'm_title',
                                    'm_culture',
                                    'm_dateOfBirth',
                                    'm_mother',
                                    'm_father',
                                    'm_heir',
                                    'm_spouse',
                                    'm_isAliveMother',
                                    'm_isAliveFather',
                                    'm_isAliveHeir',
                                    'm_isAliveSpouse',
                                    'm_age']]



#Concatenating the Dataset and Dummies to create the training set:
char_pred_data = pd.concat([char_pred_data_1.iloc[:,:],
                            house_dummies,
                            culture_dummies],
                            axis=1)


#target_variable
for col in char_pred:
    print(col)


#Setting up test (target) variable:    
char_pred_target = char_pred['isAlive']



###############################################################################
#                       Train/Test Split
###############################################################################

X_train, X_test, y_train, y_test = train_test_split(
        char_pred_data,
        char_pred_target,
        test_size=0.10,
        random_state=508,
        stratify=char_pred_target)




###############################################################################
###############################################################################
        # Developing a Classification Base with KNearestNeighbor
###############################################################################
###############################################################################
        

# Running the neighbor optimization code with a small adjustment for classification
training_accuracy = []
test_accuracy = []

neighbors_settings = range(1, 51)


for n_neighbors in neighbors_settings:
    # build the model
    clf = KNeighborsClassifier(n_neighbors = n_neighbors)
    clf.fit(X_train, 
            y_train.values.ravel())
    
    # record training set accuracy
    training_accuracy.append(clf.score(X_train, 
                                       y_train))
    
    # record generalization accuracy
    test_accuracy.append(clf.score(X_test, 
                                   y_test))




#Plotting the accuracy score    
fig, ax = plt.subplots(figsize=(12,9))
plt.plot(neighbors_settings, 
         training_accuracy, 
         label = "training accuracy")

plt.plot(neighbors_settings, 
         test_accuracy, 
         label = "test accuracy")

plt.ylabel("Accuracy")
plt.xlabel("n_neighbors")
plt.legend()
plt.show()



# exploring the highest test accuracy
print(test_accuracy)


# Printing highest test accuracy
print(test_accuracy.index(max(test_accuracy)) + 1)



# It looks like 4 neighbors is the most accurate
knn_clf = KNeighborsClassifier(n_neighbors = 4)


# Fitting the model based on the training data
knn_clf_fit = knn_clf.fit(X_train, 
                          y_train)



#try adding .values.ravel() to you code as in the code below
knn_clf_fit = knn_clf.fit(X_train, 
                          y_train.values.ravel())



# Let's compare the testing score to the training score.
print('Training Score', knn_clf_fit.score(X_train, 
                                          y_train).round(4))

print('Testing Score:', knn_clf_fit.score(X_test, 
                                          y_test).round(4))
#Training Score 0.8538
#Testing Score: 0.8103


# Generating Predictions based on the optimal KNN model
knn_clf_pred = knn_clf_fit.predict(X_test)

knn_clf_pred_probabilities = knn_clf_fit.predict_proba(X_test)

#Training Score 0.8538
#Testing Score 0.8103




###############################################################################
            # Cross Validation with k-folds for KNN (best score)
###############################################################################


# Cross Validating the knn model with three folds            
cv_knn_3 = cross_val_score(knn_clf,
                           char_pred_data,
                           char_pred_target,
                           cv = 3)


print(cv_knn_3)


print(pd.np.mean(cv_knn_3).round(3))

print('\nAverage: ',
      pd.np.mean(cv_knn_3).round(3),
      '\nMinimum: ',
      min(cv_knn_3).round(3),
      '\nMaximum: ',
      max(cv_knn_3).round(3))


#Average: 0.729
#Minimum:  0.682 
#Maximum:  0.763


#Creating a confusion matrix for KNN
print(confusion_matrix(y_true = y_test,
                       y_pred = knn_clf_pred))



#Providing label to the confusion matrix
labels = ['Dead', 
          'Alive']

cm = confusion_matrix(y_true = y_test,
                      y_pred = knn_clf_pred)



#Creating Heatmap
sns.heatmap(cm,
            annot = True,
            xticklabels = labels,
            yticklabels = labels,
            cmap = 'Blues')


plt.xlabel('Predicted')
plt.ylabel('Actual')
plt.title('Confusion matrix of the KNN classifier')
plt.show()



###############################################################################
#                               ROC Curve
###############################################################################


y_pred_proba = clf.predict_proba(X_test)[::,1]
fpr, tpr, _ = metrics.roc_curve(y_test,  y_pred_proba)
auc = metrics.roc_auc_score(y_test, y_pred_proba).round(3)
plt.plot(fpr,tpr,label="KNearestNeighbor, auc="+str(auc))
plt.legend(loc=4)
plt.show()

#AUC Score : 0.7704


#################################################################
#Now we will export the predictions to excel sheet for submission
#################################################################

ishwor_model_prediction = pd.DataFrame({'Actual' : y_test,
                                        'KNN_Predicted': knn_clf_pred})

ishwor_model_prediction.to_excel("Ishwor_Model_Prediction_KNN.xlsx")