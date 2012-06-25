module model/Event
entity Event {
  moment :: DateTime
  test ::  Bool  //todofix
  test2 :: String
  test3 :: Int
  test4 :: Email
  test5 :: Float
  test6 :: Long 
  test7 :: URL
  test8 :: Patch
  test9 :: Text
  test10 :: Secret
  test11 :: File
  test12 :: Image
  test13 :: WikiText
  test14 :: Time
  test15 :: Date
  test16 -> Issue
  test17 -> Project
  test18 -> List<Issue>
  test19 -> Set<Project> 
  
  // test18 -> Ref<Project> 
// function toJSON ( ) : JSONObject
//   {
//     var json := JSONObject() ;
//     return null;
//   }
}