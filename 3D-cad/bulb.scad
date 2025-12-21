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
// This model is for a bulb with an interior diameter large enough and high enough to
// accommodate the G4 LED bulb.
//
// -- Part of the antique candlestick holder project
//

include <candlestick-dimensions.scad>
use <threads.scad>


module meas_stick()
{
   translate([-20.4,0,0])
   {
      cube([5,5,80]);
      translate([0,0,76])
      {
         cube([25,5,5]);
      }
   }
}


translate([0,0,bulb_r1+bulb_base_height-3])
{
   $fn=200;

   difference() {
      // 1. Create the solid outer hull
      hull()
      {
         sphere(bulb_r1);
         translate([0, 0, bulb_off1])
         {
            sphere(bulb_r2);
            translate([0,0,bulb_off2])
            {
               sphere(bulb_r3);
               translate([0,0,bulb_off3])
               {
                  sphere(bulb_r4);
               }
            }
         }
      }

      // 2. Create the smaller inner hull to hollow it out
      hull()
      {
         sphere(bulb_r1 - bulb_thk);
         translate([0, 0, bulb_off1])
         {
            sphere(bulb_r2 - bulb_thk);
            translate([0,0,bulb_off2])
            {
               sphere(bulb_r3 - bulb_thk);
               translate([0,0,bulb_off3])
               {
                  sphere(bulb_r4 - bulb_thk);
               }
            }
         }
      }

      translate([0,0,-(bulb_r1)])
      {
         cylinder(h=flame_base_height, d=bulb_od);
      }

      // Taller than the bulb
      cylinder(h=45, d=bulb_air_dia, $fn=200);
   }
}

difference()
{
   $fn=200;
   metric_thread(diameter=flame_base_od, pitch=bulb_thread_pitch, length=bulb_base_height);

   cylinder(h=bulb_base_height, d=bulb_od);
}
