library(Rtesseract)
api = tesseract(save_alt_choices = TRUE, foo = "123", tessedit_char_whitelist = "0123456789.-", tessedit_zero_rejection = TRUE, edges_boxarea = .7, il1_adaptation_test = 1)
v = GetVariables(api)
"foo" %in% names(v)
v["tessedit_char_whitelist"]
v["il1_adaption_test"]
PrintVariables(api)

ans = GetVariables(api, c("tessedit_char_whitelist", "save_alt_choices", "foo", "tessedit_zero_rejection", "edges_boxarea", "il1_adaptation_test"))
print(ans)

api = tesseract()
ov = GetVariables(api)
SetVariables(api, save_alt_choices = TRUE, foo = "123", tessedit_char_whitelist = "0123456789.-", tessedit_zero_rejection = TRUE, edges_boxarea = .2, il1_adaptation_test = 1)
v = GetVariables(api)

table(names(v) == names(ov))  # check variables/names are in the same order
i = mapply(identical, v, ov)
table(i)
names(v)[!i]
cbind(v[!i], ov[!i])



