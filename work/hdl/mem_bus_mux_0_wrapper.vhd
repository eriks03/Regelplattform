-------------------------------------------------------------------------------
-- mem_bus_mux_0_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library mem_bus_mux_v1_00_a;
use mem_bus_mux_v1_00_a.all;

entity mem_bus_mux_0_wrapper is
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
end mem_bus_mux_0_wrapper;

architecture STRUCTURE of mem_bus_mux_0_wrapper is

  component mem_bus_mux is
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

begin

  mem_bus_mux_0 : mem_bus_mux
    port map (
      ADDR_RAM_IN => ADDR_RAM_IN,
      DQ_O_RAM => DQ_O_RAM,
      DQ_T_RAM => DQ_T_RAM,
      DQ_I_RAM => DQ_I_RAM,
      BEN_RAM_I => BEN_RAM_I,
      CEN_RAM_I => CEN_RAM_I,
      OEN_RAM_I => OEN_RAM_I,
      WEN_RAM_I => WEN_RAM_I,
      ADDR_FLASH_IN => ADDR_FLASH_IN,
      DQ_O_FLASH => DQ_O_FLASH,
      DQ_T_FLASH => DQ_T_FLASH,
      DQ_I_FLASH => DQ_I_FLASH,
      RPN_FLASH_I => RPN_FLASH_I,
      CEN_FLASH_I => CEN_FLASH_I,
      OEN_FLASH_I => OEN_FLASH_I,
      WEN_FLASH_I => WEN_FLASH_I,
      C_QUAD_SPI_I => C_QUAD_SPI_I,
      S_QUAD_SPI_I => S_QUAD_SPI_I,
      DQ_O_QUAD_SPI => DQ_O_QUAD_SPI,
      DQ_T_QUAD_SPI => DQ_T_QUAD_SPI,
      DQ_I_QUAD_SPI => DQ_I_QUAD_SPI,
      MEM_ADDR => MEM_ADDR,
      DQ_O => DQ_O,
      DQ_T => DQ_T,
      DQ_I => DQ_I,
      MEM_OEN => MEM_OEN,
      MEM_WEN => MEM_WEN,
      RAM_CEN_O => RAM_CEN_O,
      RAM_BEN_O => RAM_BEN_O,
      FLASH_ADDR => FLASH_ADDR,
      FLASH_CEN_O => FLASH_CEN_O,
      FLASH_RPN_O => FLASH_RPN_O,
      QUAD_SPI_C_O => QUAD_SPI_C_O,
      QUAD_SPI_S_O => QUAD_SPI_S_O,
      MOSI_QUAD_SPI_O => MOSI_QUAD_SPI_O,
      MOSI_QUAD_SPI_T => MOSI_QUAD_SPI_T,
      MOSI_QUAD_SPI_I => MOSI_QUAD_SPI_I
    );

end architecture STRUCTURE;

