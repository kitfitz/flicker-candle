// BSD-3-Clause License
//
// Copyright 2025 Kit Fitzpatrick
//
// Redistribution and use in source and binary forms, with or without modification, are
// permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this list of
//    conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice, this list
//    of conditions and the following disclaimer in the documentation and/or other
//    materials provided with the distribution.
//
// 3. Neither the name of the copyright holder nor the names of its contributors may be
//    used to endorse or promote products derived from this software without specific
//    prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
// OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
// SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
// TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
// WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

//
// This is the project file containing the dimensional parameters so they can be shared
// between models.
//
// -- Part of the antique candlestick holder project
//

candle_od = 22.9; // Standard candle size, plus just a bit
candle_height = 120;

// Actually half the thickness for the candle body,
// it's the difference of the diameters. Other use is
// actual thickness
candle_wall_thk = 2.6;

candle_top_relief_dia = candle_od - candle_wall_thk/2;
candle_top_relief_height = 4;
candle_id = candle_od - candle_wall_thk;

cup_bot_dia = 17;
cup_height = 25; // Min about 23.5

cup_id_clearance = 0.1;
cup_top_od = 40;
cup_id = candle_od + cup_id_clearance;
cup_id_depth = 12;
cup_id_taper_depth = 1;
cup_id_taper_dia = cup_id + 1;

cup_grip_id = cup_id;
cup_grip_width = 6;
cup_grip_thk = 1;
cup_grip_relief = cup_grip_thk + 1; // The space behind the grippers

bead_dia = 3;

base_height = 5;

bot_ring_dia = 2;
mid_ring_dia = 12;
top_ring_dia = 3;

bolt_head_thk = 4.5; // 11/64in
bolt_head_dia = 12.5; // 0.484in
bolt_dia = 6.8; // 1/4in
bolt_len = 7;
bolt_total_len = bolt_len + bolt_head_thk;
bolt_head_relief = 15;

socket_dia = 8.4;
socket_height = 13.5;
socket_hole_dia = 5;
socket_holder_height = socket_height + candle_wall_thk;

bulb_od = 16.5; // Actual size 15.75, allow clearance
bulb_base_height = 13;
bulb_thk = 1;
bulb_r1 = 13;
bulb_r2 = 10;
bulb_r3 = 9;
bulb_r4 = 4;
bulb_off1 = 10;
bulb_off2 = 13;
bulb_off3 = 15;
bulb_thread_pitch = 1.5;

wire_slot_height = 12;
wire_slot_width = 2;

flame_height = 40;
flame_base_height = 5;
flame_base_od = 20; // Must be larger than the bulb_od

switch_width = 7.25;
switch_height = 7.25;
switch_depth = 7.25;
switch_stem_width = 4;
switch_stem_height = 4;
switch_back_width = 4.75;
nest_wall_thk = 1;

bottom_thk = 2;

latch_height = 5;
latch_width = 12;
latch_plug_depth = 2.6;
latch_plug_width = 6.8;

usb_thk = 3.75;
usb_width = 9.4;
usb_center = usb_width-usb_thk;
chg_width = 14;
chg_length = 18;

dcdc_width = 11.5;
dcdc_length = 20;
dcdc_thk = 1.5;
dcdc_slot_dia = 5;

dcdc_stop_height = dcdc_length; // Make a stop inside the candle
dcdc_stop_depth = 3.5;

base_air_dia = 1.8;
bulb_air_dia = 2;

// Controls the height of the switch.
// Aritrary space for boards, a minimum of 12.25
switch_board_clearance = 12.25;
switch_slot_depth = cup_id_depth + switch_height + switch_board_clearance - (switch_stem_height/2-0.4);

sw_button_dia = 10;
sw_button_thk = 1;
sw_stem_width = 2;
sw_stem_depth = 3;
sw_stem_height = 1.6;

clip_thk = 0.2;
clip_width = 1.5;
clip_height = sw_stem_height;

base_width = 100;
base_depth = 100;
base_wall_thk = 3.5;
base_to_bot = 12; // From the base ring to the top of the ledge

base_primary_dia = 220;
base_ring_dia = 82; // Eyeball this for a given primary diameter
base_ring_thk = base_wall_thk;
base_corner_cut = 8;
base_pedestal_height = 4;

handle_thk = base_wall_thk;

handle_narrow_width = 10;
handle_wide_width = 20;

handle_rad1 = 20;
handle_ang1 = 90;

handle_rad2 = 10;
handle_ang2 = 180;

handle_height = 25;

handle_rad3 = 20;
handle_ang3 = 30;

handle_overall_height = handle_rad1 + handle_height + handle_rad2 + handle_thk;

handle_base_d = 30;


