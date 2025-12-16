#include <cstring>
#include <iostream>
using namespace std;
struct Node
{
    char ch;
    Node *left;
    Node *right;
};

class Tree
{
    Node *root;

public:
    Tree()
    {
        root = NULL;
    }

    void insertNode(char ch)
    {
        Node *newNode = new Node;

        newNode->ch = ch;
        newNode->left = NULL;
        newNode->right = NULL;

        if (root == NULL)
        {
            root = newNode;
            return;
        }

        Node *current = root;
        Node *parent = NULL;

        while (current != NULL)
        {
            parent = current;

            if (ch < current->ch)
                current = current->left;
            else
                current = current->right;
        }

        if (ch < parent->ch)
            parent->left = newNode;
        else
            parent->right = newNode;
    }

    void inOrder(Node *current)
    {

        if (current != NULL)
        {
            inOrder(current->left);
            cout << current->ch << " ";
            inOrder(current->right);
        }
    }

    void preOrder(Node *current)
    {
        if (current != NULL)
        {
            cout << current->ch << " ";
            preOrder(current->left);
            preOrder(current->right);
        }
    }
    void postOrder(Node *current)
    {
        if (current != NULL)
        {
            postOrder(current->left);
            postOrder(current->right);
            cout << current->ch << " ";
        }
    }

    Node *getRoot()
    {
        return root;
    }
};

int main()
{
    Tree tree;

    tree.insertNode('f');
    tree.insertNode('a');
    tree.insertNode('e');
    tree.insertNode('k');
    tree.insertNode('c');
    tree.insertNode('d');
    tree.insertNode('h');
    tree.insertNode('g');
    tree.insertNode('b');

    tree.inOrder(tree.getRoot());
    cout << endl;
    tree.preOrder(tree.getRoot());
    cout << endl;
    tree.postOrder(tree.getRoot());
}
