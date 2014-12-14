//argument0: data buffer 
var command = buffer_read(argument0, buffer_string);
show_debug_message("Networking Event: " + string(command))

switch(command){

    case "HELLO":
        server_time = buffer_read(argument0, buffer_string);
        room_goto_next();
        show_debug_message("Server welcomes you @ " + server_time);
        break;
        
    case "LOGIN":
        status = buffer_read(argument0, buffer_string)
        if(status == "TRUE"){
            
            target_room = buffer_read(argument0, buffer_string);
            target_x = buffer_read(argument0, buffer_u16);
            target_y = buffer_read(argument0, buffer_u16);
            name = buffer_read(argument0, buffer_string);
            
            goto_room = asset_get_index(target_room);
            room_goto(goto_room);

            //Initiate a player object... on this room.
            with(instance_create(target_x, target_y, obj_Player)){
                name = other.name
            }
        
        }else{
            show_message("Login Failed: User Doesnt Exist Or Password Incorrect.")
        }
        break;
        
    case "REGISTER":
        status = buffer_read(argument0, buffer_string)
        if(status == "TRUE"){
            show_message("Register Success: Please Login.")
        }else{
            show_message("Register Failed: Username Taken.")
        }
        break;

    case "POS":
        username = buffer_read(argument0, buffer_string)
        target_x = buffer_read(argument0, buffer_u16)
        target_y = buffer_read(argument0, buffer_u16)
        
        foundPlayer = -1;
        with(obj_Network_Player){
            if(name == other.username){
                other.foundPlayer = id;
                break;
            }
        }
        
        if(foundPlayer != -1){
        
            with(foundPlayer){
                target_x = other.target_x;
                target_y = other.target_y;
            }
        
        } else {
        
            with(instance_create(target_x, target_y, obj_Network_Player)){
                name = other.username;
            }    
        
        }
    
}
