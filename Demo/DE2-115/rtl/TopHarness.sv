module TopHarness(
  input     sys_clock,
  input     reset,
  // JTAG (4)
  input     jtag_TCK,
  input     jtag_TMS,
  input     jtag_TDI,
  output    jtag_TDO,
  // SPI (4)
  output    sdio_clk,
  output    sdio_cs,
  input     sdio_dat_0,
  output    sdio_dat_3,
  // Flash (4)
  output    flash_clk,
  output    flash_cs,
  output    flash_dat_0,
  input     flash_dat_1,
  // UART (2)
  output    uart_txd,
  input     uart_rxd,
  // SerDes (20)
  output    serin_ready,
  input     serin_valid,
  input     serin_data0,
  input     serin_data1,
  input     serin_data2,
  input     serin_data3,
  input     serin_data4,
  input     serin_data5,
  input     serin_data6,
  input     serin_data7,
  output    serout_valid,
  output    serout_data0,
  output    serout_data1,
  output    serout_data2,
  output    serout_data3,
  output    serout_data4,
  output    serout_data5,
  output    serout_data6,
  output    serout_data7,
  input     serout_ready,
  // GPIO (16)   
  input     gpio_gpio_i0,
  input     gpio_gpio_i1,
  input     gpio_gpio_i2,
  input     gpio_gpio_i3,
  input     gpio_gpio_i4,
  input     gpio_gpio_i5,
  input     gpio_gpio_i6,
  input     gpio_gpio_i7,
  output    gpio_gpio_o0,
  output    gpio_gpio_o1,
  output    gpio_gpio_o2,
  output    gpio_gpio_o3,
  output    gpio_gpio_o4,
  output    gpio_gpio_o5,
  output    gpio_gpio_o6,
  output    gpio_gpio_o7
);

  wire       _WIRE;	// @[Harness.scala:247:38]
  wire       _harnessBinderReset_catcher_io_sync_reset;	// @[ResetCatchAndSync.scala:39:28]
  wire       _plusarg_reader_out;	// @[PlusArg.scala:80:11]
  wire       _ram_io_ser_in_valid;	// @[TSIHarness.scala:24:24]
  wire [7:0] _ram_io_ser_in_bits;	// @[TSIHarness.scala:24:24]
  wire       _ram_io_ser_out_ready;	// @[TSIHarness.scala:24:24]
  wire       _chiptop0_serial_tl_bits_in_ready;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_serial_tl_bits_out_valid;	// @[HasHarnessInstantiators.scala:82:40]
  wire [7:0] _chiptop0_serial_tl_bits_out_bits;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_jtag_TDO;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_0_sck;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_0_dq_0_o;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_0_dq_0_ie;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_0_dq_0_oe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_0_dq_1_o;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_0_dq_1_ie;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_0_dq_1_oe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_0_dq_2_o;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_0_dq_2_ie;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_0_dq_2_oe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_0_dq_3_o;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_0_dq_3_ie;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_0_dq_3_oe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_0_cs_0;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_1_sck;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_1_dq_0_o;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_1_dq_0_ie;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_1_dq_0_oe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_1_dq_1_o;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_1_dq_1_ie;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_1_dq_1_oe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_1_dq_2_o;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_1_dq_2_ie;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_1_dq_2_oe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_1_dq_3_o;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_1_dq_3_ie;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_1_dq_3_oe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_spi_1_cs_0;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_uart_0_txd;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_0_o_oval;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_0_o_oe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_0_o_ie;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_0_o_pue;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_0_o_ds;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_0_o_ps;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_0_o_ds1;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_0_o_poe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_1_o_oval;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_1_o_oe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_1_o_ie;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_1_o_pue;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_1_o_ds;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_1_o_ps;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_1_o_ds1;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_1_o_poe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_2_o_oval;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_2_o_oe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_2_o_ie;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_2_o_pue;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_2_o_ds;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_2_o_ps;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_2_o_ds1;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_2_o_poe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_3_o_oval;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_3_o_oe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_3_o_ie;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_3_o_pue;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_3_o_ds;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_3_o_ps;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_3_o_ds1;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_3_o_poe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_4_o_oval;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_4_o_oe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_4_o_ie;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_4_o_pue;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_4_o_ds;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_4_o_ps;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_4_o_ds1;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_4_o_poe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_5_o_oval;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_5_o_oe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_5_o_ie;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_5_o_pue;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_5_o_ds;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_5_o_ps;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_5_o_ds1;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_5_o_poe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_6_o_oval;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_6_o_oe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_6_o_ie;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_6_o_pue;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_6_o_ds;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_6_o_ps;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_6_o_ds1;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_6_o_poe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_7_o_oval;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_7_o_oe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_7_o_ie;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_7_o_pue;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_7_o_ds;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_7_o_ps;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_7_o_ds1;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _chiptop0_gpio_0_pins_7_o_poe;	// @[HasHarnessInstantiators.scala:82:40]
  wire       _fpga_power_on_power_on_reset;	// @[Xilinx.scala:104:21]
  wire       _resetIBUF_O;	// @[Harness.scala:239:25]
  wire       _bundleIn_0_pins_7_i_ival_a2b_b;	// @[Util.scala:30:21]
  wire       _bundleIn_0_pins_6_i_ival_a2b_b;	// @[Util.scala:30:21]
  wire       _bundleIn_0_pins_5_i_ival_a2b_b;	// @[Util.scala:30:21]
  wire       _bundleIn_0_pins_4_i_ival_a2b_b;	// @[Util.scala:30:21]
  wire       _bundleIn_0_pins_3_i_ival_a2b_b;	// @[Util.scala:30:21]
  wire       _bundleIn_0_pins_2_i_ival_a2b_b;	// @[Util.scala:30:21]
  wire       _bundleIn_0_pins_1_i_ival_a2b_b;	// @[Util.scala:30:21]
  wire       _bundleIn_0_pins_0_i_ival_a2b_b;	// @[Util.scala:30:21]
  wire       _a2b_9_b;	// @[Util.scala:30:21]
  wire       _a2b_5_b;	// @[Util.scala:30:21]
  wire       _bundleIn_0_rxd_a2b_b;	// @[Util.scala:30:21]
  wire       _bundleIn_0_srst_n_a2b_b;	// @[Util.scala:30:21]
  wire       _bundleIn_0_TDI_a2b_b;	// @[Util.scala:30:21]
  wire       _bundleIn_0_TMS_a2b_b;	// @[Util.scala:30:21]
  wire       _bundleIn_0_TCK_a2b_b;	// @[Util.scala:30:21]
  wire       _sys_clock_ibufds_O;	// @[ClockOverlay.scala:14:24]
  wire       _harnessSysPLLNode_clk_out1;	// @[XilinxShell.scala:84:55]
  wire       _harnessSysPLLNode_locked;	// @[XilinxShell.scala:84:55]
  wire       _dutGroup_auto_out_clock;	// @[ClockGroup.scala:31:15]
  wire       _dutGroup_auto_out_reset;	// @[ClockGroup.scala:31:15]
  wire       _dutWrangler_auto_out_clock;	// @[Harness.scala:188:31]
  wire       _dutWrangler_auto_out_reset;	// @[Harness.scala:188:31]
  reg        bundleIn_0_dq_1_i_REG;	// @[SDIOOverlay.scala:19:39]
  reg        bundleIn_0_dq_1_i_REG_1;	// @[SDIOOverlay.scala:19:31]
  reg        bundleIn_0_dq_1_i_REG_2;	// @[SPIXilinxOverlay.scala:22:39]
  reg        bundleIn_0_dq_1_i_REG_3;	// @[SPIXilinxOverlay.scala:22:31]
  
