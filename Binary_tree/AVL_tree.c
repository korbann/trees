/* Sorted tree
* left child < node < right child
*
* Methods:
* add item
* remove item
* find item
* reoder traversal
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "AVL_tree.h"

static AVL_node_t* new_node(int value)
{
    AVL_node_t* newNode = (node_t*)malloc(sizeof(AVL_node_t));
    newNode->data = value;
    return newNode;
}

static void right_rotation()
{

}

static void left_rotation()
{
    
}

//-------------------------------------------------------------------------------
AVL_node_t* AVL_Add(int value)
{
    AVL_node_t *n = root;
    if(NULL == n)
    {
        return Node_New(value);
    }

    while(NULL != n)
    {
        if(value == n->data)                    // value ==
        {
            return n;
        }
        else if(value < n->data)                //value <
        {
            if(NULL == n->left)
            {
                return new_node(value);
            }
            n = n->left;
        }
        else                                    //value >
        {
            if(NULL == n->right)
            {
                return new_node(value);
            }
            n = n->right;
        }
    }

}

int AVL_Find(int value)
{

}

bool AVL_Remove(int value)
{

}
