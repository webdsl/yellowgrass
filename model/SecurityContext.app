module entities_generated/SecurityContext
entity SecurityContext {
  loggedIn :: Bool := this.principal != null
  principal -> User
}