//   wire sys_clock;
//   clk_wiz_0 clk_wiz_0 (
//       // Clock out ports
//       .clk_out1     (sys_clock      ),
//       // Status and control signals
//       .reset        (_resetIBUF_O   ),
//       .locked       ( ),
//      // Clock in ports
//       .clk_in1_p    (sys_clock_p    ),
//       .clk_in1_n    (sys_clock_n    )
//  );
  
  assign _WIRE = _resetIBUF_O;	// @[Harness.scala:239:25, :247:38, Xilinx.scala:104:21]
  always @(posedge _dutWrangler_auto_out_clock) begin	// @[Harness.scala:188:31]
    bundleIn_0_dq_1_i_REG <= _a2b_5_b;	// @[SDIOOverlay.scala:19:39, Util.scala:30:21]
    bundleIn_0_dq_1_i_REG_1 <= bundleIn_0_dq_1_i_REG;	// @[SDIOOverlay.scala:19:{31,39}]
    bundleIn_0_dq_1_i_REG_2 <= _a2b_9_b;	// @[SPIXilinxOverlay.scala:22:39, Util.scala:30:21]
    bundleIn_0_dq_1_i_REG_3 <= bundleIn_0_dq_1_i_REG_2;	// @[SPIXilinxOverlay.scala:22:{31,39}]
  end // always @(posedge)
  ResetWrangler dutWrangler (	// @[Harness.scala:188:31]
    .auto_in_clock  (_dutGroup_auto_out_clock),	// @[ClockGroup.scala:31:15]
    .auto_in_reset  (_dutGroup_auto_out_reset),	// @[ClockGroup.scala:31:15]
    .auto_out_clock (_dutWrangler_auto_out_clock),
    .auto_out_reset (_dutWrangler_auto_out_reset)
  );
  ClockGroup dutGroup (	// @[ClockGroup.scala:31:15]
    .auto_in_member_0_clock (_harnessSysPLLNode_clk_out1),	// @[XilinxShell.scala:84:55]
    .auto_in_member_0_reset (_WIRE),	// @[Harness.scala:247:38, PLLFactory.scala:78:{20,35}, XilinxShell.scala:84:55]
    .auto_out_clock         (_dutGroup_auto_out_clock),
    .auto_out_reset         (_dutGroup_auto_out_reset)
  );
  ChipTop chiptop0 (	// @[HasHarnessInstantiators.scala:82:40]
    .serial_tl_clock          (_dutWrangler_auto_out_clock),	// @[Harness.scala:188:31]
    .serial_tl_bits_in_valid  (_ram_io_ser_in_valid),	// @[TSIHarness.scala:24:24]
    .serial_tl_bits_in_bits   (_ram_io_ser_in_bits),	// @[TSIHarness.scala:24:24]
    .serial_tl_bits_out_ready (_ram_io_ser_out_ready),	// @[TSIHarness.scala:24:24]
    .reset_io                 (_harnessBinderReset_catcher_io_sync_reset),	// @[ResetCatchAndSync.scala:39:28]
    .clock_uncore_clock       (_dutWrangler_auto_out_clock),	// @[Harness.scala:188:31]
    .jtag_TCK                 (_bundleIn_0_TCK_a2b_b),	// @[Util.scala:30:21]
    .jtag_TMS                 (_bundleIn_0_TMS_a2b_b),	// @[Util.scala:30:21]
    .jtag_TDI                 (_bundleIn_0_TDI_a2b_b),	// @[Util.scala:30:21]
    .spi_0_dq_0_i             (1'h0),	// @[LazyModule.scala:411:29]
    .spi_0_dq_1_i             (bundleIn_0_dq_1_i_REG_1),	// @[SDIOOverlay.scala:19:31]
    .spi_0_dq_2_i             (1'h0),	// @[LazyModule.scala:411:29]
    .spi_0_dq_3_i             (1'h0),	// @[LazyModule.scala:411:29]
    .spi_1_dq_0_i             (1'h0),	// @[LazyModule.scala:411:29]
    .spi_1_dq_1_i             (bundleIn_0_dq_1_i_REG_3),	// @[SPIXilinxOverlay.scala:22:31]
    .spi_1_dq_2_i             (1'h0),	// @[LazyModule.scala:411:29]
    .spi_1_dq_3_i             (1'h0),	// @[LazyModule.scala:411:29]
    .uart_0_rxd               (_bundleIn_0_rxd_a2b_b),	// @[Util.scala:30:21]
    .gpio_0_pins_0_i_ival     (_bundleIn_0_pins_0_i_ival_a2b_b),	// @[Util.scala:30:21]
    .gpio_0_pins_0_i_po       (1'h0),	// @[LazyModule.scala:411:29]
    .gpio_0_pins_1_i_ival     (_bundleIn_0_pins_1_i_ival_a2b_b),	// @[Util.scala:30:21]
    .gpio_0_pins_1_i_po       (1'h0),	// @[LazyModule.scala:411:29]
    .gpio_0_pins_2_i_ival     (_bundleIn_0_pins_2_i_ival_a2b_b),	// @[Util.scala:30:21]
    .gpio_0_pins_2_i_po       (1'h0),	// @[LazyModule.scala:411:29]
    .gpio_0_pins_3_i_ival     (_bundleIn_0_pins_3_i_ival_a2b_b),	// @[Util.scala:30:21]
    .gpio_0_pins_3_i_po       (1'h0),	// @[LazyModule.scala:411:29]
    .gpio_0_pins_4_i_ival     (_bundleIn_0_pins_4_i_ival_a2b_b),	// @[Util.scala:30:21]
    .gpio_0_pins_4_i_po       (1'h0),	// @[LazyModule.scala:411:29]
    .gpio_0_pins_5_i_ival     (_bundleIn_0_pins_5_i_ival_a2b_b),	// @[Util.scala:30:21]
    .gpio_0_pins_5_i_po       (1'h0),	// @[LazyModule.scala:411:29]
    .gpio_0_pins_6_i_ival     (_bundleIn_0_pins_6_i_ival_a2b_b),	// @[Util.scala:30:21]
    .gpio_0_pins_6_i_po       (1'h0),	// @[LazyModule.scala:411:29]
    .gpio_0_pins_7_i_ival     (_bundleIn_0_pins_7_i_ival_a2b_b),	// @[Util.scala:30:21]
    .gpio_0_pins_7_i_po       (1'h0),	// @[LazyModule.scala:411:29]
    .serial_tl_bits_in_ready  (_chiptop0_serial_tl_bits_in_ready),
    .serial_tl_bits_out_valid (_chiptop0_serial_tl_bits_out_valid),
    .serial_tl_bits_out_bits  (_chiptop0_serial_tl_bits_out_bits),
    .jtag_TDO                 (_chiptop0_jtag_TDO),
    .spi_0_sck                (_chiptop0_spi_0_sck),
    .spi_0_dq_0_o             (_chiptop0_spi_0_dq_0_o),
    .spi_0_dq_0_ie            (_chiptop0_spi_0_dq_0_ie),
    .spi_0_dq_0_oe            (_chiptop0_spi_0_dq_0_oe),
    .spi_0_dq_1_o             (_chiptop0_spi_0_dq_1_o),
    .spi_0_dq_1_ie            (_chiptop0_spi_0_dq_1_ie),
    .spi_0_dq_1_oe            (_chiptop0_spi_0_dq_1_oe),
    .spi_0_dq_2_o             (_chiptop0_spi_0_dq_2_o),
    .spi_0_dq_2_ie            (_chiptop0_spi_0_dq_2_ie),
    .spi_0_dq_2_oe            (_chiptop0_spi_0_dq_2_oe),
    .spi_0_dq_3_o             (_chiptop0_spi_0_dq_3_o),
    .spi_0_dq_3_ie            (_chiptop0_spi_0_dq_3_ie),
    .spi_0_dq_3_oe            (_chiptop0_spi_0_dq_3_oe),
    .spi_0_cs_0               (_chiptop0_spi_0_cs_0),
    .spi_1_sck                (_chiptop0_spi_1_sck),
    .spi_1_dq_0_o             (_chiptop0_spi_1_dq_0_o),
    .spi_1_dq_0_ie            (_chiptop0_spi_1_dq_0_ie),
    .spi_1_dq_0_oe            (_chiptop0_spi_1_dq_0_oe),
    .spi_1_dq_1_o             (_chiptop0_spi_1_dq_1_o),
    .spi_1_dq_1_ie            (_chiptop0_spi_1_dq_1_ie),
    .spi_1_dq_1_oe            (_chiptop0_spi_1_dq_1_oe),
    .spi_1_dq_2_o             (_chiptop0_spi_1_dq_2_o),
    .spi_1_dq_2_ie            (_chiptop0_spi_1_dq_2_ie),
    .spi_1_dq_2_oe            (_chiptop0_spi_1_dq_2_oe),
    .spi_1_dq_3_o             (_chiptop0_spi_1_dq_3_o),
    .spi_1_dq_3_ie            (_chiptop0_spi_1_dq_3_ie),
    .spi_1_dq_3_oe            (_chiptop0_spi_1_dq_3_oe),
    .spi_1_cs_0               (_chiptop0_spi_1_cs_0),
    .uart_0_txd               (_chiptop0_uart_0_txd),
    .gpio_0_pins_0_o_oval     (_chiptop0_gpio_0_pins_0_o_oval),
    .gpio_0_pins_0_o_oe       (_chiptop0_gpio_0_pins_0_o_oe),
    .gpio_0_pins_0_o_ie       (_chiptop0_gpio_0_pins_0_o_ie),
    .gpio_0_pins_0_o_pue      (_chiptop0_gpio_0_pins_0_o_pue),
    .gpio_0_pins_0_o_ds       (_chiptop0_gpio_0_pins_0_o_ds),
    .gpio_0_pins_0_o_ps       (_chiptop0_gpio_0_pins_0_o_ps),
    .gpio_0_pins_0_o_ds1      (_chiptop0_gpio_0_pins_0_o_ds1),
    .gpio_0_pins_0_o_poe      (_chiptop0_gpio_0_pins_0_o_poe),
    .gpio_0_pins_1_o_oval     (_chiptop0_gpio_0_pins_1_o_oval),
    .gpio_0_pins_1_o_oe       (_chiptop0_gpio_0_pins_1_o_oe),
    .gpio_0_pins_1_o_ie       (_chiptop0_gpio_0_pins_1_o_ie),
    .gpio_0_pins_1_o_pue      (_chiptop0_gpio_0_pins_1_o_pue),
    .gpio_0_pins_1_o_ds       (_chiptop0_gpio_0_pins_1_o_ds),
    .gpio_0_pins_1_o_ps       (_chiptop0_gpio_0_pins_1_o_ps),
    .gpio_0_pins_1_o_ds1      (_chiptop0_gpio_0_pins_1_o_ds1),
    .gpio_0_pins_1_o_poe      (_chiptop0_gpio_0_pins_1_o_poe),
    .gpio_0_pins_2_o_oval     (_chiptop0_gpio_0_pins_2_o_oval),
    .gpio_0_pins_2_o_oe       (_chiptop0_gpio_0_pins_2_o_oe),
    .gpio_0_pins_2_o_ie       (_chiptop0_gpio_0_pins_2_o_ie),
    .gpio_0_pins_2_o_pue      (_chiptop0_gpio_0_pins_2_o_pue),
    .gpio_0_pins_2_o_ds       (_chiptop0_gpio_0_pins_2_o_ds),
    .gpio_0_pins_2_o_ps       (_chiptop0_gpio_0_pins_2_o_ps),
    .gpio_0_pins_2_o_ds1      (_chiptop0_gpio_0_pins_2_o_ds1),
    .gpio_0_pins_2_o_poe      (_chiptop0_gpio_0_pins_2_o_poe),
    .gpio_0_pins_3_o_oval     (_chiptop0_gpio_0_pins_3_o_oval),
    .gpio_0_pins_3_o_oe       (_chiptop0_gpio_0_pins_3_o_oe),
    .gpio_0_pins_3_o_ie       (_chiptop0_gpio_0_pins_3_o_ie),
    .gpio_0_pins_3_o_pue      (_chiptop0_gpio_0_pins_3_o_pue),
    .gpio_0_pins_3_o_ds       (_chiptop0_gpio_0_pins_3_o_ds),
    .gpio_0_pins_3_o_ps       (_chiptop0_gpio_0_pins_3_o_ps),
    .gpio_0_pins_3_o_ds1      (_chiptop0_gpio_0_pins_3_o_ds1),
    .gpio_0_pins_3_o_poe      (_chiptop0_gpio_0_pins_3_o_poe),
    .gpio_0_pins_4_o_oval     (_chiptop0_gpio_0_pins_4_o_oval),
    .gpio_0_pins_4_o_oe       (_chiptop0_gpio_0_pins_4_o_oe),
    .gpio_0_pins_4_o_ie       (_chiptop0_gpio_0_pins_4_o_ie),
    .gpio_0_pins_4_o_pue      (_chiptop0_gpio_0_pins_4_o_pue),
    .gpio_0_pins_4_o_ds       (_chiptop0_gpio_0_pins_4_o_ds),
    .gpio_0_pins_4_o_ps       (_chiptop0_gpio_0_pins_4_o_ps),
    .gpio_0_pins_4_o_ds1      (_chiptop0_gpio_0_pins_4_o_ds1),
    .gpio_0_pins_4_o_poe      (_chiptop0_gpio_0_pins_4_o_poe),
    .gpio_0_pins_5_o_oval     (_chiptop0_gpio_0_pins_5_o_oval),
    .gpio_0_pins_5_o_oe       (_chiptop0_gpio_0_pins_5_o_oe),
    .gpio_0_pins_5_o_ie       (_chiptop0_gpio_0_pins_5_o_ie),
    .gpio_0_pins_5_o_pue      (_chiptop0_gpio_0_pins_5_o_pue),
    .gpio_0_pins_5_o_ds       (_chiptop0_gpio_0_pins_5_o_ds),
    .gpio_0_pins_5_o_ps       (_chiptop0_gpio_0_pins_5_o_ps),
    .gpio_0_pins_5_o_ds1      (_chiptop0_gpio_0_pins_5_o_ds1),
    .gpio_0_pins_5_o_poe      (_chiptop0_gpio_0_pins_5_o_poe),
    .gpio_0_pins_6_o_oval     (_chiptop0_gpio_0_pins_6_o_oval),
    .gpio_0_pins_6_o_oe       (_chiptop0_gpio_0_pins_6_o_oe),
    .gpio_0_pins_6_o_ie       (_chiptop0_gpio_0_pins_6_o_ie),
    .gpio_0_pins_6_o_pue      (_chiptop0_gpio_0_pins_6_o_pue),
    .gpio_0_pins_6_o_ds       (_chiptop0_gpio_0_pins_6_o_ds),
    .gpio_0_pins_6_o_ps       (_chiptop0_gpio_0_pins_6_o_ps),
    .gpio_0_pins_6_o_ds1      (_chiptop0_gpio_0_pins_6_o_ds1),
    .gpio_0_pins_6_o_poe      (_chiptop0_gpio_0_pins_6_o_poe),
    .gpio_0_pins_7_o_oval     (_chiptop0_gpio_0_pins_7_o_oval),
    .gpio_0_pins_7_o_oe       (_chiptop0_gpio_0_pins_7_o_oe),
    .gpio_0_pins_7_o_ie       (_chiptop0_gpio_0_pins_7_o_ie),
    .gpio_0_pins_7_o_pue      (_chiptop0_gpio_0_pins_7_o_pue),
    .gpio_0_pins_7_o_ds       (_chiptop0_gpio_0_pins_7_o_ds),
    .gpio_0_pins_7_o_ps       (_chiptop0_gpio_0_pins_7_o_ps),
    .gpio_0_pins_7_o_ds1      (_chiptop0_gpio_0_pins_7_o_ds1),
    .gpio_0_pins_7_o_poe      (_chiptop0_gpio_0_pins_7_o_poe)
  );
  ResetCatchAndSync_d3_VCU118woDDRHarness_UNIQUIFIED harnessBinderReset_catcher (	// @[ResetCatchAndSync.scala:39:28]
    .clock         (_dutWrangler_auto_out_clock),	// @[Harness.scala:188:31]
    .reset         (_dutWrangler_auto_out_reset),	// @[Harness.scala:188:31]
    .io_sync_reset (_harnessBinderReset_catcher_io_sync_reset)
  );
  
  assign _sys_clock_ibufds_O = sys_clock;
  assign _harnessSysPLLNode_clk_out1 = _sys_clock_ibufds_O;
  assign _resetIBUF_O = reset;
  
  assign _bundleIn_0_TCK_a2b_b  = jtag_TCK;
  assign _bundleIn_0_TMS_a2b_b  = jtag_TMS;
  assign _bundleIn_0_TDI_a2b_b  = jtag_TDI;
  assign jtag_TDO          = _chiptop0_jtag_TDO;

  assign uart_txd               = _chiptop0_uart_0_txd;
  assign _bundleIn_0_rxd_a2b_b  = uart_rxd;

  assign sdio_clk   = _chiptop0_spi_0_sck;
  assign sdio_dat_3 = _chiptop0_spi_0_cs_0;
  assign sdio_cs    = _chiptop0_spi_0_dq_0_o;
  assign _a2b_5_b       = sdio_dat_0;
  
  assign flash_clk      = _chiptop0_spi_1_sck;
  assign flash_cs       = _chiptop0_spi_1_cs_0;
  assign flash_dat_0    = _chiptop0_spi_1_dq_0_o;
  assign _a2b_9_b       = flash_dat_1;
  
  assign serin_ready = _chiptop0_serial_tl_bits_in_ready;
  assign _ram_io_ser_in_valid   = serin_valid;
  assign _ram_io_ser_in_bits    = {serin_data7, serin_data6, serin_data5, serin_data4, 
                                   serin_data3, serin_data2, serin_data1, serin_data0};
  
  assign serout_valid   = _chiptop0_serial_tl_bits_out_valid;
  assign serout_data0    = _chiptop0_serial_tl_bits_out_bits[0];
  assign serout_data1    = _chiptop0_serial_tl_bits_out_bits[1];
  assign serout_data2    = _chiptop0_serial_tl_bits_out_bits[2];
  assign serout_data3    = _chiptop0_serial_tl_bits_out_bits[3];
  assign serout_data4    = _chiptop0_serial_tl_bits_out_bits[4];
  assign serout_data5    = _chiptop0_serial_tl_bits_out_bits[5];
  assign serout_data6    = _chiptop0_serial_tl_bits_out_bits[6];
  assign serout_data7    = _chiptop0_serial_tl_bits_out_bits[7];
  assign _ram_io_ser_out_ready  = serout_ready;
  
  // GPIO
  assign _bundleIn_0_pins_0_i_ival_a2b_b = gpio_gpio_i0;
  assign _bundleIn_0_pins_1_i_ival_a2b_b = gpio_gpio_i1;
  assign _bundleIn_0_pins_2_i_ival_a2b_b = gpio_gpio_i2;
  assign _bundleIn_0_pins_3_i_ival_a2b_b = gpio_gpio_i3;
  assign _bundleIn_0_pins_4_i_ival_a2b_b = gpio_gpio_i4;
  assign _bundleIn_0_pins_5_i_ival_a2b_b = gpio_gpio_i5;
  assign _bundleIn_0_pins_6_i_ival_a2b_b = gpio_gpio_i6;
  assign _bundleIn_0_pins_7_i_ival_a2b_b = gpio_gpio_i7;
  
  assign gpio_gpio_o0 = _chiptop0_gpio_0_pins_0_o_oval;
  assign gpio_gpio_o1 = _chiptop0_gpio_0_pins_1_o_oval;
  assign gpio_gpio_o2 = _chiptop0_gpio_0_pins_2_o_oval;
  assign gpio_gpio_o3 = _chiptop0_gpio_0_pins_3_o_oval;
  assign gpio_gpio_o4 = _chiptop0_gpio_0_pins_4_o_oval;
  assign gpio_gpio_o5 = _chiptop0_gpio_0_pins_5_o_oval;
  assign gpio_gpio_o6 = _chiptop0_gpio_0_pins_6_o_oval;
  assign gpio_gpio_o7 = _chiptop0_gpio_0_pins_7_o_oval;
  
endmodule

