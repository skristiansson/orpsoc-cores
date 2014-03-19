#ifndef __VERILATOR_TB_UTILS_H__
#define __VERILATOR_TB_UTILS_H__

#include <verilated.h>
#include <verilated_vcd_c.h>

class VerilatorTbUtils {
  private:
  unsigned long t;

  unsigned long timeout;

  bool vcdDump;
  unsigned long vcdDumpStart;
  unsigned long vcdDumpStop;
  char *vcdFileName;
  bool vcdDumping;

  char *elfFileName;
  char *binFileName;

  bool rspServerEnable;
  int rspServerPort;

  uint32_t *mem;

  void parseArgs(int argc, char **argv);
  bool loadElf();
  bool loadBin();

  public:
  VerilatorTbUtils(int argc, char **argv, uint32_t *mem);
  ~VerilatorTbUtils();

  VerilatedVcdC* tfp;

  bool doCycle();

  unsigned long getTime() { return t; }

  unsigned long getTimeout() { return timeout; }
  bool getVcdDump() { return vcdDump; }
  unsigned long getVcdDumpStart() { return vcdDumpStart; }
  unsigned long getVcdDumpStop() { return vcdDumpStop; }
  char *getVcdFileName() { return vcdFileName; }

  char *getElfFileName() { return elfFileName; }
  char *getBinFileName() { return binFileName; }

  bool getRspServerEnable() { return rspServerEnable; }
  int getRspServerPort() { return rspServerPort; }
};

#endif
