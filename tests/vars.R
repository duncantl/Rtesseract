library(Rtesseract)
api = tesseract(save_alt_choices = TRUE, foo = "123", tessedit_char_whitelist = "0123456789.-", tessedit_zero_rejection = TRUE, edges_boxarea = .7, il1_adaptation_test = 1)
GetVariables(api)
PrintVariables(api)

ans = GetVariables(api, c("tessedit_char_whitelist", "save_alt_choices", "foo", "tessedit_zero_rejection", "edges_boxarea", "il1_adaptation_test"))
print(ans)


api = tesseract()
SetVariables(api, save_alt_choices = TRUE, foo = "123", tessedit_char_whitelist = "0123456789.-", tessedit_zero_rejection = TRUE, edges_boxarea = .7, il1_adaptation_test = 1)
