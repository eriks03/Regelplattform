-------------------------------------------------------------------------------
-- system.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity system is
  port (
    fpga_0_RS232_Uart_1_RX_pin : in std_logic;
    fpga_0_RS232_Uart_1_TX_pin : out std_logic;
    fpga_0_LEDs_8Bits_GPIO_IO_O_pin : out std_logic_vector(0 to 7);
    fpga_0_Push_Buttons_4Bits_GPIO_IO_I_pin : in std_logic_vector(0 to 3);
    fpga_0_Ethernet_Lite_PHY_tx_clk_pin : in std_logic;
    fpga_0_Ethernet_Lite_PHY_rx_clk_pin : in std_logic;
    fpga_0_Ethernet_Lite_PHY_crs_pin : in std_logic;
    fpga_0_Ethernet_Lite_PHY_dv_pin : in std_logic;
    fpga_0_Ethernet_Lite_PHY_rx_data_pin : in std_logic_vector(3 downto 0);
    fpga_0_Ethernet_Lite_PHY_col_pin : in std_logic;
    fpga_0_Ethernet_Lite_PHY_rx_er_pin : in std_logic;
    fpga_0_Ethernet_Lite_PHY_rst_n_pin : out std_logic;
    fpga_0_Ethernet_Lite_PHY_tx_en_pin : out std_logic;
    fpga_0_Ethernet_Lite_PHY_tx_data_pin : out std_logic_vector(3 downto 0);
    fpga_0_Ethernet_Lite_PHY_MDC_pin : out std_logic;
    fpga_0_Ethernet_Lite_PHY_MDIO_pin : inout std_logic;
    fpga_0_Digilent_SevSeg_Disp_AN_pin : out std_logic_vector(3 downto 0);
    fpga_0_Digilent_SevSeg_Disp_SEG_pin : out std_logic_vector(7 downto 0);
    fpga_0_mem_bus_mux_0_MEM_ADDR_pin : out std_logic_vector(0 to 22);
    fpga_0_mem_bus_mux_0_DQ_pin : inout std_logic_vector(0 to 15);
    fpga_0_mem_bus_mux_0_MEM_OEN_pin : out std_logic;
    fpga_0_mem_bus_mux_0_MEM_WEN_pin : out std_logic;
    fpga_0_mem_bus_mux_0_RAM_CEN_O_pin : out std_logic;
    fpga_0_mem_bus_mux_0_RAM_BEN_O_pin : out std_logic_vector(0 to 1);
    fpga_0_mem_bus_mux_0_FLASH_ADDR_pin : out std_logic_vector(5 to 7);
    fpga_0_mem_bus_mux_0_FLASH_CEN_O_pin : out std_logic;
    fpga_0_mem_bus_mux_0_FLASH_RPN_O_pin : out std_logic;
    fpga_0_mem_bus_mux_0_QUAD_SPI_C_O_pin : out std_logic;
    fpga_0_mem_bus_mux_0_QUAD_SPI_S_O_pin : out std_logic;
    fpga_0_mem_bus_mux_0_MOSI_QUAD_SPI_pin : inout std_logic;
    fpga_0_clk_1_sys_clk_pin : in std_logic;
    fpga_0_rst_1_sys_rst_pin : in std_logic
  );
end system;

