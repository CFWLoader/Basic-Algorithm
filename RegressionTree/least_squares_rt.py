from os import path
import pandas as pd
# from sklearn import tree

from tree_node import RegressTreeNode


class OLSRegressTree:
    def __init__(self, features, y):
        self.feat_mat = features
        self.y = y
        self.root = RegressTreeNode(self.feat_mat, self.y)

    def fit(self):
        pass


script_dir = path.dirname(path.realpath(__file__))

# Data set source: https://archive.ics.uci.edu/ml/datasets/Appliances+energy+prediction#
raw_df = pd.read_csv(path.join(script_dir, 'input', 'energydata_complete.csv'))

x_mat = raw_df.drop(['date', 'rv1', 'rv2', 'Appliances'], axis=1).values
y_val = raw_df[['Appliances']].values

# regr = tree.DecisionTreeRegressor(max_depth= 6)
# regr.fit(x_mat, y_val)

# dot_data = tree.export_graphviz(regr, out_file=path.join(script_dir, "regr_plt.dot"),
#                                 feature_names=None, class_names=None,
#                                 filled=True, rounded=True, special_characters=True)


# root = TreeNode(x_mat, y_val)

# print(root.avail_feature_index)
