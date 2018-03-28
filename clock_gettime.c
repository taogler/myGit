// 使用全部的POSIX函数
#ifndef _POSIX_C_SOURCE
#define _POSIX_C_SOURCE 201801L
#endif // _POSIX_C_SOURCE
#include <time.h> // 计时器
#include <stdlib.h>

// 计时器函数tic
void tic_(struct timespec** timer)
{
    timer[0] = (struct timespec*)malloc(sizeof(struct timespec));
    clock_gettime(CLOCK_THREAD_CPUTIME_ID, timer[0]);
}

// 计时器函数toc
void toc_(struct timespec** timer, double* sec)
{
    struct timespec now;
    clock_gettime(CLOCK_THREAD_CPUTIME_ID, &now);

    struct timespec cputime;

    // 借位
    if (now.tv_nsec < timer[0]->tv_nsec)
    {
        cputime.tv_sec  = now.tv_sec  - timer[0]->tv_sec  - 1;
        cputime.tv_nsec = now.tv_nsec - timer[0]->tv_nsec + 1e9;
    }
    else
    {
        cputime.tv_sec  = now.tv_sec  - timer[0]->tv_sec;
        cputime.tv_nsec = now.tv_nsec - timer[0]->tv_nsec;
    }

    free(timer[0]);

    sec[0] = cputime.tv_sec + cputime.tv_nsec/1e9;
}
