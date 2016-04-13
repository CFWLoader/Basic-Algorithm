/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */
class Solution {
public:
    vector<int> inorderTraversal(TreeNode* root) {
        
        vector<int> resultSet;
        
        if(root == NULL)
        {
            return resultSet;
        }
        
        stack<TreeNode*> treeStack;
        
        treeStack.push(root);
        
        TreeNode* ptr = NULL;
        
        while(!treeStack.empty())
        {
            if(treeStack.top().left != NULL)
            {
                treeStack.push(treeStack.top().left);
            }
            else
            {
                ptr = treeStack.top();
                treeStack.pop();
                
                resultSet.push_back(ptr->val);
                
                if(resultSet->right != NULL)
                {
                    treeStack.push(resultSet->right);
                }
            }
        }
        
        return resultSet;
    }
};