#include<stdio.h>
#include<sys/mman.h>

/*void *create_shstk() {
  void *shstk = mmap(NULL, 0x1000, PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
  unsigned long addr = (unsigned long) shstk + 0x1000;
  asm volatile("csrw 0x11, %0\n":: "r"(addr));
  return shstk;
}*/

int main() {
  unsigned long long ssp;
  unsigned long long cur_ssp;
  unsigned long long swap_ssp;
  asm volatile("csrr %0, 0x11\n":"=r"(ssp):);
  printf("Hello ssp:0x%lx\n", ssp);
  asm volatile("sspush x1\n");
  asm volatile("sspopchk x1\n");
  printf("Check sspush/sspopchk with x1 success\n");
  asm volatile("li x5, 0x100\n");
  asm volatile("sspush x5\n");
  asm volatile("sspopchk x5\n");
  printf("Check sspush/sspopchk with x5 success\n");
  asm volatile("c.sspush x1\n");
  asm volatile("sspopchk x1\n");
  printf("Check c.sspush/sspopchk with x1 success\n");
  asm volatile("sspush x5\n");
  asm volatile("c.sspopchk x5\n");
  printf("Check sspush/c.sspopchk with x5 success\n");
  asm volatile("sspush x1\n");
  asm volatile("ssrdp %0\n":"=r"(cur_ssp):);
  printf("Current ssp from ssrdp 0x%lx\n", cur_ssp);

  asm volatile("li x5, 0x100\n");
  asm volatile("ssamoswap.d %0, x5, (%1)\n":"=r"(swap_ssp):"r"(cur_ssp));
  printf("Get value from swap 0x%lx\n", swap_ssp);
  return 0;
}
