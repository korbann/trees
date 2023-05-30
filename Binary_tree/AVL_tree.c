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
    AVL_node_t* newNode = (AVL_node_t*)malloc(sizeof(AVL_node_t));
    newNode->data = value;
    newNode->height = 0;
    return newNode;
}


/*      3           2
*      /           / \
*     2     ->    1   3
*    /
*   1
*/
static void right_rotation(int new_value, AVL_node_t *nodeForRotation, AVL_node_t **parentsLink)
{
    if(NULL != parentsLink)
    {
        parentsLink = &(nodeForRotation->left);
    }
    nodeForRotation->left->right = nodeForRotation;
    nodeForRotation->left->left = new_node(new_value);
    
    nodeForRotation->left = NULL;
    nodeForRotation->right = NULL;

}

/*  1                   2
*    \                 / \
*     2     ->        1   3
*      \
*       3
*/
static void left_rotation()
{
    
}

/*   3            3         2
*   /            /         / \
*  1      ->    2     ->  1   3
*   \          /
*    2        1
*/
static void right_left_rotation()
{

}

/*   1         1            2
*     \         \          / \
*      3   ->    2    ->  1   3
*     /           \
*    2             3
*/
static void left_right_rotation()
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
