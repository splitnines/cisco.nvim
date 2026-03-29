if exists("b:current_syntax")
  finish
endif

lua require("cisco.syntax").apply()
