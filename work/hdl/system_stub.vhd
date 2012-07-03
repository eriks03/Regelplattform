-------------------------------------------------------------------------------
-- system_stub.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity system_stub is
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
end system_stub;

architecture STRUCTURE of system_stub is

  component system is
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
  end component;

  attribute BUFFER_TYPE : STRING;
  attribute BOX_TYPE : STRING;
  attribute BUFFER_TYPE of fpga_0_Ethernet_Lite_PHY_tx_clk_pin : signal is "IBUF";
  attribute BUFFER_TYPE of fpga_0_Ethernet_Lite_PHY_rx_clk_pin : signal is "IBUF";
  attribute BOX_TYPE of system : component is "user_black_box";

begin

  system_i : system
    port map (
      fpga_0_RS232_Uart_1_RX_pin => fpga_0_RS232_Uart_1_RX_pin,
      fpga_0_RS232_Uart_1_TX_pin => fpga_0_RS232_Uart_1_TX_pin,
      fpga_0_LEDs_8Bits_GPIO_IO_O_pin => fpga_0_LEDs_8Bits_GPIO_IO_O_pin,
      fpga_0_Push_Buttons_4Bits_GPIO_IO_I_pin => fpga_0_Push_Buttons_4Bits_GPIO_IO_I_pin,
      fpga_0_Ethernet_Lite_PHY_tx_clk_pin => fpga_0_Ethernet_Lite_PHY_tx_clk_pin,
      fpga_0_Ethernet_Lite_PHY_rx_clk_pin => fpga_0_Ethernet_Lite_PHY_rx_clk_pin,
      fpga_0_Ethernet_Lite_PHY_crs_pin => fpga_0_Ethernet_Lite_PHY_crs_pin,
      fpga_0_Ethernet_Lite_PHY_dv_pin => fpga_0_Ethernet_Lite_PHY_dv_pin,
      fpga_0_Ethernet_Lite_PHY_rx_data_pin => fpga_0_Ethernet_Lite_PHY_rx_data_pin,
      fpga_0_Ethernet_Lite_PHY_col_pin => fpga_0_Ethernet_Lite_PHY_col_pin,
      fpga_0_Ethernet_Lite_PHY_rx_er_pin => fpga_0_Ethernet_Lite_PHY_rx_er_pin,
      fpga_0_Ethernet_Lite_PHY_rst_n_pin => fpga_0_Ethernet_Lite_PHY_rst_n_pin,
      fpga_0_Ethernet_Lite_PHY_tx_en_pin => fpga_0_Ethernet_Lite_PHY_tx_en_pin,
      fpga_0_Ethernet_Lite_PHY_tx_data_pin => fpga_0_Ethernet_Lite_PHY_tx_data_pin,
      fpga_0_Ethernet_Lite_PHY_MDC_pin => fpga_0_Ethernet_Lite_PHY_MDC_pin,
      fpga_0_Ethernet_Lite_PHY_MDIO_pin => fpga_0_Ethernet_Lite_PHY_MDIO_pin,
      fpga_0_Digilent_SevSeg_Disp_AN_pin => fpga_0_Digilent_SevSeg_Disp_AN_pin,
      fpga_0_Digilent_SevSeg_Disp_SEG_pin => fpga_0_Digilent_SevSeg_Disp_SEG_pin,
      fpga_0_mem_bus_mux_0_MEM_ADDR_pin => fpga_0_mem_bus_mux_0_MEM_ADDR_pin,
      fpga_0_mem_bus_mux_0_DQ_pin => fpga_0_mem_bus_mux_0_DQ_pin,
      fpga_0_mem_bus_mux_0_MEM_OEN_pin => fpga_0_mem_bus_mux_0_MEM_OEN_pin,
      fpga_0_mem_bus_mux_0_MEM_WEN_pin => fpga_0_mem_bus_mux_0_MEM_WEN_pin,
      fpga_0_mem_bus_mux_0_RAM_CEN_O_pin => fpga_0_mem_bus_mux_0_RAM_CEN_O_pin,
      fpga_0_mem_bus_mux_0_RAM_BEN_O_pin => fpga_0_mem_bus_mux_0_RAM_BEN_O_pin,
      fpga_0_mem_bus_mux_0_FLASH_ADDR_pin => fpga_0_mem_bus_mux_0_FLASH_ADDR_pin,
      fpga_0_mem_bus_mux_0_FLASH_CEN_O_pin => fpga_0_mem_bus_mux_0_FLASH_CEN_O_pin,
      fpga_0_mem_bus_mux_0_FLASH_RPN_O_pin => fpga_0_mem_bus_mux_0_FLASH_RPN_O_pin,
      fpga_0_mem_bus_mux_0_QUAD_SPI_C_O_pin => fpga_0_mem_bus_mux_0_QUAD_SPI_C_O_pin,
      fpga_0_mem_bus_mux_0_QUAD_SPI_S_O_pin => fpga_0_mem_bus_mux_0_QUAD_SPI_S_O_pin,
      fpga_0_mem_bus_mux_0_MOSI_QUAD_SPI_pin => fpga_0_mem_bus_mux_0_MOSI_QUAD_SPI_pin,
      fpga_0_clk_1_sys_clk_pin => fpga_0_clk_1_sys_clk_pin,
      fpga_0_rst_1_sys_rst_pin => fpga_0_rst_1_sys_rst_pin
    );

end architecture STRUCTURE;

