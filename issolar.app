application issolar

imports templates
imports ac
imports issue/issue
imports user/user
imports project/project

define page root() {
	main()
	define body() {
		"Hello world!"
	}
}

/*test colorsInitialized {
  assert((from Color).length == 4);
}*/