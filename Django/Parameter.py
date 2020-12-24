import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.neural_network import MLPClassifier
from sklearn.model_selection import GridSearchCV 

#Data
data = pd.read_excel('Final_Data.xlsx')
X_train, X_test, y_train, y_test = train_test_split(data[['People','Park','Popular','Road','River','Univ']], data[['Count']], test_size=0.3, random_state=50) 

 

#Parameter Select
mlp = MLPClassifier(max_iter=100)

parameter_space = {
    'hidden_layer_sizes': [(20, 10, 20),(10,10,20),(10,10,30),(20,5,5)],
    'activation': ['tanh', 'relu'],
    'solver': ['sgd', 'adam'],
    'alpha': [0.0001, 0.05],
    'learning_rate': ['constant','adaptive'],
}

clf = GridSearchCV(mlp, parameter_space, n_jobs=-1, cv=3)
clf.fit(X_train, y_train)

#Parameter Check
print('Best parameters found:\n', clf.best_params_)

#Model Accuracy Test
mlp = MLPClassifier(max_iter=3000, alpha= 0.0001, activation= 'relu', solver= 'adam', learning_rate= 'adaptive', hidden_layer_sizes= (10, 10, 30))
mlp.fit(X_train,y_train)

#X_train2, X_test2, y_train2, y_test2
print("훈련 세트 정확도: {:.3f}".format(mlp.score(X_train, y_train)))
print("테스트 세트 정확도: {:.3f}".format(mlp.score(X_test, y_test)))

#Model 저장
from sklearn.externals import joblib
file_name = 'model.pkl' 
joblib.dump(mlp, file_name) 