architecture STRUCTURE of system is

  component microblaze_0_wrapper is
    port (
      CLK : in std_logic;
      RESET : in std_logic;
      MB_RESET : in std_logic;
      INTERRUPT : in std_logic;
      EXT_BRK : in std_logic;
      EXT_NM_BRK : in std_logic;
      DBG_STOP : in std_logic;
      MB_Halted : out std_logic;
      MB_Error : out std_logic;
      INSTR : in std_logic_vector(0 to 31);
      IREADY : in std_logic;
      IWAIT : in std_logic;
      ICE : in std_logic;
      IUE : in std_logic;
      INSTR_ADDR : out std_logic_vector(0 to 31);
      IFETCH : out std_logic;
      I_AS : out std_logic;
      IPLB_M_ABort : out std_logic;
      IPLB_M_ABus : out std_logic_vector(0 to 31);
      IPLB_M_UABus : out std_logic_vector(0 to 31);
      IPLB_M_BE : out std_logic_vector(0 to 3);
      IPLB_M_busLock : out std_logic;
      IPLB_M_lockErr : out std_logic;
      IPLB_M_MSize : out std_logic_vector(0 to 1);
      IPLB_M_priority : out std_logic_vector(0 to 1);
      IPLB_M_rdBurst : out std_logic;
      IPLB_M_request : out std_logic;
      IPLB_M_RNW : out std_logic;
      IPLB_M_size : out std_logic_vector(0 to 3);
      IPLB_M_TAttribute : out std_logic_vector(0 to 15);
      IPLB_M_type : out std_logic_vector(0 to 2);
      IPLB_M_wrBurst : out std_logic;
      IPLB_M_wrDBus : out std_logic_vector(0 to 31);
      IPLB_MBusy : in std_logic;
      IPLB_MRdErr : in std_logic;
      IPLB_MWrErr : in std_logic;
      IPLB_MIRQ : in std_logic;
      IPLB_MWrBTerm : in std_logic;
      IPLB_MWrDAck : in std_logic;
      IPLB_MAddrAck : in std_logic;
      IPLB_MRdBTerm : in std_logic;
      IPLB_MRdDAck : in std_logic;
      IPLB_MRdDBus : in std_logic_vector(0 to 31);
      IPLB_MRdWdAddr : in std_logic_vector(0 to 3);
      IPLB_MRearbitrate : in std_logic;
      IPLB_MSSize : in std_logic_vector(0 to 1);
      IPLB_MTimeout : in std_logic;
      DATA_READ : in std_logic_vector(0 to 31);
      DREADY : in std_logic;
      DWAIT : in std_logic;
      DCE : in std_logic;
      DUE : in std_logic;
      DATA_WRITE : out std_logic_vector(0 to 31);
      DATA_ADDR : out std_logic_vector(0 to 31);
      D_AS : out std_logic;
      READ_STROBE : out std_logic;
      WRITE_STROBE : out std_logic;
      BYTE_ENABLE : out std_logic_vector(0 to 3);
      DPLB_M_ABort : out std_logic;
      DPLB_M_ABus : out std_logic_vector(0 to 31);
      DPLB_M_UABus : out std_logic_vector(0 to 31);
      DPLB_M_BE : out std_logic_vector(0 to 3);
      DPLB_M_busLock : out std_logic;
      DPLB_M_lockErr : out std_logic;
      DPLB_M_MSize : out std_logic_vector(0 to 1);
      DPLB_M_priority : out std_logic_vector(0 to 1);
      DPLB_M_rdBurst : out std_logic;
      DPLB_M_request : out std_logic;
      DPLB_M_RNW : out std_logic;
      DPLB_M_size : out std_logic_vector(0 to 3);
      DPLB_M_TAttribute : out std_logic_vector(0 to 15);
      DPLB_M_type : out std_logic_vector(0 to 2);
      DPLB_M_wrBurst : out std_logic;
      DPLB_M_wrDBus : out std_logic_vector(0 to 31);
      DPLB_MBusy : in std_logic;
      DPLB_MRdErr : in std_logic;
      DPLB_MWrErr : in std_logic;
      DPLB_MIRQ : in std_logic;
      DPLB_MWrBTerm : in std_logic;
      DPLB_MWrDAck : in std_logic;
      DPLB_MAddrAck : in std_logic;
      DPLB_MRdBTerm : in std_logic;
      DPLB_MRdDAck : in std_logic;
      DPLB_MRdDBus : in std_logic_vector(0 to 31);
      DPLB_MRdWdAddr : in std_logic_vector(0 to 3);
      DPLB_MRearbitrate : in std_logic;
      DPLB_MSSize : in std_logic_vector(0 to 1);
      DPLB_MTimeout : in std_logic;
      M_AXI_IP_AWID : out std_logic_vector(0 downto 0);
      M_AXI_IP_AWADDR : out std_logic_vector(31 downto 0);
      M_AXI_IP_AWLEN : out std_logic_vector(7 downto 0);
      M_AXI_IP_AWSIZE : out std_logic_vector(2 downto 0);
      M_AXI_IP_AWBURST : out std_logic_vector(1 downto 0);
      M_AXI_IP_AWLOCK : out std_logic;
      M_AXI_IP_AWCACHE : out std_logic_vector(3 downto 0);
      M_AXI_IP_AWPROT : out std_logic_vector(2 downto 0);
      M_AXI_IP_AWQOS : out std_logic_vector(3 downto 0);
      M_AXI_IP_AWVALID : out std_logic;
      M_AXI_IP_AWREADY : in std_logic;
      M_AXI_IP_WDATA : out std_logic_vector(31 downto 0);
      M_AXI_IP_WSTRB : out std_logic_vector(3 downto 0);
      M_AXI_IP_WLAST : out std_logic;
      M_AXI_IP_WVALID : out std_logic;
      M_AXI_IP_WREADY : in std_logic;
      M_AXI_IP_BID : in std_logic_vector(0 downto 0);
      M_AXI_IP_BRESP : in std_logic_vector(1 downto 0);
      M_AXI_IP_BVALID : in std_logic;
      M_AXI_IP_BREADY : out std_logic;
      M_AXI_IP_ARID : out std_logic_vector(0 downto 0);
      M_AXI_IP_ARADDR : out std_logic_vector(31 downto 0);
      M_AXI_IP_ARLEN : out std_logic_vector(7 downto 0);
      M_AXI_IP_ARSIZE : out std_logic_vector(2 downto 0);
      M_AXI_IP_ARBURST : out std_logic_vector(1 downto 0);
      M_AXI_IP_ARLOCK : out std_logic;
      M_AXI_IP_ARCACHE : out std_logic_vector(3 downto 0);
      M_AXI_IP_ARPROT : out std_logic_vector(2 downto 0);
      M_AXI_IP_ARQOS : out std_logic_vector(3 downto 0);
      M_AXI_IP_ARVALID : out std_logic;
      M_AXI_IP_ARREADY : in std_logic;
      M_AXI_IP_RID : in std_logic_vector(0 downto 0);
      M_AXI_IP_RDATA : in std_logic_vector(31 downto 0);
      M_AXI_IP_RRESP : in std_logic_vector(1 downto 0);
      M_AXI_IP_RLAST : in std_logic;
      M_AXI_IP_RVALID : in std_logic;
      M_AXI_IP_RREADY : out std_logic;
      M_AXI_DP_AWID : out std_logic_vector(0 downto 0);
      M_AXI_DP_AWADDR : out std_logic_vector(31 downto 0);
      M_AXI_DP_AWLEN : out std_logic_vector(7 downto 0);
      M_AXI_DP_AWSIZE : out std_logic_vector(2 downto 0);
      M_AXI_DP_AWBURST : out std_logic_vector(1 downto 0);
      M_AXI_DP_AWLOCK : out std_logic;
      M_AXI_DP_AWCACHE : out std_logic_vector(3 downto 0);
      M_AXI_DP_AWPROT : out std_logic_vector(2 downto 0);
      M_AXI_DP_AWQOS : out std_logic_vector(3 downto 0);
      M_AXI_DP_AWVALID : out std_logic;
      M_AXI_DP_AWREADY : in std_logic;
      M_AXI_DP_WDATA : out std_logic_vector(31 downto 0);
      M_AXI_DP_WSTRB : out std_logic_vector(3 downto 0);
      M_AXI_DP_WLAST : out std_logic;
      M_AXI_DP_WVALID : out std_logic;
      M_AXI_DP_WREADY : in std_logic;
      M_AXI_DP_BID : in std_logic_vector(0 downto 0);
      M_AXI_DP_BRESP : in std_logic_vector(1 downto 0);
      M_AXI_DP_BVALID : in std_logic;
      M_AXI_DP_BREADY : out std_logic;
      M_AXI_DP_ARID : out std_logic_vector(0 downto 0);
      M_AXI_DP_ARADDR : out std_logic_vector(31 downto 0);
      M_AXI_DP_ARLEN : out std_logic_vector(7 downto 0);
      M_AXI_DP_ARSIZE : out std_logic_vector(2 downto 0);
      M_AXI_DP_ARBURST : out std_logic_vector(1 downto 0);
      M_AXI_DP_ARLOCK : out std_logic;
      M_AXI_DP_ARCACHE : out std_logic_vector(3 downto 0);
      M_AXI_DP_ARPROT : out std_logic_vector(2 downto 0);
      M_AXI_DP_ARQOS : out std_logic_vector(3 downto 0);
      M_AXI_DP_ARVALID : out std_logic;
      M_AXI_DP_ARREADY : in std_logic;
      M_AXI_DP_RID : in std_logic_vector(0 downto 0);
      M_AXI_DP_RDATA : in std_logic_vector(31 downto 0);
      M_AXI_DP_RRESP : in std_logic_vector(1 downto 0);
      M_AXI_DP_RLAST : in std_logic;
      M_AXI_DP_RVALID : in std_logic;
      M_AXI_DP_RREADY : out std_logic;
      M_AXI_IC_AWID : out std_logic_vector(0 downto 0);
      M_AXI_IC_AWADDR : out std_logic_vector(31 downto 0);
      M_AXI_IC_AWLEN : out std_logic_vector(7 downto 0);
      M_AXI_IC_AWSIZE : out std_logic_vector(2 downto 0);
      M_AXI_IC_AWBURST : out std_logic_vector(1 downto 0);
      M_AXI_IC_AWLOCK : out std_logic;
      M_AXI_IC_AWCACHE : out std_logic_vector(3 downto 0);
      M_AXI_IC_AWPROT : out std_logic_vector(2 downto 0);
      M_AXI_IC_AWQOS : out std_logic_vector(3 downto 0);
      M_AXI_IC_AWVALID : out std_logic;
      M_AXI_IC_AWREADY : in std_logic;
      M_AXI_IC_AWUSER : out std_logic_vector(4 downto 0);
      M_AXI_IC_WDATA : out std_logic_vector(31 downto 0);
      M_AXI_IC_WSTRB : out std_logic_vector(3 downto 0);
      M_AXI_IC_WLAST : out std_logic;
      M_AXI_IC_WVALID : out std_logic;
      M_AXI_IC_WREADY : in std_logic;
      M_AXI_IC_WUSER : out std_logic_vector(0 downto 0);
      M_AXI_IC_BID : in std_logic_vector(0 downto 0);
      M_AXI_IC_BRESP : in std_logic_vector(1 downto 0);
      M_AXI_IC_BVALID : in std_logic;
      M_AXI_IC_BREADY : out std_logic;
      M_AXI_IC_BUSER : in std_logic_vector(0 downto 0);
      M_AXI_IC_ARID : out std_logic_vector(0 downto 0);
      M_AXI_IC_ARADDR : out std_logic_vector(31 downto 0);
      M_AXI_IC_ARLEN : out std_logic_vector(7 downto 0);
      M_AXI_IC_ARSIZE : out std_logic_vector(2 downto 0);
      M_AXI_IC_ARBURST : out std_logic_vector(1 downto 0);
      M_AXI_IC_ARLOCK : out std_logic;
      M_AXI_IC_ARCACHE : out std_logic_vector(3 downto 0);
      M_AXI_IC_ARPROT : out std_logic_vector(2 downto 0);
      M_AXI_IC_ARQOS : out std_logic_vector(3 downto 0);
      M_AXI_IC_ARVALID : out std_logic;
      M_AXI_IC_ARREADY : in std_logic;
      M_AXI_IC_ARUSER : out std_logic_vector(4 downto 0);
      M_AXI_IC_RID : in std_logic_vector(0 downto 0);
      M_AXI_IC_RDATA : in std_logic_vector(31 downto 0);
      M_AXI_IC_RRESP : in std_logic_vector(1 downto 0);
      M_AXI_IC_RLAST : in std_logic;
      M_AXI_IC_RVALID : in std_logic;
      M_AXI_IC_RREADY : out std_logic;
      M_AXI_IC_RUSER : in std_logic_vector(0 downto 0);
      M_AXI_DC_AWID : out std_logic_vector(0 downto 0);
      M_AXI_DC_AWADDR : out std_logic_vector(31 downto 0);
      M_AXI_DC_AWLEN : out std_logic_vector(7 downto 0);
      M_AXI_DC_AWSIZE : out std_logic_vector(2 downto 0);
      M_AXI_DC_AWBURST : out std_logic_vector(1 downto 0);
      M_AXI_DC_AWLOCK : out std_logic;
      M_AXI_DC_AWCACHE : out std_logic_vector(3 downto 0);
      M_AXI_DC_AWPROT : out std_logic_vector(2 downto 0);
      M_AXI_DC_AWQOS : out std_logic_vector(3 downto 0);
      M_AXI_DC_AWVALID : out std_logic;
      M_AXI_DC_AWREADY : in std_logic;
      M_AXI_DC_AWUSER : out std_logic_vector(4 downto 0);
      M_AXI_DC_WDATA : out std_logic_vector(31 downto 0);
      M_AXI_DC_WSTRB : out std_logic_vector(3 downto 0);
      M_AXI_DC_WLAST : out std_logic;
      M_AXI_DC_WVALID : out std_logic;
      M_AXI_DC_WREADY : in std_logic;
      M_AXI_DC_WUSER : out std_logic_vector(0 downto 0);
      M_AXI_DC_BID : in std_logic_vector(0 downto 0);
      M_AXI_DC_BRESP : in std_logic_vector(1 downto 0);
      M_AXI_DC_BVALID : in std_logic;
      M_AXI_DC_BREADY : out std_logic;
      M_AXI_DC_BUSER : in std_logic_vector(0 downto 0);
      M_AXI_DC_ARID : out std_logic_vector(0 downto 0);
      M_AXI_DC_ARADDR : out std_logic_vector(31 downto 0);
      M_AXI_DC_ARLEN : out std_logic_vector(7 downto 0);
      M_AXI_DC_ARSIZE : out std_logic_vector(2 downto 0);
      M_AXI_DC_ARBURST : out std_logic_vector(1 downto 0);
      M_AXI_DC_ARLOCK : out std_logic;
      M_AXI_DC_ARCACHE : out std_logic_vector(3 downto 0);
      M_AXI_DC_ARPROT : out std_logic_vector(2 downto 0);
      M_AXI_DC_ARQOS : out std_logic_vector(3 downto 0);
      M_AXI_DC_ARVALID : out std_logic;
      M_AXI_DC_ARREADY : in std_logic;
      M_AXI_DC_ARUSER : out std_logic_vector(4 downto 0);
      M_AXI_DC_RID : in std_logic_vector(0 downto 0);
      M_AXI_DC_RDATA : in std_logic_vector(31 downto 0);
      M_AXI_DC_RRESP : in std_logic_vector(1 downto 0);
      M_AXI_DC_RLAST : in std_logic;
      M_AXI_DC_RVALID : in std_logic;
      M_AXI_DC_RREADY : out std_logic;
      M_AXI_DC_RUSER : in std_logic_vector(0 downto 0);
      DBG_CLK : in std_logic;
      DBG_TDI : in std_logic;
      DBG_TDO : out std_logic;
      DBG_REG_EN : in std_logic_vector(0 to 7);
      DBG_SHIFT : in std_logic;
      DBG_CAPTURE : in std_logic;
      DBG_UPDATE : in std_logic;
      DEBUG_RST : in std_logic;
      Trace_Instruction : out std_logic_vector(0 to 31);
      Trace_Valid_Instr : out std_logic;
      Trace_PC : out std_logic_vector(0 to 31);
      Trace_Reg_Write : out std_logic;
      Trace_Reg_Addr : out std_logic_vector(0 to 4);
      Trace_MSR_Reg : out std_logic_vector(0 to 14);
      Trace_PID_Reg : out std_logic_vector(0 to 7);
      Trace_New_Reg_Value : out std_logic_vector(0 to 31);
      Trace_Exception_Taken : out std_logic;
      Trace_Exception_Kind : out std_logic_vector(0 to 4);
      Trace_Jump_Taken : out std_logic;
      Trace_Delay_Slot : out std_logic;
      Trace_Data_Address : out std_logic_vector(0 to 31);
      Trace_Data_Access : out std_logic;
      Trace_Data_Read : out std_logic;
      Trace_Data_Write : out std_logic;
      Trace_Data_Write_Value : out std_logic_vector(0 to 31);
      Trace_Data_Byte_Enable : out std_logic_vector(0 to 3);
      Trace_DCache_Req : out std_logic;
      Trace_DCache_Hit : out std_logic;
      Trace_DCache_Rdy : out std_logic;
      Trace_DCache_Read : out std_logic;
      Trace_ICache_Req : out std_logic;
      Trace_ICache_Hit : out std_logic;
      Trace_ICache_Rdy : out std_logic;
      Trace_OF_PipeRun : out std_logic;
      Trace_EX_PipeRun : out std_logic;
      Trace_MEM_PipeRun : out std_logic;
      Trace_MB_Halted : out std_logic;
      Trace_Jump_Hit : out std_logic;
      FSL0_S_CLK : out std_logic;
      FSL0_S_READ : out std_logic;
      FSL0_S_DATA : in std_logic_vector(0 to 31);
      FSL0_S_CONTROL : in std_logic;
      FSL0_S_EXISTS : in std_logic;
      FSL0_M_CLK : out std_logic;
      FSL0_M_WRITE : out std_logic;
      FSL0_M_DATA : out std_logic_vector(0 to 31);
      FSL0_M_CONTROL : out std_logic;
      FSL0_M_FULL : in std_logic;
      FSL1_S_CLK : out std_logic;
      FSL1_S_READ : out std_logic;
      FSL1_S_DATA : in std_logic_vector(0 to 31);
      FSL1_S_CONTROL : in std_logic;
      FSL1_S_EXISTS : in std_logic;
      FSL1_M_CLK : out std_logic;
      FSL1_M_WRITE : out std_logic;
      FSL1_M_DATA : out std_logic_vector(0 to 31);
      FSL1_M_CONTROL : out std_logic;
      FSL1_M_FULL : in std_logic;
      FSL2_S_CLK : out std_logic;
      FSL2_S_READ : out std_logic;
      FSL2_S_DATA : in std_logic_vector(0 to 31);
      FSL2_S_CONTROL : in std_logic;
      FSL2_S_EXISTS : in std_logic;
      FSL2_M_CLK : out std_logic;
      FSL2_M_WRITE : out std_logic;
      FSL2_M_DATA : out std_logic_vector(0 to 31);
      FSL2_M_CONTROL : out std_logic;
      FSL2_M_FULL : in std_logic;
      FSL3_S_CLK : out std_logic;
      FSL3_S_READ : out std_logic;
      FSL3_S_DATA : in std_logic_vector(0 to 31);
      FSL3_S_CONTROL : in std_logic;
      FSL3_S_EXISTS : in std_logic;
      FSL3_M_CLK : out std_logic;
      FSL3_M_WRITE : out std_logic;
      FSL3_M_DATA : out std_logic_vector(0 to 31);
      FSL3_M_CONTROL : out std_logic;
      FSL3_M_FULL : in std_logic;
      FSL4_S_CLK : out std_logic;
      FSL4_S_READ : out std_logic;
      FSL4_S_DATA : in std_logic_vector(0 to 31);
      FSL4_S_CONTROL : in std_logic;
      FSL4_S_EXISTS : in std_logic;
      FSL4_M_CLK : out std_logic;
      FSL4_M_WRITE : out std_logic;
      FSL4_M_DATA : out std_logic_vector(0 to 31);
      FSL4_M_CONTROL : out std_logic;
      FSL4_M_FULL : in std_logic;
      FSL5_S_CLK : out std_logic;
      FSL5_S_READ : out std_logic;
      FSL5_S_DATA : in std_logic_vector(0 to 31);
      FSL5_S_CONTROL : in std_logic;
      FSL5_S_EXISTS : in std_logic;
      FSL5_M_CLK : out std_logic;
      FSL5_M_WRITE : out std_logic;
      FSL5_M_DATA : out std_logic_vector(0 to 31);
      FSL5_M_CONTROL : out std_logic;
      FSL5_M_FULL : in std_logic;
      FSL6_S_CLK : out std_logic;
      FSL6_S_READ : out std_logic;
      FSL6_S_DATA : in std_logic_vector(0 to 31);
      FSL6_S_CONTROL : in std_logic;
      FSL6_S_EXISTS : in std_logic;
      FSL6_M_CLK : out std_logic;
      FSL6_M_WRITE : out std_logic;
      FSL6_M_DATA : out std_logic_vector(0 to 31);
      FSL6_M_CONTROL : out std_logic;
      FSL6_M_FULL : in std_logic;
      FSL7_S_CLK : out std_logic;
      FSL7_S_READ : out std_logic;
      FSL7_S_DATA : in std_logic_vector(0 to 31);
      FSL7_S_CONTROL : in std_logic;
      FSL7_S_EXISTS : in std_logic;
      FSL7_M_CLK : out std_logic;
      FSL7_M_WRITE : out std_logic;
      FSL7_M_DATA : out std_logic_vector(0 to 31);
      FSL7_M_CONTROL : out std_logic;
      FSL7_M_FULL : in std_logic;
      FSL8_S_CLK : out std_logic;
      FSL8_S_READ : out std_logic;
      FSL8_S_DATA : in std_logic_vector(0 to 31);
      FSL8_S_CONTROL : in std_logic;
      FSL8_S_EXISTS : in std_logic;
      FSL8_M_CLK : out std_logic;
      FSL8_M_WRITE : out std_logic;
      FSL8_M_DATA : out std_logic_vector(0 to 31);
      FSL8_M_CONTROL : out std_logic;
      FSL8_M_FULL : in std_logic;
      FSL9_S_CLK : out std_logic;
      FSL9_S_READ : out std_logic;
      FSL9_S_DATA : in std_logic_vector(0 to 31);
      FSL9_S_CONTROL : in std_logic;
      FSL9_S_EXISTS : in std_logic;
      FSL9_M_CLK : out std_logic;
      FSL9_M_WRITE : out std_logic;
      FSL9_M_DATA : out std_logic_vector(0 to 31);
      FSL9_M_CONTROL : out std_logic;
      FSL9_M_FULL : in std_logic;
      FSL10_S_CLK : out std_logic;
      FSL10_S_READ : out std_logic;
      FSL10_S_DATA : in std_logic_vector(0 to 31);
      FSL10_S_CONTROL : in std_logic;
      FSL10_S_EXISTS : in std_logic;
      FSL10_M_CLK : out std_logic;
      FSL10_M_WRITE : out std_logic;
      FSL10_M_DATA : out std_logic_vector(0 to 31);
      FSL10_M_CONTROL : out std_logic;
      FSL10_M_FULL : in std_logic;
      FSL11_S_CLK : out std_logic;
      FSL11_S_READ : out std_logic;
      FSL11_S_DATA : in std_logic_vector(0 to 31);
      FSL11_S_CONTROL : in std_logic;
      FSL11_S_EXISTS : in std_logic;
      FSL11_M_CLK : out std_logic;
      FSL11_M_WRITE : out std_logic;
      FSL11_M_DATA : out std_logic_vector(0 to 31);
      FSL11_M_CONTROL : out std_logic;
      FSL11_M_FULL : in std_logic;
      FSL12_S_CLK : out std_logic;
      FSL12_S_READ : out std_logic;
      FSL12_S_DATA : in std_logic_vector(0 to 31);
      FSL12_S_CONTROL : in std_logic;
      FSL12_S_EXISTS : in std_logic;
      FSL12_M_CLK : out std_logic;
      FSL12_M_WRITE : out std_logic;
      FSL12_M_DATA : out std_logic_vector(0 to 31);
      FSL12_M_CONTROL : out std_logic;
      FSL12_M_FULL : in std_logic;
      FSL13_S_CLK : out std_logic;
      FSL13_S_READ : out std_logic;
      FSL13_S_DATA : in std_logic_vector(0 to 31);
      FSL13_S_CONTROL : in std_logic;
      FSL13_S_EXISTS : in std_logic;
      FSL13_M_CLK : out std_logic;
      FSL13_M_WRITE : out std_logic;
      FSL13_M_DATA : out std_logic_vector(0 to 31);
      FSL13_M_CONTROL : out std_logic;
      FSL13_M_FULL : in std_logic;
      FSL14_S_CLK : out std_logic;
      FSL14_S_READ : out std_logic;
      FSL14_S_DATA : in std_logic_vector(0 to 31);
      FSL14_S_CONTROL : in std_logic;
      FSL14_S_EXISTS : in std_logic;
      FSL14_M_CLK : out std_logic;
      FSL14_M_WRITE : out std_logic;
      FSL14_M_DATA : out std_logic_vector(0 to 31);
      FSL14_M_CONTROL : out std_logic;
      FSL14_M_FULL : in std_logic;
      FSL15_S_CLK : out std_logic;
      FSL15_S_READ : out std_logic;
      FSL15_S_DATA : in std_logic_vector(0 to 31);
      FSL15_S_CONTROL : in std_logic;
      FSL15_S_EXISTS : in std_logic;
      FSL15_M_CLK : out std_logic;
      FSL15_M_WRITE : out std_logic;
      FSL15_M_DATA : out std_logic_vector(0 to 31);
      FSL15_M_CONTROL : out std_logic;
      FSL15_M_FULL : in std_logic;
      M0_AXIS_TLAST : out std_logic;
      M0_AXIS_TDATA : out std_logic_vector(31 downto 0);
      M0_AXIS_TVALID : out std_logic;
      M0_AXIS_TREADY : in std_logic;
      S0_AXIS_TLAST : in std_logic;
      S0_AXIS_TDATA : in std_logic_vector(31 downto 0);
      S0_AXIS_TVALID : in std_logic;
      S0_AXIS_TREADY : out std_logic;
      M1_AXIS_TLAST : out std_logic;
      M1_AXIS_TDATA : out std_logic_vector(31 downto 0);
      M1_AXIS_TVALID : out std_logic;
      M1_AXIS_TREADY : in std_logic;
      S1_AXIS_TLAST : in std_logic;
      S1_AXIS_TDATA : in std_logic_vector(31 downto 0);
      S1_AXIS_TVALID : in std_logic;
      S1_AXIS_TREADY : out std_logic;
      M2_AXIS_TLAST : out std_logic;
      M2_AXIS_TDATA : out std_logic_vector(31 downto 0);
      M2_AXIS_TVALID : out std_logic;
      M2_AXIS_TREADY : in std_logic;
      S2_AXIS_TLAST : in std_logic;
      S2_AXIS_TDATA : in std_logic_vector(31 downto 0);
      S2_AXIS_TVALID : in std_logic;
      S2_AXIS_TREADY : out std_logic;
      M3_AXIS_TLAST : out std_logic;
      M3_AXIS_TDATA : out std_logic_vector(31 downto 0);
      M3_AXIS_TVALID : out std_logic;
      M3_AXIS_TREADY : in std_logic;
      S3_AXIS_TLAST : in std_logic;
      S3_AXIS_TDATA : in std_logic_vector(31 downto 0);
      S3_AXIS_TVALID : in std_logic;
      S3_AXIS_TREADY : out std_logic;
      M4_AXIS_TLAST : out std_logic;
      M4_AXIS_TDATA : out std_logic_vector(31 downto 0);
      M4_AXIS_TVALID : out std_logic;
      M4_AXIS_TREADY : in std_logic;
      S4_AXIS_TLAST : in std_logic;
      S4_AXIS_TDATA : in std_logic_vector(31 downto 0);
      S4_AXIS_TVALID : in std_logic;
      S4_AXIS_TREADY : out std_logic;
      M5_AXIS_TLAST : out std_logic;
      M5_AXIS_TDATA : out std_logic_vector(31 downto 0);
      M5_AXIS_TVALID : out std_logic;
      M5_AXIS_TREADY : in std_logic;
      S5_AXIS_TLAST : in std_logic;
      S5_AXIS_TDATA : in std_logic_vector(31 downto 0);
      S5_AXIS_TVALID : in std_logic;
      S5_AXIS_TREADY : out std_logic;
      M6_AXIS_TLAST : out std_logic;
      M6_AXIS_TDATA : out std_logic_vector(31 downto 0);
      M6_AXIS_TVALID : out std_logic;
      M6_AXIS_TREADY : in std_logic;
      S6_AXIS_TLAST : in std_logic;
      S6_AXIS_TDATA : in std_logic_vector(31 downto 0);
      S6_AXIS_TVALID : in std_logic;
      S6_AXIS_TREADY : out std_logic;
      M7_AXIS_TLAST : out std_logic;
      M7_AXIS_TDATA : out std_logic_vector(31 downto 0);
      M7_AXIS_TVALID : out std_logic;
      M7_AXIS_TREADY : in std_logic;
      S7_AXIS_TLAST : in std_logic;
      S7_AXIS_TDATA : in std_logic_vector(31 downto 0);
      S7_AXIS_TVALID : in std_logic;
      S7_AXIS_TREADY : out std_logic;
      M8_AXIS_TLAST : out std_logic;
      M8_AXIS_TDATA : out std_logic_vector(31 downto 0);
      M8_AXIS_TVALID : out std_logic;
      M8_AXIS_TREADY : in std_logic;
      S8_AXIS_TLAST : in std_logic;
      S8_AXIS_TDATA : in std_logic_vector(31 downto 0);
      S8_AXIS_TVALID : in std_logic;
      S8_AXIS_TREADY : out std_logic;
      M9_AXIS_TLAST : out std_logic;
      M9_AXIS_TDATA : out std_logic_vector(31 downto 0);
      M9_AXIS_TVALID : out std_logic;
      M9_AXIS_TREADY : in std_logic;
      S9_AXIS_TLAST : in std_logic;
      S9_AXIS_TDATA : in std_logic_vector(31 downto 0);
      S9_AXIS_TVALID : in std_logic;
      S9_AXIS_TREADY : out std_logic;
      M10_AXIS_TLAST : out std_logic;
      M10_AXIS_TDATA : out std_logic_vector(31 downto 0);
      M10_AXIS_TVALID : out std_logic;
      M10_AXIS_TREADY : in std_logic;
      S10_AXIS_TLAST : in std_logic;
      S10_AXIS_TDATA : in std_logic_vector(31 downto 0);
      S10_AXIS_TVALID : in std_logic;
      S10_AXIS_TREADY : out std_logic;
      M11_AXIS_TLAST : out std_logic;
      M11_AXIS_TDATA : out std_logic_vector(31 downto 0);
      M11_AXIS_TVALID : out std_logic;
      M11_AXIS_TREADY : in std_logic;
      S11_AXIS_TLAST : in std_logic;
      S11_AXIS_TDATA : in std_logic_vector(31 downto 0);
      S11_AXIS_TVALID : in std_logic;
      S11_AXIS_TREADY : out std_logic;
      M12_AXIS_TLAST : out std_logic;
      M12_AXIS_TDATA : out std_logic_vector(31 downto 0);
      M12_AXIS_TVALID : out std_logic;
      M12_AXIS_TREADY : in std_logic;
      S12_AXIS_TLAST : in std_logic;
      S12_AXIS_TDATA : in std_logic_vector(31 downto 0);
      S12_AXIS_TVALID : in std_logic;
      S12_AXIS_TREADY : out std_logic;
      M13_AXIS_TLAST : out std_logic;
      M13_AXIS_TDATA : out std_logic_vector(31 downto 0);
      M13_AXIS_TVALID : out std_logic;
      M13_AXIS_TREADY : in std_logic;
      S13_AXIS_TLAST : in std_logic;
      S13_AXIS_TDATA : in std_logic_vector(31 downto 0);
      S13_AXIS_TVALID : in std_logic;
      S13_AXIS_TREADY : out std_logic;
      M14_AXIS_TLAST : out std_logic;
      M14_AXIS_TDATA : out std_logic_vector(31 downto 0);
      M14_AXIS_TVALID : out std_logic;
      M14_AXIS_TREADY : in std_logic;
      S14_AXIS_TLAST : in std_logic;
      S14_AXIS_TDATA : in std_logic_vector(31 downto 0);
      S14_AXIS_TVALID : in std_logic;
      S14_AXIS_TREADY : out std_logic;
      M15_AXIS_TLAST : out std_logic;
      M15_AXIS_TDATA : out std_logic_vector(31 downto 0);
      M15_AXIS_TVALID : out std_logic;
      M15_AXIS_TREADY : in std_logic;
      S15_AXIS_TLAST : in std_logic;
      S15_AXIS_TDATA : in std_logic_vector(31 downto 0);
      S15_AXIS_TVALID : in std_logic;
      S15_AXIS_TREADY : out std_logic;
      ICACHE_FSL_IN_CLK : out std_logic;
      ICACHE_FSL_IN_READ : out std_logic;
      ICACHE_FSL_IN_DATA : in std_logic_vector(0 to 31);
      ICACHE_FSL_IN_CONTROL : in std_logic;
      ICACHE_FSL_IN_EXISTS : in std_logic;
      ICACHE_FSL_OUT_CLK : out std_logic;
      ICACHE_FSL_OUT_WRITE : out std_logic;
      ICACHE_FSL_OUT_DATA : out std_logic_vector(0 to 31);
      ICACHE_FSL_OUT_CONTROL : out std_logic;
      ICACHE_FSL_OUT_FULL : in std_logic;
      DCACHE_FSL_IN_CLK : out std_logic;
      DCACHE_FSL_IN_READ : out std_logic;
      DCACHE_FSL_IN_DATA : in std_logic_vector(0 to 31);
      DCACHE_FSL_IN_CONTROL : in std_logic;
      DCACHE_FSL_IN_EXISTS : in std_logic;
      DCACHE_FSL_OUT_CLK : out std_logic;
      DCACHE_FSL_OUT_WRITE : out std_logic;
      DCACHE_FSL_OUT_DATA : out std_logic_vector(0 to 31);
      DCACHE_FSL_OUT_CONTROL : out std_logic;
      DCACHE_FSL_OUT_FULL : in std_logic
    );
  end component;

  component mb_plb_wrapper is
    port (
      PLB_Clk : in std_logic;
      SYS_Rst : in std_logic;
      PLB_Rst : out std_logic;
      SPLB_Rst : out std_logic_vector(0 to 10);
      MPLB_Rst : out std_logic_vector(0 to 1);
      PLB_dcrAck : out std_logic;
      PLB_dcrDBus : out std_logic_vector(0 to 31);
      DCR_ABus : in std_logic_vector(0 to 9);
      DCR_DBus : in std_logic_vector(0 to 31);
      DCR_Read : in std_logic;
      DCR_Write : in std_logic;
      M_ABus : in std_logic_vector(0 to 63);
      M_UABus : in std_logic_vector(0 to 63);
      M_BE : in std_logic_vector(0 to 7);
      M_RNW : in std_logic_vector(0 to 1);
      M_abort : in std_logic_vector(0 to 1);
      M_busLock : in std_logic_vector(0 to 1);
      M_TAttribute : in std_logic_vector(0 to 31);
      M_lockErr : in std_logic_vector(0 to 1);
      M_MSize : in std_logic_vector(0 to 3);
      M_priority : in std_logic_vector(0 to 3);
      M_rdBurst : in std_logic_vector(0 to 1);
      M_request : in std_logic_vector(0 to 1);
      M_size : in std_logic_vector(0 to 7);
      M_type : in std_logic_vector(0 to 5);
      M_wrBurst : in std_logic_vector(0 to 1);
      M_wrDBus : in std_logic_vector(0 to 63);
      Sl_addrAck : in std_logic_vector(0 to 10);
      Sl_MRdErr : in std_logic_vector(0 to 21);
      Sl_MWrErr : in std_logic_vector(0 to 21);
      Sl_MBusy : in std_logic_vector(0 to 21);
      Sl_rdBTerm : in std_logic_vector(0 to 10);
      Sl_rdComp : in std_logic_vector(0 to 10);
      Sl_rdDAck : in std_logic_vector(0 to 10);
      Sl_rdDBus : in std_logic_vector(0 to 351);
      Sl_rdWdAddr : in std_logic_vector(0 to 43);
      Sl_rearbitrate : in std_logic_vector(0 to 10);
      Sl_SSize : in std_logic_vector(0 to 21);
      Sl_wait : in std_logic_vector(0 to 10);
      Sl_wrBTerm : in std_logic_vector(0 to 10);
      Sl_wrComp : in std_logic_vector(0 to 10);
      Sl_wrDAck : in std_logic_vector(0 to 10);
      Sl_MIRQ : in std_logic_vector(0 to 21);
      PLB_MIRQ : out std_logic_vector(0 to 1);
      PLB_ABus : out std_logic_vector(0 to 31);
      PLB_UABus : out std_logic_vector(0 to 31);
      PLB_BE : out std_logic_vector(0 to 3);
      PLB_MAddrAck : out std_logic_vector(0 to 1);
      PLB_MTimeout : out std_logic_vector(0 to 1);
      PLB_MBusy : out std_logic_vector(0 to 1);
      PLB_MRdErr : out std_logic_vector(0 to 1);
      PLB_MWrErr : out std_logic_vector(0 to 1);
      PLB_MRdBTerm : out std_logic_vector(0 to 1);
      PLB_MRdDAck : out std_logic_vector(0 to 1);
      PLB_MRdDBus : out std_logic_vector(0 to 63);
      PLB_MRdWdAddr : out std_logic_vector(0 to 7);
      PLB_MRearbitrate : out std_logic_vector(0 to 1);
      PLB_MWrBTerm : out std_logic_vector(0 to 1);
      PLB_MWrDAck : out std_logic_vector(0 to 1);
      PLB_MSSize : out std_logic_vector(0 to 3);
      PLB_PAValid : out std_logic;
      PLB_RNW : out std_logic;
      PLB_SAValid : out std_logic;
      PLB_abort : out std_logic;
      PLB_busLock : out std_logic;
      PLB_TAttribute : out std_logic_vector(0 to 15);
      PLB_lockErr : out std_logic;
      PLB_masterID : out std_logic_vector(0 to 0);
      PLB_MSize : out std_logic_vector(0 to 1);
      PLB_rdPendPri : out std_logic_vector(0 to 1);
      PLB_wrPendPri : out std_logic_vector(0 to 1);
      PLB_rdPendReq : out std_logic;
      PLB_wrPendReq : out std_logic;
      PLB_rdBurst : out std_logic;
      PLB_rdPrim : out std_logic_vector(0 to 10);
      PLB_reqPri : out std_logic_vector(0 to 1);
      PLB_size : out std_logic_vector(0 to 3);
      PLB_type : out std_logic_vector(0 to 2);
      PLB_wrBurst : out std_logic;
      PLB_wrDBus : out std_logic_vector(0 to 31);
      PLB_wrPrim : out std_logic_vector(0 to 10);
      PLB_SaddrAck : out std_logic;
      PLB_SMRdErr : out std_logic_vector(0 to 1);
      PLB_SMWrErr : out std_logic_vector(0 to 1);
      PLB_SMBusy : out std_logic_vector(0 to 1);
      PLB_SrdBTerm : out std_logic;
      PLB_SrdComp : out std_logic;
      PLB_SrdDAck : out std_logic;
      PLB_SrdDBus : out std_logic_vector(0 to 31);
      PLB_SrdWdAddr : out std_logic_vector(0 to 3);
      PLB_Srearbitrate : out std_logic;
      PLB_Sssize : out std_logic_vector(0 to 1);
      PLB_Swait : out std_logic;
      PLB_SwrBTerm : out std_logic;
      PLB_SwrComp : out std_logic;
      PLB_SwrDAck : out std_logic;
      Bus_Error_Det : out std_logic
    );
  end component;

  component ilmb_wrapper is
    port (
      LMB_Clk : in std_logic;
      SYS_Rst : in std_logic;
      LMB_Rst : out std_logic;
      M_ABus : in std_logic_vector(0 to 31);
      M_ReadStrobe : in std_logic;
      M_WriteStrobe : in std_logic;
      M_AddrStrobe : in std_logic;
      M_DBus : in std_logic_vector(0 to 31);
      M_BE : in std_logic_vector(0 to 3);
      Sl_DBus : in std_logic_vector(0 to 31);
      Sl_Ready : in std_logic_vector(0 to 0);
      Sl_Wait : in std_logic_vector(0 to 0);
      Sl_UE : in std_logic_vector(0 to 0);
      Sl_CE : in std_logic_vector(0 to 0);
      LMB_ABus : out std_logic_vector(0 to 31);
      LMB_ReadStrobe : out std_logic;
      LMB_WriteStrobe : out std_logic;
      LMB_AddrStrobe : out std_logic;
      LMB_ReadDBus : out std_logic_vector(0 to 31);
      LMB_WriteDBus : out std_logic_vector(0 to 31);
      LMB_Ready : out std_logic;
      LMB_Wait : out std_logic;
      LMB_UE : out std_logic;
      LMB_CE : out std_logic;
      LMB_BE : out std_logic_vector(0 to 3)
    );
  end component;

  component dlmb_wrapper is
    port (
      LMB_Clk : in std_logic;
      SYS_Rst : in std_logic;
      LMB_Rst : out std_logic;
      M_ABus : in std_logic_vector(0 to 31);
      M_ReadStrobe : in std_logic;
      M_WriteStrobe : in std_logic;
      M_AddrStrobe : in std_logic;
      M_DBus : in std_logic_vector(0 to 31);
      M_BE : in std_logic_vector(0 to 3);
      Sl_DBus : in std_logic_vector(0 to 31);
      Sl_Ready : in std_logic_vector(0 to 0);
      Sl_Wait : in std_logic_vector(0 to 0);
      Sl_UE : in std_logic_vector(0 to 0);
      Sl_CE : in std_logic_vector(0 to 0);
      LMB_ABus : out std_logic_vector(0 to 31);
      LMB_ReadStrobe : out std_logic;
      LMB_WriteStrobe : out std_logic;
      LMB_AddrStrobe : out std_logic;
      LMB_ReadDBus : out std_logic_vector(0 to 31);
      LMB_WriteDBus : out std_logic_vector(0 to 31);
      LMB_Ready : out std_logic;
      LMB_Wait : out std_logic;
      LMB_UE : out std_logic;
      LMB_CE : out std_logic;
      LMB_BE : out std_logic_vector(0 to 3)
    );
  end component;

  component dlmb_cntlr_wrapper is
    port (
      LMB_Clk : in std_logic;
      LMB_Rst : in std_logic;
      LMB_ABus : in std_logic_vector(0 to 31);
      LMB_WriteDBus : in std_logic_vector(0 to 31);
      LMB_AddrStrobe : in std_logic;
      LMB_ReadStrobe : in std_logic;
      LMB_WriteStrobe : in std_logic;
      LMB_BE : in std_logic_vector(0 to 3);
      Sl_DBus : out std_logic_vector(0 to 31);
      Sl_Ready : out std_logic;
      Sl_Wait : out std_logic;
      Sl_UE : out std_logic;
      Sl_CE : out std_logic;
      BRAM_Rst_A : out std_logic;
      BRAM_Clk_A : out std_logic;
      BRAM_EN_A : out std_logic;
      BRAM_WEN_A : out std_logic_vector(0 to 3);
      BRAM_Addr_A : out std_logic_vector(0 to 31);
      BRAM_Din_A : in std_logic_vector(0 to 31);
      BRAM_Dout_A : out std_logic_vector(0 to 31);
      Interrupt : out std_logic;
      SPLB_CTRL_PLB_ABus : in std_logic_vector(0 to 31);
      SPLB_CTRL_PLB_PAValid : in std_logic;
      SPLB_CTRL_PLB_masterID : in std_logic_vector(0 to 0);
      SPLB_CTRL_PLB_RNW : in std_logic;
      SPLB_CTRL_PLB_BE : in std_logic_vector(0 to 3);
      SPLB_CTRL_PLB_size : in std_logic_vector(0 to 3);
      SPLB_CTRL_PLB_type : in std_logic_vector(0 to 2);
      SPLB_CTRL_PLB_wrDBus : in std_logic_vector(0 to 31);
      SPLB_CTRL_Sl_addrAck : out std_logic;
      SPLB_CTRL_Sl_SSize : out std_logic_vector(0 to 1);
      SPLB_CTRL_Sl_wait : out std_logic;
      SPLB_CTRL_Sl_rearbitrate : out std_logic;
      SPLB_CTRL_Sl_wrDAck : out std_logic;
      SPLB_CTRL_Sl_wrComp : out std_logic;
      SPLB_CTRL_Sl_rdDBus : out std_logic_vector(0 to 31);
      SPLB_CTRL_Sl_rdDAck : out std_logic;
      SPLB_CTRL_Sl_rdComp : out std_logic;
      SPLB_CTRL_Sl_MBusy : out std_logic_vector(0 to 0);
      SPLB_CTRL_Sl_MWrErr : out std_logic_vector(0 to 0);
      SPLB_CTRL_Sl_MRdErr : out std_logic_vector(0 to 0);
      SPLB_CTRL_PLB_UABus : in std_logic_vector(0 to 31);
      SPLB_CTRL_PLB_SAValid : in std_logic;
      SPLB_CTRL_PLB_rdPrim : in std_logic;
      SPLB_CTRL_PLB_wrPrim : in std_logic;
      SPLB_CTRL_PLB_abort : in std_logic;
      SPLB_CTRL_PLB_busLock : in std_logic;
      SPLB_CTRL_PLB_MSize : in std_logic_vector(0 to 1);
      SPLB_CTRL_PLB_lockErr : in std_logic;
      SPLB_CTRL_PLB_wrBurst : in std_logic;
      SPLB_CTRL_PLB_rdBurst : in std_logic;
      SPLB_CTRL_PLB_wrPendReq : in std_logic;
      SPLB_CTRL_PLB_rdPendReq : in std_logic;
      SPLB_CTRL_PLB_wrPendPri : in std_logic_vector(0 to 1);
      SPLB_CTRL_PLB_rdPendPri : in std_logic_vector(0 to 1);
      SPLB_CTRL_PLB_reqPri : in std_logic_vector(0 to 1);
      SPLB_CTRL_PLB_TAttribute : in std_logic_vector(0 to 15);
      SPLB_CTRL_Sl_wrBTerm : out std_logic;
      SPLB_CTRL_Sl_rdWdAddr : out std_logic_vector(0 to 3);
      SPLB_CTRL_Sl_rdBTerm : out std_logic;
      SPLB_CTRL_Sl_MIRQ : out std_logic_vector(0 to 0);
      S_AXI_CTRL_ACLK : in std_logic;
      S_AXI_CTRL_ARESETN : in std_logic;
      S_AXI_CTRL_AWADDR : in std_logic_vector(31 downto 0);
      S_AXI_CTRL_AWVALID : in std_logic;
      S_AXI_CTRL_AWREADY : out std_logic;
      S_AXI_CTRL_WDATA : in std_logic_vector(31 downto 0);
      S_AXI_CTRL_WSTRB : in std_logic_vector(3 downto 0);
      S_AXI_CTRL_WVALID : in std_logic;
      S_AXI_CTRL_WREADY : out std_logic;
      S_AXI_CTRL_BRESP : out std_logic_vector(1 downto 0);
      S_AXI_CTRL_BVALID : out std_logic;
      S_AXI_CTRL_BREADY : in std_logic;
      S_AXI_CTRL_ARADDR : in std_logic_vector(31 downto 0);
      S_AXI_CTRL_ARVALID : in std_logic;
      S_AXI_CTRL_ARREADY : out std_logic;
      S_AXI_CTRL_RDATA : out std_logic_vector(31 downto 0);
      S_AXI_CTRL_RRESP : out std_logic_vector(1 downto 0);
      S_AXI_CTRL_RVALID : out std_logic;
      S_AXI_CTRL_RREADY : in std_logic
    );
  end component;

  component ilmb_cntlr_wrapper is
    port (
      LMB_Clk : in std_logic;
      LMB_Rst : in std_logic;
      LMB_ABus : in std_logic_vector(0 to 31);
      LMB_WriteDBus : in std_logic_vector(0 to 31);
      LMB_AddrStrobe : in std_logic;
      LMB_ReadStrobe : in std_logic;
      LMB_WriteStrobe : in std_logic;
      LMB_BE : in std_logic_vector(0 to 3);
      Sl_DBus : out std_logic_vector(0 to 31);
      Sl_Ready : out std_logic;
      Sl_Wait : out std_logic;
      Sl_UE : out std_logic;
      Sl_CE : out std_logic;
      BRAM_Rst_A : out std_logic;
      BRAM_Clk_A : out std_logic;
      BRAM_EN_A : out std_logic;
      BRAM_WEN_A : out std_logic_vector(0 to 3);
      BRAM_Addr_A : out std_logic_vector(0 to 31);
      BRAM_Din_A : in std_logic_vector(0 to 31);
      BRAM_Dout_A : out std_logic_vector(0 to 31);
      Interrupt : out std_logic;
      SPLB_CTRL_PLB_ABus : in std_logic_vector(0 to 31);
      SPLB_CTRL_PLB_PAValid : in std_logic;
      SPLB_CTRL_PLB_masterID : in std_logic_vector(0 to 0);
      SPLB_CTRL_PLB_RNW : in std_logic;
      SPLB_CTRL_PLB_BE : in std_logic_vector(0 to 3);
      SPLB_CTRL_PLB_size : in std_logic_vector(0 to 3);
      SPLB_CTRL_PLB_type : in std_logic_vector(0 to 2);
      SPLB_CTRL_PLB_wrDBus : in std_logic_vector(0 to 31);
      SPLB_CTRL_Sl_addrAck : out std_logic;
      SPLB_CTRL_Sl_SSize : out std_logic_vector(0 to 1);
      SPLB_CTRL_Sl_wait : out std_logic;
      SPLB_CTRL_Sl_rearbitrate : out std_logic;
      SPLB_CTRL_Sl_wrDAck : out std_logic;
      SPLB_CTRL_Sl_wrComp : out std_logic;
      SPLB_CTRL_Sl_rdDBus : out std_logic_vector(0 to 31);
      SPLB_CTRL_Sl_rdDAck : out std_logic;
      SPLB_CTRL_Sl_rdComp : out std_logic;
      SPLB_CTRL_Sl_MBusy : out std_logic_vector(0 to 0);
      SPLB_CTRL_Sl_MWrErr : out std_logic_vector(0 to 0);
      SPLB_CTRL_Sl_MRdErr : out std_logic_vector(0 to 0);
      SPLB_CTRL_PLB_UABus : in std_logic_vector(0 to 31);
      SPLB_CTRL_PLB_SAValid : in std_logic;
      SPLB_CTRL_PLB_rdPrim : in std_logic;
      SPLB_CTRL_PLB_wrPrim : in std_logic;
      SPLB_CTRL_PLB_abort : in std_logic;
      SPLB_CTRL_PLB_busLock : in std_logic;
      SPLB_CTRL_PLB_MSize : in std_logic_vector(0 to 1);
      SPLB_CTRL_PLB_lockErr : in std_logic;
      SPLB_CTRL_PLB_wrBurst : in std_logic;
      SPLB_CTRL_PLB_rdBurst : in std_logic;
      SPLB_CTRL_PLB_wrPendReq : in std_logic;
      SPLB_CTRL_PLB_rdPendReq : in std_logic;
      SPLB_CTRL_PLB_wrPendPri : in std_logic_vector(0 to 1);
      SPLB_CTRL_PLB_rdPendPri : in std_logic_vector(0 to 1);
      SPLB_CTRL_PLB_reqPri : in std_logic_vector(0 to 1);
      SPLB_CTRL_PLB_TAttribute : in std_logic_vector(0 to 15);
      SPLB_CTRL_Sl_wrBTerm : out std_logic;
      SPLB_CTRL_Sl_rdWdAddr : out std_logic_vector(0 to 3);
      SPLB_CTRL_Sl_rdBTerm : out std_logic;
      SPLB_CTRL_Sl_MIRQ : out std_logic_vector(0 to 0);
      S_AXI_CTRL_ACLK : in std_logic;
      S_AXI_CTRL_ARESETN : in std_logic;
      S_AXI_CTRL_AWADDR : in std_logic_vector(31 downto 0);
      S_AXI_CTRL_AWVALID : in std_logic;
      S_AXI_CTRL_AWREADY : out std_logic;
      S_AXI_CTRL_WDATA : in std_logic_vector(31 downto 0);
      S_AXI_CTRL_WSTRB : in std_logic_vector(3 downto 0);
      S_AXI_CTRL_WVALID : in std_logic;
      S_AXI_CTRL_WREADY : out std_logic;
      S_AXI_CTRL_BRESP : out std_logic_vector(1 downto 0);
      S_AXI_CTRL_BVALID : out std_logic;
      S_AXI_CTRL_BREADY : in std_logic;
      S_AXI_CTRL_ARADDR : in std_logic_vector(31 downto 0);
      S_AXI_CTRL_ARVALID : in std_logic;
      S_AXI_CTRL_ARREADY : out std_logic;
      S_AXI_CTRL_RDATA : out std_logic_vector(31 downto 0);
      S_AXI_CTRL_RRESP : out std_logic_vector(1 downto 0);
      S_AXI_CTRL_RVALID : out std_logic;
      S_AXI_CTRL_RREADY : in std_logic
    );
  end component;

  component lmb_bram_wrapper is
    port (
      BRAM_Rst_A : in std_logic;
      BRAM_Clk_A : in std_logic;
      BRAM_EN_A : in std_logic;
      BRAM_WEN_A : in std_logic_vector(0 to 3);
      BRAM_Addr_A : in std_logic_vector(0 to 31);
      BRAM_Din_A : out std_logic_vector(0 to 31);
      BRAM_Dout_A : in std_logic_vector(0 to 31);
      BRAM_Rst_B : in std_logic;
      BRAM_Clk_B : in std_logic;
      BRAM_EN_B : in std_logic;
      BRAM_WEN_B : in std_logic_vector(0 to 3);
      BRAM_Addr_B : in std_logic_vector(0 to 31);
      BRAM_Din_B : out std_logic_vector(0 to 31);
      BRAM_Dout_B : in std_logic_vector(0 to 31)
    );
  end component;

  component rs232_uart_1_wrapper is
    port (
      SPLB_Clk : in std_logic;
      SPLB_Rst : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_masterID : in std_logic_vector(0 to 0);
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to 3);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_wrDBus : in std_logic_vector(0 to 31);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_lockErr : in std_logic;
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to 31);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to 1);
      Sl_MWrErr : out std_logic_vector(0 to 1);
      Sl_MRdErr : out std_logic_vector(0 to 1);
      Sl_wrBTerm : out std_logic;
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdBTerm : out std_logic;
      Sl_MIRQ : out std_logic_vector(0 to 1);
      RX : in std_logic;
      TX : out std_logic;
      Interrupt : out std_logic
    );
  end component;

  component leds_8bits_wrapper is
    port (
      SPLB_Clk : in std_logic;
      SPLB_Rst : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_masterID : in std_logic_vector(0 to 0);
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to 3);
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_lockErr : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to 31);
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to 31);
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdBTerm : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to 1);
      Sl_MWrErr : out std_logic_vector(0 to 1);
      Sl_MRdErr : out std_logic_vector(0 to 1);
      Sl_MIRQ : out std_logic_vector(0 to 1);
      IP2INTC_Irpt : out std_logic;
      GPIO_IO_I : in std_logic_vector(0 to 7);
      GPIO_IO_O : out std_logic_vector(0 to 7);
      GPIO_IO_T : out std_logic_vector(0 to 7);
      GPIO2_IO_I : in std_logic_vector(0 to 31);
      GPIO2_IO_O : out std_logic_vector(0 to 31);
      GPIO2_IO_T : out std_logic_vector(0 to 31)
    );
  end component;

  component push_buttons_4bits_wrapper is
    port (
      SPLB_Clk : in std_logic;
      SPLB_Rst : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_masterID : in std_logic_vector(0 to 0);
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to 3);
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_lockErr : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to 31);
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to 31);
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdBTerm : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to 1);
      Sl_MWrErr : out std_logic_vector(0 to 1);
      Sl_MRdErr : out std_logic_vector(0 to 1);
      Sl_MIRQ : out std_logic_vector(0 to 1);
      IP2INTC_Irpt : out std_logic;
      GPIO_IO_I : in std_logic_vector(0 to 3);
      GPIO_IO_O : out std_logic_vector(0 to 3);
      GPIO_IO_T : out std_logic_vector(0 to 3);
      GPIO2_IO_I : in std_logic_vector(0 to 31);
      GPIO2_IO_O : out std_logic_vector(0 to 31);
      GPIO2_IO_T : out std_logic_vector(0 to 31)
    );
  end component;

  component ethernet_lite_wrapper is
    port (
      PHY_tx_clk : in std_logic;
      PHY_rx_clk : in std_logic;
      PHY_crs : in std_logic;
      PHY_dv : in std_logic;
      PHY_rx_data : in std_logic_vector(3 downto 0);
      PHY_col : in std_logic;
      PHY_rx_er : in std_logic;
      PHY_rst_n : out std_logic;
      PHY_tx_en : out std_logic;
      PHY_tx_data : out std_logic_vector(3 downto 0);
      PHY_MDC : out std_logic;
      PHY_MDIO_I : in std_logic;
      PHY_MDIO_O : out std_logic;
      PHY_MDIO_T : out std_logic;
      IP2INTC_Irpt : out std_logic;
      SPLB_Clk : in std_logic;
      SPLB_Rst : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_masterID : in std_logic_vector(0 to 0);
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to 3);
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_lockErr : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to 31);
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to 31);
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdBTerm : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to 1);
      Sl_MWrErr : out std_logic_vector(0 to 1);
      Sl_MRdErr : out std_logic_vector(0 to 1);
      Sl_MIRQ : out std_logic_vector(0 to 1)
    );
  end component;

  component micron_ram_wrapper is
    port (
      MCH_SPLB_Clk : in std_logic;
      RdClk : in std_logic;
      MCH_SPLB_Rst : in std_logic;
      MCH0_Access_Control : in std_logic;
      MCH0_Access_Data : in std_logic_vector(0 to 31);
      MCH0_Access_Write : in std_logic;
      MCH0_Access_Full : out std_logic;
      MCH0_ReadData_Control : out std_logic;
      MCH0_ReadData_Data : out std_logic_vector(0 to 31);
      MCH0_ReadData_Read : in std_logic;
      MCH0_ReadData_Exists : out std_logic;
      MCH1_Access_Control : in std_logic;
      MCH1_Access_Data : in std_logic_vector(0 to 31);
      MCH1_Access_Write : in std_logic;
      MCH1_Access_Full : out std_logic;
      MCH1_ReadData_Control : out std_logic;
      MCH1_ReadData_Data : out std_logic_vector(0 to 31);
      MCH1_ReadData_Read : in std_logic;
      MCH1_ReadData_Exists : out std_logic;
      MCH2_Access_Control : in std_logic;
      MCH2_Access_Data : in std_logic_vector(0 to 31);
      MCH2_Access_Write : in std_logic;
      MCH2_Access_Full : out std_logic;
      MCH2_ReadData_Control : out std_logic;
      MCH2_ReadData_Data : out std_logic_vector(0 to 31);
      MCH2_ReadData_Read : in std_logic;
      MCH2_ReadData_Exists : out std_logic;
      MCH3_Access_Control : in std_logic;
      MCH3_Access_Data : in std_logic_vector(0 to 31);
      MCH3_Access_Write : in std_logic;
      MCH3_Access_Full : out std_logic;
      MCH3_ReadData_Control : out std_logic;
      MCH3_ReadData_Data : out std_logic_vector(0 to 31);
      MCH3_ReadData_Read : in std_logic;
      MCH3_ReadData_Exists : out std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_masterID : in std_logic_vector(0 to 0);
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to 3);
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_lockErr : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to 31);
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to 31);
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdBTerm : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to 1);
      Sl_MWrErr : out std_logic_vector(0 to 1);
      Sl_MRdErr : out std_logic_vector(0 to 1);
      Sl_MIRQ : out std_logic_vector(0 to 1);
      Mem_DQ_I : in std_logic_vector(0 to 15);
      Mem_DQ_O : out std_logic_vector(0 to 15);
      Mem_DQ_T : out std_logic_vector(0 to 15);
      Mem_A : out std_logic_vector(0 to 31);
      Mem_RPN : out std_logic;
      Mem_CEN : out std_logic_vector(0 to 0);
      Mem_OEN : out std_logic_vector(0 to 0);
      Mem_WEN : out std_logic;
      Mem_QWEN : out std_logic_vector(0 to 1);
      Mem_BEN : out std_logic_vector(0 to 1);
      Mem_CE : out std_logic_vector(0 to 0);
      Mem_ADV_LDN : out std_logic;
      Mem_LBON : out std_logic;
      Mem_CKEN : out std_logic;
      Mem_RNW : out std_logic
    );
  end component;

  component numonyx_pcm_wrapper is
    port (
      MCH_SPLB_Clk : in std_logic;
      RdClk : in std_logic;
      MCH_SPLB_Rst : in std_logic;
      MCH0_Access_Control : in std_logic;
      MCH0_Access_Data : in std_logic_vector(0 to 31);
      MCH0_Access_Write : in std_logic;
      MCH0_Access_Full : out std_logic;
      MCH0_ReadData_Control : out std_logic;
      MCH0_ReadData_Data : out std_logic_vector(0 to 31);
      MCH0_ReadData_Read : in std_logic;
      MCH0_ReadData_Exists : out std_logic;
      MCH1_Access_Control : in std_logic;
      MCH1_Access_Data : in std_logic_vector(0 to 31);
      MCH1_Access_Write : in std_logic;
      MCH1_Access_Full : out std_logic;
      MCH1_ReadData_Control : out std_logic;
      MCH1_ReadData_Data : out std_logic_vector(0 to 31);
      MCH1_ReadData_Read : in std_logic;
      MCH1_ReadData_Exists : out std_logic;
      MCH2_Access_Control : in std_logic;
      MCH2_Access_Data : in std_logic_vector(0 to 31);
      MCH2_Access_Write : in std_logic;
      MCH2_Access_Full : out std_logic;
      MCH2_ReadData_Control : out std_logic;
      MCH2_ReadData_Data : out std_logic_vector(0 to 31);
      MCH2_ReadData_Read : in std_logic;
      MCH2_ReadData_Exists : out std_logic;
      MCH3_Access_Control : in std_logic;
      MCH3_Access_Data : in std_logic_vector(0 to 31);
      MCH3_Access_Write : in std_logic;
      MCH3_Access_Full : out std_logic;
      MCH3_ReadData_Control : out std_logic;
      MCH3_ReadData_Data : out std_logic_vector(0 to 31);
      MCH3_ReadData_Read : in std_logic;
      MCH3_ReadData_Exists : out std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_masterID : in std_logic_vector(0 to 0);
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to 3);
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_lockErr : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to 31);
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to 31);
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdBTerm : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to 1);
      Sl_MWrErr : out std_logic_vector(0 to 1);
      Sl_MRdErr : out std_logic_vector(0 to 1);
      Sl_MIRQ : out std_logic_vector(0 to 1);
      Mem_DQ_I : in std_logic_vector(0 to 15);
      Mem_DQ_O : out std_logic_vector(0 to 15);
      Mem_DQ_T : out std_logic_vector(0 to 15);
      Mem_A : out std_logic_vector(0 to 31);
      Mem_RPN : out std_logic;
      Mem_CEN : out std_logic_vector(0 to 0);
      Mem_OEN : out std_logic_vector(0 to 0);
      Mem_WEN : out std_logic;
      Mem_QWEN : out std_logic_vector(0 to 1);
      Mem_BEN : out std_logic_vector(0 to 1);
      Mem_CE : out std_logic_vector(0 to 0);
      Mem_ADV_LDN : out std_logic;
      Mem_LBON : out std_logic;
      Mem_CKEN : out std_logic;
      Mem_RNW : out std_logic
    );
  end component;

  component digilent_quadspi_cntlr_wrapper is
    port (
      C : out std_logic;
      S : out std_logic;
      DQ_O : out std_logic_vector(3 downto 0);
      DQ_T : out std_logic_vector(3 downto 0);
      DQ_I : in std_logic_vector(3 downto 0);
      SPLB_Clk : in std_logic;
      SPLB_Rst : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_masterID : in std_logic_vector(0 to 0);
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to 3);
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_lockErr : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to 31);
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to 31);
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdBTerm : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to 1);
      Sl_MWrErr : out std_logic_vector(0 to 1);
      Sl_MRdErr : out std_logic_vector(0 to 1);
      Sl_MIRQ : out std_logic_vector(0 to 1)
    );
  end component;

  component digilent_sevseg_disp_wrapper is
    port (
      AN : out std_logic_vector(3 downto 0);
      SEG : out std_logic_vector(7 downto 0);
      SPLB_Clk : in std_logic;
      SPLB_Rst : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_masterID : in std_logic_vector(0 to 0);
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to 3);
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_lockErr : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to 31);
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to 31);
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdBTerm : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to 1);
      Sl_MWrErr : out std_logic_vector(0 to 1);
      Sl_MRdErr : out std_logic_vector(0 to 1);
      Sl_MIRQ : out std_logic_vector(0 to 1)
    );
  end component;

  component mem_bus_mux_0_wrapper is
    port (
      ADDR_RAM_IN : in std_logic_vector(0 to 31);
      DQ_O_RAM : in std_logic_vector(0 to 15);
      DQ_T_RAM : in std_logic_vector(0 to 15);
      DQ_I_RAM : out std_logic_vector(0 to 15);
      BEN_RAM_I : in std_logic_vector(0 to 1);
      CEN_RAM_I : in std_logic_vector(0 to 0);
      OEN_RAM_I : in std_logic_vector(0 to 0);
      WEN_RAM_I : in std_logic;
      ADDR_FLASH_IN : in std_logic_vector(0 to 31);
      DQ_O_FLASH : in std_logic_vector(0 to 15);
      DQ_T_FLASH : in std_logic_vector(0 to 15);
      DQ_I_FLASH : out std_logic_vector(0 to 15);
      RPN_FLASH_I : in std_logic;
      CEN_FLASH_I : in std_logic_vector(0 to 0);
      OEN_FLASH_I : in std_logic_vector(0 to 0);
      WEN_FLASH_I : in std_logic;
      C_QUAD_SPI_I : in std_logic;
      S_QUAD_SPI_I : in std_logic;
      DQ_O_QUAD_SPI : in std_logic_vector(3 downto 0);
      DQ_T_QUAD_SPI : in std_logic_vector(3 downto 0);
      DQ_I_QUAD_SPI : out std_logic_vector(3 downto 0);
      MEM_ADDR : out std_logic_vector(0 to 22);
      DQ_O : out std_logic_vector(0 to 15);
      DQ_T : out std_logic_vector(0 to 15);
      DQ_I : in std_logic_vector(0 to 15);
      MEM_OEN : out std_logic;
      MEM_WEN : out std_logic;
      RAM_CEN_O : out std_logic;
      RAM_BEN_O : out std_logic_vector(0 to 1);
      FLASH_ADDR : out std_logic_vector(5 to 7);
      FLASH_CEN_O : out std_logic;
      FLASH_RPN_O : out std_logic;
      QUAD_SPI_C_O : out std_logic;
      QUAD_SPI_S_O : out std_logic;
      MOSI_QUAD_SPI_O : out std_logic;
      MOSI_QUAD_SPI_T : out std_logic;
      MOSI_QUAD_SPI_I : in std_logic
    );
  end component;

  component clock_generator_0_wrapper is
    port (
      CLKIN : in std_logic;
      CLKOUT0 : out std_logic;
      CLKOUT1 : out std_logic;
      CLKOUT2 : out std_logic;
      CLKOUT3 : out std_logic;
      CLKOUT4 : out std_logic;
      CLKOUT5 : out std_logic;
      CLKOUT6 : out std_logic;
      CLKOUT7 : out std_logic;
      CLKOUT8 : out std_logic;
      CLKOUT9 : out std_logic;
      CLKOUT10 : out std_logic;
      CLKOUT11 : out std_logic;
      CLKOUT12 : out std_logic;
      CLKOUT13 : out std_logic;
      CLKOUT14 : out std_logic;
      CLKOUT15 : out std_logic;
      CLKFBIN : in std_logic;
      CLKFBOUT : out std_logic;
      PSCLK : in std_logic;
      PSEN : in std_logic;
      PSINCDEC : in std_logic;
      PSDONE : out std_logic;
      RST : in std_logic;
      LOCKED : out std_logic
    );
  end component;

  component mdm_0_wrapper is
    port (
      Interrupt : out std_logic;
      Debug_SYS_Rst : out std_logic;
      Ext_BRK : out std_logic;
      Ext_NM_BRK : out std_logic;
      S_AXI_ACLK : in std_logic;
      S_AXI_ARESETN : in std_logic;
      S_AXI_AWADDR : in std_logic_vector(31 downto 0);
      S_AXI_AWVALID : in std_logic;
      S_AXI_AWREADY : out std_logic;
      S_AXI_WDATA : in std_logic_vector(31 downto 0);
      S_AXI_WSTRB : in std_logic_vector(3 downto 0);
      S_AXI_WVALID : in std_logic;
      S_AXI_WREADY : out std_logic;
      S_AXI_BRESP : out std_logic_vector(1 downto 0);
      S_AXI_BVALID : out std_logic;
      S_AXI_BREADY : in std_logic;
      S_AXI_ARADDR : in std_logic_vector(31 downto 0);
      S_AXI_ARVALID : in std_logic;
      S_AXI_ARREADY : out std_logic;
      S_AXI_RDATA : out std_logic_vector(31 downto 0);
      S_AXI_RRESP : out std_logic_vector(1 downto 0);
      S_AXI_RVALID : out std_logic;
      S_AXI_RREADY : in std_logic;
      SPLB_Clk : in std_logic;
      SPLB_Rst : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_masterID : in std_logic_vector(0 to 0);
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to 3);
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_lockErr : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to 31);
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to 31);
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdBTerm : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to 1);
      Sl_MWrErr : out std_logic_vector(0 to 1);
      Sl_MRdErr : out std_logic_vector(0 to 1);
      Sl_MIRQ : out std_logic_vector(0 to 1);
      Dbg_Clk_0 : out std_logic;
      Dbg_TDI_0 : out std_logic;
      Dbg_TDO_0 : in std_logic;
      Dbg_Reg_En_0 : out std_logic_vector(0 to 7);
      Dbg_Capture_0 : out std_logic;
      Dbg_Shift_0 : out std_logic;
      Dbg_Update_0 : out std_logic;
      Dbg_Rst_0 : out std_logic;
      Dbg_Clk_1 : out std_logic;
      Dbg_TDI_1 : out std_logic;
      Dbg_TDO_1 : in std_logic;
      Dbg_Reg_En_1 : out std_logic_vector(0 to 7);
      Dbg_Capture_1 : out std_logic;
      Dbg_Shift_1 : out std_logic;
      Dbg_Update_1 : out std_logic;
      Dbg_Rst_1 : out std_logic;
      Dbg_Clk_2 : out std_logic;
      Dbg_TDI_2 : out std_logic;
      Dbg_TDO_2 : in std_logic;
      Dbg_Reg_En_2 : out std_logic_vector(0 to 7);
      Dbg_Capture_2 : out std_logic;
      Dbg_Shift_2 : out std_logic;
      Dbg_Update_2 : out std_logic;
      Dbg_Rst_2 : out std_logic;
      Dbg_Clk_3 : out std_logic;
      Dbg_TDI_3 : out std_logic;
      Dbg_TDO_3 : in std_logic;
      Dbg_Reg_En_3 : out std_logic_vector(0 to 7);
      Dbg_Capture_3 : out std_logic;
      Dbg_Shift_3 : out std_logic;
      Dbg_Update_3 : out std_logic;
      Dbg_Rst_3 : out std_logic;
      Dbg_Clk_4 : out std_logic;
      Dbg_TDI_4 : out std_logic;
      Dbg_TDO_4 : in std_logic;
      Dbg_Reg_En_4 : out std_logic_vector(0 to 7);
      Dbg_Capture_4 : out std_logic;
      Dbg_Shift_4 : out std_logic;
      Dbg_Update_4 : out std_logic;
      Dbg_Rst_4 : out std_logic;
      Dbg_Clk_5 : out std_logic;
      Dbg_TDI_5 : out std_logic;
      Dbg_TDO_5 : in std_logic;
      Dbg_Reg_En_5 : out std_logic_vector(0 to 7);
      Dbg_Capture_5 : out std_logic;
      Dbg_Shift_5 : out std_logic;
      Dbg_Update_5 : out std_logic;
      Dbg_Rst_5 : out std_logic;
      Dbg_Clk_6 : out std_logic;
      Dbg_TDI_6 : out std_logic;
      Dbg_TDO_6 : in std_logic;
      Dbg_Reg_En_6 : out std_logic_vector(0 to 7);
      Dbg_Capture_6 : out std_logic;
      Dbg_Shift_6 : out std_logic;
      Dbg_Update_6 : out std_logic;
      Dbg_Rst_6 : out std_logic;
      Dbg_Clk_7 : out std_logic;
      Dbg_TDI_7 : out std_logic;
      Dbg_TDO_7 : in std_logic;
      Dbg_Reg_En_7 : out std_logic_vector(0 to 7);
      Dbg_Capture_7 : out std_logic;
      Dbg_Shift_7 : out std_logic;
      Dbg_Update_7 : out std_logic;
      Dbg_Rst_7 : out std_logic;
      bscan_tdi : out std_logic;
      bscan_reset : out std_logic;
      bscan_shift : out std_logic;
      bscan_update : out std_logic;
      bscan_capture : out std_logic;
      bscan_sel1 : out std_logic;
      bscan_drck1 : out std_logic;
      bscan_tdo1 : in std_logic;
      Ext_JTAG_DRCK : out std_logic;
      Ext_JTAG_RESET : out std_logic;
      Ext_JTAG_SEL : out std_logic;
      Ext_JTAG_CAPTURE : out std_logic;
      Ext_JTAG_SHIFT : out std_logic;
      Ext_JTAG_UPDATE : out std_logic;
      Ext_JTAG_TDI : out std_logic;
      Ext_JTAG_TDO : in std_logic
    );
  end component;

  component proc_sys_reset_0_wrapper is
    port (
      Slowest_sync_clk : in std_logic;
      Ext_Reset_In : in std_logic;
      Aux_Reset_In : in std_logic;
      MB_Debug_Sys_Rst : in std_logic;
      Core_Reset_Req_0 : in std_logic;
      Chip_Reset_Req_0 : in std_logic;
      System_Reset_Req_0 : in std_logic;
      Core_Reset_Req_1 : in std_logic;
      Chip_Reset_Req_1 : in std_logic;
      System_Reset_Req_1 : in std_logic;
      Dcm_locked : in std_logic;
      RstcPPCresetcore_0 : out std_logic;
      RstcPPCresetchip_0 : out std_logic;
      RstcPPCresetsys_0 : out std_logic;
      RstcPPCresetcore_1 : out std_logic;
      RstcPPCresetchip_1 : out std_logic;
      RstcPPCresetsys_1 : out std_logic;
      MB_Reset : out std_logic;
      Bus_Struct_Reset : out std_logic_vector(0 to 0);
      Peripheral_Reset : out std_logic_vector(0 to 0);
      Interconnect_aresetn : out std_logic_vector(0 to 0);
      Peripheral_aresetn : out std_logic_vector(0 to 0)
    );
  end component;

  component xps_intc_0_wrapper is
    port (
      SPLB_Clk : in std_logic;
      SPLB_Rst : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_masterID : in std_logic_vector(0 to 0);
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to 3);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_wrDBus : in std_logic_vector(0 to 31);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_lockErr : in std_logic;
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to 31);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to 1);
      Sl_MWrErr : out std_logic_vector(0 to 1);
      Sl_MRdErr : out std_logic_vector(0 to 1);
      Sl_wrBTerm : out std_logic;
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdBTerm : out std_logic;
      Sl_MIRQ : out std_logic_vector(0 to 1);
      Intr : in std_logic_vector(2 downto 0);
      Irq : out std_logic
    );
  end component;

  component xps_timer_0_wrapper is
    port (
      CaptureTrig0 : in std_logic;
      CaptureTrig1 : in std_logic;
      GenerateOut0 : out std_logic;
      GenerateOut1 : out std_logic;
      PWM0 : out std_logic;
      Interrupt : out std_logic;
      Freeze : in std_logic;
      SPLB_Clk : in std_logic;
      SPLB_Rst : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_masterID : in std_logic_vector(0 to 0);
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to 3);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_wrDBus : in std_logic_vector(0 to 31);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to 31);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to 1);
      Sl_MWrErr : out std_logic_vector(0 to 1);
      Sl_MRdErr : out std_logic_vector(0 to 1);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_lockErr : in std_logic;
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_wrBTerm : out std_logic;
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdBTerm : out std_logic;
      Sl_MIRQ : out std_logic_vector(0 to 1)
    );
  end component;

  component IOBUF is
    port (
      I : in std_logic;
      IO : inout std_logic;
      O : out std_logic;
      T : in std_logic
    );
  end component;

  -- Internal signals

  signal CLK_S : std_logic;
  signal Dcm_all_locked : std_logic;
  signal Debug_SYS_Rst : std_logic;
  signal Ethernet_Lite_IP2INTC_Irpt : std_logic;
  signal Ext_BRK : std_logic;
  signal Ext_NM_BRK : std_logic;
  signal RS232_Uart_1_Interrupt : std_logic;
  signal clk_66_6667MHz : std_logic;
  signal dlmb_LMB_ABus : std_logic_vector(0 to 31);
  signal dlmb_LMB_AddrStrobe : std_logic;
  signal dlmb_LMB_BE : std_logic_vector(0 to 3);
  signal dlmb_LMB_CE : std_logic;
  signal dlmb_LMB_ReadDBus : std_logic_vector(0 to 31);
  signal dlmb_LMB_ReadStrobe : std_logic;
  signal dlmb_LMB_Ready : std_logic;
  signal dlmb_LMB_Rst : std_logic;
  signal dlmb_LMB_UE : std_logic;
  signal dlmb_LMB_Wait : std_logic;
  signal dlmb_LMB_WriteDBus : std_logic_vector(0 to 31);
  signal dlmb_LMB_WriteStrobe : std_logic;
  signal dlmb_M_ABus : std_logic_vector(0 to 31);
  signal dlmb_M_AddrStrobe : std_logic;
  signal dlmb_M_BE : std_logic_vector(0 to 3);
  signal dlmb_M_DBus : std_logic_vector(0 to 31);
  signal dlmb_M_ReadStrobe : std_logic;
  signal dlmb_M_WriteStrobe : std_logic;
  signal dlmb_Sl_CE : std_logic_vector(0 to 0);
  signal dlmb_Sl_DBus : std_logic_vector(0 to 31);
  signal dlmb_Sl_Ready : std_logic_vector(0 to 0);
  signal dlmb_Sl_UE : std_logic_vector(0 to 0);
  signal dlmb_Sl_Wait : std_logic_vector(0 to 0);
  signal dlmb_port_BRAM_Addr : std_logic_vector(0 to 31);
  signal dlmb_port_BRAM_Clk : std_logic;
  signal dlmb_port_BRAM_Din : std_logic_vector(0 to 31);
  signal dlmb_port_BRAM_Dout : std_logic_vector(0 to 31);
  signal dlmb_port_BRAM_EN : std_logic;
  signal dlmb_port_BRAM_Rst : std_logic;
  signal dlmb_port_BRAM_WEN : std_logic_vector(0 to 3);
  signal fpga_0_Ethernet_Lite_PHY_MDIO_pin_I : std_logic;
  signal fpga_0_Ethernet_Lite_PHY_MDIO_pin_O : std_logic;
  signal fpga_0_Ethernet_Lite_PHY_MDIO_pin_T : std_logic;
  signal fpga_0_mem_bus_mux_0_DQ_pin_I : std_logic_vector(0 to 15);
  signal fpga_0_mem_bus_mux_0_DQ_pin_O : std_logic_vector(0 to 15);
  signal fpga_0_mem_bus_mux_0_DQ_pin_T : std_logic_vector(0 to 15);
  signal fpga_0_mem_bus_mux_0_MOSI_QUAD_SPI_pin_I : std_logic;
  signal fpga_0_mem_bus_mux_0_MOSI_QUAD_SPI_pin_O : std_logic;
  signal fpga_0_mem_bus_mux_0_MOSI_QUAD_SPI_pin_T : std_logic;
  signal ilmb_LMB_ABus : std_logic_vector(0 to 31);
  signal ilmb_LMB_AddrStrobe : std_logic;
  signal ilmb_LMB_BE : std_logic_vector(0 to 3);
  signal ilmb_LMB_CE : std_logic;
  signal ilmb_LMB_ReadDBus : std_logic_vector(0 to 31);
  signal ilmb_LMB_ReadStrobe : std_logic;
  signal ilmb_LMB_Ready : std_logic;
  signal ilmb_LMB_Rst : std_logic;
  signal ilmb_LMB_UE : std_logic;
  signal ilmb_LMB_Wait : std_logic;
  signal ilmb_LMB_WriteDBus : std_logic_vector(0 to 31);
  signal ilmb_LMB_WriteStrobe : std_logic;
  signal ilmb_M_ABus : std_logic_vector(0 to 31);
  signal ilmb_M_AddrStrobe : std_logic;
  signal ilmb_M_ReadStrobe : std_logic;
  signal ilmb_Sl_CE : std_logic_vector(0 to 0);
  signal ilmb_Sl_DBus : std_logic_vector(0 to 31);
  signal ilmb_Sl_Ready : std_logic_vector(0 to 0);
  signal ilmb_Sl_UE : std_logic_vector(0 to 0);
  signal ilmb_Sl_Wait : std_logic_vector(0 to 0);
  signal ilmb_port_BRAM_Addr : std_logic_vector(0 to 31);
  signal ilmb_port_BRAM_Clk : std_logic;
  signal ilmb_port_BRAM_Din : std_logic_vector(0 to 31);
  signal ilmb_port_BRAM_Dout : std_logic_vector(0 to 31);
  signal ilmb_port_BRAM_EN : std_logic;
  signal ilmb_port_BRAM_Rst : std_logic;
  signal ilmb_port_BRAM_WEN : std_logic_vector(0 to 3);
  signal mb_plb_M_ABort : std_logic_vector(0 to 1);
  signal mb_plb_M_ABus : std_logic_vector(0 to 63);
  signal mb_plb_M_BE : std_logic_vector(0 to 7);
  signal mb_plb_M_MSize : std_logic_vector(0 to 3);
  signal mb_plb_M_RNW : std_logic_vector(0 to 1);
  signal mb_plb_M_TAttribute : std_logic_vector(0 to 31);
  signal mb_plb_M_UABus : std_logic_vector(0 to 63);
  signal mb_plb_M_busLock : std_logic_vector(0 to 1);
  signal mb_plb_M_lockErr : std_logic_vector(0 to 1);
  signal mb_plb_M_priority : std_logic_vector(0 to 3);
  signal mb_plb_M_rdBurst : std_logic_vector(0 to 1);
  signal mb_plb_M_request : std_logic_vector(0 to 1);
  signal mb_plb_M_size : std_logic_vector(0 to 7);
  signal mb_plb_M_type : std_logic_vector(0 to 5);
  signal mb_plb_M_wrBurst : std_logic_vector(0 to 1);
  signal mb_plb_M_wrDBus : std_logic_vector(0 to 63);
  signal mb_plb_PLB_ABus : std_logic_vector(0 to 31);
  signal mb_plb_PLB_BE : std_logic_vector(0 to 3);
  signal mb_plb_PLB_MAddrAck : std_logic_vector(0 to 1);
  signal mb_plb_PLB_MBusy : std_logic_vector(0 to 1);
  signal mb_plb_PLB_MIRQ : std_logic_vector(0 to 1);
  signal mb_plb_PLB_MRdBTerm : std_logic_vector(0 to 1);
  signal mb_plb_PLB_MRdDAck : std_logic_vector(0 to 1);
  signal mb_plb_PLB_MRdDBus : std_logic_vector(0 to 63);
  signal mb_plb_PLB_MRdErr : std_logic_vector(0 to 1);
  signal mb_plb_PLB_MRdWdAddr : std_logic_vector(0 to 7);
  signal mb_plb_PLB_MRearbitrate : std_logic_vector(0 to 1);
  signal mb_plb_PLB_MSSize : std_logic_vector(0 to 3);
  signal mb_plb_PLB_MSize : std_logic_vector(0 to 1);
  signal mb_plb_PLB_MTimeout : std_logic_vector(0 to 1);
  signal mb_plb_PLB_MWrBTerm : std_logic_vector(0 to 1);
  signal mb_plb_PLB_MWrDAck : std_logic_vector(0 to 1);
  signal mb_plb_PLB_MWrErr : std_logic_vector(0 to 1);
  signal mb_plb_PLB_PAValid : std_logic;
  signal mb_plb_PLB_RNW : std_logic;
  signal mb_plb_PLB_SAValid : std_logic;
  signal mb_plb_PLB_TAttribute : std_logic_vector(0 to 15);
  signal mb_plb_PLB_UABus : std_logic_vector(0 to 31);
  signal mb_plb_PLB_abort : std_logic;
  signal mb_plb_PLB_busLock : std_logic;
  signal mb_plb_PLB_lockErr : std_logic;
  signal mb_plb_PLB_masterID : std_logic_vector(0 to 0);
  signal mb_plb_PLB_rdBurst : std_logic;
  signal mb_plb_PLB_rdPendPri : std_logic_vector(0 to 1);
  signal mb_plb_PLB_rdPendReq : std_logic;
  signal mb_plb_PLB_rdPrim : std_logic_vector(0 to 10);
  signal mb_plb_PLB_reqPri : std_logic_vector(0 to 1);
  signal mb_plb_PLB_size : std_logic_vector(0 to 3);
  signal mb_plb_PLB_type : std_logic_vector(0 to 2);
  signal mb_plb_PLB_wrBurst : std_logic;
  signal mb_plb_PLB_wrDBus : std_logic_vector(0 to 31);
  signal mb_plb_PLB_wrPendPri : std_logic_vector(0 to 1);
  signal mb_plb_PLB_wrPendReq : std_logic;
  signal mb_plb_PLB_wrPrim : std_logic_vector(0 to 10);
  signal mb_plb_SPLB_Rst : std_logic_vector(0 to 10);
  signal mb_plb_Sl_MBusy : std_logic_vector(0 to 21);
  signal mb_plb_Sl_MIRQ : std_logic_vector(0 to 21);
  signal mb_plb_Sl_MRdErr : std_logic_vector(0 to 21);
  signal mb_plb_Sl_MWrErr : std_logic_vector(0 to 21);
  signal mb_plb_Sl_SSize : std_logic_vector(0 to 21);
  signal mb_plb_Sl_addrAck : std_logic_vector(0 to 10);
  signal mb_plb_Sl_rdBTerm : std_logic_vector(0 to 10);
  signal mb_plb_Sl_rdComp : std_logic_vector(0 to 10);
  signal mb_plb_Sl_rdDAck : std_logic_vector(0 to 10);
  signal mb_plb_Sl_rdDBus : std_logic_vector(0 to 351);
  signal mb_plb_Sl_rdWdAddr : std_logic_vector(0 to 43);
  signal mb_plb_Sl_rearbitrate : std_logic_vector(0 to 10);
  signal mb_plb_Sl_wait : std_logic_vector(0 to 10);
  signal mb_plb_Sl_wrBTerm : std_logic_vector(0 to 10);
  signal mb_plb_Sl_wrComp : std_logic_vector(0 to 10);
  signal mb_plb_Sl_wrDAck : std_logic_vector(0 to 10);
  signal mb_reset : std_logic;
  signal microblaze_0_DXCL_FSL_M_Control : std_logic;
  signal microblaze_0_DXCL_FSL_M_Data : std_logic_vector(0 to 31);
  signal microblaze_0_DXCL_FSL_M_Full : std_logic;
  signal microblaze_0_DXCL_FSL_M_Write : std_logic;
  signal microblaze_0_DXCL_FSL_S_Control : std_logic;
  signal microblaze_0_DXCL_FSL_S_Data : std_logic_vector(0 to 31);
  signal microblaze_0_DXCL_FSL_S_Exists : std_logic;
  signal microblaze_0_DXCL_FSL_S_Read : std_logic;
  signal microblaze_0_IXCL_FSL_M_Control : std_logic;
  signal microblaze_0_IXCL_FSL_M_Data : std_logic_vector(0 to 31);
  signal microblaze_0_IXCL_FSL_M_Full : std_logic;
  signal microblaze_0_IXCL_FSL_M_Write : std_logic;
  signal microblaze_0_IXCL_FSL_S_Control : std_logic;
  signal microblaze_0_IXCL_FSL_S_Data : std_logic_vector(0 to 31);
  signal microblaze_0_IXCL_FSL_S_Exists : std_logic;
  signal microblaze_0_IXCL_FSL_S_Read : std_logic;
  signal microblaze_0_Interrupt : std_logic;
  signal microblaze_0_mdm_bus_Dbg_Capture : std_logic;
  signal microblaze_0_mdm_bus_Dbg_Clk : std_logic;
  signal microblaze_0_mdm_bus_Dbg_Reg_En : std_logic_vector(0 to 7);
  signal microblaze_0_mdm_bus_Dbg_Shift : std_logic;
  signal microblaze_0_mdm_bus_Dbg_TDI : std_logic;
  signal microblaze_0_mdm_bus_Dbg_TDO : std_logic;
  signal microblaze_0_mdm_bus_Dbg_Update : std_logic;
  signal microblaze_0_mdm_bus_Debug_Rst : std_logic;
  signal net_bsbassign0 : std_logic_vector(0 to 31);
  signal net_bsbassign32 : std_logic_vector(0 to 1);
  signal net_bsbassign34 : std_logic_vector(0 to 0);
  signal net_bsbassign35 : std_logic_vector(0 to 15);
  signal net_bsbassign51 : std_logic_vector(0 to 15);
  signal net_bsbassign67 : std_logic_vector(0 to 15);
  signal net_bsbassign83 : std_logic_vector(0 to 0);
  signal net_bsbassign84 : std_logic;
  signal net_bsbassign85 : std_logic_vector(0 to 31);
  signal net_bsbassign116 : std_logic_vector(0 to 0);
  signal net_bsbassign117 : std_logic_vector(0 to 15);
  signal net_bsbassign133 : std_logic_vector(0 to 15);
  signal net_bsbassign149 : std_logic_vector(0 to 15);
  signal net_bsbassign165 : std_logic_vector(0 to 0);
  signal net_bsbassign166 : std_logic;
  signal net_bsbassign167 : std_logic;
  signal net_bsbassign168 : std_logic;
  signal net_bsbassign169 : std_logic_vector(3 downto 0);
  signal net_bsbassign173 : std_logic_vector(3 downto 0);
  signal net_bsbassign177 : std_logic_vector(3 downto 0);
  signal net_bsbassign181 : std_logic;
  signal net_gnd0 : std_logic;
  signal net_gnd1 : std_logic_vector(0 downto 0);
  signal net_gnd2 : std_logic_vector(1 downto 0);
  signal net_gnd3 : std_logic_vector(0 to 2);
  signal net_gnd4 : std_logic_vector(0 to 3);
  signal net_gnd8 : std_logic_vector(0 to 7);
  signal net_gnd10 : std_logic_vector(0 to 9);
  signal net_gnd16 : std_logic_vector(0 to 15);
  signal net_gnd32 : std_logic_vector(0 to 31);
  signal net_vcc0 : std_logic;
  signal pgassign1 : std_logic_vector(2 downto 0);
  signal sys_bus_reset : std_logic_vector(0 to 0);
  signal sys_rst_s : std_logic;
  signal xps_timer_0_Interrupt : std_logic;

  attribute BUFFER_TYPE : STRING;
  attribute BOX_TYPE : STRING;
  attribute BUFFER_TYPE of fpga_0_Ethernet_Lite_PHY_tx_clk_pin : signal is "IBUF";
  attribute BUFFER_TYPE of fpga_0_Ethernet_Lite_PHY_rx_clk_pin : signal is "IBUF";
  attribute BOX_TYPE of microblaze_0_wrapper : component is "user_black_box";
  attribute BOX_TYPE of mb_plb_wrapper : component is "user_black_box";
  attribute BOX_TYPE of ilmb_wrapper : component is "user_black_box";
  attribute BOX_TYPE of dlmb_wrapper : component is "user_black_box";
  attribute BOX_TYPE of dlmb_cntlr_wrapper : component is "user_black_box";
  attribute BOX_TYPE of ilmb_cntlr_wrapper : component is "user_black_box";
  attribute BOX_TYPE of lmb_bram_wrapper : component is "user_black_box";
  attribute BOX_TYPE of rs232_uart_1_wrapper : component is "user_black_box";
  attribute BOX_TYPE of leds_8bits_wrapper : component is "user_black_box";
  attribute BOX_TYPE of push_buttons_4bits_wrapper : component is "user_black_box";
  attribute BOX_TYPE of ethernet_lite_wrapper : component is "user_black_box";
  attribute BOX_TYPE of micron_ram_wrapper : component is "user_black_box";
  attribute BOX_TYPE of numonyx_pcm_wrapper : component is "user_black_box";
  attribute BOX_TYPE of digilent_quadspi_cntlr_wrapper : component is "user_black_box";
  attribute BOX_TYPE of digilent_sevseg_disp_wrapper : component is "user_black_box";
  attribute BOX_TYPE of mem_bus_mux_0_wrapper : component is "user_black_box";
  attribute BOX_TYPE of clock_generator_0_wrapper : component is "user_black_box";
  attribute BOX_TYPE of mdm_0_wrapper : component is "user_black_box";
  attribute BOX_TYPE of proc_sys_reset_0_wrapper : component is "user_black_box";
  attribute BOX_TYPE of xps_intc_0_wrapper : component is "user_black_box";
  attribute BOX_TYPE of xps_timer_0_wrapper : component is "user_black_box";

