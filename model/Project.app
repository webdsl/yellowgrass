module model/Project
entity Project {
  email :: Email
  private :: Bool ( searchable )
  // created :: DateTime
  followers -> Set<User>
  memberRequests -> Set<User>
  members -> Set<User>
  issues -> Set<Issue>
  url :: URL
  description :: WikiText
  name :: String ( id, searchable, validate(isUniqueProject(this),"Another project with this name already exists"), validate(name.length()>=3,"Project names should be three characters or longer"), validate ( /[a-z0-9A-Z._]*/.match(name) , "Project names may contain characters, numbers, dots and underscores." ) )
  function toJSONRef ( ) : JSONObject
  {
    // if ( private && ! securityContext.principal in members )
    // {
    //   return null;
    // }
    var jsonobject := JSONObject() ;
    jsonobject.put("id", id);
    return jsonobject;
  }
  // function toSimpleJSON ( ) : JSONObject
  // {
  //   // if ( private && ! securityContext.principal in members )
  //   // {
  //   //   return null;
  //   // }
  //   var jsonobject := JSONObject() ;
  //   jsonobject.put("id", id);
  //   jsonobject.put("name", name);
  //   jsonobject.put("version", version);
  //   return jsonobject;
  // }
  // function toJSON ( old : JSONObject ) : JSONObject
  // {
  //   // if ( private && ! securityContext.principal in members )
  //   // {
  //   //   return null;
  //   // }
  //   var jsonobject := JSONObject() ;
  //   jsonobject.put("id", id);
  //   var version := old.getInt("version") ;
  //   if ( version < this.version )
  //   {
  //     jsonobject.put("name", name);
  //     jsonobject.put("description", description.format());
  //     jsonobject.put("url", url);
  //     jsonobject.put("version", this.version);
  //   }
  //   jsonobject.put("weeklyStatsGraph", this.getWeeklyStatsGraph());
  //   if ( version == 0 )
  //   {
  //     var jsonArrayIssues := JSONArray() ;
  //     for ( issue : Issue in issues order by issue.number desc limit 10 )
  //     {
  //       jsonArrayIssues.put(issue.toJSON());
  //     }
  //     jsonobject.put("issues", jsonArrayIssues);
  //     var releases : List<Release>;//= generateRoadmap(this) ;
  //     var jsonmap := JSONArray() ;
  //     for ( release : Release in releases order by release.name desc )
  //     {
  //       if ( jsonmap.length() == 0 )
  //       {
  //         jsonmap.put(release.toJSON());
  //       }
  //       else
  //       {
  //         jsonmap.put(release.toJSONSimple());
  //       }
  //     }
  //     jsonobject.put("roadmap", jsonmap);
  //   }
  //   // var jsonoldmembers := toVersionObejcts(old.getJSONArray("members")) ; 
  //   var jsonArrayMembers := JSONArray() ;
  //   // var dirty := false ;
  //   // for ( member : User in members )
  //   // {
  //   //   // var vobject := VersionObject{id := member.id} ;
  //   //   var index := 1;// jsonoldmembers.indexOf(vobject) ;
  //   //   if ( index == -1 || jsonoldmembers.get(index).version != member.version )
  //   //   {
  //   //     log(member.name + "is out dated");
  //   //     jsonArrayMembers.put(member.toJSON());
  //   //     dirty := true;
  //   //   }
  //   //   else
  //   //   {
  //   //     log(member.name + "(" + member.id + ")" + ":" + member.version + "is in ");
  //   //     for ( object : VersionObject in jsonoldmembers )
  //   //     {
  //   //       log(object.toString2());
  //   //     }
  //   //     jsonArrayMembers.put(member.toSimpleJSON());
  //   //   }
  //   // }
  //   // if ( dirty || version < this.version )
  //   // {
  //   //   jsonobject.put("members", jsonArrayMembers);
  //   // }
  //   // var jsonoldfollowers := toVersionObejcts(old.getJSONArray("followers")) ;
  //   // dirty := false;
  //   // var jsonArrayFollowers := JSONArray() ;
  //   // for ( follower : User in followers )
  //   // {
  //   //   var vobject := VersionObject{id := follower.id} ;
  //   //   var index := jsonoldfollowers.indexOf(vobject) ;
  //   //   if ( index == -1 || jsonoldmembers.get(index).version != follower.version )
  //   //   {
  //   //     jsonArrayMembers.put(follower.toJSON());
  //   //     dirty := true;
  //   //   }
  //   //   else
  //   //   {
  //   //     jsonArrayMembers.put(follower.toSimpleJSON());
  //   //   }
  //   // }
  //   // if ( dirty || version < this.version )
  //   // {
  //   //   jsonobject.put("followers", jsonArrayFollowers);
  //   // }
  //   var issuetags := JSONArray() ;
  //   for ( tag : Tag in getIssueTypeTags() )
  //   {
  //     issuetags.put(tag.toJSON());
  //   }
  //   jsonobject.put("issueTypes", issuetags);
  //   return jsonobject;
  // }
  function getWeeklyStatsGraph ( ) : String
  {
    var stats := getIssueStatsWeekly() ;
    var maxStat := 20;//maxList(stats) ;
    var prefix := "http://chart.apis.google.com/chart?cht=bvg&chs=230x100&chco=bbcebb&chbh=a,5,10&chxt=y" ;
    var rangePrefix := "&chds=0," + maxStat ;
    var axisPrefix := "&chxr=0,0," + maxStat ;
    var dataPrefix := "&chd=t:" ;
    var url : List<String> ;
    url.add(prefix);
    url.add(rangePrefix);
    url.add(axisPrefix);
    url.add(dataPrefix);
    for
    (
    nr
    :
    Int
    from
    0
    to
    stats.length
    -
    2
    )
    {
      url.add(stats.get(nr).toString() + ",");
    }
    url.add(stats.get(stats.length - 1).toString());
    return url.concat();
  }
  function getIssueStatsWeekly ( ) : List<Int>
  {
    var yearStart : DateTime := now().addYears(-1) ;
    var stats : List<Int> ;
    for
    (
    week
    :
    Int
    from
    1
    to
    51
    )
    {
      var start := yearStart.addDays(week * 7) ;
      var end := yearStart.addDays(week + 1 * 7) ;
      stats.add(select count ( * ) from
                                   Issue where _project = ~this and _submitted > ~start and _submitted < ~end);
    }
    return stats;
  }
  function getOrderedIssues ( filterOpen : Bool ) : List<Issue>
  {
    if ( filterOpen )
    {
      return from
             Issue where _project = ~this and _open = true order by
                                                           _number
                                                           desc limit 2000;
    }
    else
    {
      return from
             Issue where _project = ~this order by
                                          _number
                                          desc limit 2000;
    }
  }
  function getIssueTypeTags ( ) : List<Tag>
  {
    var issuetypes : List<Tag> := select t1 from
                                            Tag
                                            as
                                            t1
                                            left
                                            join
                                            t1
                                            .
                                            tags
                                            as
                                            t2 where t1 . project = ~this and t2 . project = ~this and t2 . name = ~"issuetype" group by t1 . name order by
                                                                                                                                                        t1
                                                                                                                                                        .
                                                                                                                                                        name ;
    return issuetypes;
  }
  function getCommonTags ( nr : Int ) : List<Tag>
  {
    var result : List<Tag> := (( select t from
                                         Issue
                                         as
                                         i
                                         inner
                                         join
                                         i
                                         .
                                         tags
                                         as
                                         t where ( i . _project = ~this ) and ( t . _project = ~this ) and ( t . _name not like ~"@%" ) and ( t . _name not like ~"!%" ) group by t . _name order by
                                                                                                                                                                                            count
                                                                                                                                                                                            (
                                                                                                                                                                                            i
                                                                                                                                                                                            )
                                                                                                                                                                                            desc limit ~nr )as List<Tag> ) ;
    return result;
  }
}