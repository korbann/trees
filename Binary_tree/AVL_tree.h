#ifndef AVL_TREE_H
#define AVL_TREE_H

#include <stdbool.h>

typedef struct AVL_node AVL_node_t;

typedef struct AVL_node
{
    int data;
    int height;
    AVL_node_t *left;
    AVL_node_t *right;
} AVL_node_t;

AVL_node_t *root;

AVL_node_t* AVL_Add(int value);
int AVL_Find(int value);
bool AVL_Remove(int value);


#endif //AVL_TREE_H