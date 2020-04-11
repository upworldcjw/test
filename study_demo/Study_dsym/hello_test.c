/*
 *hello.c源码
*/
int call_count = 0;
 
int hello_init()
{
    call_count = 0;
    return 0;
}
int hello_call_count_add()
{
    return ++call_count;
}
int hello_handle()
{
    return hello_call_count_add();
}
void hello_exit()
{
    call_count = 0;
}
