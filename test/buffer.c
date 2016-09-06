/* compile with
   cc -std=c11 -pthread main.c
   */

#include <stdio.h>
#include <stdatomic.h>
#include <pthread.h>
#include <stdlib.h>

int BUF_SIZE = 5;

char* ring_buffer;
char* _Atomic read_ptr;
char* write_ptr;

void init_ring_buffer() {

  ring_buffer = malloc(BUF_SIZE);
  read_ptr = ring_buffer;
  /* Don't log, doesn't count as write obiously */
  write_ptr = ring_buffer;

}

char* buffer_next(char* ptr) {
  //assert ring_buffer <= ptr < ring_buffer + BUF_SIZE
  return (char*) ring_buffer + (((ptr - ring_buffer) + 1) % BUF_SIZE);
}


void process(char* data){
  /* Log function call*/
  struct timespec ts;
  ts.tv_sec = 0;
  ts.tv_nsec = 1000000;
  nanosleep(&ts, NULL); //produces warning
  //thrd_sleep(&(struct timespec){.tv_usec=1}, NULL); // sleep 1 usec
}

void producer_main() {

  char* next_write_ptr;

  // reads one byte and writes it to the location of write_ptr
  while (!feof(stdin)){
    next_write_ptr = buffer_next(write_ptr);
    if (next_write_ptr != read_ptr) {
      *write_ptr = getc(stdin);
      // Log variable change
      write_ptr = next_write_ptr;

      struct timespec ts;
      ts.tv_sec = 0;
      ts.tv_nsec = 100000000ULL * rand() / RAND_MAX ;
      nanosleep(&ts, NULL); // should generate better traces
    }
  }
}

void* consumer_main(void* thread_id) {
  //int tid = *(int*) thread_id;
  int tid = (int) thread_id; //assume id is transfered directly
  char* current_rptr;
  char* current_wptr;
  char data = 0;
  char* next_read_ptr;
  char* local_read_ptr;

  while (1) {
    local_read_ptr = read_ptr;

    if (local_read_ptr != write_ptr) {
      data = *local_read_ptr;
      next_read_ptr = buffer_next(local_read_ptr);
      if (atomic_compare_exchange_weak(&read_ptr, &local_read_ptr, next_read_ptr)) {
        //process data
        process(&data);
        /* printf("Process %d processed data: %d\n", tid, data); */
      }
      struct timespec ts;
      ts.tv_sec = 0;
      ts.tv_nsec = 100000000ULL * rand() / RAND_MAX ;
      nanosleep(&ts, NULL); // shpuld generate better traces
    }
  }
}


void create_consumers(int num_consumers) {

  pthread_t threads[num_consumers]; //should be made static for future access
  int thread_ids[num_consumers]; //should be made static for future access
  int thread;
  for(int t = 0; t < num_consumers; t++){
    /* printf("Creating consumer %d\n", t); */
    thread_ids[t] = t;
    //rc = pthread_create(&threads[t], NULL, consumer_main, &thread_ids[t]);
    thread = pthread_create(&threads[t], NULL, consumer_main, (void* ) t); //transfer value directly
    if (thread){
      /* printf("ERROR; return code from pthread_create() is %d\n", rc); */
      pthread_exit(NULL);
    }
  }
}

int main() {

  /* printf("Initialising ring buffer.\n"); */
  init_ring_buffer();

  /* printf("Instantiating consumer threads.\n"); */
  create_consumers(2);

  /* printf("Starting production.\n"); */
  producer_main();

  return 0;
}



