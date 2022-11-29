import pandas as pd

def split_df(df_name):
    # Creating a dataframe
    df = pd.read_csv('dataset/'+df_name+'.data', sep=',', header=None)

    # Splitting the dataframe into train and test
    # with 80% and 20% values of original dataframe
    test_df = df.sample(frac=0.3, replace=False)
    train_df = df.drop(test_df.index)

    # Save the train-test splits
    with open('dataset/'+df_name+'_train.data', 'w') as f:
        f.write(train_df.to_csv(header=False, index=False))
    with open('dataset/'+df_name+'_test.data', 'w') as f:
        f.write(test_df.to_csv(header=False, index=False))


if __name__=='__main__':
    # Iris dataset
    split_df('iris')

    # Wine dataset
    split_df('wine')

    # Breast Cancer dataset
    split_df('cancer')

    # Glass dataset
    split_df('glass')

    # Dry Bean dataset
    split_df('drybean')
