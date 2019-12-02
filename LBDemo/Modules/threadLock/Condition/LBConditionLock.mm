//
//  LBConditionLock.m
//  LBDemo
//
//  Created by 李兵 on 2019/12/2.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBConditionLock.h"

#include <stdlib.h>
#include <vector>
#include <queue>
#include <unistd.h>
#include <pthread.h>

pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

int num = 0;
int MAX_BUF = 100;


void *producer (void *) {
    while (true) {
        pthread_mutex_lock(&mutex);
        if (num >= MAX_BUF) {
            // 等待
            pthread_cond_wait(&cond, &mutex);
            printf("缓存区满了，等待消费者消费\n");
        }
        num += 1;
        printf("生产一个产品，当前数量%d\n",num);
        sleep(3);
        pthread_cond_signal(&cond);
        printf("通知消费者\n");
        pthread_mutex_unlock(&mutex);
        sleep(1);
    }
}

void *consumer(void *) {
    while (true) {
        pthread_mutex_lock(&mutex);
        if (num <= 0) {
            //等待
            pthread_cond_wait(&cond, &mutex);
            printf("缓冲区空了，等待生产者生产\n");
        }
        num -= 1;
        printf("消费一个产品，当前数量：%d\n",num);
        sleep(1);
        pthread_cond_signal(&cond);
        printf("通知生产者消费者\n");
        pthread_mutex_unlock(&mutex);
    }
}

int main1() {
    pthread_t thread1,thread2;
    
    
    pthread_create(&thread1, NULL, &consumer, NULL);
    pthread_create(&thread2, NULL, &producer, NULL);
    
    pthread_join(thread1,NULL);
    pthread_join(thread2, NULL);
    
    return 0;
    
}

@implementation LBConditionLock



- (void)begin {
    main1();
}


@end
