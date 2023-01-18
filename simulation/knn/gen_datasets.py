import pandas as pd

def split_df(df_name):
    # Creating a dataframe
    df = pd.read_csv('dataset/'+df_name+'.data', sep=',', header=None)

    # Splitting the dataframe into train and test
    # with 70% and 30% values of original dataframe
    test_df = df.sample(frac=0.3, replace=False,
                        random_state=1 # Comment this for really random splits
                        )
    train_df = df.drop(test_df.index)

    # Save the train-test splits
    with open('dataset/'+df_name+'_train.data', 'w') as f:
        f.write(train_df.to_csv(header=False, index=False, float_format='%.6f'))
    with open('dataset/'+df_name+'_test.data', 'w') as f:
        f.write(test_df.to_csv(header=False, index=False, float_format='%.6f'))


if __name__=='__main__':
    # Cleaned/prepared data from UC Irvine Machine Learning Repository (https://archive.ics.uci.edu/ml/)

    # Iris dataset (https://archive.ics.uci.edu/ml/datasets/Iris)
    split_df('iris')

    # Wine dataset (https://archive.ics.uci.edu/ml/datasets/Wine)
    split_df('wine')

    # Breast Cancer dataset (https://archive.ics.uci.edu/ml/datasets/breast+cancer+wisconsin+(diagnostic))
    split_df('cancer')

    # Glass dataset (https://archive.ics.uci.edu/ml/datasets/glass+identification)
    split_df('glass')

    # Dry Bean dataset (https://archive.ics.uci.edu/ml/datasets/dry+bean+dataset)
    split_df('drybean')
    
    # Parkinsons dataset (https://archive.ics.uci.edu/ml/datasets/Parkinsons)
    split_df('parkinsons')
