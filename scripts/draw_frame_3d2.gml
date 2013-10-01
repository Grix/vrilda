//draws the current frame on the screen

p = 0;
list_id = controller.frame_list; //ds_list_find_value(ild_list,frame);
format = ds_list_find_value(list_id,2);

draw_set_color(c_white);
draw_set_alpha(1);
draw_set_blend_mode_ext(bm_src_alpha,bm_one);
d3d_set_culling(false);
alpha = 0.12;

switch (format)
    {
    case 0: //format 0: old 3d
        {
        while (p < ds_list_size(list_id)/4-2)
            {
            blank = (ds_list_find_value(list_id,5+(p)*4+3) >> 14) & 1
            
            //find next point
            xpn = ds_list_find_value(list_id,5+(p+1)*4)/$ffff*1024;
            ypn = ds_list_find_value(list_id,5+(p+1)*4+1)/$ffff*768;
            if (xpn >= 512)
                xpn -= 512;
            else
                xpn += 512;
            if (ypn >= 384)
                ypn -= 384;
            else
                ypn += 384;
            ypn = 768-ypn;
            
            //find point
            xp = ds_list_find_value(list_id,5+(p)*4)/$ffff*1024;
            yp = ds_list_find_value(list_id,5+(p)*4+1)/$ffff*768;
        
            if (xp >= 512)
                xp -= 512;
            else
                xp += 512;
            if (yp >= 384)
                yp -= 384;
            else
                yp += 384;
            yp = 768-yp;
                
            //if blanking bit is 0, draw line between the two points
            if !(blank)
                {
                color = (ds_list_find_value(list_id,5+(p)*4+3)) & $FF;
                colormade = (make_color_rgb(ds_grid_get(controller.palette_grid,0,color),ds_grid_get(controller.palette_grid,1,color),ds_grid_get(controller.palette_grid,2,color)));
                d3d_primitive_begin(pr_trianglelist);
                    d3d_vertex_color(obj_scanner.x,obj_scanner.y,obj_scanner.z,colormade,alpha);
                    d3d_vertex_color(obj_scanflate.x+xp*obj_scanner.scanmulti,0,obj_scanflate.y+(768*obj_scanner.scanmulti)-(yp*obj_scanner.scanmulti),colormade,alpha);
                    d3d_vertex_color(obj_scanflate.x+xpn*obj_scanner.scanmulti,0,obj_scanflate.y+(768*obj_scanner.scanmulti)-(ypn*obj_scanner.scanmulti),colormade,alpha);
                d3d_primitive_end();
                }
            
            p++;
            }
        }
        break;
    case 4: //format 4: new 3d
        {
        while (p < ds_list_size(list_id)/7-5)
            {
            np = p+1;
                
            blank = ds_list_find_value(list_id,5+(np)*7+3);
            blank = (blank >> 6) & 1
            
            //find next point
            xpn = ds_list_find_value(list_id,5+(np)*7)/$ffff*1024;
            ypn = ds_list_find_value(list_id,5+(np)*7+1)/$ffff*768;
            if (xpn >= 512)
                xpn -= 512;
            else
                xpn += 512;
            if (ypn >= 384)
                ypn -= 384;
            else
                ypn += 384;
            ypn = 768-ypn;
            
            //find point
            xp = ds_list_find_value(list_id,5+(p)*7)/$ffff*1024;
            yp = ds_list_find_value(list_id,5+(p)*7+1)/$ffff*768;
        
            if (xp >= 512)
                xp -= 512;
            else
                xp += 512;
            if (yp >= 384)
                yp -= 384;
            else
                yp += 384;
            yp = 768-yp;
                
            //if blanking bit is 0, draw line between the two points
            if !(blank)
                {
                blue = ds_list_find_value(list_id,5+(np)*7+4);
                green = ds_list_find_value(list_id,5+(np)*7+5);
                red = ds_list_find_value(list_id,5+(np)*7+6);
                colormade = make_color_rgb(red,green,blue);
                d3d_primitive_begin(pr_trianglelist);
                    d3d_vertex_color(obj_scanner.x,obj_scanner.y,obj_scanner.z,colormade,alpha);
                    d3d_vertex_color(obj_scanflate.x+xp*obj_scanner.scanmulti,0,obj_scanflate.y+(768*obj_scanner.scanmulti)-(yp*obj_scanner.scanmulti),colormade,alpha);
                    d3d_vertex_color(obj_scanflate.x+xpn*obj_scanner.scanmulti,0,obj_scanflate.y+(768*obj_scanner.scanmulti)-(ypn*obj_scanner.scanmulti),colormade,alpha);
                d3d_primitive_end();
                }
            
            p++;
            }
        }
        break;
    case 5: //format 5: new 2d
        {
        while (p < ds_list_size(list_id)/6-5)
            {
            np = p+1;
                
            blank = ds_list_find_value(list_id,5+(np)*6+2);
            blank = (blank >> 6) & 1
            
            //find next point
            xpn = ds_list_find_value(list_id,5+(np)*6)/$ffff*1024;
            ypn = ds_list_find_value(list_id,5+(np)*6+1)/$ffff*768;
            if (xpn >= 512)
                xpn -= 512;
            else
                xpn += 512;
            if (ypn >= 384)
                ypn -= 384;
            else
                ypn += 384;
            ypn = 768-ypn;
            
            //find point
            xp = ds_list_find_value(list_id,5+(p)*6)/$ffff*1024;
            yp = ds_list_find_value(list_id,5+(p)*6+1)/$ffff*768;
        
            if (xp >= 512)
                xp -= 512;
            else
                xp += 512;
            if (yp >= 384)
                yp -= 384;
            else
                yp += 384;
            yp = 768-yp;
                
            //if blanking bit is on, draw line between the two points
            if !(blank)
                {
                blue = ds_list_find_value(list_id,5+(np)*6+3);
                green = ds_list_find_value(list_id,5+(np)*6+4);
                red = ds_list_find_value(list_id,5+(np)*6+5);
                colormade = make_color_rgb(red,green,blue);
                d3d_primitive_begin(pr_trianglelist);
                    d3d_vertex_color(obj_scanner.x,obj_scanner.y,obj_scanner.z,colormade,alpha);
                    d3d_vertex_color(obj_scanflate.x+xp*obj_scanner.scanmulti,0,obj_scanflate.y+(768*obj_scanner.scanmulti)-(yp*obj_scanner.scanmulti),colormade,alpha);
                    d3d_vertex_color(obj_scanflate.x+xpn*obj_scanner.scanmulti,0,obj_scanflate.y+(768*obj_scanner.scanmulti)-(ypn*obj_scanner.scanmulti),colormade,alpha);
                d3d_primitive_end();
                }
            
            p++;
            }
        }
        break;
    }
    
draw_set_blend_mode(bm_normal);
