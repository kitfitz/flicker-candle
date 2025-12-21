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
// This model is for the charge plate. It has the USB-C cutout in the bottom and room
// for the charger and the DC to DC converter. It has the pedestal for the switch that
// also indexes the plate to the candle body. The back has the locking feature for the
// latch to ensure it stays seated.
//
// -- Part of the antique candlestick holder project
//

include <candlestick-dimensions.scad>

// Make the diameter equal to make a tight fit
id_fit = 0;


module usb_c_shape(thk)
{
   cylinder(h=bottom_thk, d=usb_thk, $fn=200);
   translate([0, -usb_thk/2, 0])
   {
      cube([usb_center, usb_thk, bottom_thk]);
   }

   translate([usb_width-usb_thk, 0, 0])
   {
      cylinder(h=bottom_thk, d=usb_thk, $fn=200);
   }
}

difference()
{
   // Make sure there's cleaance with the switch post
   cylinder(d = candle_od, h=switch_slot_depth - switch_height + (switch_height/2 - switch_stem_height/2) -0.5, $fn=300);

   // Make it a slightly tighter fit
   cylinder(d = candle_od - (candle_wall_thk - id_fit), h=switch_slot_depth - switch_height + (switch_height/2 - switch_stem_height/2), $fn=300);

   translate([-candle_od/2, switch_stem_width/2, 0])
   {
      cube([candle_od, candle_od/2, switch_slot_depth]);
   }

   translate([-candle_od/2, -(switch_stem_width/2+candle_od/2), 0])
   {
      cube([candle_od, candle_od/2, switch_slot_depth]);
   }

   translate([-(candle_od/2 + 0.2), -switch_stem_width/2, 0])
   {
      cube([candle_od/2, switch_stem_width, switch_slot_depth]);
   }
}

// Magical number to fit
translate([3.25 + 2,-switch_width/2+0.25/2,0])
{
   cube([switch_depth - 3, switch_width-0.25, (switch_slot_depth-switch_height)-0.4]);

   // Make the board capture feature
   translate([-2, 0, (switch_slot_depth-switch_height)-2.2])
   {
      cube([ 2, switch_width-0.25, 1.8]);
   }
}

// Connector to outside curve
translate([candle_od/2 - (candle_wall_thk+0.2), -4/2, 0])
{
   cube([candle_wall_thk, 4, (switch_slot_depth-switch_height)-0.5]);
}

difference()
{
   // Make the fit a bit snug
   cylinder(h=bottom_thk, d=candle_id + id_fit, $fn=200);

   // Air vent holes through the bottom plate
   for(i = [1:7])
   {
      rotate([0,0,i*45])
      {
         translate([8.5,0,0])
         {
            cylinder( h=bottom_thk, d=base_air_dia, $fn=200);
         }
      }
   }

   // Move 2mm from center, spitballing
   translate([2, -usb_center/2 ,0])
   {
      rotate([0,0,90])
      {
         usb_c_shape(bottom_thk);
      }
   }
}

// Create a nest for the dcdc board
translate([-(dcdc_thk+1), -dcdc_width/2, bottom_thk])
{
   difference()
   {
      cube([dcdc_thk, dcdc_width + 4, dcdc_length/2 + 2]);

      translate([ 0, dcdc_width/2 + 1.5, dcdc_length/2 + 2])
      {
         rotate([0,90,0])
         {
            cylinder(h=dcdc_thk, d = dcdc_slot_dia, $fn=200);
         }

         translate([0, -dcdc_slot_dia/2, 0])
         {
            cube([dcdc_thk, dcdc_slot_dia, dcdc_slot_dia]);
         }
      }
   }
}

// Back dcdc support and insertion guides
difference()
{
   translate([-7.5, -(dcdc_width/2-0.5), 0])
   {
      union()
      {
         cube([dcdc_thk, dcdc_width -1, dcdc_length]);

         translate([-2, 0, 0])
         {
            cube([2, dcdc_thk, dcdc_length]);

            translate([0, (dcdc_width-1)-dcdc_thk, 0])
            {
               cube([2, dcdc_thk, dcdc_length]);
            }

            translate([ 0,0,latch_height-dcdc_thk])
            {
               cube([2, dcdc_width-dcdc_thk, dcdc_thk]);
            }

            translate([ 0,0,latch_height*2])
            {
               cube([2, dcdc_width-dcdc_thk, dcdc_thk]);
            }
         }
      }
   }

   difference()
   {
      cylinder(d = candle_od + 5, h=dcdc_length+bottom_thk, $fn=300);
      cylinder(d = candle_id + id_fit, h=dcdc_length+bottom_thk, $fn=300);
   }

   // Clear the air vent holes through the support
   for(i = [1:7])
   {
      rotate([0,0,i*45])
      {
         translate([8.5,0,0])
         {
            if (i == 3 || i == 5)
            {
               cylinder( h=dcdc_length, d=base_air_dia, $fn=200);
            }
         }
      }
   }

}
