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
// This model is for the candle body. It has the index slot and latching cutout feature
// for the charging plate. The top has air vent holes around the G4 socket holder.
//
// -- Part of the antique candlestick holder project
//

include <candlestick-dimensions.scad>

use <threads.scad>

difference()
{
   cylinder(h = candle_height, d = candle_od, $fn=300);

   cylinder(h = candle_height, d = candle_id, $fn=300);

   translate([0, -switch_stem_width/2,0])
   {
      // The slot depth is a mess to decode, hack in the fudge factor "+ 0.5"
      cube([candle_od/2, switch_stem_width, switch_slot_depth - ((switch_height/2 - switch_stem_height/2) + 0.5)]);
   }

   // Pry slot
   translate([-candle_od/2, -latch_width/2, latch_height])
   {
      cube([candle_od/2, latch_width, latch_height]);
   }

   // Taper for bulb threads
   translate([ 0, 0, candle_height - candle_top_relief_height])
   {
      cylinder(h=candle_top_relief_height, d1=candle_od-candle_wall_thk, d2=candle_top_relief_dia, $fn=200);
   }
}

translate([0, 0, candle_height - (bulb_base_height + socket_holder_height)])
{
   difference()
   {
      cylinder(h = socket_holder_height, d = candle_id, $fn=300);

      cylinder(h = candle_wall_thk, d = socket_hole_dia, $fn=300);
      translate([0,0,candle_wall_thk])
      {
         cylinder(h = socket_height, d = socket_dia, $fn=300);
      }

      // Air vent holes
      for(i = [1:8])
      {
         rotate([0,0,i*45])
         {
            translate([6,0,0])
            {
               cylinder( h=bulb_base_height + socket_holder_height, d=base_air_dia, $fn=200);
            }
         }
      }
   }
}

translate([0,0,candle_height-bulb_base_height])
{
   difference()
   {
      cylinder(h = bulb_base_height, d = candle_id, $fn=300);

      // The internal thread option doesn't actually add clearance
      metric_thread(diameter=flame_base_od + 0.75, pitch=bulb_thread_pitch, length=bulb_base_height, internal=true );
   }
}

// Create a stop for the base plate using the length of the dc-dc converter
translate([ 0, 0, dcdc_stop_height])
{
   difference()
   {
      cylinder(h = 4, d = candle_od, $fn=300);

      translate([ -candle_od/2+dcdc_stop_depth, -candle_od/2, 0])
      {
         cube([candle_od-dcdc_stop_depth, candle_od, 20]);
      }
   }
}
