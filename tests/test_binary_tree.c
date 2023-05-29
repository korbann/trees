#include  <stdlib.h>
#include  <stdio.h>

#include "binary_tree.h"

int main(void)
{
    // Count of failed tests
    int rc = 0;

    rc+= run_binary_tree_tests();

    printf("======================================================\n");
    if ( rc != 0 )
    {
        printf("Total number of failed unit tests: %d\n", rc);
    }
    else
    {
        printf("All tests have been passed.\n");
    }
    printf("======================================================\n");

    /* Return count of failed tests */
    return rc;
}