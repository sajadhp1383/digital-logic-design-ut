library verilog;
use verilog.vl_types.all;
entity divider is
    generic(
        Idle            : vl_logic_vector(1 downto 0) := (Hi0, Hi0);
        Starting        : vl_logic_vector(1 downto 0) := (Hi0, Hi1);
        Load            : vl_logic_vector(1 downto 0) := (Hi1, Hi0);
        \Process\       : vl_logic_vector(1 downto 0) := (Hi1, Hi1)
    );
    port(
        A               : in     vl_logic_vector(15 downto 0);
        B               : in     vl_logic_vector(15 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        start           : in     vl_logic;
        R2              : out    vl_logic_vector(15 downto 0);
        Q               : out    vl_logic_vector(15 downto 0);
        ready           : out    vl_logic;
        err             : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of Idle : constant is 2;
    attribute mti_svvh_generic_type of Starting : constant is 2;
    attribute mti_svvh_generic_type of Load : constant is 2;
    attribute mti_svvh_generic_type of \Process\ : constant is 2;
end divider;
