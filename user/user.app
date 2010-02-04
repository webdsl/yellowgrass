module user/user

imports user/ac
imports user/home
imports user/register
imports user/access

entity User {
	name			:: String
	email			:: Email		(validate(userEmailExists(), "Another user already registered using this email address"))
	password		:: Secret		(validate(password.length() >= 8, "Password needs to be at least 8 characters"))
	projects		-> Set<Project> (inverse = Project.members)
	
	function userEmailExists() : Bool {
		return findUserByEmail(email).length == 0;
	}
}

define page user(u : User) {
	main()
	define body(){
		<h1> output(u.name) </h1>
	}
}

define template users(us : Set<User>) {
	table {
		for(u : User in us) {
			row { navigate(user(u)) {output(u.name)}}
		}
	}
}