begin

  -- Internal assignments

  CLK_S <= fpga_0_clk_1_sys_clk_pin;
  sys_rst_s <= fpga_0_rst_1_sys_rst_pin;
  pgassign1(2) <= RS232_Uart_1_Interrupt;
  pgassign1(1) <= Ethernet_Lite_IP2INTC_Irpt;
  pgassign1(0) <= xps_timer_0_Interrupt;
  net_gnd0 <= '0';
  net_gnd1(0 downto 0) <= B"0";
  net_gnd10(0 to 9) <= B"0000000000";
  net_gnd16(0 to 15) <= B"0000000000000000";
  net_gnd2(1 downto 0) <= B"00";
  net_gnd3(0 to 2) <= B"000";
  net_gnd32(0 to 31) <= B"00000000000000000000000000000000";
  net_gnd4(0 to 3) <= B"0000";
  net_gnd8(0 to 7) <= B"00000000";
  net_vcc0 <= '1';

  microblaze_0 : microblaze_0_wrapper
    port map (
      CLK => clk_66_6667MHz,
      RESET => dlmb_LMB_Rst,
      MB_RESET => mb_reset,
      INTERRUPT => microblaze_0_Interrupt,
      EXT_BRK => Ext_BRK,
      EXT_NM_BRK => Ext_NM_BRK,
      DBG_STOP => net_gnd0,
      MB_Halted => open,
      MB_Error => open,
      INSTR => ilmb_LMB_ReadDBus,
      IREADY => ilmb_LMB_Ready,
      IWAIT => ilmb_LMB_Wait,
      ICE => ilmb_LMB_CE,
      IUE => ilmb_LMB_UE,
      INSTR_ADDR => ilmb_M_ABus,
      IFETCH => ilmb_M_ReadStrobe,
      I_AS => ilmb_M_AddrStrobe,
      IPLB_M_ABort => mb_plb_M_ABort(1),
      IPLB_M_ABus => mb_plb_M_ABus(32 to 63),
      IPLB_M_UABus => mb_plb_M_UABus(32 to 63),
      IPLB_M_BE => mb_plb_M_BE(4 to 7),
      IPLB_M_busLock => mb_plb_M_busLock(1),
      IPLB_M_lockErr => mb_plb_M_lockErr(1),
      IPLB_M_MSize => mb_plb_M_MSize(2 to 3),
      IPLB_M_priority => mb_plb_M_priority(2 to 3),
      IPLB_M_rdBurst => mb_plb_M_rdBurst(1),
      IPLB_M_request => mb_plb_M_request(1),
      IPLB_M_RNW => mb_plb_M_RNW(1),
      IPLB_M_size => mb_plb_M_size(4 to 7),
      IPLB_M_TAttribute => mb_plb_M_TAttribute(16 to 31),
      IPLB_M_type => mb_plb_M_type(3 to 5),
      IPLB_M_wrBurst => mb_plb_M_wrBurst(1),
      IPLB_M_wrDBus => mb_plb_M_wrDBus(32 to 63),
      IPLB_MBusy => mb_plb_PLB_MBusy(1),
      IPLB_MRdErr => mb_plb_PLB_MRdErr(1),
      IPLB_MWrErr => mb_plb_PLB_MWrErr(1),
      IPLB_MIRQ => mb_plb_PLB_MIRQ(1),
      IPLB_MWrBTerm => mb_plb_PLB_MWrBTerm(1),
      IPLB_MWrDAck => mb_plb_PLB_MWrDAck(1),
      IPLB_MAddrAck => mb_plb_PLB_MAddrAck(1),
      IPLB_MRdBTerm => mb_plb_PLB_MRdBTerm(1),
      IPLB_MRdDAck => mb_plb_PLB_MRdDAck(1),
      IPLB_MRdDBus => mb_plb_PLB_MRdDBus(32 to 63),
      IPLB_MRdWdAddr => mb_plb_PLB_MRdWdAddr(4 to 7),
      IPLB_MRearbitrate => mb_plb_PLB_MRearbitrate(1),
      IPLB_MSSize => mb_plb_PLB_MSSize(2 to 3),
      IPLB_MTimeout => mb_plb_PLB_MTimeout(1),
      DATA_READ => dlmb_LMB_ReadDBus,
      DREADY => dlmb_LMB_Ready,
      DWAIT => dlmb_LMB_Wait,
      DCE => dlmb_LMB_CE,
      DUE => dlmb_LMB_UE,
      DATA_WRITE => dlmb_M_DBus,
      DATA_ADDR => dlmb_M_ABus,
      D_AS => dlmb_M_AddrStrobe,
      READ_STROBE => dlmb_M_ReadStrobe,
      WRITE_STROBE => dlmb_M_WriteStrobe,
      BYTE_ENABLE => dlmb_M_BE,
      DPLB_M_ABort => mb_plb_M_ABort(0),
      DPLB_M_ABus => mb_plb_M_ABus(0 to 31),
      DPLB_M_UABus => mb_plb_M_UABus(0 to 31),
      DPLB_M_BE => mb_plb_M_BE(0 to 3),
      DPLB_M_busLock => mb_plb_M_busLock(0),
      DPLB_M_lockErr => mb_plb_M_lockErr(0),
      DPLB_M_MSize => mb_plb_M_MSize(0 to 1),
      DPLB_M_priority => mb_plb_M_priority(0 to 1),
      DPLB_M_rdBurst => mb_plb_M_rdBurst(0),
      DPLB_M_request => mb_plb_M_request(0),
      DPLB_M_RNW => mb_plb_M_RNW(0),
      DPLB_M_size => mb_plb_M_size(0 to 3),
      DPLB_M_TAttribute => mb_plb_M_TAttribute(0 to 15),
      DPLB_M_type => mb_plb_M_type(0 to 2),
      DPLB_M_wrBurst => mb_plb_M_wrBurst(0),
      DPLB_M_wrDBus => mb_plb_M_wrDBus(0 to 31),
      DPLB_MBusy => mb_plb_PLB_MBusy(0),
      DPLB_MRdErr => mb_plb_PLB_MRdErr(0),
      DPLB_MWrErr => mb_plb_PLB_MWrErr(0),
      DPLB_MIRQ => mb_plb_PLB_MIRQ(0),
      DPLB_MWrBTerm => mb_plb_PLB_MWrBTerm(0),
      DPLB_MWrDAck => mb_plb_PLB_MWrDAck(0),
      DPLB_MAddrAck => mb_plb_PLB_MAddrAck(0),
      DPLB_MRdBTerm => mb_plb_PLB_MRdBTerm(0),
      DPLB_MRdDAck => mb_plb_PLB_MRdDAck(0),
      DPLB_MRdDBus => mb_plb_PLB_MRdDBus(0 to 31),
      DPLB_MRdWdAddr => mb_plb_PLB_MRdWdAddr(0 to 3),
      DPLB_MRearbitrate => mb_plb_PLB_MRearbitrate(0),
      DPLB_MSSize => mb_plb_PLB_MSSize(0 to 1),
      DPLB_MTimeout => mb_plb_PLB_MTimeout(0),
      M_AXI_IP_AWID => open,
      M_AXI_IP_AWADDR => open,
      M_AXI_IP_AWLEN => open,
      M_AXI_IP_AWSIZE => open,
      M_AXI_IP_AWBURST => open,
      M_AXI_IP_AWLOCK => open,
      M_AXI_IP_AWCACHE => open,
      M_AXI_IP_AWPROT => open,
      M_AXI_IP_AWQOS => open,
      M_AXI_IP_AWVALID => open,
      M_AXI_IP_AWREADY => net_gnd0,
      M_AXI_IP_WDATA => open,
      M_AXI_IP_WSTRB => open,
      M_AXI_IP_WLAST => open,
      M_AXI_IP_WVALID => open,
      M_AXI_IP_WREADY => net_gnd0,
      M_AXI_IP_BID => net_gnd1(0 downto 0),
      M_AXI_IP_BRESP => net_gnd2,
      M_AXI_IP_BVALID => net_gnd0,
      M_AXI_IP_BREADY => open,
      M_AXI_IP_ARID => open,
      M_AXI_IP_ARADDR => open,
      M_AXI_IP_ARLEN => open,
      M_AXI_IP_ARSIZE => open,
      M_AXI_IP_ARBURST => open,
      M_AXI_IP_ARLOCK => open,
      M_AXI_IP_ARCACHE => open,
      M_AXI_IP_ARPROT => open,
      M_AXI_IP_ARQOS => open,
      M_AXI_IP_ARVALID => open,
      M_AXI_IP_ARREADY => net_gnd0,
      M_AXI_IP_RID => net_gnd1(0 downto 0),
      M_AXI_IP_RDATA => net_gnd32(0 to 31),
      M_AXI_IP_RRESP => net_gnd2,
      M_AXI_IP_RLAST => net_gnd0,
      M_AXI_IP_RVALID => net_gnd0,
      M_AXI_IP_RREADY => open,
      M_AXI_DP_AWID => open,
      M_AXI_DP_AWADDR => open,
      M_AXI_DP_AWLEN => open,
      M_AXI_DP_AWSIZE => open,
      M_AXI_DP_AWBURST => open,
      M_AXI_DP_AWLOCK => open,
      M_AXI_DP_AWCACHE => open,
      M_AXI_DP_AWPROT => open,
      M_AXI_DP_AWQOS => open,
      M_AXI_DP_AWVALID => open,
      M_AXI_DP_AWREADY => net_gnd0,
      M_AXI_DP_WDATA => open,
      M_AXI_DP_WSTRB => open,
      M_AXI_DP_WLAST => open,
      M_AXI_DP_WVALID => open,
      M_AXI_DP_WREADY => net_gnd0,
      M_AXI_DP_BID => net_gnd1(0 downto 0),
      M_AXI_DP_BRESP => net_gnd2,
      M_AXI_DP_BVALID => net_gnd0,
      M_AXI_DP_BREADY => open,
      M_AXI_DP_ARID => open,
      M_AXI_DP_ARADDR => open,
      M_AXI_DP_ARLEN => open,
      M_AXI_DP_ARSIZE => open,
      M_AXI_DP_ARBURST => open,
      M_AXI_DP_ARLOCK => open,
      M_AXI_DP_ARCACHE => open,
      M_AXI_DP_ARPROT => open,
      M_AXI_DP_ARQOS => open,
      M_AXI_DP_ARVALID => open,
      M_AXI_DP_ARREADY => net_gnd0,
      M_AXI_DP_RID => net_gnd1(0 downto 0),
      M_AXI_DP_RDATA => net_gnd32(0 to 31),
      M_AXI_DP_RRESP => net_gnd2,
      M_AXI_DP_RLAST => net_gnd0,
      M_AXI_DP_RVALID => net_gnd0,
      M_AXI_DP_RREADY => open,
      M_AXI_IC_AWID => open,
      M_AXI_IC_AWADDR => open,
      M_AXI_IC_AWLEN => open,
      M_AXI_IC_AWSIZE => open,
      M_AXI_IC_AWBURST => open,
      M_AXI_IC_AWLOCK => open,
      M_AXI_IC_AWCACHE => open,
      M_AXI_IC_AWPROT => open,
      M_AXI_IC_AWQOS => open,
      M_AXI_IC_AWVALID => open,
      M_AXI_IC_AWREADY => net_gnd0,
      M_AXI_IC_AWUSER => open,
      M_AXI_IC_WDATA => open,
      M_AXI_IC_WSTRB => open,
      M_AXI_IC_WLAST => open,
      M_AXI_IC_WVALID => open,
      M_AXI_IC_WREADY => net_gnd0,
      M_AXI_IC_WUSER => open,
      M_AXI_IC_BID => net_gnd1(0 downto 0),
      M_AXI_IC_BRESP => net_gnd2,
      M_AXI_IC_BVALID => net_gnd0,
      M_AXI_IC_BREADY => open,
      M_AXI_IC_BUSER => net_gnd1(0 downto 0),
      M_AXI_IC_ARID => open,
      M_AXI_IC_ARADDR => open,
      M_AXI_IC_ARLEN => open,
      M_AXI_IC_ARSIZE => open,
      M_AXI_IC_ARBURST => open,
      M_AXI_IC_ARLOCK => open,
      M_AXI_IC_ARCACHE => open,
      M_AXI_IC_ARPROT => open,
      M_AXI_IC_ARQOS => open,
      M_AXI_IC_ARVALID => open,
      M_AXI_IC_ARREADY => net_gnd0,
      M_AXI_IC_ARUSER => open,
      M_AXI_IC_RID => net_gnd1(0 downto 0),
      M_AXI_IC_RDATA => net_gnd32(0 to 31),
      M_AXI_IC_RRESP => net_gnd2,
      M_AXI_IC_RLAST => net_gnd0,
      M_AXI_IC_RVALID => net_gnd0,
      M_AXI_IC_RREADY => open,
      M_AXI_IC_RUSER => net_gnd1(0 downto 0),
      M_AXI_DC_AWID => open,
      M_AXI_DC_AWADDR => open,
      M_AXI_DC_AWLEN => open,
      M_AXI_DC_AWSIZE => open,
      M_AXI_DC_AWBURST => open,
      M_AXI_DC_AWLOCK => open,
      M_AXI_DC_AWCACHE => open,
      M_AXI_DC_AWPROT => open,
      M_AXI_DC_AWQOS => open,
      M_AXI_DC_AWVALID => open,
      M_AXI_DC_AWREADY => net_gnd0,
      M_AXI_DC_AWUSER => open,
      M_AXI_DC_WDATA => open,
      M_AXI_DC_WSTRB => open,
      M_AXI_DC_WLAST => open,
      M_AXI_DC_WVALID => open,
      M_AXI_DC_WREADY => net_gnd0,
      M_AXI_DC_WUSER => open,
      M_AXI_DC_BID => net_gnd1(0 downto 0),
      M_AXI_DC_BRESP => net_gnd2,
      M_AXI_DC_BVALID => net_gnd0,
      M_AXI_DC_BREADY => open,
      M_AXI_DC_BUSER => net_gnd1(0 downto 0),
      M_AXI_DC_ARID => open,
      M_AXI_DC_ARADDR => open,
      M_AXI_DC_ARLEN => open,
      M_AXI_DC_ARSIZE => open,
      M_AXI_DC_ARBURST => open,
      M_AXI_DC_ARLOCK => open,
      M_AXI_DC_ARCACHE => open,
      M_AXI_DC_ARPROT => open,
      M_AXI_DC_ARQOS => open,
      M_AXI_DC_ARVALID => open,
      M_AXI_DC_ARREADY => net_gnd0,
      M_AXI_DC_ARUSER => open,
      M_AXI_DC_RID => net_gnd1(0 downto 0),
      M_AXI_DC_RDATA => net_gnd32(0 to 31),
      M_AXI_DC_RRESP => net_gnd2,
      M_AXI_DC_RLAST => net_gnd0,
      M_AXI_DC_RVALID => net_gnd0,
      M_AXI_DC_RREADY => open,
      M_AXI_DC_RUSER => net_gnd1(0 downto 0),
      DBG_CLK => microblaze_0_mdm_bus_Dbg_Clk,
      DBG_TDI => microblaze_0_mdm_bus_Dbg_TDI,
      DBG_TDO => microblaze_0_mdm_bus_Dbg_TDO,
      DBG_REG_EN => microblaze_0_mdm_bus_Dbg_Reg_En,
      DBG_SHIFT => microblaze_0_mdm_bus_Dbg_Shift,
      DBG_CAPTURE => microblaze_0_mdm_bus_Dbg_Capture,
      DBG_UPDATE => microblaze_0_mdm_bus_Dbg_Update,
      DEBUG_RST => microblaze_0_mdm_bus_Debug_Rst,
      Trace_Instruction => open,
      Trace_Valid_Instr => open,
      Trace_PC => open,
      Trace_Reg_Write => open,
      Trace_Reg_Addr => open,
      Trace_MSR_Reg => open,
      Trace_PID_Reg => open,
      Trace_New_Reg_Value => open,
      Trace_Exception_Taken => open,
      Trace_Exception_Kind => open,
      Trace_Jump_Taken => open,
      Trace_Delay_Slot => open,
      Trace_Data_Address => open,
      Trace_Data_Access => open,
      Trace_Data_Read => open,
      Trace_Data_Write => open,
      Trace_Data_Write_Value => open,
      Trace_Data_Byte_Enable => open,
      Trace_DCache_Req => open,
      Trace_DCache_Hit => open,
      Trace_DCache_Rdy => open,
      Trace_DCache_Read => open,
      Trace_ICache_Req => open,
      Trace_ICache_Hit => open,
      Trace_ICache_Rdy => open,
      Trace_OF_PipeRun => open,
      Trace_EX_PipeRun => open,
      Trace_MEM_PipeRun => open,
      Trace_MB_Halted => open,
      Trace_Jump_Hit => open,
      FSL0_S_CLK => open,
      FSL0_S_READ => open,
      FSL0_S_DATA => net_gnd32,
      FSL0_S_CONTROL => net_gnd0,
      FSL0_S_EXISTS => net_gnd0,
      FSL0_M_CLK => open,
      FSL0_M_WRITE => open,
      FSL0_M_DATA => open,
      FSL0_M_CONTROL => open,
      FSL0_M_FULL => net_gnd0,
      FSL1_S_CLK => open,
      FSL1_S_READ => open,
      FSL1_S_DATA => net_gnd32,
      FSL1_S_CONTROL => net_gnd0,
      FSL1_S_EXISTS => net_gnd0,
      FSL1_M_CLK => open,
      FSL1_M_WRITE => open,
      FSL1_M_DATA => open,
      FSL1_M_CONTROL => open,
      FSL1_M_FULL => net_gnd0,
      FSL2_S_CLK => open,
      FSL2_S_READ => open,
      FSL2_S_DATA => net_gnd32,
      FSL2_S_CONTROL => net_gnd0,
      FSL2_S_EXISTS => net_gnd0,
      FSL2_M_CLK => open,
      FSL2_M_WRITE => open,
      FSL2_M_DATA => open,
      FSL2_M_CONTROL => open,
      FSL2_M_FULL => net_gnd0,
      FSL3_S_CLK => open,
      FSL3_S_READ => open,
      FSL3_S_DATA => net_gnd32,
      FSL3_S_CONTROL => net_gnd0,
      FSL3_S_EXISTS => net_gnd0,
      FSL3_M_CLK => open,
      FSL3_M_WRITE => open,
      FSL3_M_DATA => open,
      FSL3_M_CONTROL => open,
      FSL3_M_FULL => net_gnd0,
      FSL4_S_CLK => open,
      FSL4_S_READ => open,
      FSL4_S_DATA => net_gnd32,
      FSL4_S_CONTROL => net_gnd0,
      FSL4_S_EXISTS => net_gnd0,
      FSL4_M_CLK => open,
      FSL4_M_WRITE => open,
      FSL4_M_DATA => open,
      FSL4_M_CONTROL => open,
      FSL4_M_FULL => net_gnd0,
      FSL5_S_CLK => open,
      FSL5_S_READ => open,
      FSL5_S_DATA => net_gnd32,
      FSL5_S_CONTROL => net_gnd0,
      FSL5_S_EXISTS => net_gnd0,
      FSL5_M_CLK => open,
      FSL5_M_WRITE => open,
      FSL5_M_DATA => open,
      FSL5_M_CONTROL => open,
      FSL5_M_FULL => net_gnd0,
      FSL6_S_CLK => open,
      FSL6_S_READ => open,
      FSL6_S_DATA => net_gnd32,
      FSL6_S_CONTROL => net_gnd0,
      FSL6_S_EXISTS => net_gnd0,
      FSL6_M_CLK => open,
      FSL6_M_WRITE => open,
      FSL6_M_DATA => open,
      FSL6_M_CONTROL => open,
      FSL6_M_FULL => net_gnd0,
      FSL7_S_CLK => open,
      FSL7_S_READ => open,
      FSL7_S_DATA => net_gnd32,
      FSL7_S_CONTROL => net_gnd0,
      FSL7_S_EXISTS => net_gnd0,
      FSL7_M_CLK => open,
      FSL7_M_WRITE => open,
      FSL7_M_DATA => open,
      FSL7_M_CONTROL => open,
      FSL7_M_FULL => net_gnd0,
      FSL8_S_CLK => open,
      FSL8_S_READ => open,
      FSL8_S_DATA => net_gnd32,
      FSL8_S_CONTROL => net_gnd0,
      FSL8_S_EXISTS => net_gnd0,
      FSL8_M_CLK => open,
      FSL8_M_WRITE => open,
      FSL8_M_DATA => open,
      FSL8_M_CONTROL => open,
      FSL8_M_FULL => net_gnd0,
      FSL9_S_CLK => open,
      FSL9_S_READ => open,
      FSL9_S_DATA => net_gnd32,
      FSL9_S_CONTROL => net_gnd0,
      FSL9_S_EXISTS => net_gnd0,
      FSL9_M_CLK => open,
      FSL9_M_WRITE => open,
      FSL9_M_DATA => open,
      FSL9_M_CONTROL => open,
      FSL9_M_FULL => net_gnd0,
      FSL10_S_CLK => open,
      FSL10_S_READ => open,
      FSL10_S_DATA => net_gnd32,
      FSL10_S_CONTROL => net_gnd0,
      FSL10_S_EXISTS => net_gnd0,
      FSL10_M_CLK => open,
      FSL10_M_WRITE => open,
      FSL10_M_DATA => open,
      FSL10_M_CONTROL => open,
      FSL10_M_FULL => net_gnd0,
      FSL11_S_CLK => open,
      FSL11_S_READ => open,
      FSL11_S_DATA => net_gnd32,
      FSL11_S_CONTROL => net_gnd0,
      FSL11_S_EXISTS => net_gnd0,
      FSL11_M_CLK => open,
      FSL11_M_WRITE => open,
      FSL11_M_DATA => open,
      FSL11_M_CONTROL => open,
      FSL11_M_FULL => net_gnd0,
      FSL12_S_CLK => open,
      FSL12_S_READ => open,
      FSL12_S_DATA => net_gnd32,
      FSL12_S_CONTROL => net_gnd0,
      FSL12_S_EXISTS => net_gnd0,
      FSL12_M_CLK => open,
      FSL12_M_WRITE => open,
      FSL12_M_DATA => open,
      FSL12_M_CONTROL => open,
      FSL12_M_FULL => net_gnd0,
      FSL13_S_CLK => open,
      FSL13_S_READ => open,
      FSL13_S_DATA => net_gnd32,
      FSL13_S_CONTROL => net_gnd0,
      FSL13_S_EXISTS => net_gnd0,
      FSL13_M_CLK => open,
      FSL13_M_WRITE => open,
      FSL13_M_DATA => open,
      FSL13_M_CONTROL => open,
      FSL13_M_FULL => net_gnd0,
      FSL14_S_CLK => open,
      FSL14_S_READ => open,
      FSL14_S_DATA => net_gnd32,
      FSL14_S_CONTROL => net_gnd0,
      FSL14_S_EXISTS => net_gnd0,
      FSL14_M_CLK => open,
      FSL14_M_WRITE => open,
      FSL14_M_DATA => open,
      FSL14_M_CONTROL => open,
      FSL14_M_FULL => net_gnd0,
      FSL15_S_CLK => open,
      FSL15_S_READ => open,
      FSL15_S_DATA => net_gnd32,
      FSL15_S_CONTROL => net_gnd0,
      FSL15_S_EXISTS => net_gnd0,
      FSL15_M_CLK => open,
      FSL15_M_WRITE => open,
      FSL15_M_DATA => open,
      FSL15_M_CONTROL => open,
      FSL15_M_FULL => net_gnd0,
      M0_AXIS_TLAST => open,
      M0_AXIS_TDATA => open,
      M0_AXIS_TVALID => open,
      M0_AXIS_TREADY => net_gnd0,
      S0_AXIS_TLAST => net_gnd0,
      S0_AXIS_TDATA => net_gnd32(0 to 31),
      S0_AXIS_TVALID => net_gnd0,
      S0_AXIS_TREADY => open,
      M1_AXIS_TLAST => open,
      M1_AXIS_TDATA => open,
      M1_AXIS_TVALID => open,
      M1_AXIS_TREADY => net_gnd0,
      S1_AXIS_TLAST => net_gnd0,
      S1_AXIS_TDATA => net_gnd32(0 to 31),
      S1_AXIS_TVALID => net_gnd0,
      S1_AXIS_TREADY => open,
      M2_AXIS_TLAST => open,
      M2_AXIS_TDATA => open,
      M2_AXIS_TVALID => open,
      M2_AXIS_TREADY => net_gnd0,
      S2_AXIS_TLAST => net_gnd0,
      S2_AXIS_TDATA => net_gnd32(0 to 31),
      S2_AXIS_TVALID => net_gnd0,
      S2_AXIS_TREADY => open,
      M3_AXIS_TLAST => open,
      M3_AXIS_TDATA => open,
      M3_AXIS_TVALID => open,
      M3_AXIS_TREADY => net_gnd0,
      S3_AXIS_TLAST => net_gnd0,
      S3_AXIS_TDATA => net_gnd32(0 to 31),
      S3_AXIS_TVALID => net_gnd0,
      S3_AXIS_TREADY => open,
      M4_AXIS_TLAST => open,
      M4_AXIS_TDATA => open,
      M4_AXIS_TVALID => open,
      M4_AXIS_TREADY => net_gnd0,
      S4_AXIS_TLAST => net_gnd0,
      S4_AXIS_TDATA => net_gnd32(0 to 31),
      S4_AXIS_TVALID => net_gnd0,
      S4_AXIS_TREADY => open,
      M5_AXIS_TLAST => open,
      M5_AXIS_TDATA => open,
      M5_AXIS_TVALID => open,
      M5_AXIS_TREADY => net_gnd0,
      S5_AXIS_TLAST => net_gnd0,
      S5_AXIS_TDATA => net_gnd32(0 to 31),
      S5_AXIS_TVALID => net_gnd0,
      S5_AXIS_TREADY => open,
      M6_AXIS_TLAST => open,
      M6_AXIS_TDATA => open,
      M6_AXIS_TVALID => open,
      M6_AXIS_TREADY => net_gnd0,
      S6_AXIS_TLAST => net_gnd0,
      S6_AXIS_TDATA => net_gnd32(0 to 31),
      S6_AXIS_TVALID => net_gnd0,
      S6_AXIS_TREADY => open,
      M7_AXIS_TLAST => open,
      M7_AXIS_TDATA => open,
      M7_AXIS_TVALID => open,
      M7_AXIS_TREADY => net_gnd0,
      S7_AXIS_TLAST => net_gnd0,
      S7_AXIS_TDATA => net_gnd32(0 to 31),
      S7_AXIS_TVALID => net_gnd0,
      S7_AXIS_TREADY => open,
      M8_AXIS_TLAST => open,
      M8_AXIS_TDATA => open,
      M8_AXIS_TVALID => open,
      M8_AXIS_TREADY => net_gnd0,
      S8_AXIS_TLAST => net_gnd0,
      S8_AXIS_TDATA => net_gnd32(0 to 31),
      S8_AXIS_TVALID => net_gnd0,
      S8_AXIS_TREADY => open,
      M9_AXIS_TLAST => open,
      M9_AXIS_TDATA => open,
      M9_AXIS_TVALID => open,
      M9_AXIS_TREADY => net_gnd0,
      S9_AXIS_TLAST => net_gnd0,
      S9_AXIS_TDATA => net_gnd32(0 to 31),
      S9_AXIS_TVALID => net_gnd0,
      S9_AXIS_TREADY => open,
      M10_AXIS_TLAST => open,
      M10_AXIS_TDATA => open,
      M10_AXIS_TVALID => open,
      M10_AXIS_TREADY => net_gnd0,
      S10_AXIS_TLAST => net_gnd0,
      S10_AXIS_TDATA => net_gnd32(0 to 31),
      S10_AXIS_TVALID => net_gnd0,
      S10_AXIS_TREADY => open,
      M11_AXIS_TLAST => open,
      M11_AXIS_TDATA => open,
      M11_AXIS_TVALID => open,
      M11_AXIS_TREADY => net_gnd0,
      S11_AXIS_TLAST => net_gnd0,
      S11_AXIS_TDATA => net_gnd32(0 to 31),
      S11_AXIS_TVALID => net_gnd0,
      S11_AXIS_TREADY => open,
      M12_AXIS_TLAST => open,
      M12_AXIS_TDATA => open,
      M12_AXIS_TVALID => open,
      M12_AXIS_TREADY => net_gnd0,
      S12_AXIS_TLAST => net_gnd0,
      S12_AXIS_TDATA => net_gnd32(0 to 31),
      S12_AXIS_TVALID => net_gnd0,
      S12_AXIS_TREADY => open,
      M13_AXIS_TLAST => open,
      M13_AXIS_TDATA => open,
      M13_AXIS_TVALID => open,
      M13_AXIS_TREADY => net_gnd0,
      S13_AXIS_TLAST => net_gnd0,
      S13_AXIS_TDATA => net_gnd32(0 to 31),
      S13_AXIS_TVALID => net_gnd0,
      S13_AXIS_TREADY => open,
      M14_AXIS_TLAST => open,
      M14_AXIS_TDATA => open,
      M14_AXIS_TVALID => open,
      M14_AXIS_TREADY => net_gnd0,
      S14_AXIS_TLAST => net_gnd0,
      S14_AXIS_TDATA => net_gnd32(0 to 31),
      S14_AXIS_TVALID => net_gnd0,
      S14_AXIS_TREADY => open,
      M15_AXIS_TLAST => open,
      M15_AXIS_TDATA => open,
      M15_AXIS_TVALID => open,
      M15_AXIS_TREADY => net_gnd0,
      S15_AXIS_TLAST => net_gnd0,
      S15_AXIS_TDATA => net_gnd32(0 to 31),
      S15_AXIS_TVALID => net_gnd0,
      S15_AXIS_TREADY => open,
      ICACHE_FSL_IN_CLK => open,
      ICACHE_FSL_IN_READ => microblaze_0_IXCL_FSL_S_Read,
      ICACHE_FSL_IN_DATA => microblaze_0_IXCL_FSL_S_Data,
      ICACHE_FSL_IN_CONTROL => microblaze_0_IXCL_FSL_S_Control,
      ICACHE_FSL_IN_EXISTS => microblaze_0_IXCL_FSL_S_Exists,
      ICACHE_FSL_OUT_CLK => open,
      ICACHE_FSL_OUT_WRITE => microblaze_0_IXCL_FSL_M_Write,
      ICACHE_FSL_OUT_DATA => microblaze_0_IXCL_FSL_M_Data,
      ICACHE_FSL_OUT_CONTROL => microblaze_0_IXCL_FSL_M_Control,
      ICACHE_FSL_OUT_FULL => microblaze_0_IXCL_FSL_M_Full,
      DCACHE_FSL_IN_CLK => open,
      DCACHE_FSL_IN_READ => microblaze_0_DXCL_FSL_S_Read,
      DCACHE_FSL_IN_DATA => microblaze_0_DXCL_FSL_S_Data,
      DCACHE_FSL_IN_CONTROL => microblaze_0_DXCL_FSL_S_Control,
      DCACHE_FSL_IN_EXISTS => microblaze_0_DXCL_FSL_S_Exists,
      DCACHE_FSL_OUT_CLK => open,
      DCACHE_FSL_OUT_WRITE => microblaze_0_DXCL_FSL_M_Write,
      DCACHE_FSL_OUT_DATA => microblaze_0_DXCL_FSL_M_Data,
      DCACHE_FSL_OUT_CONTROL => microblaze_0_DXCL_FSL_M_Control,
      DCACHE_FSL_OUT_FULL => microblaze_0_DXCL_FSL_M_Full
    );

  mb_plb : mb_plb_wrapper
    port map (
      PLB_Clk => clk_66_6667MHz,
      SYS_Rst => sys_bus_reset(0),
      PLB_Rst => open,
      SPLB_Rst => mb_plb_SPLB_Rst,
      MPLB_Rst => open,
      PLB_dcrAck => open,
      PLB_dcrDBus => open,
      DCR_ABus => net_gnd10,
      DCR_DBus => net_gnd32,
      DCR_Read => net_gnd0,
      DCR_Write => net_gnd0,
      M_ABus => mb_plb_M_ABus,
      M_UABus => mb_plb_M_UABus,
      M_BE => mb_plb_M_BE,
      M_RNW => mb_plb_M_RNW,
      M_abort => mb_plb_M_ABort,
      M_busLock => mb_plb_M_busLock,
      M_TAttribute => mb_plb_M_TAttribute,
      M_lockErr => mb_plb_M_lockErr,
      M_MSize => mb_plb_M_MSize,
      M_priority => mb_plb_M_priority,
      M_rdBurst => mb_plb_M_rdBurst,
      M_request => mb_plb_M_request,
      M_size => mb_plb_M_size,
      M_type => mb_plb_M_type,
      M_wrBurst => mb_plb_M_wrBurst,
      M_wrDBus => mb_plb_M_wrDBus,
      Sl_addrAck => mb_plb_Sl_addrAck,
      Sl_MRdErr => mb_plb_Sl_MRdErr,
      Sl_MWrErr => mb_plb_Sl_MWrErr,
      Sl_MBusy => mb_plb_Sl_MBusy,
      Sl_rdBTerm => mb_plb_Sl_rdBTerm,
      Sl_rdComp => mb_plb_Sl_rdComp,
      Sl_rdDAck => mb_plb_Sl_rdDAck,
      Sl_rdDBus => mb_plb_Sl_rdDBus,
      Sl_rdWdAddr => mb_plb_Sl_rdWdAddr,
      Sl_rearbitrate => mb_plb_Sl_rearbitrate,
      Sl_SSize => mb_plb_Sl_SSize,
      Sl_wait => mb_plb_Sl_wait,
      Sl_wrBTerm => mb_plb_Sl_wrBTerm,
      Sl_wrComp => mb_plb_Sl_wrComp,
      Sl_wrDAck => mb_plb_Sl_wrDAck,
      Sl_MIRQ => mb_plb_Sl_MIRQ,
      PLB_MIRQ => mb_plb_PLB_MIRQ,
      PLB_ABus => mb_plb_PLB_ABus,
      PLB_UABus => mb_plb_PLB_UABus,
      PLB_BE => mb_plb_PLB_BE,
      PLB_MAddrAck => mb_plb_PLB_MAddrAck,
      PLB_MTimeout => mb_plb_PLB_MTimeout,
      PLB_MBusy => mb_plb_PLB_MBusy,
      PLB_MRdErr => mb_plb_PLB_MRdErr,
      PLB_MWrErr => mb_plb_PLB_MWrErr,
      PLB_MRdBTerm => mb_plb_PLB_MRdBTerm,
      PLB_MRdDAck => mb_plb_PLB_MRdDAck,
      PLB_MRdDBus => mb_plb_PLB_MRdDBus,
      PLB_MRdWdAddr => mb_plb_PLB_MRdWdAddr,
      PLB_MRearbitrate => mb_plb_PLB_MRearbitrate,
      PLB_MWrBTerm => mb_plb_PLB_MWrBTerm,
      PLB_MWrDAck => mb_plb_PLB_MWrDAck,
      PLB_MSSize => mb_plb_PLB_MSSize,
      PLB_PAValid => mb_plb_PLB_PAValid,
      PLB_RNW => mb_plb_PLB_RNW,
      PLB_SAValid => mb_plb_PLB_SAValid,
      PLB_abort => mb_plb_PLB_abort,
      PLB_busLock => mb_plb_PLB_busLock,
      PLB_TAttribute => mb_plb_PLB_TAttribute,
      PLB_lockErr => mb_plb_PLB_lockErr,
      PLB_masterID => mb_plb_PLB_masterID(0 to 0),
      PLB_MSize => mb_plb_PLB_MSize,
      PLB_rdPendPri => mb_plb_PLB_rdPendPri,
      PLB_wrPendPri => mb_plb_PLB_wrPendPri,
      PLB_rdPendReq => mb_plb_PLB_rdPendReq,
      PLB_wrPendReq => mb_plb_PLB_wrPendReq,
      PLB_rdBurst => mb_plb_PLB_rdBurst,
      PLB_rdPrim => mb_plb_PLB_rdPrim,
      PLB_reqPri => mb_plb_PLB_reqPri,
      PLB_size => mb_plb_PLB_size,
      PLB_type => mb_plb_PLB_type,
      PLB_wrBurst => mb_plb_PLB_wrBurst,
      PLB_wrDBus => mb_plb_PLB_wrDBus,
      PLB_wrPrim => mb_plb_PLB_wrPrim,
      PLB_SaddrAck => open,
      PLB_SMRdErr => open,
      PLB_SMWrErr => open,
      PLB_SMBusy => open,
      PLB_SrdBTerm => open,
      PLB_SrdComp => open,
      PLB_SrdDAck => open,
      PLB_SrdDBus => open,
      PLB_SrdWdAddr => open,
      PLB_Srearbitrate => open,
      PLB_Sssize => open,
      PLB_Swait => open,
      PLB_SwrBTerm => open,
      PLB_SwrComp => open,
      PLB_SwrDAck => open,
      Bus_Error_Det => open
    );

  ilmb : ilmb_wrapper
    port map (
      LMB_Clk => clk_66_6667MHz,
      SYS_Rst => sys_bus_reset(0),
      LMB_Rst => ilmb_LMB_Rst,
      M_ABus => ilmb_M_ABus,
      M_ReadStrobe => ilmb_M_ReadStrobe,
      M_WriteStrobe => net_gnd0,
      M_AddrStrobe => ilmb_M_AddrStrobe,
      M_DBus => net_gnd32,
      M_BE => net_gnd4,
      Sl_DBus => ilmb_Sl_DBus,
      Sl_Ready => ilmb_Sl_Ready(0 to 0),
      Sl_Wait => ilmb_Sl_Wait(0 to 0),
      Sl_UE => ilmb_Sl_UE(0 to 0),
      Sl_CE => ilmb_Sl_CE(0 to 0),
      LMB_ABus => ilmb_LMB_ABus,
      LMB_ReadStrobe => ilmb_LMB_ReadStrobe,
      LMB_WriteStrobe => ilmb_LMB_WriteStrobe,
      LMB_AddrStrobe => ilmb_LMB_AddrStrobe,
      LMB_ReadDBus => ilmb_LMB_ReadDBus,
      LMB_WriteDBus => ilmb_LMB_WriteDBus,
      LMB_Ready => ilmb_LMB_Ready,
      LMB_Wait => ilmb_LMB_Wait,
      LMB_UE => ilmb_LMB_UE,
      LMB_CE => ilmb_LMB_CE,
      LMB_BE => ilmb_LMB_BE
    );

  dlmb : dlmb_wrapper
    port map (
      LMB_Clk => clk_66_6667MHz,
      SYS_Rst => sys_bus_reset(0),
      LMB_Rst => dlmb_LMB_Rst,
      M_ABus => dlmb_M_ABus,
      M_ReadStrobe => dlmb_M_ReadStrobe,
      M_WriteStrobe => dlmb_M_WriteStrobe,
      M_AddrStrobe => dlmb_M_AddrStrobe,
      M_DBus => dlmb_M_DBus,
      M_BE => dlmb_M_BE,
      Sl_DBus => dlmb_Sl_DBus,
      Sl_Ready => dlmb_Sl_Ready(0 to 0),
      Sl_Wait => dlmb_Sl_Wait(0 to 0),
      Sl_UE => dlmb_Sl_UE(0 to 0),
      Sl_CE => dlmb_Sl_CE(0 to 0),
      LMB_ABus => dlmb_LMB_ABus,
      LMB_ReadStrobe => dlmb_LMB_ReadStrobe,
      LMB_WriteStrobe => dlmb_LMB_WriteStrobe,
      LMB_AddrStrobe => dlmb_LMB_AddrStrobe,
      LMB_ReadDBus => dlmb_LMB_ReadDBus,
      LMB_WriteDBus => dlmb_LMB_WriteDBus,
      LMB_Ready => dlmb_LMB_Ready,
      LMB_Wait => dlmb_LMB_Wait,
      LMB_UE => dlmb_LMB_UE,
      LMB_CE => dlmb_LMB_CE,
      LMB_BE => dlmb_LMB_BE
    );

  dlmb_cntlr : dlmb_cntlr_wrapper
    port map (
      LMB_Clk => clk_66_6667MHz,
      LMB_Rst => dlmb_LMB_Rst,
      LMB_ABus => dlmb_LMB_ABus,
      LMB_WriteDBus => dlmb_LMB_WriteDBus,
      LMB_AddrStrobe => dlmb_LMB_AddrStrobe,
      LMB_ReadStrobe => dlmb_LMB_ReadStrobe,
      LMB_WriteStrobe => dlmb_LMB_WriteStrobe,
      LMB_BE => dlmb_LMB_BE,
      Sl_DBus => dlmb_Sl_DBus,
      Sl_Ready => dlmb_Sl_Ready(0),
      Sl_Wait => dlmb_Sl_Wait(0),
      Sl_UE => dlmb_Sl_UE(0),
      Sl_CE => dlmb_Sl_CE(0),
      BRAM_Rst_A => dlmb_port_BRAM_Rst,
      BRAM_Clk_A => dlmb_port_BRAM_Clk,
      BRAM_EN_A => dlmb_port_BRAM_EN,
      BRAM_WEN_A => dlmb_port_BRAM_WEN,
      BRAM_Addr_A => dlmb_port_BRAM_Addr,
      BRAM_Din_A => dlmb_port_BRAM_Din,
      BRAM_Dout_A => dlmb_port_BRAM_Dout,
      Interrupt => open,
      SPLB_CTRL_PLB_ABus => net_gnd32,
      SPLB_CTRL_PLB_PAValid => net_gnd0,
      SPLB_CTRL_PLB_masterID => net_gnd1(0 downto 0),
      SPLB_CTRL_PLB_RNW => net_gnd0,
      SPLB_CTRL_PLB_BE => net_gnd4,
      SPLB_CTRL_PLB_size => net_gnd4,
      SPLB_CTRL_PLB_type => net_gnd3,
      SPLB_CTRL_PLB_wrDBus => net_gnd32,
      SPLB_CTRL_Sl_addrAck => open,
      SPLB_CTRL_Sl_SSize => open,
      SPLB_CTRL_Sl_wait => open,
      SPLB_CTRL_Sl_rearbitrate => open,
      SPLB_CTRL_Sl_wrDAck => open,
      SPLB_CTRL_Sl_wrComp => open,
      SPLB_CTRL_Sl_rdDBus => open,
      SPLB_CTRL_Sl_rdDAck => open,
      SPLB_CTRL_Sl_rdComp => open,
      SPLB_CTRL_Sl_MBusy => open,
      SPLB_CTRL_Sl_MWrErr => open,
      SPLB_CTRL_Sl_MRdErr => open,
      SPLB_CTRL_PLB_UABus => net_gnd32,
      SPLB_CTRL_PLB_SAValid => net_gnd0,
      SPLB_CTRL_PLB_rdPrim => net_gnd0,
      SPLB_CTRL_PLB_wrPrim => net_gnd0,
      SPLB_CTRL_PLB_abort => net_gnd0,
      SPLB_CTRL_PLB_busLock => net_gnd0,
      SPLB_CTRL_PLB_MSize => net_gnd2(1 downto 0),
      SPLB_CTRL_PLB_lockErr => net_gnd0,
      SPLB_CTRL_PLB_wrBurst => net_gnd0,
      SPLB_CTRL_PLB_rdBurst => net_gnd0,
      SPLB_CTRL_PLB_wrPendReq => net_gnd0,
      SPLB_CTRL_PLB_rdPendReq => net_gnd0,
      SPLB_CTRL_PLB_wrPendPri => net_gnd2(1 downto 0),
      SPLB_CTRL_PLB_rdPendPri => net_gnd2(1 downto 0),
      SPLB_CTRL_PLB_reqPri => net_gnd2(1 downto 0),
      SPLB_CTRL_PLB_TAttribute => net_gnd16,
      SPLB_CTRL_Sl_wrBTerm => open,
      SPLB_CTRL_Sl_rdWdAddr => open,
      SPLB_CTRL_Sl_rdBTerm => open,
      SPLB_CTRL_Sl_MIRQ => open,
      S_AXI_CTRL_ACLK => net_vcc0,
      S_AXI_CTRL_ARESETN => net_gnd0,
      S_AXI_CTRL_AWADDR => net_gnd32(0 to 31),
      S_AXI_CTRL_AWVALID => net_gnd0,
      S_AXI_CTRL_AWREADY => open,
      S_AXI_CTRL_WDATA => net_gnd32(0 to 31),
      S_AXI_CTRL_WSTRB => net_gnd4(0 to 3),
      S_AXI_CTRL_WVALID => net_gnd0,
      S_AXI_CTRL_WREADY => open,
      S_AXI_CTRL_BRESP => open,
      S_AXI_CTRL_BVALID => open,
      S_AXI_CTRL_BREADY => net_gnd0,
      S_AXI_CTRL_ARADDR => net_gnd32(0 to 31),
      S_AXI_CTRL_ARVALID => net_gnd0,
      S_AXI_CTRL_ARREADY => open,
      S_AXI_CTRL_RDATA => open,
      S_AXI_CTRL_RRESP => open,
      S_AXI_CTRL_RVALID => open,
      S_AXI_CTRL_RREADY => net_gnd0
    );

  ilmb_cntlr : ilmb_cntlr_wrapper
    port map (
      LMB_Clk => clk_66_6667MHz,
      LMB_Rst => ilmb_LMB_Rst,
      LMB_ABus => ilmb_LMB_ABus,
      LMB_WriteDBus => ilmb_LMB_WriteDBus,
      LMB_AddrStrobe => ilmb_LMB_AddrStrobe,
      LMB_ReadStrobe => ilmb_LMB_ReadStrobe,
      LMB_WriteStrobe => ilmb_LMB_WriteStrobe,
      LMB_BE => ilmb_LMB_BE,
      Sl_DBus => ilmb_Sl_DBus,
      Sl_Ready => ilmb_Sl_Ready(0),
      Sl_Wait => ilmb_Sl_Wait(0),
      Sl_UE => ilmb_Sl_UE(0),
      Sl_CE => ilmb_Sl_CE(0),
      BRAM_Rst_A => ilmb_port_BRAM_Rst,
      BRAM_Clk_A => ilmb_port_BRAM_Clk,
      BRAM_EN_A => ilmb_port_BRAM_EN,
      BRAM_WEN_A => ilmb_port_BRAM_WEN,
      BRAM_Addr_A => ilmb_port_BRAM_Addr,
      BRAM_Din_A => ilmb_port_BRAM_Din,
      BRAM_Dout_A => ilmb_port_BRAM_Dout,
      Interrupt => open,
      SPLB_CTRL_PLB_ABus => net_gnd32,
      SPLB_CTRL_PLB_PAValid => net_gnd0,
      SPLB_CTRL_PLB_masterID => net_gnd1(0 downto 0),
      SPLB_CTRL_PLB_RNW => net_gnd0,
      SPLB_CTRL_PLB_BE => net_gnd4,
      SPLB_CTRL_PLB_size => net_gnd4,
      SPLB_CTRL_PLB_type => net_gnd3,
      SPLB_CTRL_PLB_wrDBus => net_gnd32,
      SPLB_CTRL_Sl_addrAck => open,
      SPLB_CTRL_Sl_SSize => open,
      SPLB_CTRL_Sl_wait => open,
      SPLB_CTRL_Sl_rearbitrate => open,
      SPLB_CTRL_Sl_wrDAck => open,
      SPLB_CTRL_Sl_wrComp => open,
      SPLB_CTRL_Sl_rdDBus => open,
      SPLB_CTRL_Sl_rdDAck => open,
      SPLB_CTRL_Sl_rdComp => open,
      SPLB_CTRL_Sl_MBusy => open,
      SPLB_CTRL_Sl_MWrErr => open,
      SPLB_CTRL_Sl_MRdErr => open,
      SPLB_CTRL_PLB_UABus => net_gnd32,
      SPLB_CTRL_PLB_SAValid => net_gnd0,
      SPLB_CTRL_PLB_rdPrim => net_gnd0,
      SPLB_CTRL_PLB_wrPrim => net_gnd0,
      SPLB_CTRL_PLB_abort => net_gnd0,
      SPLB_CTRL_PLB_busLock => net_gnd0,
      SPLB_CTRL_PLB_MSize => net_gnd2(1 downto 0),
      SPLB_CTRL_PLB_lockErr => net_gnd0,
      SPLB_CTRL_PLB_wrBurst => net_gnd0,
      SPLB_CTRL_PLB_rdBurst => net_gnd0,
      SPLB_CTRL_PLB_wrPendReq => net_gnd0,
      SPLB_CTRL_PLB_rdPendReq => net_gnd0,
      SPLB_CTRL_PLB_wrPendPri => net_gnd2(1 downto 0),
      SPLB_CTRL_PLB_rdPendPri => net_gnd2(1 downto 0),
      SPLB_CTRL_PLB_reqPri => net_gnd2(1 downto 0),
      SPLB_CTRL_PLB_TAttribute => net_gnd16,
      SPLB_CTRL_Sl_wrBTerm => open,
      SPLB_CTRL_Sl_rdWdAddr => open,
      SPLB_CTRL_Sl_rdBTerm => open,
      SPLB_CTRL_Sl_MIRQ => open,
      S_AXI_CTRL_ACLK => net_vcc0,
      S_AXI_CTRL_ARESETN => net_gnd0,
      S_AXI_CTRL_AWADDR => net_gnd32(0 to 31),
      S_AXI_CTRL_AWVALID => net_gnd0,
      S_AXI_CTRL_AWREADY => open,
      S_AXI_CTRL_WDATA => net_gnd32(0 to 31),
      S_AXI_CTRL_WSTRB => net_gnd4(0 to 3),
      S_AXI_CTRL_WVALID => net_gnd0,
      S_AXI_CTRL_WREADY => open,
      S_AXI_CTRL_BRESP => open,
      S_AXI_CTRL_BVALID => open,
      S_AXI_CTRL_BREADY => net_gnd0,
      S_AXI_CTRL_ARADDR => net_gnd32(0 to 31),
      S_AXI_CTRL_ARVALID => net_gnd0,
      S_AXI_CTRL_ARREADY => open,
      S_AXI_CTRL_RDATA => open,
      S_AXI_CTRL_RRESP => open,
      S_AXI_CTRL_RVALID => open,
      S_AXI_CTRL_RREADY => net_gnd0
    );

  lmb_bram : lmb_bram_wrapper
    port map (
      BRAM_Rst_A => ilmb_port_BRAM_Rst,
      BRAM_Clk_A => ilmb_port_BRAM_Clk,
      BRAM_EN_A => ilmb_port_BRAM_EN,
      BRAM_WEN_A => ilmb_port_BRAM_WEN,
      BRAM_Addr_A => ilmb_port_BRAM_Addr,
      BRAM_Din_A => ilmb_port_BRAM_Din,
      BRAM_Dout_A => ilmb_port_BRAM_Dout,
      BRAM_Rst_B => dlmb_port_BRAM_Rst,
      BRAM_Clk_B => dlmb_port_BRAM_Clk,
      BRAM_EN_B => dlmb_port_BRAM_EN,
      BRAM_WEN_B => dlmb_port_BRAM_WEN,
      BRAM_Addr_B => dlmb_port_BRAM_Addr,
      BRAM_Din_B => dlmb_port_BRAM_Din,
      BRAM_Dout_B => dlmb_port_BRAM_Dout
    );

  RS232_Uart_1 : rs232_uart_1_wrapper
    port map (
      SPLB_Clk => clk_66_6667MHz,
      SPLB_Rst => mb_plb_SPLB_Rst(0),
      PLB_ABus => mb_plb_PLB_ABus,
      PLB_PAValid => mb_plb_PLB_PAValid,
      PLB_masterID => mb_plb_PLB_masterID(0 to 0),
      PLB_RNW => mb_plb_PLB_RNW,
      PLB_BE => mb_plb_PLB_BE,
      PLB_size => mb_plb_PLB_size,
      PLB_type => mb_plb_PLB_type,
      PLB_wrDBus => mb_plb_PLB_wrDBus,
      PLB_UABus => mb_plb_PLB_UABus,
      PLB_SAValid => mb_plb_PLB_SAValid,
      PLB_rdPrim => mb_plb_PLB_rdPrim(0),
      PLB_wrPrim => mb_plb_PLB_wrPrim(0),
      PLB_abort => mb_plb_PLB_abort,
      PLB_busLock => mb_plb_PLB_busLock,
      PLB_MSize => mb_plb_PLB_MSize,
      PLB_lockErr => mb_plb_PLB_lockErr,
      PLB_wrBurst => mb_plb_PLB_wrBurst,
      PLB_rdBurst => mb_plb_PLB_rdBurst,
      PLB_wrPendReq => mb_plb_PLB_wrPendReq,
      PLB_rdPendReq => mb_plb_PLB_rdPendReq,
      PLB_wrPendPri => mb_plb_PLB_wrPendPri,
      PLB_rdPendPri => mb_plb_PLB_rdPendPri,
      PLB_reqPri => mb_plb_PLB_reqPri,
      PLB_TAttribute => mb_plb_PLB_TAttribute,
      Sl_addrAck => mb_plb_Sl_addrAck(0),
      Sl_SSize => mb_plb_Sl_SSize(0 to 1),
      Sl_wait => mb_plb_Sl_wait(0),
      Sl_rearbitrate => mb_plb_Sl_rearbitrate(0),
      Sl_wrDAck => mb_plb_Sl_wrDAck(0),
      Sl_wrComp => mb_plb_Sl_wrComp(0),
      Sl_rdDBus => mb_plb_Sl_rdDBus(0 to 31),
      Sl_rdDAck => mb_plb_Sl_rdDAck(0),
      Sl_rdComp => mb_plb_Sl_rdComp(0),
      Sl_MBusy => mb_plb_Sl_MBusy(0 to 1),
      Sl_MWrErr => mb_plb_Sl_MWrErr(0 to 1),
      Sl_MRdErr => mb_plb_Sl_MRdErr(0 to 1),
      Sl_wrBTerm => mb_plb_Sl_wrBTerm(0),
      Sl_rdWdAddr => mb_plb_Sl_rdWdAddr(0 to 3),
      Sl_rdBTerm => mb_plb_Sl_rdBTerm(0),
      Sl_MIRQ => mb_plb_Sl_MIRQ(0 to 1),
      RX => fpga_0_RS232_Uart_1_RX_pin,
      TX => fpga_0_RS232_Uart_1_TX_pin,
      Interrupt => RS232_Uart_1_Interrupt
    );

  LEDs_8Bits : leds_8bits_wrapper
    port map (
      SPLB_Clk => clk_66_6667MHz,
      SPLB_Rst => mb_plb_SPLB_Rst(1),
      PLB_ABus => mb_plb_PLB_ABus,
      PLB_UABus => mb_plb_PLB_UABus,
      PLB_PAValid => mb_plb_PLB_PAValid,
      PLB_SAValid => mb_plb_PLB_SAValid,
      PLB_rdPrim => mb_plb_PLB_rdPrim(1),
      PLB_wrPrim => mb_plb_PLB_wrPrim(1),
      PLB_masterID => mb_plb_PLB_masterID(0 to 0),
      PLB_abort => mb_plb_PLB_abort,
      PLB_busLock => mb_plb_PLB_busLock,
      PLB_RNW => mb_plb_PLB_RNW,
      PLB_BE => mb_plb_PLB_BE,
      PLB_MSize => mb_plb_PLB_MSize,
      PLB_size => mb_plb_PLB_size,
      PLB_type => mb_plb_PLB_type,
      PLB_lockErr => mb_plb_PLB_lockErr,
      PLB_wrDBus => mb_plb_PLB_wrDBus,
      PLB_wrBurst => mb_plb_PLB_wrBurst,
      PLB_rdBurst => mb_plb_PLB_rdBurst,
      PLB_wrPendReq => mb_plb_PLB_wrPendReq,
      PLB_rdPendReq => mb_plb_PLB_rdPendReq,
      PLB_wrPendPri => mb_plb_PLB_wrPendPri,
      PLB_rdPendPri => mb_plb_PLB_rdPendPri,
      PLB_reqPri => mb_plb_PLB_reqPri,
      PLB_TAttribute => mb_plb_PLB_TAttribute,
      Sl_addrAck => mb_plb_Sl_addrAck(1),
      Sl_SSize => mb_plb_Sl_SSize(2 to 3),
      Sl_wait => mb_plb_Sl_wait(1),
      Sl_rearbitrate => mb_plb_Sl_rearbitrate(1),
      Sl_wrDAck => mb_plb_Sl_wrDAck(1),
      Sl_wrComp => mb_plb_Sl_wrComp(1),
      Sl_wrBTerm => mb_plb_Sl_wrBTerm(1),
      Sl_rdDBus => mb_plb_Sl_rdDBus(32 to 63),
      Sl_rdWdAddr => mb_plb_Sl_rdWdAddr(4 to 7),
      Sl_rdDAck => mb_plb_Sl_rdDAck(1),
      Sl_rdComp => mb_plb_Sl_rdComp(1),
      Sl_rdBTerm => mb_plb_Sl_rdBTerm(1),
      Sl_MBusy => mb_plb_Sl_MBusy(2 to 3),
      Sl_MWrErr => mb_plb_Sl_MWrErr(2 to 3),
      Sl_MRdErr => mb_plb_Sl_MRdErr(2 to 3),
      Sl_MIRQ => mb_plb_Sl_MIRQ(2 to 3),
      IP2INTC_Irpt => open,
      GPIO_IO_I => net_gnd8,
      GPIO_IO_O => fpga_0_LEDs_8Bits_GPIO_IO_O_pin,
      GPIO_IO_T => open,
      GPIO2_IO_I => net_gnd32,
      GPIO2_IO_O => open,
      GPIO2_IO_T => open
    );

  Push_Buttons_4Bits : push_buttons_4bits_wrapper
    port map (
      SPLB_Clk => clk_66_6667MHz,
      SPLB_Rst => mb_plb_SPLB_Rst(2),
      PLB_ABus => mb_plb_PLB_ABus,
      PLB_UABus => mb_plb_PLB_UABus,
      PLB_PAValid => mb_plb_PLB_PAValid,
      PLB_SAValid => mb_plb_PLB_SAValid,
      PLB_rdPrim => mb_plb_PLB_rdPrim(2),
      PLB_wrPrim => mb_plb_PLB_wrPrim(2),
      PLB_masterID => mb_plb_PLB_masterID(0 to 0),
      PLB_abort => mb_plb_PLB_abort,
      PLB_busLock => mb_plb_PLB_busLock,
      PLB_RNW => mb_plb_PLB_RNW,
      PLB_BE => mb_plb_PLB_BE,
      PLB_MSize => mb_plb_PLB_MSize,
      PLB_size => mb_plb_PLB_size,
      PLB_type => mb_plb_PLB_type,
      PLB_lockErr => mb_plb_PLB_lockErr,
      PLB_wrDBus => mb_plb_PLB_wrDBus,
      PLB_wrBurst => mb_plb_PLB_wrBurst,
      PLB_rdBurst => mb_plb_PLB_rdBurst,
      PLB_wrPendReq => mb_plb_PLB_wrPendReq,
      PLB_rdPendReq => mb_plb_PLB_rdPendReq,
      PLB_wrPendPri => mb_plb_PLB_wrPendPri,
      PLB_rdPendPri => mb_plb_PLB_rdPendPri,
      PLB_reqPri => mb_plb_PLB_reqPri,
      PLB_TAttribute => mb_plb_PLB_TAttribute,
      Sl_addrAck => mb_plb_Sl_addrAck(2),
      Sl_SSize => mb_plb_Sl_SSize(4 to 5),
      Sl_wait => mb_plb_Sl_wait(2),
      Sl_rearbitrate => mb_plb_Sl_rearbitrate(2),
      Sl_wrDAck => mb_plb_Sl_wrDAck(2),
      Sl_wrComp => mb_plb_Sl_wrComp(2),
      Sl_wrBTerm => mb_plb_Sl_wrBTerm(2),
      Sl_rdDBus => mb_plb_Sl_rdDBus(64 to 95),
      Sl_rdWdAddr => mb_plb_Sl_rdWdAddr(8 to 11),
      Sl_rdDAck => mb_plb_Sl_rdDAck(2),
      Sl_rdComp => mb_plb_Sl_rdComp(2),
      Sl_rdBTerm => mb_plb_Sl_rdBTerm(2),
      Sl_MBusy => mb_plb_Sl_MBusy(4 to 5),
      Sl_MWrErr => mb_plb_Sl_MWrErr(4 to 5),
      Sl_MRdErr => mb_plb_Sl_MRdErr(4 to 5),
      Sl_MIRQ => mb_plb_Sl_MIRQ(4 to 5),
      IP2INTC_Irpt => open,
      GPIO_IO_I => fpga_0_Push_Buttons_4Bits_GPIO_IO_I_pin,
      GPIO_IO_O => open,
      GPIO_IO_T => open,
      GPIO2_IO_I => net_gnd32,
      GPIO2_IO_O => open,
      GPIO2_IO_T => open
    );

  Ethernet_Lite : ethernet_lite_wrapper
    port map (
      PHY_tx_clk => fpga_0_Ethernet_Lite_PHY_tx_clk_pin,
      PHY_rx_clk => fpga_0_Ethernet_Lite_PHY_rx_clk_pin,
      PHY_crs => fpga_0_Ethernet_Lite_PHY_crs_pin,
      PHY_dv => fpga_0_Ethernet_Lite_PHY_dv_pin,
      PHY_rx_data => fpga_0_Ethernet_Lite_PHY_rx_data_pin,
      PHY_col => fpga_0_Ethernet_Lite_PHY_col_pin,
      PHY_rx_er => fpga_0_Ethernet_Lite_PHY_rx_er_pin,
      PHY_rst_n => fpga_0_Ethernet_Lite_PHY_rst_n_pin,
      PHY_tx_en => fpga_0_Ethernet_Lite_PHY_tx_en_pin,
      PHY_tx_data => fpga_0_Ethernet_Lite_PHY_tx_data_pin,
      PHY_MDC => fpga_0_Ethernet_Lite_PHY_MDC_pin,
      PHY_MDIO_I => fpga_0_Ethernet_Lite_PHY_MDIO_pin_I,
      PHY_MDIO_O => fpga_0_Ethernet_Lite_PHY_MDIO_pin_O,
      PHY_MDIO_T => fpga_0_Ethernet_Lite_PHY_MDIO_pin_T,
      IP2INTC_Irpt => Ethernet_Lite_IP2INTC_Irpt,
      SPLB_Clk => clk_66_6667MHz,
      SPLB_Rst => mb_plb_SPLB_Rst(3),
      PLB_ABus => mb_plb_PLB_ABus,
      PLB_UABus => mb_plb_PLB_UABus,
      PLB_PAValid => mb_plb_PLB_PAValid,
      PLB_SAValid => mb_plb_PLB_SAValid,
      PLB_rdPrim => mb_plb_PLB_rdPrim(3),
      PLB_wrPrim => mb_plb_PLB_wrPrim(3),
      PLB_masterID => mb_plb_PLB_masterID(0 to 0),
      PLB_abort => mb_plb_PLB_abort,
      PLB_busLock => mb_plb_PLB_busLock,
      PLB_RNW => mb_plb_PLB_RNW,
      PLB_BE => mb_plb_PLB_BE,
      PLB_MSize => mb_plb_PLB_MSize,
      PLB_size => mb_plb_PLB_size,
      PLB_type => mb_plb_PLB_type,
      PLB_lockErr => mb_plb_PLB_lockErr,
      PLB_wrDBus => mb_plb_PLB_wrDBus,
      PLB_wrBurst => mb_plb_PLB_wrBurst,
      PLB_rdBurst => mb_plb_PLB_rdBurst,
      PLB_wrPendReq => mb_plb_PLB_wrPendReq,
      PLB_rdPendReq => mb_plb_PLB_rdPendReq,
      PLB_wrPendPri => mb_plb_PLB_wrPendPri,
      PLB_rdPendPri => mb_plb_PLB_rdPendPri,
      PLB_reqPri => mb_plb_PLB_reqPri,
      PLB_TAttribute => mb_plb_PLB_TAttribute,
      Sl_addrAck => mb_plb_Sl_addrAck(3),
      Sl_SSize => mb_plb_Sl_SSize(6 to 7),
      Sl_wait => mb_plb_Sl_wait(3),
      Sl_rearbitrate => mb_plb_Sl_rearbitrate(3),
      Sl_wrDAck => mb_plb_Sl_wrDAck(3),
      Sl_wrComp => mb_plb_Sl_wrComp(3),
      Sl_wrBTerm => mb_plb_Sl_wrBTerm(3),
      Sl_rdDBus => mb_plb_Sl_rdDBus(96 to 127),
      Sl_rdWdAddr => mb_plb_Sl_rdWdAddr(12 to 15),
      Sl_rdDAck => mb_plb_Sl_rdDAck(3),
      Sl_rdComp => mb_plb_Sl_rdComp(3),
      Sl_rdBTerm => mb_plb_Sl_rdBTerm(3),
      Sl_MBusy => mb_plb_Sl_MBusy(6 to 7),
      Sl_MWrErr => mb_plb_Sl_MWrErr(6 to 7),
      Sl_MRdErr => mb_plb_Sl_MRdErr(6 to 7),
      Sl_MIRQ => mb_plb_Sl_MIRQ(6 to 7)
    );

  Micron_RAM : micron_ram_wrapper
    port map (
      MCH_SPLB_Clk => clk_66_6667MHz,
      RdClk => clk_66_6667MHz,
      MCH_SPLB_Rst => mb_plb_SPLB_Rst(4),
      MCH0_Access_Control => microblaze_0_IXCL_FSL_M_Control,
      MCH0_Access_Data => microblaze_0_IXCL_FSL_M_Data,
      MCH0_Access_Write => microblaze_0_IXCL_FSL_M_Write,
      MCH0_Access_Full => microblaze_0_IXCL_FSL_M_Full,
      MCH0_ReadData_Control => microblaze_0_IXCL_FSL_S_Control,
      MCH0_ReadData_Data => microblaze_0_IXCL_FSL_S_Data,
      MCH0_ReadData_Read => microblaze_0_IXCL_FSL_S_Read,
      MCH0_ReadData_Exists => microblaze_0_IXCL_FSL_S_Exists,
      MCH1_Access_Control => microblaze_0_DXCL_FSL_M_Control,
      MCH1_Access_Data => microblaze_0_DXCL_FSL_M_Data,
      MCH1_Access_Write => microblaze_0_DXCL_FSL_M_Write,
      MCH1_Access_Full => microblaze_0_DXCL_FSL_M_Full,
      MCH1_ReadData_Control => microblaze_0_DXCL_FSL_S_Control,
      MCH1_ReadData_Data => microblaze_0_DXCL_FSL_S_Data,
      MCH1_ReadData_Read => microblaze_0_DXCL_FSL_S_Read,
      MCH1_ReadData_Exists => microblaze_0_DXCL_FSL_S_Exists,
      MCH2_Access_Control => net_gnd0,
      MCH2_Access_Data => net_gnd32,
      MCH2_Access_Write => net_gnd0,
      MCH2_Access_Full => open,
      MCH2_ReadData_Control => open,
      MCH2_ReadData_Data => open,
      MCH2_ReadData_Read => net_gnd0,
      MCH2_ReadData_Exists => open,
      MCH3_Access_Control => net_gnd0,
      MCH3_Access_Data => net_gnd32,
      MCH3_Access_Write => net_gnd0,
      MCH3_Access_Full => open,
      MCH3_ReadData_Control => open,
      MCH3_ReadData_Data => open,
      MCH3_ReadData_Read => net_gnd0,
      MCH3_ReadData_Exists => open,
      PLB_ABus => mb_plb_PLB_ABus,
      PLB_UABus => mb_plb_PLB_UABus,
      PLB_PAValid => mb_plb_PLB_PAValid,
      PLB_SAValid => mb_plb_PLB_SAValid,
      PLB_rdPrim => mb_plb_PLB_rdPrim(4),
      PLB_wrPrim => mb_plb_PLB_wrPrim(4),
      PLB_masterID => mb_plb_PLB_masterID(0 to 0),
      PLB_abort => mb_plb_PLB_abort,
      PLB_busLock => mb_plb_PLB_busLock,
      PLB_RNW => mb_plb_PLB_RNW,
      PLB_BE => mb_plb_PLB_BE,
      PLB_MSize => mb_plb_PLB_MSize,
      PLB_size => mb_plb_PLB_size,
      PLB_type => mb_plb_PLB_type,
      PLB_lockErr => mb_plb_PLB_lockErr,
      PLB_wrDBus => mb_plb_PLB_wrDBus,
      PLB_wrBurst => mb_plb_PLB_wrBurst,
      PLB_rdBurst => mb_plb_PLB_rdBurst,
      PLB_wrPendReq => mb_plb_PLB_wrPendReq,
      PLB_rdPendReq => mb_plb_PLB_rdPendReq,
      PLB_wrPendPri => mb_plb_PLB_wrPendPri,
      PLB_rdPendPri => mb_plb_PLB_rdPendPri,
      PLB_reqPri => mb_plb_PLB_reqPri,
      PLB_TAttribute => mb_plb_PLB_TAttribute,
      Sl_addrAck => mb_plb_Sl_addrAck(4),
      Sl_SSize => mb_plb_Sl_SSize(8 to 9),
      Sl_wait => mb_plb_Sl_wait(4),
      Sl_rearbitrate => mb_plb_Sl_rearbitrate(4),
      Sl_wrDAck => mb_plb_Sl_wrDAck(4),
      Sl_wrComp => mb_plb_Sl_wrComp(4),
      Sl_wrBTerm => mb_plb_Sl_wrBTerm(4),
      Sl_rdDBus => mb_plb_Sl_rdDBus(128 to 159),
      Sl_rdWdAddr => mb_plb_Sl_rdWdAddr(16 to 19),
      Sl_rdDAck => mb_plb_Sl_rdDAck(4),
      Sl_rdComp => mb_plb_Sl_rdComp(4),
      Sl_rdBTerm => mb_plb_Sl_rdBTerm(4),
      Sl_MBusy => mb_plb_Sl_MBusy(8 to 9),
      Sl_MWrErr => mb_plb_Sl_MWrErr(8 to 9),
      Sl_MRdErr => mb_plb_Sl_MRdErr(8 to 9),
      Sl_MIRQ => mb_plb_Sl_MIRQ(8 to 9),
      Mem_DQ_I => net_bsbassign35,
      Mem_DQ_O => net_bsbassign51,
      Mem_DQ_T => net_bsbassign67,
      Mem_A => net_bsbassign0,
      Mem_RPN => open,
      Mem_CEN => net_bsbassign34(0 to 0),
      Mem_OEN => net_bsbassign83(0 to 0),
      Mem_WEN => net_bsbassign84,
      Mem_QWEN => open,
      Mem_BEN => net_bsbassign32,
      Mem_CE => open,
      Mem_ADV_LDN => open,
      Mem_LBON => open,
      Mem_CKEN => open,
      Mem_RNW => open
    );

  Numonyx_PCM : numonyx_pcm_wrapper
    port map (
      MCH_SPLB_Clk => clk_66_6667MHz,
      RdClk => clk_66_6667MHz,
      MCH_SPLB_Rst => mb_plb_SPLB_Rst(5),
      MCH0_Access_Control => net_gnd0,
      MCH0_Access_Data => net_gnd32,
      MCH0_Access_Write => net_gnd0,
      MCH0_Access_Full => open,
      MCH0_ReadData_Control => open,
      MCH0_ReadData_Data => open,
      MCH0_ReadData_Read => net_gnd0,
      MCH0_ReadData_Exists => open,
      MCH1_Access_Control => net_gnd0,
      MCH1_Access_Data => net_gnd32,
      MCH1_Access_Write => net_gnd0,
      MCH1_Access_Full => open,
      MCH1_ReadData_Control => open,
      MCH1_ReadData_Data => open,
      MCH1_ReadData_Read => net_gnd0,
      MCH1_ReadData_Exists => open,
      MCH2_Access_Control => net_gnd0,
      MCH2_Access_Data => net_gnd32,
      MCH2_Access_Write => net_gnd0,
      MCH2_Access_Full => open,
      MCH2_ReadData_Control => open,
      MCH2_ReadData_Data => open,
      MCH2_ReadData_Read => net_gnd0,
      MCH2_ReadData_Exists => open,
      MCH3_Access_Control => net_gnd0,
      MCH3_Access_Data => net_gnd32,
      MCH3_Access_Write => net_gnd0,
      MCH3_Access_Full => open,
      MCH3_ReadData_Control => open,
      MCH3_ReadData_Data => open,
      MCH3_ReadData_Read => net_gnd0,
      MCH3_ReadData_Exists => open,
      PLB_ABus => mb_plb_PLB_ABus,
      PLB_UABus => mb_plb_PLB_UABus,
      PLB_PAValid => mb_plb_PLB_PAValid,
      PLB_SAValid => mb_plb_PLB_SAValid,
      PLB_rdPrim => mb_plb_PLB_rdPrim(5),
      PLB_wrPrim => mb_plb_PLB_wrPrim(5),
      PLB_masterID => mb_plb_PLB_masterID(0 to 0),
      PLB_abort => mb_plb_PLB_abort,
      PLB_busLock => mb_plb_PLB_busLock,
      PLB_RNW => mb_plb_PLB_RNW,
      PLB_BE => mb_plb_PLB_BE,
      PLB_MSize => mb_plb_PLB_MSize,
      PLB_size => mb_plb_PLB_size,
      PLB_type => mb_plb_PLB_type,
      PLB_lockErr => mb_plb_PLB_lockErr,
      PLB_wrDBus => mb_plb_PLB_wrDBus,
      PLB_wrBurst => mb_plb_PLB_wrBurst,
      PLB_rdBurst => mb_plb_PLB_rdBurst,
      PLB_wrPendReq => mb_plb_PLB_wrPendReq,
      PLB_rdPendReq => mb_plb_PLB_rdPendReq,
      PLB_wrPendPri => mb_plb_PLB_wrPendPri,
      PLB_rdPendPri => mb_plb_PLB_rdPendPri,
      PLB_reqPri => mb_plb_PLB_reqPri,
      PLB_TAttribute => mb_plb_PLB_TAttribute,
      Sl_addrAck => mb_plb_Sl_addrAck(5),
      Sl_SSize => mb_plb_Sl_SSize(10 to 11),
      Sl_wait => mb_plb_Sl_wait(5),
      Sl_rearbitrate => mb_plb_Sl_rearbitrate(5),
      Sl_wrDAck => mb_plb_Sl_wrDAck(5),
      Sl_wrComp => mb_plb_Sl_wrComp(5),
      Sl_wrBTerm => mb_plb_Sl_wrBTerm(5),
      Sl_rdDBus => mb_plb_Sl_rdDBus(160 to 191),
      Sl_rdWdAddr => mb_plb_Sl_rdWdAddr(20 to 23),
      Sl_rdDAck => mb_plb_Sl_rdDAck(5),
      Sl_rdComp => mb_plb_Sl_rdComp(5),
      Sl_rdBTerm => mb_plb_Sl_rdBTerm(5),
      Sl_MBusy => mb_plb_Sl_MBusy(10 to 11),
      Sl_MWrErr => mb_plb_Sl_MWrErr(10 to 11),
      Sl_MRdErr => mb_plb_Sl_MRdErr(10 to 11),
      Sl_MIRQ => mb_plb_Sl_MIRQ(10 to 11),
      Mem_DQ_I => net_bsbassign117,
      Mem_DQ_O => net_bsbassign133,
      Mem_DQ_T => net_bsbassign149,
      Mem_A => net_bsbassign85,
      Mem_RPN => net_bsbassign166,
      Mem_CEN => net_bsbassign116(0 to 0),
      Mem_OEN => net_bsbassign165(0 to 0),
      Mem_WEN => net_bsbassign167,
      Mem_QWEN => open,
      Mem_BEN => open,
      Mem_CE => open,
      Mem_ADV_LDN => open,
      Mem_LBON => open,
      Mem_CKEN => open,
      Mem_RNW => open
    );

  Digilent_QuadSPI_Cntlr : digilent_quadspi_cntlr_wrapper
    port map (
      C => net_bsbassign168,
      S => net_bsbassign181,
      DQ_O => net_bsbassign173,
      DQ_T => net_bsbassign177,
      DQ_I => net_bsbassign169,
      SPLB_Clk => clk_66_6667MHz,
      SPLB_Rst => mb_plb_SPLB_Rst(6),
      PLB_ABus => mb_plb_PLB_ABus,
      PLB_UABus => mb_plb_PLB_UABus,
      PLB_PAValid => mb_plb_PLB_PAValid,
      PLB_SAValid => mb_plb_PLB_SAValid,
      PLB_rdPrim => mb_plb_PLB_rdPrim(6),
      PLB_wrPrim => mb_plb_PLB_wrPrim(6),
      PLB_masterID => mb_plb_PLB_masterID(0 to 0),
      PLB_abort => mb_plb_PLB_abort,
      PLB_busLock => mb_plb_PLB_busLock,
      PLB_RNW => mb_plb_PLB_RNW,
      PLB_BE => mb_plb_PLB_BE,
      PLB_MSize => mb_plb_PLB_MSize,
      PLB_size => mb_plb_PLB_size,
      PLB_type => mb_plb_PLB_type,
      PLB_lockErr => mb_plb_PLB_lockErr,
      PLB_wrDBus => mb_plb_PLB_wrDBus,
      PLB_wrBurst => mb_plb_PLB_wrBurst,
      PLB_rdBurst => mb_plb_PLB_rdBurst,
      PLB_wrPendReq => mb_plb_PLB_wrPendReq,
      PLB_rdPendReq => mb_plb_PLB_rdPendReq,
      PLB_wrPendPri => mb_plb_PLB_wrPendPri,
      PLB_rdPendPri => mb_plb_PLB_rdPendPri,
      PLB_reqPri => mb_plb_PLB_reqPri,
      PLB_TAttribute => mb_plb_PLB_TAttribute,
      Sl_addrAck => mb_plb_Sl_addrAck(6),
      Sl_SSize => mb_plb_Sl_SSize(12 to 13),
      Sl_wait => mb_plb_Sl_wait(6),
      Sl_rearbitrate => mb_plb_Sl_rearbitrate(6),
      Sl_wrDAck => mb_plb_Sl_wrDAck(6),
      Sl_wrComp => mb_plb_Sl_wrComp(6),
      Sl_wrBTerm => mb_plb_Sl_wrBTerm(6),
      Sl_rdDBus => mb_plb_Sl_rdDBus(192 to 223),
      Sl_rdWdAddr => mb_plb_Sl_rdWdAddr(24 to 27),
      Sl_rdDAck => mb_plb_Sl_rdDAck(6),
      Sl_rdComp => mb_plb_Sl_rdComp(6),
      Sl_rdBTerm => mb_plb_Sl_rdBTerm(6),
      Sl_MBusy => mb_plb_Sl_MBusy(12 to 13),
      Sl_MWrErr => mb_plb_Sl_MWrErr(12 to 13),
      Sl_MRdErr => mb_plb_Sl_MRdErr(12 to 13),
      Sl_MIRQ => mb_plb_Sl_MIRQ(12 to 13)
    );

  Digilent_SevSeg_Disp : digilent_sevseg_disp_wrapper
    port map (
      AN => fpga_0_Digilent_SevSeg_Disp_AN_pin,
      SEG => fpga_0_Digilent_SevSeg_Disp_SEG_pin,
      SPLB_Clk => clk_66_6667MHz,
      SPLB_Rst => mb_plb_SPLB_Rst(7),
      PLB_ABus => mb_plb_PLB_ABus,
      PLB_UABus => mb_plb_PLB_UABus,
      PLB_PAValid => mb_plb_PLB_PAValid,
      PLB_SAValid => mb_plb_PLB_SAValid,
      PLB_rdPrim => mb_plb_PLB_rdPrim(7),
      PLB_wrPrim => mb_plb_PLB_wrPrim(7),
      PLB_masterID => mb_plb_PLB_masterID(0 to 0),
      PLB_abort => mb_plb_PLB_abort,
      PLB_busLock => mb_plb_PLB_busLock,
      PLB_RNW => mb_plb_PLB_RNW,
      PLB_BE => mb_plb_PLB_BE,
      PLB_MSize => mb_plb_PLB_MSize,
      PLB_size => mb_plb_PLB_size,
      PLB_type => mb_plb_PLB_type,
      PLB_lockErr => mb_plb_PLB_lockErr,
      PLB_wrDBus => mb_plb_PLB_wrDBus,
      PLB_wrBurst => mb_plb_PLB_wrBurst,
      PLB_rdBurst => mb_plb_PLB_rdBurst,
      PLB_wrPendReq => mb_plb_PLB_wrPendReq,
      PLB_rdPendReq => mb_plb_PLB_rdPendReq,
      PLB_wrPendPri => mb_plb_PLB_wrPendPri,
      PLB_rdPendPri => mb_plb_PLB_rdPendPri,
      PLB_reqPri => mb_plb_PLB_reqPri,
      PLB_TAttribute => mb_plb_PLB_TAttribute,
      Sl_addrAck => mb_plb_Sl_addrAck(7),
      Sl_SSize => mb_plb_Sl_SSize(14 to 15),
      Sl_wait => mb_plb_Sl_wait(7),
      Sl_rearbitrate => mb_plb_Sl_rearbitrate(7),
      Sl_wrDAck => mb_plb_Sl_wrDAck(7),
      Sl_wrComp => mb_plb_Sl_wrComp(7),
      Sl_wrBTerm => mb_plb_Sl_wrBTerm(7),
      Sl_rdDBus => mb_plb_Sl_rdDBus(224 to 255),
      Sl_rdWdAddr => mb_plb_Sl_rdWdAddr(28 to 31),
      Sl_rdDAck => mb_plb_Sl_rdDAck(7),
      Sl_rdComp => mb_plb_Sl_rdComp(7),
      Sl_rdBTerm => mb_plb_Sl_rdBTerm(7),
      Sl_MBusy => mb_plb_Sl_MBusy(14 to 15),
      Sl_MWrErr => mb_plb_Sl_MWrErr(14 to 15),
      Sl_MRdErr => mb_plb_Sl_MRdErr(14 to 15),
      Sl_MIRQ => mb_plb_Sl_MIRQ(14 to 15)
    );

  mem_bus_mux_0 : mem_bus_mux_0_wrapper
    port map (
      ADDR_RAM_IN => net_bsbassign0,
      DQ_O_RAM => net_bsbassign51,
      DQ_T_RAM => net_bsbassign67,
      DQ_I_RAM => net_bsbassign35,
      BEN_RAM_I => net_bsbassign32,
      CEN_RAM_I => net_bsbassign34(0 to 0),
      OEN_RAM_I => net_bsbassign83(0 to 0),
      WEN_RAM_I => net_bsbassign84,
      ADDR_FLASH_IN => net_bsbassign85,
      DQ_O_FLASH => net_bsbassign133,
      DQ_T_FLASH => net_bsbassign149,
      DQ_I_FLASH => net_bsbassign117,
      RPN_FLASH_I => net_bsbassign166,
      CEN_FLASH_I => net_bsbassign116(0 to 0),
      OEN_FLASH_I => net_bsbassign165(0 to 0),
      WEN_FLASH_I => net_bsbassign167,
      C_QUAD_SPI_I => net_bsbassign168,
      S_QUAD_SPI_I => net_bsbassign181,
      DQ_O_QUAD_SPI => net_bsbassign173,
      DQ_T_QUAD_SPI => net_bsbassign177,
      DQ_I_QUAD_SPI => net_bsbassign169,
      MEM_ADDR => fpga_0_mem_bus_mux_0_MEM_ADDR_pin,
      DQ_O => fpga_0_mem_bus_mux_0_DQ_pin_O,
      DQ_T => fpga_0_mem_bus_mux_0_DQ_pin_T,
      DQ_I => fpga_0_mem_bus_mux_0_DQ_pin_I,
      MEM_OEN => fpga_0_mem_bus_mux_0_MEM_OEN_pin,
      MEM_WEN => fpga_0_mem_bus_mux_0_MEM_WEN_pin,
      RAM_CEN_O => fpga_0_mem_bus_mux_0_RAM_CEN_O_pin,
      RAM_BEN_O => fpga_0_mem_bus_mux_0_RAM_BEN_O_pin,
      FLASH_ADDR => fpga_0_mem_bus_mux_0_FLASH_ADDR_pin,
      FLASH_CEN_O => fpga_0_mem_bus_mux_0_FLASH_CEN_O_pin,
      FLASH_RPN_O => fpga_0_mem_bus_mux_0_FLASH_RPN_O_pin,
      QUAD_SPI_C_O => fpga_0_mem_bus_mux_0_QUAD_SPI_C_O_pin,
      QUAD_SPI_S_O => fpga_0_mem_bus_mux_0_QUAD_SPI_S_O_pin,
      MOSI_QUAD_SPI_O => fpga_0_mem_bus_mux_0_MOSI_QUAD_SPI_pin_O,
      MOSI_QUAD_SPI_T => fpga_0_mem_bus_mux_0_MOSI_QUAD_SPI_pin_T,
      MOSI_QUAD_SPI_I => fpga_0_mem_bus_mux_0_MOSI_QUAD_SPI_pin_I
    );

  clock_generator_0 : clock_generator_0_wrapper
    port map (
      CLKIN => CLK_S,
      CLKOUT0 => clk_66_6667MHz,
      CLKOUT1 => open,
      CLKOUT2 => open,
      CLKOUT3 => open,
      CLKOUT4 => open,
      CLKOUT5 => open,
      CLKOUT6 => open,
      CLKOUT7 => open,
      CLKOUT8 => open,
      CLKOUT9 => open,
      CLKOUT10 => open,
      CLKOUT11 => open,
      CLKOUT12 => open,
      CLKOUT13 => open,
      CLKOUT14 => open,
      CLKOUT15 => open,
      CLKFBIN => net_gnd0,
      CLKFBOUT => open,
      PSCLK => net_gnd0,
      PSEN => net_gnd0,
      PSINCDEC => net_gnd0,
      PSDONE => open,
      RST => sys_rst_s,
      LOCKED => Dcm_all_locked
    );

  mdm_0 : mdm_0_wrapper
    port map (
      Interrupt => open,
      Debug_SYS_Rst => Debug_SYS_Rst,
      Ext_BRK => Ext_BRK,
      Ext_NM_BRK => Ext_NM_BRK,
      S_AXI_ACLK => net_gnd0,
      S_AXI_ARESETN => net_gnd0,
      S_AXI_AWADDR => net_gnd32(0 to 31),
      S_AXI_AWVALID => net_gnd0,
      S_AXI_AWREADY => open,
      S_AXI_WDATA => net_gnd32(0 to 31),
      S_AXI_WSTRB => net_gnd4(0 to 3),
      S_AXI_WVALID => net_gnd0,
      S_AXI_WREADY => open,
      S_AXI_BRESP => open,
      S_AXI_BVALID => open,
      S_AXI_BREADY => net_gnd0,
      S_AXI_ARADDR => net_gnd32(0 to 31),
      S_AXI_ARVALID => net_gnd0,
      S_AXI_ARREADY => open,
      S_AXI_RDATA => open,
      S_AXI_RRESP => open,
      S_AXI_RVALID => open,
      S_AXI_RREADY => net_gnd0,
      SPLB_Clk => clk_66_6667MHz,
      SPLB_Rst => mb_plb_SPLB_Rst(8),
      PLB_ABus => mb_plb_PLB_ABus,
      PLB_UABus => mb_plb_PLB_UABus,
      PLB_PAValid => mb_plb_PLB_PAValid,
      PLB_SAValid => mb_plb_PLB_SAValid,
      PLB_rdPrim => mb_plb_PLB_rdPrim(8),
      PLB_wrPrim => mb_plb_PLB_wrPrim(8),
      PLB_masterID => mb_plb_PLB_masterID(0 to 0),
      PLB_abort => mb_plb_PLB_abort,
      PLB_busLock => mb_plb_PLB_busLock,
      PLB_RNW => mb_plb_PLB_RNW,
      PLB_BE => mb_plb_PLB_BE,
      PLB_MSize => mb_plb_PLB_MSize,
      PLB_size => mb_plb_PLB_size,
      PLB_type => mb_plb_PLB_type,
      PLB_lockErr => mb_plb_PLB_lockErr,
      PLB_wrDBus => mb_plb_PLB_wrDBus,
      PLB_wrBurst => mb_plb_PLB_wrBurst,
      PLB_rdBurst => mb_plb_PLB_rdBurst,
      PLB_wrPendReq => mb_plb_PLB_wrPendReq,
      PLB_rdPendReq => mb_plb_PLB_rdPendReq,
      PLB_wrPendPri => mb_plb_PLB_wrPendPri,
      PLB_rdPendPri => mb_plb_PLB_rdPendPri,
      PLB_reqPri => mb_plb_PLB_reqPri,
      PLB_TAttribute => mb_plb_PLB_TAttribute,
      Sl_addrAck => mb_plb_Sl_addrAck(8),
      Sl_SSize => mb_plb_Sl_SSize(16 to 17),
      Sl_wait => mb_plb_Sl_wait(8),
      Sl_rearbitrate => mb_plb_Sl_rearbitrate(8),
      Sl_wrDAck => mb_plb_Sl_wrDAck(8),
      Sl_wrComp => mb_plb_Sl_wrComp(8),
      Sl_wrBTerm => mb_plb_Sl_wrBTerm(8),
      Sl_rdDBus => mb_plb_Sl_rdDBus(256 to 287),
      Sl_rdWdAddr => mb_plb_Sl_rdWdAddr(32 to 35),
      Sl_rdDAck => mb_plb_Sl_rdDAck(8),
      Sl_rdComp => mb_plb_Sl_rdComp(8),
      Sl_rdBTerm => mb_plb_Sl_rdBTerm(8),
      Sl_MBusy => mb_plb_Sl_MBusy(16 to 17),
      Sl_MWrErr => mb_plb_Sl_MWrErr(16 to 17),
      Sl_MRdErr => mb_plb_Sl_MRdErr(16 to 17),
      Sl_MIRQ => mb_plb_Sl_MIRQ(16 to 17),
      Dbg_Clk_0 => microblaze_0_mdm_bus_Dbg_Clk,
      Dbg_TDI_0 => microblaze_0_mdm_bus_Dbg_TDI,
      Dbg_TDO_0 => microblaze_0_mdm_bus_Dbg_TDO,
      Dbg_Reg_En_0 => microblaze_0_mdm_bus_Dbg_Reg_En,
      Dbg_Capture_0 => microblaze_0_mdm_bus_Dbg_Capture,
      Dbg_Shift_0 => microblaze_0_mdm_bus_Dbg_Shift,
      Dbg_Update_0 => microblaze_0_mdm_bus_Dbg_Update,
      Dbg_Rst_0 => microblaze_0_mdm_bus_Debug_Rst,
      Dbg_Clk_1 => open,
      Dbg_TDI_1 => open,
      Dbg_TDO_1 => net_gnd0,
      Dbg_Reg_En_1 => open,
      Dbg_Capture_1 => open,
      Dbg_Shift_1 => open,
      Dbg_Update_1 => open,
      Dbg_Rst_1 => open,
      Dbg_Clk_2 => open,
      Dbg_TDI_2 => open,
      Dbg_TDO_2 => net_gnd0,
      Dbg_Reg_En_2 => open,
      Dbg_Capture_2 => open,
      Dbg_Shift_2 => open,
      Dbg_Update_2 => open,
      Dbg_Rst_2 => open,
      Dbg_Clk_3 => open,
      Dbg_TDI_3 => open,
      Dbg_TDO_3 => net_gnd0,
      Dbg_Reg_En_3 => open,
      Dbg_Capture_3 => open,
      Dbg_Shift_3 => open,
      Dbg_Update_3 => open,
      Dbg_Rst_3 => open,
      Dbg_Clk_4 => open,
      Dbg_TDI_4 => open,
      Dbg_TDO_4 => net_gnd0,
      Dbg_Reg_En_4 => open,
      Dbg_Capture_4 => open,
      Dbg_Shift_4 => open,
      Dbg_Update_4 => open,
      Dbg_Rst_4 => open,
      Dbg_Clk_5 => open,
      Dbg_TDI_5 => open,
      Dbg_TDO_5 => net_gnd0,
      Dbg_Reg_En_5 => open,
      Dbg_Capture_5 => open,
      Dbg_Shift_5 => open,
      Dbg_Update_5 => open,
      Dbg_Rst_5 => open,
      Dbg_Clk_6 => open,
      Dbg_TDI_6 => open,
      Dbg_TDO_6 => net_gnd0,
      Dbg_Reg_En_6 => open,
      Dbg_Capture_6 => open,
      Dbg_Shift_6 => open,
      Dbg_Update_6 => open,
      Dbg_Rst_6 => open,
      Dbg_Clk_7 => open,
      Dbg_TDI_7 => open,
      Dbg_TDO_7 => net_gnd0,
      Dbg_Reg_En_7 => open,
      Dbg_Capture_7 => open,
      Dbg_Shift_7 => open,
      Dbg_Update_7 => open,
      Dbg_Rst_7 => open,
      bscan_tdi => open,
      bscan_reset => open,
      bscan_shift => open,
      bscan_update => open,
      bscan_capture => open,
      bscan_sel1 => open,
      bscan_drck1 => open,
      bscan_tdo1 => net_gnd0,
      Ext_JTAG_DRCK => open,
      Ext_JTAG_RESET => open,
      Ext_JTAG_SEL => open,
      Ext_JTAG_CAPTURE => open,
      Ext_JTAG_SHIFT => open,
      Ext_JTAG_UPDATE => open,
      Ext_JTAG_TDI => open,
      Ext_JTAG_TDO => net_gnd0
    );

  proc_sys_reset_0 : proc_sys_reset_0_wrapper
    port map (
      Slowest_sync_clk => clk_66_6667MHz,
      Ext_Reset_In => sys_rst_s,
      Aux_Reset_In => net_gnd0,
      MB_Debug_Sys_Rst => Debug_SYS_Rst,
      Core_Reset_Req_0 => net_gnd0,
      Chip_Reset_Req_0 => net_gnd0,
      System_Reset_Req_0 => net_gnd0,
      Core_Reset_Req_1 => net_gnd0,
      Chip_Reset_Req_1 => net_gnd0,
      System_Reset_Req_1 => net_gnd0,
      Dcm_locked => Dcm_all_locked,
      RstcPPCresetcore_0 => open,
      RstcPPCresetchip_0 => open,
      RstcPPCresetsys_0 => open,
      RstcPPCresetcore_1 => open,
      RstcPPCresetchip_1 => open,
      RstcPPCresetsys_1 => open,
      MB_Reset => mb_reset,
      Bus_Struct_Reset => sys_bus_reset(0 to 0),
      Peripheral_Reset => open,
      Interconnect_aresetn => open,
      Peripheral_aresetn => open
    );

  xps_intc_0 : xps_intc_0_wrapper
    port map (
      SPLB_Clk => clk_66_6667MHz,
      SPLB_Rst => mb_plb_SPLB_Rst(9),
      PLB_ABus => mb_plb_PLB_ABus,
      PLB_PAValid => mb_plb_PLB_PAValid,
      PLB_masterID => mb_plb_PLB_masterID(0 to 0),
      PLB_RNW => mb_plb_PLB_RNW,
      PLB_BE => mb_plb_PLB_BE,
      PLB_size => mb_plb_PLB_size,
      PLB_type => mb_plb_PLB_type,
      PLB_wrDBus => mb_plb_PLB_wrDBus,
      PLB_UABus => mb_plb_PLB_UABus,
      PLB_SAValid => mb_plb_PLB_SAValid,
      PLB_rdPrim => mb_plb_PLB_rdPrim(9),
      PLB_wrPrim => mb_plb_PLB_wrPrim(9),
      PLB_abort => mb_plb_PLB_abort,
      PLB_busLock => mb_plb_PLB_busLock,
      PLB_MSize => mb_plb_PLB_MSize,
      PLB_lockErr => mb_plb_PLB_lockErr,
      PLB_wrBurst => mb_plb_PLB_wrBurst,
      PLB_rdBurst => mb_plb_PLB_rdBurst,
      PLB_wrPendReq => mb_plb_PLB_wrPendReq,
      PLB_rdPendReq => mb_plb_PLB_rdPendReq,
      PLB_wrPendPri => mb_plb_PLB_wrPendPri,
      PLB_rdPendPri => mb_plb_PLB_rdPendPri,
      PLB_reqPri => mb_plb_PLB_reqPri,
      PLB_TAttribute => mb_plb_PLB_TAttribute,
      Sl_addrAck => mb_plb_Sl_addrAck(9),
      Sl_SSize => mb_plb_Sl_SSize(18 to 19),
      Sl_wait => mb_plb_Sl_wait(9),
      Sl_rearbitrate => mb_plb_Sl_rearbitrate(9),
      Sl_wrDAck => mb_plb_Sl_wrDAck(9),
      Sl_wrComp => mb_plb_Sl_wrComp(9),
      Sl_rdDBus => mb_plb_Sl_rdDBus(288 to 319),
      Sl_rdDAck => mb_plb_Sl_rdDAck(9),
      Sl_rdComp => mb_plb_Sl_rdComp(9),
      Sl_MBusy => mb_plb_Sl_MBusy(18 to 19),
      Sl_MWrErr => mb_plb_Sl_MWrErr(18 to 19),
      Sl_MRdErr => mb_plb_Sl_MRdErr(18 to 19),
      Sl_wrBTerm => mb_plb_Sl_wrBTerm(9),
      Sl_rdWdAddr => mb_plb_Sl_rdWdAddr(36 to 39),
      Sl_rdBTerm => mb_plb_Sl_rdBTerm(9),
      Sl_MIRQ => mb_plb_Sl_MIRQ(18 to 19),
      Intr => pgassign1,
      Irq => microblaze_0_Interrupt
    );

  xps_timer_0 : xps_timer_0_wrapper
    port map (
      CaptureTrig0 => net_gnd0,
      CaptureTrig1 => net_gnd0,
      GenerateOut0 => open,
      GenerateOut1 => open,
      PWM0 => open,
      Interrupt => xps_timer_0_Interrupt,
      Freeze => net_gnd0,
      SPLB_Clk => clk_66_6667MHz,
      SPLB_Rst => mb_plb_SPLB_Rst(10),
      PLB_ABus => mb_plb_PLB_ABus,
      PLB_PAValid => mb_plb_PLB_PAValid,
      PLB_masterID => mb_plb_PLB_masterID(0 to 0),
      PLB_RNW => mb_plb_PLB_RNW,
      PLB_BE => mb_plb_PLB_BE,
      PLB_size => mb_plb_PLB_size,
      PLB_type => mb_plb_PLB_type,
      PLB_wrDBus => mb_plb_PLB_wrDBus,
      Sl_addrAck => mb_plb_Sl_addrAck(10),
      Sl_SSize => mb_plb_Sl_SSize(20 to 21),
      Sl_wait => mb_plb_Sl_wait(10),
      Sl_rearbitrate => mb_plb_Sl_rearbitrate(10),
      Sl_wrDAck => mb_plb_Sl_wrDAck(10),
      Sl_wrComp => mb_plb_Sl_wrComp(10),
      Sl_rdDBus => mb_plb_Sl_rdDBus(320 to 351),
      Sl_rdDAck => mb_plb_Sl_rdDAck(10),
      Sl_rdComp => mb_plb_Sl_rdComp(10),
      Sl_MBusy => mb_plb_Sl_MBusy(20 to 21),
      Sl_MWrErr => mb_plb_Sl_MWrErr(20 to 21),
      Sl_MRdErr => mb_plb_Sl_MRdErr(20 to 21),
      PLB_UABus => mb_plb_PLB_UABus,
      PLB_SAValid => mb_plb_PLB_SAValid,
      PLB_rdPrim => mb_plb_PLB_rdPrim(10),
      PLB_wrPrim => mb_plb_PLB_wrPrim(10),
      PLB_abort => mb_plb_PLB_abort,
      PLB_busLock => mb_plb_PLB_busLock,
      PLB_MSize => mb_plb_PLB_MSize,
      PLB_lockErr => mb_plb_PLB_lockErr,
      PLB_wrBurst => mb_plb_PLB_wrBurst,
      PLB_rdBurst => mb_plb_PLB_rdBurst,
      PLB_wrPendReq => mb_plb_PLB_wrPendReq,
      PLB_rdPendReq => mb_plb_PLB_rdPendReq,
      PLB_wrPendPri => mb_plb_PLB_wrPendPri,
      PLB_rdPendPri => mb_plb_PLB_rdPendPri,
      PLB_reqPri => mb_plb_PLB_reqPri,
      PLB_TAttribute => mb_plb_PLB_TAttribute,
      Sl_wrBTerm => mb_plb_Sl_wrBTerm(10),
      Sl_rdWdAddr => mb_plb_Sl_rdWdAddr(40 to 43),
      Sl_rdBTerm => mb_plb_Sl_rdBTerm(10),
      Sl_MIRQ => mb_plb_Sl_MIRQ(20 to 21)
    );

  iobuf_0 : IOBUF
    port map (
      I => fpga_0_Ethernet_Lite_PHY_MDIO_pin_O,
      IO => fpga_0_Ethernet_Lite_PHY_MDIO_pin,
      O => fpga_0_Ethernet_Lite_PHY_MDIO_pin_I,
      T => fpga_0_Ethernet_Lite_PHY_MDIO_pin_T
    );

  iobuf_1 : IOBUF
    port map (
      I => fpga_0_mem_bus_mux_0_DQ_pin_O(0),
      IO => fpga_0_mem_bus_mux_0_DQ_pin(0),
      O => fpga_0_mem_bus_mux_0_DQ_pin_I(0),
      T => fpga_0_mem_bus_mux_0_DQ_pin_T(0)
    );

  iobuf_2 : IOBUF
    port map (
      I => fpga_0_mem_bus_mux_0_DQ_pin_O(1),
      IO => fpga_0_mem_bus_mux_0_DQ_pin(1),
      O => fpga_0_mem_bus_mux_0_DQ_pin_I(1),
      T => fpga_0_mem_bus_mux_0_DQ_pin_T(1)
    );

  iobuf_3 : IOBUF
    port map (
      I => fpga_0_mem_bus_mux_0_DQ_pin_O(2),
      IO => fpga_0_mem_bus_mux_0_DQ_pin(2),
      O => fpga_0_mem_bus_mux_0_DQ_pin_I(2),
      T => fpga_0_mem_bus_mux_0_DQ_pin_T(2)
    );

  iobuf_4 : IOBUF
    port map (
      I => fpga_0_mem_bus_mux_0_DQ_pin_O(3),
      IO => fpga_0_mem_bus_mux_0_DQ_pin(3),
      O => fpga_0_mem_bus_mux_0_DQ_pin_I(3),
      T => fpga_0_mem_bus_mux_0_DQ_pin_T(3)
    );

  iobuf_5 : IOBUF
    port map (
      I => fpga_0_mem_bus_mux_0_DQ_pin_O(4),
      IO => fpga_0_mem_bus_mux_0_DQ_pin(4),
      O => fpga_0_mem_bus_mux_0_DQ_pin_I(4),
      T => fpga_0_mem_bus_mux_0_DQ_pin_T(4)
    );

  iobuf_6 : IOBUF
    port map (
      I => fpga_0_mem_bus_mux_0_DQ_pin_O(5),
      IO => fpga_0_mem_bus_mux_0_DQ_pin(5),
      O => fpga_0_mem_bus_mux_0_DQ_pin_I(5),
      T => fpga_0_mem_bus_mux_0_DQ_pin_T(5)
    );

  iobuf_7 : IOBUF
    port map (
      I => fpga_0_mem_bus_mux_0_DQ_pin_O(6),
      IO => fpga_0_mem_bus_mux_0_DQ_pin(6),
      O => fpga_0_mem_bus_mux_0_DQ_pin_I(6),
      T => fpga_0_mem_bus_mux_0_DQ_pin_T(6)
    );

  iobuf_8 : IOBUF
    port map (
      I => fpga_0_mem_bus_mux_0_DQ_pin_O(7),
      IO => fpga_0_mem_bus_mux_0_DQ_pin(7),
      O => fpga_0_mem_bus_mux_0_DQ_pin_I(7),
      T => fpga_0_mem_bus_mux_0_DQ_pin_T(7)
    );

  iobuf_9 : IOBUF
    port map (
      I => fpga_0_mem_bus_mux_0_DQ_pin_O(8),
      IO => fpga_0_mem_bus_mux_0_DQ_pin(8),
      O => fpga_0_mem_bus_mux_0_DQ_pin_I(8),
      T => fpga_0_mem_bus_mux_0_DQ_pin_T(8)
    );

  iobuf_10 : IOBUF
    port map (
      I => fpga_0_mem_bus_mux_0_DQ_pin_O(9),
      IO => fpga_0_mem_bus_mux_0_DQ_pin(9),
      O => fpga_0_mem_bus_mux_0_DQ_pin_I(9),
      T => fpga_0_mem_bus_mux_0_DQ_pin_T(9)
    );

  iobuf_11 : IOBUF
    port map (
      I => fpga_0_mem_bus_mux_0_DQ_pin_O(10),
      IO => fpga_0_mem_bus_mux_0_DQ_pin(10),
      O => fpga_0_mem_bus_mux_0_DQ_pin_I(10),
      T => fpga_0_mem_bus_mux_0_DQ_pin_T(10)
    );

  iobuf_12 : IOBUF
    port map (
      I => fpga_0_mem_bus_mux_0_DQ_pin_O(11),
      IO => fpga_0_mem_bus_mux_0_DQ_pin(11),
      O => fpga_0_mem_bus_mux_0_DQ_pin_I(11),
      T => fpga_0_mem_bus_mux_0_DQ_pin_T(11)
    );

  iobuf_13 : IOBUF
    port map (
      I => fpga_0_mem_bus_mux_0_DQ_pin_O(12),
      IO => fpga_0_mem_bus_mux_0_DQ_pin(12),
      O => fpga_0_mem_bus_mux_0_DQ_pin_I(12),
      T => fpga_0_mem_bus_mux_0_DQ_pin_T(12)
    );

  iobuf_14 : IOBUF
    port map (
      I => fpga_0_mem_bus_mux_0_DQ_pin_O(13),
      IO => fpga_0_mem_bus_mux_0_DQ_pin(13),
      O => fpga_0_mem_bus_mux_0_DQ_pin_I(13),
      T => fpga_0_mem_bus_mux_0_DQ_pin_T(13)
    );

  iobuf_15 : IOBUF
    port map (
      I => fpga_0_mem_bus_mux_0_DQ_pin_O(14),
      IO => fpga_0_mem_bus_mux_0_DQ_pin(14),
      O => fpga_0_mem_bus_mux_0_DQ_pin_I(14),
      T => fpga_0_mem_bus_mux_0_DQ_pin_T(14)
    );

  iobuf_16 : IOBUF
    port map (
      I => fpga_0_mem_bus_mux_0_DQ_pin_O(15),
      IO => fpga_0_mem_bus_mux_0_DQ_pin(15),
      O => fpga_0_mem_bus_mux_0_DQ_pin_I(15),
      T => fpga_0_mem_bus_mux_0_DQ_pin_T(15)
    );

  iobuf_17 : IOBUF
    port map (
      I => fpga_0_mem_bus_mux_0_MOSI_QUAD_SPI_pin_O,
      IO => fpga_0_mem_bus_mux_0_MOSI_QUAD_SPI_pin,
      O => fpga_0_mem_bus_mux_0_MOSI_QUAD_SPI_pin_I,
      T => fpga_0_mem_bus_mux_0_MOSI_QUAD_SPI_pin_T
    );

end architecture STRUCTURE;

