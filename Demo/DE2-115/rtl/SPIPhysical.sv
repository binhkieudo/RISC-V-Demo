// Generated by CIRCT unknown git version
// Standard header to adapt well known macros to our needs.
`ifndef RANDOMIZE
  `ifdef RANDOMIZE_REG_INIT
    `define RANDOMIZE
  `endif // RANDOMIZE_REG_INIT
`endif // not def RANDOMIZE
`ifndef RANDOMIZE
  `ifdef RANDOMIZE_MEM_INIT
    `define RANDOMIZE
  `endif // RANDOMIZE_MEM_INIT
`endif // not def RANDOMIZE

// RANDOM may be set to an expression that produces a 32-bit random unsigned value.
`ifndef RANDOM
  `define RANDOM $random
`endif // not def RANDOM

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

// Users can define 'ASSERT_VERBOSE_COND' to add an extra gate to assert error printing.
`ifndef ASSERT_VERBOSE_COND_
  `ifdef ASSERT_VERBOSE_COND
    `define ASSERT_VERBOSE_COND_ (`ASSERT_VERBOSE_COND)
  `else  // ASSERT_VERBOSE_COND
    `define ASSERT_VERBOSE_COND_ 1
  `endif // ASSERT_VERBOSE_COND
`endif // not def ASSERT_VERBOSE_COND_

// Users can define 'STOP_COND' to add an extra gate to stop conditions.
`ifndef STOP_COND_
  `ifdef STOP_COND
    `define STOP_COND_ (`STOP_COND)
  `else  // STOP_COND
    `define STOP_COND_ 1
  `endif // STOP_COND
`endif // not def STOP_COND_

// Users can define INIT_RANDOM as general code that gets injected into the
// initializer block for modules with registers.
`ifndef INIT_RANDOM
  `define INIT_RANDOM
`endif // not def INIT_RANDOM

// If using random initialization, you can also define RANDOMIZE_DELAY to
// customize the delay used, otherwise 0.002 is used.
`ifndef RANDOMIZE_DELAY
  `define RANDOMIZE_DELAY 0.002
`endif // not def RANDOMIZE_DELAY

// Define INIT_RANDOM_PROLOG_ for use in our modules below.
`ifndef INIT_RANDOM_PROLOG_
  `ifdef RANDOMIZE
    `ifdef VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM
    `else  // VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM #`RANDOMIZE_DELAY begin end
    `endif // VERILATOR
  `else  // RANDOMIZE
    `define INIT_RANDOM_PROLOG_
  `endif // RANDOMIZE
`endif // not def INIT_RANDOM_PROLOG_

module SPIPhysical(
  input         clock,
                reset,
                io_port_dq_0_i,
                io_port_dq_1_i,
                io_port_dq_2_i,
                io_port_dq_3_i,
  input  [11:0] io_ctrl_sck_div,
  input         io_ctrl_sck_pol,
                io_ctrl_sck_pha,
  input  [1:0]  io_ctrl_fmt_proto,
  input         io_ctrl_fmt_endian,
                io_ctrl_fmt_iodir,
  input  [11:0] io_ctrl_extradel_coarse,
  input  [4:0]  io_ctrl_sampledel_sd,
  input         io_op_valid,
                io_op_bits_fn,
                io_op_bits_stb,
  input  [7:0]  io_op_bits_cnt,
                io_op_bits_data,
  output        io_port_sck,
                io_port_dq_0_o,
                io_port_dq_0_ie,
                io_port_dq_0_oe,
                io_port_dq_1_o,
                io_port_dq_1_ie,
                io_port_dq_1_oe,
                io_port_dq_2_o,
                io_port_dq_2_ie,
                io_port_dq_2_oe,
                io_port_dq_3_o,
                io_port_dq_3_ie,
                io_port_dq_3_oe,
                io_op_ready,
                io_rx_valid,
  output [7:0]  io_rx_bits
);

  reg  [11:0] ctrl_sck_div;	// @[SPIPhysical.scala:51:17]
  reg         ctrl_sck_pol;	// @[SPIPhysical.scala:51:17]
  reg         ctrl_sck_pha;	// @[SPIPhysical.scala:51:17]
  reg  [1:0]  ctrl_fmt_proto;	// @[SPIPhysical.scala:51:17]
  reg         ctrl_fmt_endian;	// @[SPIPhysical.scala:51:17]
  reg         ctrl_fmt_iodir;	// @[SPIPhysical.scala:51:17]
  wire        proto_0 = ctrl_fmt_proto == 2'h0;	// @[Mux.scala:27:73, SPIConsts.scala:12:48, SPIPhysical.scala:51:17]
  wire        proto_1 = ctrl_fmt_proto == 2'h1;	// @[SPIConsts.scala:12:48, SPIPhysical.scala:51:17]
  wire        proto_2 = ctrl_fmt_proto == 2'h2;	// @[SPIConsts.scala:12:48, SPIPhysical.scala:51:17]
  reg         setup_d;	// @[SPIPhysical.scala:59:20]
  reg  [7:0]  scnt;	// @[SPIPhysical.scala:61:17]
  reg  [11:0] tcnt;	// @[SPIPhysical.scala:62:17]
  wire        stop = scnt == 8'h0;	// @[SPIPhysical.scala:61:17, :64:20]
  wire        beat = tcnt == 12'h0;	// @[SPIPhysical.scala:62:17, :65:20]
  reg         sample_d;	// @[SPIPhysical.scala:69:25]
  reg  [11:0] del_cntr;	// @[SPIPhysical.scala:70:25]
  reg         last_d;	// @[SPIPhysical.scala:91:23]
  reg  [11:0] del_cntr_last;	// @[SPIPhysical.scala:92:30]
  reg         sck;	// @[SPIPhysical.scala:115:16]
  reg         cref;	// @[SPIPhysical.scala:116:17]
  reg  [7:0]  buffer;	// @[SPIPhysical.scala:140:19]
  reg  [3:0]  txd;	// @[SPIPhysical.scala:152:16]
  wire        txen_2 = proto_2 & ctrl_fmt_iodir;	// @[SPIConsts.scala:12:48, SPIPhysical.scala:51:17, :161:49]
  wire        txen_1 = proto_1 & ctrl_fmt_iodir | txen_2;	// @[SPIConsts.scala:12:48, SPIPhysical.scala:51:17, :161:{49,82}]
  reg         rdisableOE;	// @[SPIPhysical.scala:163:23]
  wire        _io_port_dq_0_oe_output = ~rdisableOE & (proto_0 | txen_1);	// @[SPIConsts.scala:12:48, SPIPhysical.scala:161:82, :163:23, :170:19]
  wire        _io_port_dq_1_oe_output = ~rdisableOE & txen_1;	// @[SPIPhysical.scala:161:82, :163:23, :170:19]
  wire        _io_port_dq_3_oe_output = ~rdisableOE & txen_2;	// @[SPIPhysical.scala:161:49, :163:23, :170:19]
  reg         done;	// @[SPIPhysical.scala:175:17]
  reg         xfr;	// @[SPIPhysical.scala:181:16]
  wire        _GEN = beat & xfr;	// @[SPIPhysical.scala:65:20, :115:16, :181:16, :187:17, :189:18, :190:13]
  wire        _T_17 = scnt == 8'h1;	// @[SPIPhysical.scala:61:17, :200:14]
  wire        _T_19 = beat & ~cref;	// @[SPIPhysical.scala:65:20, :116:17, :202:{16,19}]
  wire        _GEN_0 = _T_17 & _T_19;	// @[SPIPhysical.scala:183:15, :200:{14,27}, :202:{16,26}, :203:14]
  wire        accept = _GEN_0 | stop;	// @[SPIPhysical.scala:64:20, :183:15, :200:27, :202:26, :203:14]
  wire        _T_20 = accept & done;	// @[SPIPhysical.scala:175:17, :183:15, :200:27, :202:26, :203:14, :209:16]
  wire [1:0]  _txd_sel_T = accept ? io_ctrl_fmt_proto : ctrl_fmt_proto;	// @[SPIPhysical.scala:51:17, :154:39, :183:15, :200:27, :202:26, :203:14]
  wire [11:0] totalCoarseDel = io_ctrl_extradel_coarse + {7'h0, io_ctrl_sampledel_sd};	// @[SPIPhysical.scala:68:49]
  wire [11:0] decr = (beat ? {4'h0, scnt} : tcnt) - 12'h1;	// @[SPIPhysical.scala:61:17, :62:17, :65:20, :111:{17,36}, :152:16]
  wire        cinv = ctrl_sck_pha ^ ctrl_sck_pol;	// @[SPIPhysical.scala:51:17, :117:27]
  wire        _sck_T = cref ^ cinv;	// @[SPIPhysical.scala:116:17, :117:27, :190:21]
  wire        _GEN_1 = stop | ~_GEN;	// @[SPIPhysical.scala:64:20, :115:16, :183:15, :187:17, :189:18, :190:13]
  wire        _GEN_2 = _GEN & ~cref;	// @[SPIPhysical.scala:115:16, :116:17, :187:17, :188:15, :189:18, :190:13, :192:15, compatibility.scala:76:26]
  wire        _GEN_3 = _T_20 & io_op_valid;	// @[SPIPhysical.scala:183:15, :209:{16,25}, :211:24, :212:12]
  wire        _GEN_4 = _T_20 & io_op_valid & ~io_op_bits_fn;	// @[SPIPhysical.scala:143:10, :209:{16,25}, :211:24, :219:22, :221:18]
  wire        setup = _GEN_4 | (_T_17 ? ~(_T_19 | stop) & _GEN_2 : ~stop & _GEN_2);	// @[SPIPhysical.scala:64:20, :116:17, :143:10, :183:15, :187:17, :189:18, :192:15, :200:{14,27}, :202:{16,26}, :204:13, :209:25, :211:24, :219:22, :221:18, :223:17, compatibility.scala:76:26]
  wire        _GEN_5 = io_op_bits_fn & io_op_bits_stb;	// @[SPIPhysical.scala:200:27, :219:22, :228:25, :229:17]
  wire        shift = (|totalCoarseDel) ? setup_d | sample_d & stop : sample_d;	// @[SPIPhysical.scala:59:20, :64:20, :68:49, :69:25, :142:{19,36,52,65}]
  wire [3:0]  txd_in = accept ? (io_ctrl_fmt_endian ? {io_op_bits_data[0], io_op_bits_data[1], io_op_bits_data[2], io_op_bits_data[3]} : io_op_bits_data[7:4]) : buffer[7:4];	// @[Cat.scala:33:92, SPIPhysical.scala:120:{8,54}, :140:19, :146:42, :153:19, :183:15, :200:27, :202:26, :203:14]
  always @(posedge clock) begin
    if (_GEN_3 & io_op_bits_fn & _GEN_5) begin	// @[SPIPhysical.scala:51:17, :183:15, :200:27, :209:25, :211:24, :212:12, :219:22, :228:25, :229:17]
      ctrl_sck_div <= io_ctrl_sck_div;	// @[SPIPhysical.scala:51:17]
      ctrl_sck_pol <= io_ctrl_sck_pol;	// @[SPIPhysical.scala:51:17]
      ctrl_sck_pha <= io_ctrl_sck_pha;	// @[SPIPhysical.scala:51:17]
    end
    if (_T_20 & io_op_valid & io_op_bits_stb) begin	// @[SPIPhysical.scala:51:17, :209:{16,25}, :211:24, :214:21, :215:18]
      ctrl_fmt_proto <= io_ctrl_fmt_proto;	// @[SPIPhysical.scala:51:17]
      ctrl_fmt_endian <= io_ctrl_fmt_endian;	// @[SPIPhysical.scala:51:17]
      ctrl_fmt_iodir <= io_ctrl_fmt_iodir;	// @[SPIPhysical.scala:51:17]
    end
    setup_d <= setup;	// @[SPIPhysical.scala:59:20, :200:27, :209:25, :211:24, :219:22, :223:17]
    if (stop | beat)	// @[SPIPhysical.scala:64:20, :65:20, :183:15, :184:11, compatibility.scala:76:26]
      tcnt <= ctrl_sck_div;	// @[SPIPhysical.scala:51:17, :62:17]
    else	// @[SPIPhysical.scala:183:15, :184:11, compatibility.scala:76:26]
      tcnt <= decr;	// @[SPIPhysical.scala:62:17, :111:36]
    if (_GEN_3) begin	// @[SPIPhysical.scala:183:15, :209:25, :211:24, :212:12]
      if (io_op_bits_fn) begin
        if (_GEN_5)	// @[SPIPhysical.scala:200:27, :219:22, :228:25, :229:17]
          sck <= io_ctrl_sck_pol;	// @[SPIPhysical.scala:115:16]
        else if (_GEN_0)	// @[SPIPhysical.scala:183:15, :200:27, :202:26, :203:14]
          sck <= ctrl_sck_pol;	// @[SPIPhysical.scala:51:17, :115:16]
        else if (_GEN_1) begin	// @[SPIPhysical.scala:115:16, :183:15, :187:17]
        end
        else	// @[SPIPhysical.scala:115:16, :183:15, :187:17]
          sck <= _sck_T;	// @[SPIPhysical.scala:115:16, :190:21]
      end
      else
        sck <= cinv;	// @[SPIPhysical.scala:115:16, :117:27]
      xfr <= ~io_op_bits_fn;	// @[SPIPhysical.scala:181:16, :219:22]
    end
    else if (_GEN_0)	// @[SPIPhysical.scala:183:15, :200:27, :202:26, :203:14]
      sck <= ctrl_sck_pol;	// @[SPIPhysical.scala:51:17, :115:16]
    else if (_GEN_1) begin	// @[SPIPhysical.scala:115:16, :183:15, :187:17]
    end
    else	// @[SPIPhysical.scala:115:16, :183:15, :187:17]
      sck <= _sck_T;	// @[SPIPhysical.scala:115:16, :190:21]
    if (_GEN_4) begin	// @[SPIPhysical.scala:143:10, :209:25, :211:24, :219:22, :221:18]
      if (io_ctrl_fmt_endian)
        buffer <= {io_op_bits_data[0], io_op_bits_data[1], io_op_bits_data[2], io_op_bits_data[3], io_op_bits_data[4], io_op_bits_data[5], io_op_bits_data[6], io_op_bits_data[7]};	// @[Cat.scala:33:92, SPIPhysical.scala:120:54, :140:19]
      else
        buffer <= io_op_bits_data;	// @[SPIPhysical.scala:140:19]
    end
    else	// @[SPIPhysical.scala:143:10, :209:25, :211:24, :219:22, :221:18]
      buffer <= (proto_0 ? {shift ? buffer[6:0] : buffer[7:1], sample_d ? io_port_dq_1_i : buffer[0]} : 8'h0) | (proto_1 ? {shift ? buffer[5:0] : buffer[7:2], sample_d ? {io_port_dq_1_i, io_port_dq_0_i} : buffer[1:0]} : 8'h0) | (proto_2 ? {shift ? buffer[3:0] : buffer[7:4], sample_d ? {io_port_dq_3_i, io_port_dq_2_i, io_port_dq_1_i, io_port_dq_0_i} : buffer[3:0]} : 8'h0);	// @[Cat.scala:33:92, Mux.scala:27:73, SPIConsts.scala:12:48, SPIPhysical.scala:61:17, :69:25, :137:29, :138:40, :140:19, :142:19, :146:{12,26,42}, :147:{12,35}]
    rdisableOE <= ~_GEN_3 & rdisableOE;	// @[SPIPhysical.scala:163:23, :183:15, :209:25, :211:24, :212:12, :213:18]
    if (reset) begin
      scnt <= 8'h0;	// @[SPIPhysical.scala:61:17]
      sample_d <= 1'h0;	// @[SPIPhysical.scala:51:17, :69:25]
      del_cntr <= 12'h3;	// @[SPIPhysical.scala:70:25]
      last_d <= 1'h0;	// @[SPIPhysical.scala:51:17, :91:23]
      del_cntr_last <= 12'h3;	// @[SPIPhysical.scala:70:25, :92:30]
      cref <= 1'h1;	// @[SPIPhysical.scala:73:26, :116:17]
      txd <= 4'h0;	// @[SPIPhysical.scala:152:16]
      done <= 1'h1;	// @[SPIPhysical.scala:73:26, :175:17]
    end
    else begin
      if (_GEN_3)	// @[SPIPhysical.scala:183:15, :209:25, :211:24, :212:12]
        scnt <= io_op_bits_cnt;	// @[SPIPhysical.scala:61:17]
      else if (stop | ~(beat & ~cref)) begin	// @[SPIPhysical.scala:61:17, :64:20, :65:20, :116:17, :183:15, :187:17, :188:15, :194:20, :195:14]
      end
      else	// @[SPIPhysical.scala:61:17, :183:15, :187:17]
        scnt <= decr[7:0];	// @[SPIPhysical.scala:61:17, :111:36, :195:14]
      sample_d <= del_cntr == 12'h1;	// @[SPIPhysical.scala:69:25, :70:25, :77:16, :85:18]
      if (beat & ~stop & _GEN & cref) begin	// @[SPIPhysical.scala:64:20, :65:20, :72:14, :115:16, :116:17, :183:15, :187:17, :189:18, :190:13, compatibility.scala:76:26]
        if (|(totalCoarseDel[11:1]))	// @[SPIPhysical.scala:68:49, :73:26]
          del_cntr <= totalCoarseDel - 12'h1;	// @[SPIPhysical.scala:68:49, :70:25, :74:34]
        else	// @[SPIPhysical.scala:73:26]
          del_cntr <= 12'h1;	// @[SPIPhysical.scala:70:25, :77:16]
      end
      else if (|del_cntr)	// @[SPIPhysical.scala:70:25, :80:19]
        del_cntr <= del_cntr - 12'h1;	// @[SPIPhysical.scala:70:25, :81:28]
      last_d <= del_cntr_last == 12'h1;	// @[SPIPhysical.scala:77:16, :91:23, :92:30, :106:23]
      if (beat & _T_17 & cref & xfr) begin	// @[SPIPhysical.scala:65:20, :93:14, :116:17, :181:16, :200:14]
        if (|(totalCoarseDel[11:1]))	// @[SPIPhysical.scala:68:49, :73:26, :94:26]
          del_cntr_last <= totalCoarseDel - 12'h1;	// @[SPIPhysical.scala:68:49, :92:30, :95:39]
        else	// @[SPIPhysical.scala:94:26]
          del_cntr_last <= 12'h1;	// @[SPIPhysical.scala:77:16, :92:30]
      end
      else if (|del_cntr_last)	// @[SPIPhysical.scala:92:30, :101:25]
        del_cntr_last <= del_cntr_last - 12'h1;	// @[SPIPhysical.scala:92:30, :102:38]
      cref <= ~stop & beat ^ cref;	// @[SPIPhysical.scala:64:20, :65:20, :116:17, :183:15, :187:17]
      if (setup)	// @[SPIPhysical.scala:200:27, :209:25, :211:24, :219:22, :223:17]
        txd <= {2'h0, {1'h0, _txd_sel_T == 2'h0 & txd_in[3]} | (_txd_sel_T == 2'h1 ? txd_in[3:2] : 2'h0)} | (_txd_sel_T == 2'h2 ? txd_in : 4'h0);	// @[Mux.scala:27:73, SPIConsts.scala:12:48, SPIPhysical.scala:51:17, :152:16, :153:19, :154:39, :155:55]
      if (_GEN_4)	// @[SPIPhysical.scala:143:10, :209:25, :211:24, :219:22, :221:18]
        done <= io_op_bits_cnt == 8'h0;	// @[SPIPhysical.scala:61:17, :175:17, :224:27]
      else	// @[SPIPhysical.scala:143:10, :209:25, :211:24, :219:22, :221:18]
        done <= done | last_d;	// @[SPIPhysical.scala:91:23, :175:17, :176:16]
    end
  end // always @(posedge)
  `ifndef SYNTHESIS
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM_0;
    logic [31:0] _RANDOM_1;
    logic [31:0] _RANDOM_2;
    logic [31:0] _RANDOM_3;
    initial begin
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        _RANDOM_0 = `RANDOM;
        _RANDOM_1 = `RANDOM;
        _RANDOM_2 = `RANDOM;
        _RANDOM_3 = `RANDOM;
        ctrl_sck_div = _RANDOM_0[11:0];	// @[SPIPhysical.scala:51:17]
        ctrl_sck_pol = _RANDOM_0[12];	// @[SPIPhysical.scala:51:17]
        ctrl_sck_pha = _RANDOM_0[13];	// @[SPIPhysical.scala:51:17]
        ctrl_fmt_proto = _RANDOM_0[15:14];	// @[SPIPhysical.scala:51:17]
        ctrl_fmt_endian = _RANDOM_0[16];	// @[SPIPhysical.scala:51:17]
        ctrl_fmt_iodir = _RANDOM_0[17];	// @[SPIPhysical.scala:51:17]
        setup_d = _RANDOM_1[3];	// @[SPIPhysical.scala:59:20]
        scnt = _RANDOM_1[11:4];	// @[SPIPhysical.scala:59:20, :61:17]
        tcnt = _RANDOM_1[23:12];	// @[SPIPhysical.scala:59:20, :62:17]
        sample_d = _RANDOM_1[24];	// @[SPIPhysical.scala:59:20, :69:25]
        del_cntr = {_RANDOM_1[31:25], _RANDOM_2[4:0]};	// @[SPIPhysical.scala:59:20, :70:25]
        last_d = _RANDOM_2[5];	// @[SPIPhysical.scala:70:25, :91:23]
        del_cntr_last = _RANDOM_2[17:6];	// @[SPIPhysical.scala:70:25, :92:30]
        sck = _RANDOM_2[18];	// @[SPIPhysical.scala:70:25, :115:16]
        cref = _RANDOM_2[19];	// @[SPIPhysical.scala:70:25, :116:17]
        buffer = _RANDOM_2[27:20];	// @[SPIPhysical.scala:70:25, :140:19]
        txd = _RANDOM_2[31:28];	// @[SPIPhysical.scala:70:25, :152:16]
        rdisableOE = _RANDOM_3[0];	// @[SPIPhysical.scala:163:23]
        done = _RANDOM_3[1];	// @[SPIPhysical.scala:163:23, :175:17]
        xfr = _RANDOM_3[2];	// @[SPIPhysical.scala:163:23, :181:16]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // not def SYNTHESIS
  assign io_port_sck = sck;	// @[SPIPhysical.scala:115:16]
  assign io_port_dq_0_o = txd[0];	// @[SPIPhysical.scala:152:16, :167:24]
  assign io_port_dq_0_ie = ~_io_port_dq_0_oe_output;	// @[SPIPhysical.scala:170:19, :171:16]
  assign io_port_dq_0_oe = _io_port_dq_0_oe_output;	// @[SPIPhysical.scala:170:19]
  assign io_port_dq_1_o = txd[1];	// @[SPIPhysical.scala:152:16, :167:24]
  assign io_port_dq_1_ie = ~_io_port_dq_1_oe_output;	// @[SPIPhysical.scala:170:19, :171:16]
  assign io_port_dq_1_oe = _io_port_dq_1_oe_output;	// @[SPIPhysical.scala:170:19]
  assign io_port_dq_2_o = txd[2];	// @[SPIPhysical.scala:152:16, :167:24]
  assign io_port_dq_2_ie = ~_io_port_dq_3_oe_output;	// @[SPIPhysical.scala:170:19, :171:16]
  assign io_port_dq_2_oe = _io_port_dq_3_oe_output;	// @[SPIPhysical.scala:170:19]
  assign io_port_dq_3_o = txd[3];	// @[SPIPhysical.scala:152:16, :167:24]
  assign io_port_dq_3_ie = ~_io_port_dq_3_oe_output;	// @[SPIPhysical.scala:170:19, :171:16]
  assign io_port_dq_3_oe = _io_port_dq_3_oe_output;	// @[SPIPhysical.scala:170:19]
  assign io_op_ready = _T_20;	// @[SPIPhysical.scala:209:16]
  assign io_rx_valid = done;	// @[SPIPhysical.scala:175:17]
  assign io_rx_bits = ctrl_fmt_endian ? {buffer[0], buffer[1], buffer[2], buffer[3], buffer[4], buffer[5], buffer[6], buffer[7]} : buffer;	// @[Cat.scala:33:92, SPIPhysical.scala:51:17, :120:{8,54}, :140:19, :147:35]
endmodule

