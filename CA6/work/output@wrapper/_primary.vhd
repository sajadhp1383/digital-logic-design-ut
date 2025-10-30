library verilog;
use verilog.vl_types.all;
entity outputWrapper is
    generic(
        Idle            : vl_logic_vector(1 downto 0) := (Hi0, Hi0);
        Loading         : vl_logic_vector(1 downto 0) := (Hi0, Hi1);
        ReceivingData   : vl_logic_vector(1 downto 0) := (Hi1, Hi0);
        WaitForNext     : vl_logic_vector(1 downto 0) := (Hi1, Hi1)
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        ready           : in     vl_logic;
        receiveData     : in     vl_logic;
        Q               : in     vl_logic_vector(15 downto 0);
        R               : in     vl_logic_vector(15 downto 0);
        readyForInput   : out    vl_logic;
        OutBuffFull     : out    vl_logic;
        eightBitOut     : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of Idle : constant is 2;
    attribute mti_svvh_generic_type of Loading : constant is 2;
    attribute mti_svvh_generic_type of ReceivingData : constant is 2;
    attribute mti_svvh_generic_type of WaitForNext : constant is 2;
end outputWrapper;
