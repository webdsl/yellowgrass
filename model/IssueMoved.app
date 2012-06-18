module model/IssueMoved
entity IssueMoved : Event {
  target -> Issue
  actor -> User
}