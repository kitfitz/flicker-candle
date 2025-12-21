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
// This module creates the handle shape for the base.
//
// -- Part of the antique candlestick holder project
//

include <candlestick-dimensions.scad>

module handle_base_shape()
{
   $fn=360;

   // Get the start of the handle at the origin
   translate([handle_rad1, -handle_rad1, 0])
   {
      // The bottom radius, making the first 90 degree bend
      translate([-handle_rad1,0, 0])
      {
         rotate_extrude(angle = handle_ang1) translate([handle_rad1, 0, 0]) square(size = [handle_thk, handle_wide_width], center = true);
      }

      // On top of that part, build the next piece
      translate([-handle_thk/2, 0, -handle_wide_width/2])
      {
         rotate([90, 0, 0])
         {
            // The straight piece, up to the top radius
            cube([handle_thk, handle_wide_width, handle_height]);

            // The next piece is at the end of that cube
            translate([handle_rad2+handle_thk/2, 0, handle_height])
            {
               // Make the top raidus
               translate([0, handle_wide_width/2, 0])
               {
                  rotate([ 90, 0, 0])
                  {
                     // The top radius
                     rotate_extrude(angle = handle_ang2) translate([handle_rad2, 0, 0]) square(size = [handle_thk, handle_wide_width], center = true);
                  }
               }

               minkowski()
               {
                  translate([handle_rad2+handle_rad3, handle_wide_width/2, 0])
                  {
                     rotate([-90, 0, 180])
                     {
                        // The final radius
                        rotate_extrude(angle = handle_ang3) translate([handle_rad3, 0, 0]) square(size = [handle_thk/2, handle_wide_width], center = true);
                     }
                  }
                  sphere(d=handle_thk/2);
               }

            }
         }
      }
   }
}

module handle()
{
   difference()
   {
      translate([0, 0, handle_thk/2])
      {
         rotate([-90,0,0])
         {
            handle_base_shape();
         }
      }

      translate([handle_base_d/2, handle_base_d/2+handle_narrow_width/2, 0])
      {
         cylinder(h=handle_overall_height, d = handle_base_d, $fn=300);
      }

      translate([handle_base_d/2, -(handle_base_d/2+handle_narrow_width/2), 0])
      {
         cylinder(h=handle_overall_height, d = handle_base_d, $fn=300);
      }


      translate([handle_rad1+handle_rad2+handle_base_d/2, handle_base_d/2+handle_narrow_width/2, 0])
      {
         cylinder(h=handle_overall_height, d = handle_base_d, $fn=300);
      }

      translate([handle_rad1+handle_rad2+handle_base_d/2, -(handle_base_d/2+handle_narrow_width/2), 0])
      {
         cylinder(h=handle_overall_height, d = handle_base_d, $fn=300);
      }
   }
}
