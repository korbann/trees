#include <string.h>
#include <stdio.h>











/* Test suit */
void testBT(void** state)
{
    
}

//-------------------------------------------------------------
static const struct CMUnitTest binary_tree_tests[] =
{
    cmocka_unit_test(testBT),
};

// static int setup(void **state)
// {
//     return 0;
// }

// static int teardown(void** state)
// {
//     return 0;
// }

int run_binary_tree_tests(void)
{
    return cmocka_run_group_tests(binary_tree_tests, NULL, NULL);
}

