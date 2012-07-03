#################################################################
# Makefile generated by Xilinx Platform Studio 
# Project:/afs/tu-chemnitz.de/home/urz/e/eriks/PRIVAT/HiWi_SSE/Masterarbeit/work/system.xmp
#
# WARNING : This file will be re-generated every time a command
# to run a make target is invoked. So, any changes made to this  
# file manually, will be lost when make is invoked next. 
#################################################################

XILINX_EDK_DIR = /sse/eda/xilinx-13.1/ISE_DS/EDK

SYSTEM = system

MHSFILE = system.mhs

FPGA_ARCH = spartan6

DEVICE = xc6slx16csg324-3

LANGUAGE = vhdl
GLOBAL_SEARCHPATHOPT = 
PROJECT_SEARCHPATHOPT =  -lp /afs/tu-chemnitz.de/home/urz/e/eriks/PRIVAT/HiWi_SSE/FPGA_Reconfiguration/Nexys3_BSB_Support_v_2_4/Nexys3_PLB_BSB_Support/lib/

SEARCHPATHOPT = $(PROJECT_SEARCHPATHOPT) $(GLOBAL_SEARCHPATHOPT)

SUBMODULE_OPT = 

PLATGEN_OPTIONS = -p $(DEVICE) -lang $(LANGUAGE) $(SEARCHPATHOPT) $(SUBMODULE_OPT) -msg __xps/ise/xmsgprops.lst

OBSERVE_PAR_OPTIONS = -error yes

MICROBLAZE_BOOTLOOP = $(XILINX_EDK_DIR)/sw/lib/microblaze/mb_bootloop.elf
MICROBLAZE_BOOTLOOP_LE = $(XILINX_EDK_DIR)/sw/lib/microblaze/mb_bootloop_le.elf
PPC405_BOOTLOOP = $(XILINX_EDK_DIR)/sw/lib/ppc405/ppc_bootloop.elf
PPC440_BOOTLOOP = $(XILINX_EDK_DIR)/sw/lib/ppc440/ppc440_bootloop.elf
BOOTLOOP_DIR = bootloops

MICROBLAZE_0_BOOTLOOP = $(BOOTLOOP_DIR)/microblaze_0.elf
MICROBLAZE_0_ELF_IMP = SDK/workspace/srec_bootloader_0/Debug/srec_bootloader_0.elf

BRAMINIT_ELF_IMP_FILES = $(MICROBLAZE_0_ELF_IMP)
BRAMINIT_ELF_IMP_FILE_ARGS = -pe microblaze_0 $(MICROBLAZE_0_ELF_IMP)

BRAMINIT_ELF_SIM_FILES = $(MICROBLAZE_0_BOOTLOOP)
BRAMINIT_ELF_SIM_FILE_ARGS = -pe microblaze_0 $(MICROBLAZE_0_BOOTLOOP)

SIM_CMD = xterm -e ./isim_system

BEHAVIORAL_SIM_SCRIPT = simulation/behavioral/$(SYSTEM)_setup.tcl

STRUCTURAL_SIM_SCRIPT = simulation/structural/$(SYSTEM)_setup.tcl

TIMING_SIM_SCRIPT = simulation/timing/$(SYSTEM)_setup.tcl

DEFAULT_SIM_SCRIPT = $(BEHAVIORAL_SIM_SCRIPT)

MIX_LANG_SIM_OPT = -mixed yes

SIMGEN_OPTIONS = -p $(DEVICE) -lang $(LANGUAGE) $(SEARCHPATHOPT) $(BRAMINIT_ELF_SIM_FILE_ARGS) $(MIX_LANG_SIM_OPT) -msg __xps/ise/xmsgprops.lst -s isim


CORE_STATE_DEVELOPMENT_FILES = 

WRAPPER_NGC_FILES = implementation/microblaze_0_wrapper.ngc \
implementation/mb_plb_wrapper.ngc \
implementation/ilmb_wrapper.ngc \
implementation/dlmb_wrapper.ngc \
implementation/dlmb_cntlr_wrapper.ngc \
implementation/ilmb_cntlr_wrapper.ngc \
implementation/lmb_bram_wrapper.ngc \
implementation/rs232_uart_1_wrapper.ngc \
implementation/leds_8bits_wrapper.ngc \
implementation/push_buttons_4bits_wrapper.ngc \
implementation/ethernet_lite_wrapper.ngc \
implementation/micron_ram_wrapper.ngc \
implementation/numonyx_pcm_wrapper.ngc \
implementation/digilent_quadspi_cntlr_wrapper.ngc \
implementation/digilent_sevseg_disp_wrapper.ngc \
implementation/mem_bus_mux_0_wrapper.ngc \
implementation/clock_generator_0_wrapper.ngc \
implementation/mdm_0_wrapper.ngc \
implementation/proc_sys_reset_0_wrapper.ngc \
implementation/xps_intc_0_wrapper.ngc \
implementation/xps_timer_0_wrapper.ngc

POSTSYN_NETLIST = implementation/$(SYSTEM).ngc

SYSTEM_BIT = implementation/$(SYSTEM).bit

DOWNLOAD_BIT = implementation/download.bit

SYSTEM_ACE = implementation/$(SYSTEM).ace

UCF_FILE = data/system.ucf

BMM_FILE = implementation/$(SYSTEM).bmm

BITGEN_UT_FILE = etc/bitgen.ut

XFLOW_OPT_FILE = etc/fast_runtime.opt
XFLOW_DEPENDENCY = __xps/xpsxflow.opt $(XFLOW_OPT_FILE)

XPLORER_DEPENDENCY = __xps/xplorer.opt
XPLORER_OPTIONS = -p $(DEVICE) -uc $(SYSTEM).ucf -bm $(SYSTEM).bmm -max_runs 7

FPGA_IMP_DEPENDENCY = $(BMM_FILE) $(POSTSYN_NETLIST) $(UCF_FILE) $(XFLOW_DEPENDENCY)

SDK_EXPORT_DIR = SDK/SDK_Export/hw
SYSTEM_HW_HANDOFF = $(SDK_EXPORT_DIR)/$(SYSTEM).xml
SYSTEM_HW_HANDOFF_BIT = $(SDK_EXPORT_DIR)/$(SYSTEM).bit
SYSTEM_HW_HANDOFF_BMM = $(SDK_EXPORT_DIR)/$(SYSTEM)_bd.bmm
SYSTEM_HW_HANDOFF_DEP = $(SYSTEM_HW_HANDOFF) $(SYSTEM_HW_HANDOFF_BIT) $(SYSTEM_HW_HANDOFF_BMM)
