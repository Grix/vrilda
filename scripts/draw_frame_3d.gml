//draws the current frame on the screen

p = 0;
ild_list = ds_list_find_value(controller.scan_list,scanner);
list_id = ds_list_find_value(ild_list,controller.frame);
format = ds_list_find_value(list_id,2);

draw_set_color(c_white);
draw_set_alpha(1);
usealpha = alpha*0.5;
draw_set_blend_mode_ext(bm_src_alpha,bm_dest_alpha);
d3d_set_culling(false);
if (controller.fog) 
    {
    shader_set(lasershader);
    usealpha /= 0.5;
    }


switch (format)
    {
    case 0: //format 0: old 3d
        {
        while (p < ds_list_size(list_id)/4-5)
            {
            blank = (ds_list_find_value(list_id,5+(p)*4+3) >> 14) & 1
            
            //find next point
            xpn = ds_list_find_value(list_id,5+(p+1)*4)/$ffff*1024;
            ypn = ds_list_find_value(list_id,5+(p+1)*4+1)/$ffff*1024;
            if (xpn >= 512)
                xpn -= 512;
            else
                xpn += 512;
            if (ypn >= 512)
                ypn -= 512;
            else
                ypn += 512;
            ypn = 1024-ypn;
            xpn = 1024-xpn;
            
            //find point
            xp = ds_list_find_value(list_id,5+(p)*4)/$ffff*1024;
            yp = ds_list_find_value(list_id,5+(p)*4+1)/$ffff*1024;
        
            if (xp >= 512)
                xp -= 512;
            else
                xp += 512;
            if (yp >= 512)
                yp -= 512;
            else
                yp += 512;
            yp = 1024-yp;
            xp = 1024-xp;
                
            //if blanking bit is 0, draw line between the two points
            if !(blank)
                {
                color = (ds_list_find_value(list_id,5+(p)*4+3)) & $FF;
                colormade = (make_color_rgb(ds_grid_get(controller.palette_grid,0,color),ds_grid_get(controller.palette_grid,1,color),ds_grid_get(controller.palette_grid,2,color)));
                
                d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                    d3d_vertex_texture_color(x,y,z,0,0,colormade,usealpha);
                    d3d_vertex_texture_color(scanflate.x-(512*scanmulti)+xp*scanmulti,scanflate.y,scanflate.z-(389*scanmulti)+(1024*scanmulti)-(yp*scanmulti),0,0,colormade,usealpha);
                    d3d_vertex_texture_color(scanflate.x-(512*scanmulti)+xpn*scanmulti,scanflate.y,scanflate.z-(389*scanmulti)+(1024*scanmulti)-(ypn*scanmulti),0,0,colormade,usealpha);
                d3d_primitive_end();
                }
            
            p++;
            }
        break;
        }
    case 4: //format 4: new 3d
        {
        while (p < ds_list_size(list_id)/7-5)
            {
            np = p+1;
                
            blank = ds_list_find_value(list_id,5+(np)*7+3);
            blank = (blank >> 6) & 1
            
            //find next point
            xpn = ds_list_find_value(list_id,5+(np)*7)/$ffff*1024;
            ypn = ds_list_find_value(list_id,5+(np)*7+1)/$ffff*1024;
            if (xpn >= 512)
                xpn -= 512;
            else
                xpn += 512;
            if (ypn >= 512)
                ypn -= 512;
            else
                ypn += 512;
            ypn = 1024-ypn;
            xpn = 1024-xpn;
            
            //find point
            xp = ds_list_find_value(list_id,5+(p)*7)/$ffff*1024;
            yp = ds_list_find_value(list_id,5+(p)*7+1)/$ffff*1024;
        
            if (xp >= 512)
                xp -= 512;
            else
                xp += 512;
            if (yp >= 512)
                yp -= 512;
            else
                yp += 512;
            yp = 1024-yp;
            xp = 1024-xp;
                
            //if blanking bit is 0, draw line between the two points
            if !(blank)
                {
                blue = ds_list_find_value(list_id,5+(np)*7+4);
                green = ds_list_find_value(list_id,5+(np)*7+5);
                red = ds_list_find_value(list_id,5+(np)*7+6);
                colormade = make_color_rgb(red,green,blue);
                
                d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                    d3d_vertex_texture_color(x,y,z,0,0,colormade,usealpha);
                    d3d_vertex_texture_color(scanflate.x-(512*scanmulti)+xp*scanmulti,scanflate.y,scanflate.z-(389*scanmulti)+(1024*scanmulti)-(yp*scanmulti),0,0,colormade,usealpha);
                    d3d_vertex_texture_color(scanflate.x-(512*scanmulti)+xpn*scanmulti,scanflate.y,scanflate.z-(389*scanmulti)+(1024*scanmulti)-(ypn*scanmulti),0,0,colormade,usealpha);
                d3d_primitive_end();
                }
            
            p++;
            }
        break;
        }
    case 5: //format 5: new 2d
        {
        while (p < ds_list_size(list_id)/6-5)
            {
            np = p+1;
                
            blank = ds_list_find_value(list_id,5+(np)*6+2);
            blank = (blank >> 6) & 1
            
            //find next point
            xpn = ds_list_find_value(list_id,5+(np)*6)/$ffff*1024;
            ypn = ds_list_find_value(list_id,5+(np)*6+1)/$ffff*1024;
            if (xpn >= 512)
                xpn -= 512;
            else
                xpn += 512;
            if (ypn >= 512)
                ypn -= 512;
            else
                ypn += 512;
            ypn = 1024-ypn;
            xpn = 1024-xpn;
            
            //find point
            xp = ds_list_find_value(list_id,5+(p)*6)/$ffff*1024;
            yp = ds_list_find_value(list_id,5+(p)*6+1)/$ffff*1024;
        
            if (xp >= 512)
                xp -= 512;
            else
                xp += 512;
            if (yp >= 512)
                yp -= 512;
            else
                yp += 512;
            yp = 1024-yp;
            xp = 1024-xp;
                
            //if blanking bit is on, draw line between the two points
            if !(blank)
                {
                blue = ds_list_find_value(list_id,5+(np)*6+3);
                green = ds_list_find_value(list_id,5+(np)*6+4);
                red = ds_list_find_value(list_id,5+(np)*6+5);
                colormade = make_color_rgb(red,green,blue);
                
                d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                    d3d_vertex_texture_color(x,y,z,0,0,colormade,usealpha);
                    d3d_vertex_texture_color(scanflate.x-(512*scanmulti)+xp*scanmulti,scanflate.y,scanflate.z-(389*scanmulti)+(1024*scanmulti)-(yp*scanmulti),0,0,colormade,usealpha);
                    d3d_vertex_texture_color(scanflate.x-(512*scanmulti)+xpn*scanmulti,scanflate.y,scanflate.z-(389*scanmulti)+(1024*scanmulti)-(ypn*scanmulti),0,0,colormade,usealpha);
                d3d_primitive_end();
                
                }
            
            p++;
            }
        break;
        }
    }
    
draw_set_blend_mode(bm_normal);
shader_reset();
