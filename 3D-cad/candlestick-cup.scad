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
// This model is for the cup that glues to the base. It holds the candle tightly, with
// the four grip areas being a little flexible.
//
// -- Part of the antique candlestick holder project
//

include <candlestick-dimensions.scad>
use <torus.scad>


module bead_ring(ring_dia, bead_dia, count)
{
   for(i = [0:count-1])
   {
      angle = 360/count;

      rotate([0,0,i*angle])
      {
         translate([-ring_dia, 0, 0])
         {
            sphere(d=bead_dia, $fn=300);
         }
      }
   }
}

module bolt(length)
{
   cylinder(h=length, d=bolt_dia, $fn=200);

   translate([0,0,length])
   {
      cylinder(h=bolt_head_thk, d = bolt_head_dia, $fn = 6);
   }
}


difference()
{
   union()
   {
      cylinder( h = base_height, d = cup_bot_dia, $fn=200 );

      translate([0,0,base_height+5])
      {
         cylinder( h = cup_height-base_height-5, d = cup_top_od, $fn=200 );
      }

      translate([0,0, cup_height/2-(2.5 + 5)])
      {
         difference()
         {
            cylinder(h=5, d1=cup_id, d2=cup_top_od, $fn=300);
            cylinder(h=5, d=bolt_dia, $fn=300);
         }
      }
   }

   // The inside of the cup, behind the grippers
   translate([0,0,cup_height-cup_id_depth])
   {
      cylinder( h=cup_id_depth-cup_id_taper_depth, d=cup_id+cup_grip_relief, $fn=300 );
   }

   translate([0,0,cup_height-cup_id_taper_depth])
   {
      cylinder(h=cup_id_taper_depth, d1=cup_id, d2=cup_id_taper_dia, $fn=200);
   }

   translate([0, 0, cup_height-cup_id_depth])
   {
      cylinder(h=cup_id_depth, d=cup_id, $fn=300);
   }

   // The restoration used a bolt
   // bolt(bolt_len);

   // The glue
   cylinder(h=bolt_len, d=bolt_dia, $fn=360);
   translate([0,0,bolt_len])
   {
      cylinder(h=bolt_head_thk, d = cup_id-candle_wall_thk, $fn = 360);
   }

   // Air vent holes
   for(i = [1:8])
   {
      rotate([0,0,i*45])
      {
         translate([10,0,0])
         {
            rotate([0,-5.5,0])
            {
               cylinder( h=bolt_total_len, d=base_air_dia, $fn=200);
            }
         }
      }
   }

   // Make a stop above the bottom to ensure airflow
   translate([0,0, bolt_total_len])
   {
      cylinder(h = cup_height - bolt_total_len, d = cup_id - candle_wall_thk, $fn=200);
   }

   // The main concave cutout
   translate([0,0, cup_height/2])
   {
      torus(cup_top_od - mid_ring_dia, mid_ring_dia, 300 );
   }
 }

// The grippers
translate([0, 0, cup_height-cup_id_depth])
{
   difference()
   {
      cylinder(h=cup_id_depth-cup_id_taper_depth, d=cup_id+cup_grip_thk, $fn=360);

      cylinder(h=cup_id_depth, d2=cup_id, d1=cup_id-0.4, $fn=360);

      for(angle = [0 : 90 : 270])
      {
         rotate([0, 0, angle])
         {
            // The cube needs to have x moved negative a bit in order to cut the cylinder
            translate([cup_id/2 - 0.5, -cup_grip_width/2, 0])
            {
               cube([cup_grip_relief, cup_grip_width, cup_id_depth]);
            }
         }
      }
   }
}

// Top inner ring
translate([0,0,cup_height-bot_ring_dia])
{
   torus(cup_top_od/2, top_ring_dia, 200 );
}

// Top outer ring and bead ring
translate([0,0,cup_height])
{
   torus(cup_top_od/2+5, top_ring_dia, 300 );

   // Add beads to the top ring
   translate([0, 0, bead_dia])
   {
      bead_ring(cup_top_od/2+5, bead_dia, 100);
   }
}
