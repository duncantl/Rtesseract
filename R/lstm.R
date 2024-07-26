getLSTMSymbolChoices =
function(api, level = RIL_WORD)
{
    .Call("R_getLSTMSymbolChoices", api, as.integer(level))
}

