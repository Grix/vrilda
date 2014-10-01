
/// Initialize our 3D world.
d3d_start();

d3d_set_culling(true); 
d3d_set_lighting(true);//
//d3d_set_hidden(true);
d3d_set_shading(true);//

//enable_zbuffer();
d3d_set_zwriteenable(true);
draw_set_alpha_test(true);
draw_set_alpha_test_ref_value(128);
draw_enable_alphablend(true);

//Some niceties
d3d_light_define_ambient(c_black);
texture_set_interpolation(true);
texture_set_blending(true);
texture_set_repeat(true);



window_set_size(1920,1080);

display_reset(4,0); //8x AA + VSYNC 
OVR_enableTextureFiltering();
//AA is not really important, but only looks better. VSYNC is almost unmissable - if you want to give the game a realistic feel, don't forget to turn vsync on!
