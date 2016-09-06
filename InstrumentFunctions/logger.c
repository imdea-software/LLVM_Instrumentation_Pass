/* compile with
   cc -std=c11 -pthread main.c
   */
#include <stdlib.h>
#include <sys/time.h>
#include "zlog.h"

zlog_category_t *variable_values_cat;
zlog_category_t *function_calls_cat;

int initialized = 0;

int init() {
    int rc = zlog_init("zlog.conf");
    if (rc) {
        printf("init failed\n");
        return -1;
    }

    variable_values_cat = zlog_get_category("variable_values_cat");
    if (!variable_values_cat) {
        printf("get cat fail\n");
        zlog_fini();
        return -2;
    }

    function_calls_cat = zlog_get_category("function_calls_cat");
    if (!function_calls_cat) {
        printf("get cat fail\n");
        zlog_fini();
        return -2;
    }
    initialized = 1;
    return 0;
}

void log_variable_change(const char* variable, int value) {
    initialized || init();

    zlog_info(variable_values_cat, "%s %d", variable, value);
}

void log_function_call(const char* function) {
    initialized || init();

    zlog_info(function_calls_cat, "%s", function);
}
