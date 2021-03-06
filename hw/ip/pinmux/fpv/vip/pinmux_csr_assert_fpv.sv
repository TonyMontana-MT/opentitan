// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

// FPV CSR read and write assertions auto-generated by `reggen` containing data structure
// Do Not Edit directly


// Block: pinmux
module pinmux_csr_assert_fpv import tlul_pkg::*; (
  input clk_i,
  input rst_ni,

  //tile link ports
  input tl_h2d_t h2d,
  input tl_d2h_t d2h
);

  // mask register to convert byte to bit
  logic [31:0] a_mask_bit;

  assign a_mask_bit[7:0]   = h2d.a_mask[0] ? '1 : '0;
  assign a_mask_bit[15:8]  = h2d.a_mask[1] ? '1 : '0;
  assign a_mask_bit[23:16] = h2d.a_mask[2] ? '1 : '0;
  assign a_mask_bit[31:24] = h2d.a_mask[3] ? '1 : '0;

  // declare common read and write sequences
  sequence device_wr_S(logic [4:0] addr);
    h2d.a_address == addr && h2d.a_opcode inside {PutFullData, PutPartialData} && h2d.a_valid && h2d.d_ready && !d2h.d_valid;
  endsequence

  sequence device_rd_S(logic [4:0] addr);
    h2d.a_address == addr && h2d.a_opcode inside {Get} && h2d.a_valid && h2d.d_ready && !d2h.d_valid;
  endsequence

  // declare common read and write properties
  property wr_P(int width, bit [4:0] addr, bit [31:0] compare_data, bit regen = 1);
    logic [31:0] id;
    logic [width:0] data;
    (device_wr_S(addr),id = h2d.a_source, data = h2d.a_data & a_mask_bit) |->
        strong(##[1:$] (d2h.d_valid && d2h.d_source == id && (d2h.d_error ||
        (!d2h.d_error && compare_data == data) || !regen)));
  endproperty

  property wr_ext_P(int width, bit [4:0] addr, bit [31:0] compare_data, bit regen = 1);
    logic [31:0] id;
    logic [width:0] data;
    logic [width:0] compare_value;
    (device_wr_S(addr),id = h2d.a_source, data = h2d.a_data & a_mask_bit,
        compare_value = compare_data) |->
        strong(##[1:$] (d2h.d_valid && d2h.d_source == id && (d2h.d_error ||
        (!d2h.d_error && compare_value == data) || !regen)));
  endproperty

  property rd_P(int width, bit [4:0] addr, bit [31:0] compare_data);
    logic [31:0] id;
    logic [width:0] data;
    (device_rd_S(addr), id = h2d.a_source, data = $past(compare_data)) |->
        strong(##[1:$] (d2h.d_valid && d2h.d_source == id && (d2h.d_error ||
        (!d2h.d_error && d2h.d_data == data))));
  endproperty

  property rd_ext_P(int width, bit [4:0] addr, bit [31:0] compare_data);
    logic [31:0] id;
    logic [width:0] data;
    (device_rd_S(addr), id = h2d.a_source, data = compare_data) |->
        strong(##[1:$] (d2h.d_valid && d2h.d_source == id && (d2h.d_error ||
        (!d2h.d_error && d2h.d_data == data))));
  endproperty

  property wr_regen_stable_P(regen, compare_data);
    (!regen && $stable(regen)) |-> $stable(compare_data);
  endproperty

// for all the regsters, declare assertion

  // read/write assertions for register: regen
  `ASSERT(regen_wr_A, wr_P(0, 5'h0, i_pinmux.i_reg_top.regen_we, 0), clk_i, !rst_ni)
  `ASSERT(regen_rd_A, rd_P(0, 5'h0, i_pinmux.i_reg_top.regen_qs), clk_i, !rst_ni)

  // define local fpv variable for the multi_reg
  logic [63:0] periph_insel_q_fpv;
  for (genvar s = 0; s <= 16-1; s++) begin : gen_periph_insel_rd
    assign periph_insel_q_fpv[((s+1)*4-1):s*4] = i_pinmux.reg2hw.periph_insel[s].q;
  end

  // read/write assertions for register: periph_insel0
  `ASSERT(periph_insel0_wr_A, wr_P(31, 5'h4, periph_insel_q_fpv[31:0], i_pinmux.i_reg_top.regen_qs), clk_i, !rst_ni)
  `ASSERT(periph_insel0_stable_A, wr_regen_stable_P(i_pinmux.i_reg_top.regen_qs, periph_insel_q_fpv[31:0]), clk_i, !rst_ni)
  `ASSERT(periph_insel0_rd_A, rd_P(31, 5'h4, periph_insel_q_fpv[31:0]), clk_i, !rst_ni)

  // read/write assertions for register: periph_insel1
  `ASSERT(periph_insel1_wr_A, wr_P(31, 5'h8, periph_insel_q_fpv[63:32], i_pinmux.i_reg_top.regen_qs), clk_i, !rst_ni)
  `ASSERT(periph_insel1_stable_A, wr_regen_stable_P(i_pinmux.i_reg_top.regen_qs, periph_insel_q_fpv[63:32]), clk_i, !rst_ni)
  `ASSERT(periph_insel1_rd_A, rd_P(31, 5'h8, periph_insel_q_fpv[63:32]), clk_i, !rst_ni)

  // define local fpv variable for the multi_reg
  logic [39:0] mio_outsel_q_fpv;
  for (genvar s = 0; s <= 8-1; s++) begin : gen_mio_outsel_rd
    assign mio_outsel_q_fpv[((s+1)*5-1):s*5] = i_pinmux.reg2hw.mio_outsel[s].q;
  end

  // read/write assertions for register: mio_outsel0
  `ASSERT(mio_outsel0_wr_A, wr_P(29, 5'hc, mio_outsel_q_fpv[29:0], i_pinmux.i_reg_top.regen_qs), clk_i, !rst_ni)
  `ASSERT(mio_outsel0_stable_A, wr_regen_stable_P(i_pinmux.i_reg_top.regen_qs, mio_outsel_q_fpv[29:0]), clk_i, !rst_ni)
  `ASSERT(mio_outsel0_rd_A, rd_P(29, 5'hc, mio_outsel_q_fpv[29:0]), clk_i, !rst_ni)

  // read/write assertions for register: mio_outsel1
  `ASSERT(mio_outsel1_wr_A, wr_P(9, 5'h10, mio_outsel_q_fpv[39:30], i_pinmux.i_reg_top.regen_qs), clk_i, !rst_ni)
  `ASSERT(mio_outsel1_stable_A, wr_regen_stable_P(i_pinmux.i_reg_top.regen_qs, mio_outsel_q_fpv[39:30]), clk_i, !rst_ni)
  `ASSERT(mio_outsel1_rd_A, rd_P(9, 5'h10, mio_outsel_q_fpv[39:30]), clk_i, !rst_ni)

endmodule
