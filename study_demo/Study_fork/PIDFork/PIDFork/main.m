//
//  main.m
//  PIDFork
//
//  Created by JianweiChen on 2020/4/6.
//  Copyright © 2020 inke. All rights reserved.
//

#import <Foundation/Foundation.h>
#include<unistd.h>
#include<sys/types.h>
#include<stdio.h>
#include<stdlib.h>
//int main(int argc, char ** argv )
//{
//  pid_t result = fork();
//  if(result < 0)
//  {
//        printf("Error \n");
//  }
//  else if(result == 0)
//  {
//        printf("From the son\n");
//  }
//  else
//  {
//        printf("From the father\n");
//  }
//}

int main(int argc, char ** argv )
{
         int i;
         for(i = 0;i < 2;i++)
         {
               fork();
            printf("%d PPID:%d PID:%d\n",i,getppid(),getpid());

         }
}

//int main(int argc, char ** argv )
//{
//         int i;
//         for(i = 0;i < 2;i++)
//         {
//               fork();
////               printf("%d PPID:%d PID:%d",i,getppid(),getpid());
////           printf("%d",i);
//         }
//}


