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
// This model is for the latch that locks the charge plate in the candle.
//
// -- Part of the antique candlestick holder project
//

include <candlestick-dimensions.scad>

height_clearance = latch_height - 0.3;
width_clearance = latch_plug_width - 0.1;

difference()
{
   cylinder(h = height_clearance, d = candle_od, $fn=300);

   cylinder(h = height_clearance, d = candle_id, $fn=300);

   translate([-(candle_od/2+latch_width/2), -candle_od/2, 0])
   {
      cube([candle_od/2, candle_od, height_clearance]);
   }

   translate([latch_width/2, -candle_od/2, 0])
   {
      cube([candle_od/2, candle_od, height_clearance]);
   }

   translate([-candle_od/2, 0, 0])
   {
      cube([candle_od, candle_od/2, height_clearance]);
   }
}

// Somewhere between 0.6 and 1.5 are workable
translate([-latch_plug_width/2, -(candle_od/2-0.8), 0])
{
   cube([latch_plug_width, latch_plug_depth, height_clearance]);
}