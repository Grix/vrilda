with (obj_miniscanner) instance_destroy();

for( i=0; i<=(ds_list_size(controller.scan_list)-1); i++)
    {
    scanner = instance_create(0,0,obj_miniscanner);
        scanner.scanner = i;
        scanner.master = 1;
    }

with (obj_miniscanner)
    {
    
    dual = ds_list_find_value(ds_list_find_value(controller.scan_list,scanner),0);
    if (dual == 1)
        {
        slave = instance_create(x,y,obj_miniscanner);
            slave.master = 0;
            slave.scanner = scanner;
        }
    }