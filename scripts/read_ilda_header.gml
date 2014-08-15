//reads the header of the ilda frame, returns 1 if error

if !is_wrong($49) return 0;
i += 8;
repeat(8) //8
    {
    name+= chr(get_byte());
    i++
    }
repeat(8) //16
    {
    author+= chr(get_byte());
    i++
    }
bytes = get_bytes(); //24
if (bytes != 0)
    {
    frame_list = ds_list_create();
    ds_list_add(frame_list,bytes);
    }
else
    return 1;
    
i+=2;//26
frame_number = get_bytes();
i+=2;//28
maxframes = get_bytes();
i+=2; //30
    
ds_list_add(frame_list,byte);
ds_list_add(frame_list,format);
ds_list_add(frame_list,name);
ds_list_add(frame_list,author);
author="";
name="";
i+=2;

if !(frame_number % 128)
    return 2;
    
return 0;
