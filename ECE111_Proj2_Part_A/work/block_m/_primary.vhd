library verilog;
use verilog.vl_types.all;
entity block_m is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        writing         : in     vl_logic;
        datain          : in     vl_logic_vector(31 downto 0);
        CU1_lrunwo      : out    vl_logic;
        CU1_haslast     : out    vl_logic;
        CU2_haslast     : out    vl_logic;
        CU3_haslast     : out    vl_logic;
        CU4_haslast     : out    vl_logic;
        CU1_curr        : out    vl_logic_vector(15 downto 0);
        CU1_lrun        : out    vl_logic_vector(15 downto 0);
        CU2_curr        : out    vl_logic_vector(15 downto 0);
        CU3_curr        : out    vl_logic_vector(15 downto 0);
        CU4_curr        : out    vl_logic_vector(15 downto 0);
        CU4_lrunlen     : out    vl_logic_vector(7 downto 0);
        CU4_lrunval     : out    vl_logic_vector(7 downto 0)
    );
end block_m;
