library verilog;
use verilog.vl_types.all;
entity eightBusInterface is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        dataReady       : in     vl_logic;
        receiveData     : in     vl_logic;
        eightBitInp     : in     vl_logic_vector(7 downto 0);
        readyToAccept   : out    vl_logic;
        OutBuffFull     : out    vl_logic;
        error           : out    vl_logic;
        eightBitOut     : out    vl_logic_vector(7 downto 0)
    );
end eightBusInterface;
