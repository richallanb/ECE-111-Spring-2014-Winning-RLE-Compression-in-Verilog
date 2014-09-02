library verilog;
use verilog.vl_types.all;
entity comp_unit is
    port(
        din             : in     vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        writing         : in     vl_logic;
        l_run_val_i     : in     vl_logic_vector(7 downto 0);
        l_run_len_i     : in     vl_logic_vector(7 downto 0);
        curr_out        : out    vl_logic_vector(15 downto 0);
        l_run_dout      : out    vl_logic_vector(15 downto 0);
        l_run_wo        : out    vl_logic;
        l_run_val_o     : out    vl_logic_vector(7 downto 0);
        l_run_len_o     : out    vl_logic_vector(7 downto 0);
        en_next         : out    vl_logic;
        has_last        : out    vl_logic;
        offset_o        : out    vl_logic_vector(3 downto 0);
        dout_next       : out    vl_logic_vector(31 downto 0)
    );
end comp_unit;
