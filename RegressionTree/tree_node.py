class RegressTreeNode:
    def __init__(self, features, predicts, avail_feature_index = None):
        self.features_mat = features
        self.y = predicts
        self.avail_feature_index = [i for i in range(0, self.features_mat.shape[1])] if avail_feature_index is None else avail_feature_index
        self.left_child = None
        self.right_child = None

# if __name__ == '__main__':