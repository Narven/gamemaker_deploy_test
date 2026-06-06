// Calculate the amount of time between this frame and the last
global.curr_time = get_timer();
global.timer_delta = global.curr_time - global.start_time;
global.start_time = global.curr_time;

if (global.is_html5 && runtime_id < 202414)
{
    message_timer += delta_time * 0.000001;
    
    if (message_timer > 2)
    {
        show_message("THIS PROJECT IS NOT SUPPORTED ON HTML5 BEFORE 2024.14");
        message_timer -= 20;
    }
}