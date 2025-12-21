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
// This model is for the base of the candlestick holder. It has the locating pin feature
// to glue the cup.
//
// -- Part of the antique candlestick holder project
//

include <candlestick-dimensions.scad>

use <torus.scad>
use <triangle.scad>
use <leaf.scad>
use <bee.scad>
use <handle.scad>

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


// Main bowl shape
translate([0,0,base_primary_dia/2])
{
   difference()
   {
      sphere(d=base_primary_dia, $fn=300);

      translate([ 0, 0, base_to_bot])
      {
         cube([ base_primary_dia, base_primary_dia, base_primary_dia], center=true);
      }

      translate([0,0,-base_primary_dia/2])
      {
         difference()
         {
            cylinder(h=base_to_bot+base_wall_thk, d=base_primary_dia, $fn=360);
            cylinder(h=base_to_bot+base_wall_thk, d=base_ring_dia, $fn=360);
         }
      }

      translate([0,0, base_wall_thk])
      {
         sphere(d=base_primary_dia, $fn=300);
      }

      for( angle = [0 : 24 : 360])
      {
         rotate([ 0, 0, angle])
         {
            translate([0,0,-base_primary_dia/2])
            {
               linear_extrude(height=base_to_bot, scale = 1, $fn=300)
               {
                  translate([ 0, 9, 0])
                  {
                     scale([ 0.125, 0.295, 1])
                     {
                        leaf_100mm();
                     }
                  }
               }
            }
         }
      }
   }
}

// Flat top of the bowl
translate([0, 0, base_to_bot])
{
   difference()
   {
      // Didn't want to take the bees out with the other cuts, so move it here
      difference()
      {
         cube([base_width, base_depth, base_wall_thk], center=true);

         translate([ 0, 0, -base_wall_thk/2])
         {
            // Cut out 4 bees, one in each corner
            for(angle=[45 : 90 : 315])
            {
               rotate([0,0,angle])
               {
                  translate([-(base_width/2 + 1), 0, 0])
                  {
                     scale([0.08,0.08, 1])
                     {
                        linear_extrude(height=base_wall_thk, convexity = 100)
                        {
                           bee();
                        }
                     }
                  }
               }
            }
         }
      }


      cylinder(h=base_wall_thk, d=base_ring_dia, center=true, $fn=300);

      // Left rear corner
      translate([-base_width/2, base_depth/2, -base_wall_thk/2])
      {
         rotate([0,0,-90])
         {
            triangle(base_corner_cut, base_corner_cut, base_wall_thk);
         }
      }

      // Right rear corner
      translate([base_width/2, base_depth/2, -base_wall_thk/2])
      {
         rotate([0,0,180])
         {
            triangle(base_corner_cut, base_corner_cut, base_wall_thk);
         }
      }

      // Left front corner
      translate([-base_width/2, -base_depth/2, -base_wall_thk/2])
      {
         triangle(base_corner_cut, base_corner_cut, base_wall_thk);
      }

      // Right front corner
      translate([base_width/2, -base_depth/2, -base_wall_thk/2])
      {
         rotate([0,0,90])
         {
            triangle(base_corner_cut, base_corner_cut, base_wall_thk);
         }
      }
   }
}

// Add the handle
translate([base_width/2, 0, base_to_bot-base_wall_thk/2])
{
   handle();
}


// Beads around the main bowl
translate([ 0, 0, base_to_bot-bead_dia/2])
{
   translate([0, 0, bead_dia])
   {
      bead_ring(base_ring_dia/2+bead_dia, bead_dia, 200);
   }
}

// Base ring
difference()
{
   cylinder(h=base_to_bot, d=base_ring_dia, $fn=300);
   cylinder(h=base_to_bot, d=base_ring_dia-base_ring_thk, $fn=300);
}

// Center pin
translate([ 0, 0, base_wall_thk])
{
   cylinder(h=base_pedestal_height, d=cup_bot_dia, $fn=200);

   translate([ 0, 0, base_pedestal_height])
   {
      // Ensure clearance
      cylinder(h=bolt_len, d=bolt_dia - 0.2, $fn=200);
   }
}