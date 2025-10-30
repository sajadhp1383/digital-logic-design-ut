library verilog;
use verilog.vl_types.all;
entity inputWrapper is
    generic(
        Idle            : vl_logic_vector(1 downto 0) := (Hi0, Hi0);
        Init            : vl_logic_vector(1 downto 0) := (Hi0, Hi1);
        ReceivingData   : vl_logic_vector(1 downto 0) := (Hi1, Hi0);
        WaitForNext     : vl_logic_vector(1 downto 0) := (Hi1, Hi1)
    );
    port(
        dataReady       : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        readyForInput   : in     vl_logic;
        eightBitInp     : in     vl_logic_vector(7 downto 0);
        A               : out    vl_logic_vector(15 downto 0);
        B               : out    vl_logic_vector(15 downto 0);
        readyToAccept   : out    vl_logic;
        start           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of Idle : constant is 2;
    attribute mti_svvh_generic_type of Init : constant is 2;
    attribute mti_svvh_generic_type of ReceivingData : constant is 2;
    attribute mti_svvh_generic_type of WaitForNext : constant is 2;
end inputWrapper;
