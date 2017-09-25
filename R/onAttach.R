.onAttach =
function(...)
{
    if(!configInfo$useRexit)
       .C("R_atexit")
}
