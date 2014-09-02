library verilog;
use verilog.vl_types.all;
entity rle is
    generic(
        starting        : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        reading         : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        writing         : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        working         : vl_logic_vector(0 to 1) := (Hi1, Hi1)
    );
    port(
        clk             : in     vl_logic;
        nreset          : in     vl_logic;
        start           : in     vl_logic;
        message_addr    : in     vl_logic_vector(31 downto 0);
        message_size    : in     vl_logic_vector(31 downto 0);
        rle_addr        : in     vl_logic_vector(31 downto 0);
        rle_size        : out    vl_logic_vector(31 downto 0);
        done            : out    vl_logic;
        port_A_clk      : out    vl_logic;
        port_A_data_in  : out    vl_logic_vector(31 downto 0);
        port_A_data_out : in     vl_logic_vector(31 downto 0);
        port_A_addr     : out    vl_logic_vector(15 downto 0);
        port_A_we       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of starting : constant is 1;
    attribute mti_svvh_generic_type of reading : constant is 1;
    attribute mti_svvh_generic_type of writing : constant is 1;
    attribute mti_svvh_generic_type of working : constant is 1;
end rle;
