mobl.provides('Yellowgrassmobile');
mobl.provides('mobl.ui');
mobl.provides('webservices');
mobl.provides('lib');
mobl.provides('Yellowgrassmobile');
mobl.provides('mobl.ui.generic');
mobl.provides('servicemodel');
mobl.provides('mobl');
persistence.debug = false;Yellowgrassmobile.currentProject = mobl.ref(new servicemodel.Project({}));
Yellowgrassmobile.allProjects = mobl.ref(new persistence.LocalQueryCollection([]));

Yellowgrassmobile.root = function(callback, screenCallback) {
  var root6238 = $("<div>");
  var subs__ = new mobl.CompSubscription();
  var nodes5434 = $("<span>");
  root6238.append(nodes5434);
  subs__.addSub((mobl.ui.generic.header)(mobl.ref(""), mobl.ref(false), mobl.ref(null), function(_, callback) {
    var root6239 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    var nodes5435 = $("<span>");
    root6239.append(nodes5435);
    subs__.addSub((lib.getHeaderImage)(mobl.ref(false), function(_, callback) {
      var root6240 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root6240); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes5435;
      nodes5435 = node.contents();
      oldNodes.replaceWith(nodes5435);
    }));
    callback(root6239); return subs__;
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes5434;
    nodes5434 = node.contents();
    oldNodes.replaceWith(nodes5434);
  }));
  var nodes5436 = $("<span>");
  root6238.append(nodes5436);
  subs__.addSub((mobl.ui.generic.group)(function(_, callback) {
    var root6241 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    var result__ = function(event, callback) {
                     if(event && event.stopPropagation) event.stopPropagation();
                     mobl.call('Yellowgrassmobile.showProjects', [mobl.ref(false), mobl.ref("slide"), mobl.ref(null)], function(result__) {
                     var tmp3445 = result__;
                     if(callback && callback.apply) callback(); return;
                     });
                   };
    var tmp3391 = mobl.ref(result__);
    
    var nodes5437 = $("<span>");
    root6241.append(nodes5437);
    subs__.addSub((mobl.ui.generic.item)(mobl.ref(mobl.ui.generic.itemStyle), mobl.ref(mobl.ui.generic.itemPushedStyle), tmp3391, mobl.ref(null), mobl.ref(false), function(_, callback) {
      var root6242 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      var nodes5438 = $("<span>");
      root6242.append(nodes5438);
      subs__.addSub((mobl.label)(mobl.ref("Show Projects"), mobl.ref(null), mobl.ref(null), function(_, callback) {
        var root6243 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        callback(root6243); return subs__;
        return subs__;
      }, function(node) {
        var oldNodes = nodes5438;
        nodes5438 = node.contents();
        oldNodes.replaceWith(nodes5438);
      }));
      callback(root6242); return subs__;
      
      return subs__;
    }, function(node) {
      var oldNodes = nodes5437;
      nodes5437 = node.contents();
      oldNodes.replaceWith(nodes5437);
    }));
    var result__ = function(event, callback) {
                     if(event && event.stopPropagation) event.stopPropagation();
                     mobl.call('Yellowgrassmobile.showActiveProjects', [mobl.ref(false), mobl.ref("slide"), mobl.ref(null)], function(result__) {
                     var tmp3444 = result__;
                     if(callback && callback.apply) callback(); return;
                     });
                   };
    var tmp3392 = mobl.ref(result__);
    
    var nodes5439 = $("<span>");
    root6241.append(nodes5439);
    subs__.addSub((mobl.ui.generic.item)(mobl.ref(mobl.ui.generic.itemStyle), mobl.ref(mobl.ui.generic.itemPushedStyle), tmp3392, mobl.ref(null), mobl.ref(false), function(_, callback) {
      var root6244 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      var nodes5440 = $("<span>");
      root6244.append(nodes5440);
      subs__.addSub((mobl.label)(mobl.ref("Show Favorite Projects"), mobl.ref(null), mobl.ref(null), function(_, callback) {
        var root6245 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        callback(root6245); return subs__;
        return subs__;
      }, function(node) {
        var oldNodes = nodes5440;
        nodes5440 = node.contents();
        oldNodes.replaceWith(nodes5440);
      }));
      callback(root6244); return subs__;
      
      return subs__;
    }, function(node) {
      var oldNodes = nodes5439;
      nodes5439 = node.contents();
      oldNodes.replaceWith(nodes5439);
    }));
    callback(root6241); return subs__;
    
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes5436;
    nodes5436 = node.contents();
    oldNodes.replaceWith(nodes5436);
  }));
  callback(root6238); return subs__;
  
  
  return subs__;
};

Yellowgrassmobile.showProjects = function(callback, screenCallback) {
  var root6246 = $("<div>");
  var subs__ = new mobl.CompSubscription();
  var nodes5441 = $("<span>");
  root6246.append(nodes5441);
  subs__.addSub((mobl.ui.generic.header)(mobl.ref("All Projects"), mobl.ref(false), mobl.ref(null), function(_, callback) {
    var root6247 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    var nodes5442 = $("<span>");
    root6247.append(nodes5442);
    subs__.addSub((lib.getHeaderImage)(mobl.ref(true), function(_, callback) {
      var root6248 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root6248); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes5442;
      nodes5442 = node.contents();
      oldNodes.replaceWith(nodes5442);
    }));
    var result__ = lib.toSmall();
    var tmp3394 = mobl.ref(result__);
    
    
    var node1035 = $("<span>");
    root6247.append(node1035);
    var condSubs640 = new mobl.CompSubscription();
    subs__.addSub(condSubs640);
    var oldValue640;
    var renderCond640 = function() {
      var value704 = tmp3394.get();
      if(oldValue640 === value704) return;
      oldValue640 = value704;
      var subs__ = condSubs640;
      subs__.unsubscribe();
      node1035.empty();
      if(value704) {
        var result__ = function(event, callback) {
                         if(event && event.stopPropagation) event.stopPropagation();
                         mobl.call('Yellowgrassmobile.root', [mobl.ref(false), mobl.ref("slide"), mobl.ref(null)], function(result__) {
                         var tmp3446 = result__;
                         if(callback && callback.apply) callback(); return;
                         });
                       };
        var tmp3393 = mobl.ref(result__);
        
        var nodes5443 = $("<span>");
        node1035.append(nodes5443);
        subs__.addSub((mobl.ui.generic.backButton)(mobl.ref("back"), mobl.ref(mobl.ui.generic.backButtonStyle), mobl.ref(mobl.ui.generic.backButtonPushedStyle), tmp3393, function(_, callback) {
          var root6249 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root6249); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes5443;
          nodes5443 = node.contents();
          oldNodes.replaceWith(nodes5443);
        }));
        
        
      } else {
        
      }
    };
    renderCond640();
    subs__.addSub(tmp3394.addEventListener('change', function() {
      renderCond640();
    }));
    
    var result__ = 1 - lib.toSmall();
    var tmp3396 = mobl.ref(result__);
    
    
    var node1036 = $("<span>");
    root6247.append(node1036);
    var condSubs641 = new mobl.CompSubscription();
    subs__.addSub(condSubs641);
    var oldValue641;
    var renderCond641 = function() {
      var value705 = tmp3396.get();
      if(oldValue641 === value705) return;
      oldValue641 = value705;
      var subs__ = condSubs641;
      subs__.unsubscribe();
      node1036.empty();
      if(value705) {
        var result__ = function(event, callback) {
                         if(event && event.stopPropagation) event.stopPropagation();
                         mobl.call('Yellowgrassmobile.root', [mobl.ref(false), mobl.ref("slide"), mobl.ref(null)], function(result__) {
                         var tmp3447 = result__;
                         if(callback && callback.apply) callback(); return;
                         });
                       };
        var tmp3395 = mobl.ref(result__);
        
        var nodes5444 = $("<span>");
        node1036.append(nodes5444);
        subs__.addSub((mobl.ui.generic.button)(mobl.ref("back"), mobl.ref(mobl.ui.generic.buttonStyle), mobl.ref(mobl.ui.generic.buttonPushedStyle), tmp3395, function(_, callback) {
          var root6250 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root6250); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes5444;
          nodes5444 = node.contents();
          oldNodes.replaceWith(nodes5444);
        }));
        
        
      } else {
        
      }
    };
    renderCond641();
    subs__.addSub(tmp3396.addEventListener('change', function() {
      renderCond641();
    }));
    
    var result__ = function(event, callback) {
                     if(event && event.stopPropagation) event.stopPropagation();
                     mobl.call('Yellowgrassmobile.showActiveProjects', [mobl.ref(false), mobl.ref("slide"), mobl.ref(null)], function(result__) {
                     var tmp3448 = result__;
                     if(callback && callback.apply) callback(); return;
                     });
                   };
    var tmp3397 = mobl.ref(result__);
    
    var nodes5445 = $("<span>");
    root6247.append(nodes5445);
    subs__.addSub((mobl.ui.generic.button)(mobl.ref("Active"), mobl.ref(mobl.ui.generic.buttonStyle), mobl.ref(mobl.ui.generic.buttonPushedStyle), tmp3397, function(_, callback) {
      var root6251 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root6251); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes5445;
      nodes5445 = node.contents();
      oldNodes.replaceWith(nodes5445);
    }));
    callback(root6247); return subs__;
    
    
    
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes5441;
    nodes5441 = node.contents();
    oldNodes.replaceWith(nodes5441);
  }));
  var nodes5446 = $("<span>");
  root6246.append(nodes5446);
  subs__.addSub((mobl.ui.generic.group)(function(_, callback) {
    var root6252 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    webservices.Service.getProjects(function(result__) {
      var tmp3449 = result__;
      var projects = mobl.ref(result__);
      var result__ = Yellowgrassmobile.setAllProjects(projects.get());
      
      var node1037 = mobl.loadingSpan();
      root6252.append(node1037);
      var list271;
      var listSubs271 = new mobl.CompSubscription();
      subs__.addSub(listSubs271);
      var renderList271 = function() {
        var subs__ = listSubs271;
        list271 = projects.get();
        list271.list(function(results271) {
          node1037.empty();
          for(var i357 = 0; i357 < results271.length; i357++) {
            (function() {
              var iternode271 = $("<span>");
              node1037.append(iternode271);
              var project;
              project = mobl.ref(mobl.ref(results271), i357);
              var result__ = function(event, callback) {
                               if(event && event.stopPropagation) event.stopPropagation();
                               mobl.call('Yellowgrassmobile.ShowProject', [project, mobl.ref(false), mobl.ref("slide"), mobl.ref(null)], function(result__) {
                               var tmp3450 = result__;
                               if(callback && callback.apply) callback(); return;
                               });
                             };
              var tmp3398 = mobl.ref(result__);
              
              var nodes5447 = $("<span>");
              iternode271.append(nodes5447);
              subs__.addSub((mobl.ui.generic.item)(mobl.ref(mobl.ui.generic.itemStyle), mobl.ref(mobl.ui.generic.itemPushedStyle), tmp3398, mobl.ref(null), mobl.ref(false), function(_, callback) {
                var root6253 = $("<span>");
                var subs__ = new mobl.CompSubscription();
                var nodes5448 = $("<span>");
                root6253.append(nodes5448);
                subs__.addSub((mobl.label)(mobl.ref(project, 'name'), mobl.ref(null), mobl.ref(null), function(_, callback) {
                  var root6254 = $("<span>");
                  var subs__ = new mobl.CompSubscription();
                  callback(root6254); return subs__;
                  return subs__;
                }, function(node) {
                  var oldNodes = nodes5448;
                  nodes5448 = node.contents();
                  oldNodes.replaceWith(nodes5448);
                }));
                callback(root6253); return subs__;
                
                return subs__;
              }, function(node) {
                var oldNodes = nodes5447;
                nodes5447 = node.contents();
                oldNodes.replaceWith(nodes5447);
              }));
              
              var oldNodes = iternode271;
              iternode271 = iternode271.contents();
              oldNodes.replaceWith(iternode271);
              
              
            }());
          }
          mobl.delayedUpdateScrollers();
          subs__.addSub(list271.addEventListener('change', function() { listSubs271.unsubscribe(); renderList271(true); }));
          subs__.addSub(projects.addEventListener('change', function() { listSubs271.unsubscribe(); renderList271(true); }));
        });
      };
      renderList271();
      
      callback(root6252); return subs__;
      
    });
    return subs__;
  }, function(node) {
    var oldNodes = nodes5446;
    nodes5446 = node.contents();
    oldNodes.replaceWith(nodes5446);
  }));
  callback(root6246); return subs__;
  
  
  return subs__;
};

Yellowgrassmobile.showActiveProjects = function(callback, screenCallback) {
  var root6255 = $("<div>");
  var subs__ = new mobl.CompSubscription();
  var nodes5449 = $("<span>");
  root6255.append(nodes5449);
  subs__.addSub((mobl.ui.generic.header)(mobl.ref("Active Projects"), mobl.ref(false), mobl.ref(null), function(_, callback) {
    var root6256 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    var nodes5450 = $("<span>");
    root6256.append(nodes5450);
    subs__.addSub((lib.getHeaderImage)(mobl.ref(true), function(_, callback) {
      var root6257 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root6257); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes5450;
      nodes5450 = node.contents();
      oldNodes.replaceWith(nodes5450);
    }));
    var result__ = lib.toSmall();
    var tmp3400 = mobl.ref(result__);
    
    
    var node1038 = $("<span>");
    root6256.append(node1038);
    var condSubs642 = new mobl.CompSubscription();
    subs__.addSub(condSubs642);
    var oldValue642;
    var renderCond642 = function() {
      var value706 = tmp3400.get();
      if(oldValue642 === value706) return;
      oldValue642 = value706;
      var subs__ = condSubs642;
      subs__.unsubscribe();
      node1038.empty();
      if(value706) {
        var result__ = function(event, callback) {
                         if(event && event.stopPropagation) event.stopPropagation();
                         mobl.call('Yellowgrassmobile.root', [mobl.ref(false), mobl.ref("slide"), mobl.ref(null)], function(result__) {
                         var tmp3451 = result__;
                         if(callback && callback.apply) callback(); return;
                         });
                       };
        var tmp3399 = mobl.ref(result__);
        
        var nodes5451 = $("<span>");
        node1038.append(nodes5451);
        subs__.addSub((mobl.ui.generic.backButton)(mobl.ref("back"), mobl.ref(mobl.ui.generic.backButtonStyle), mobl.ref(mobl.ui.generic.backButtonPushedStyle), tmp3399, function(_, callback) {
          var root6258 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root6258); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes5451;
          nodes5451 = node.contents();
          oldNodes.replaceWith(nodes5451);
        }));
        
        
      } else {
        
      }
    };
    renderCond642();
    subs__.addSub(tmp3400.addEventListener('change', function() {
      renderCond642();
    }));
    
    var result__ = 1 - lib.toSmall();
    var tmp3402 = mobl.ref(result__);
    
    
    var node1039 = $("<span>");
    root6256.append(node1039);
    var condSubs643 = new mobl.CompSubscription();
    subs__.addSub(condSubs643);
    var oldValue643;
    var renderCond643 = function() {
      var value707 = tmp3402.get();
      if(oldValue643 === value707) return;
      oldValue643 = value707;
      var subs__ = condSubs643;
      subs__.unsubscribe();
      node1039.empty();
      if(value707) {
        var result__ = function(event, callback) {
                         if(event && event.stopPropagation) event.stopPropagation();
                         mobl.call('Yellowgrassmobile.root', [mobl.ref(false), mobl.ref("slide"), mobl.ref(null)], function(result__) {
                         var tmp3452 = result__;
                         if(callback && callback.apply) callback(); return;
                         });
                       };
        var tmp3401 = mobl.ref(result__);
        
        var nodes5452 = $("<span>");
        node1039.append(nodes5452);
        subs__.addSub((mobl.ui.generic.button)(mobl.ref("back"), mobl.ref(mobl.ui.generic.buttonStyle), mobl.ref(mobl.ui.generic.buttonPushedStyle), tmp3401, function(_, callback) {
          var root6259 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root6259); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes5452;
          nodes5452 = node.contents();
          oldNodes.replaceWith(nodes5452);
        }));
        
        
      } else {
        
      }
    };
    renderCond643();
    subs__.addSub(tmp3402.addEventListener('change', function() {
      renderCond643();
    }));
    
    var result__ = function(event, callback) {
                     if(event && event.stopPropagation) event.stopPropagation();
                     mobl.call('Yellowgrassmobile.showActiveProjects', [mobl.ref(false), mobl.ref("slide"), mobl.ref(null)], function(result__) {
                     var tmp3453 = result__;
                     if(callback && callback.apply) callback(); return;
                     });
                   };
    var tmp3403 = mobl.ref(result__);
    
    var nodes5453 = $("<span>");
    root6256.append(nodes5453);
    subs__.addSub((mobl.ui.generic.button)(mobl.ref("Active"), mobl.ref(mobl.ui.generic.buttonStyle), mobl.ref(mobl.ui.generic.buttonPushedStyle), tmp3403, function(_, callback) {
      var root6260 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root6260); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes5453;
      nodes5453 = node.contents();
      oldNodes.replaceWith(nodes5453);
    }));
    callback(root6256); return subs__;
    
    
    
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes5449;
    nodes5449 = node.contents();
    oldNodes.replaceWith(nodes5449);
  }));
  var nodes5454 = $("<span>");
  root6255.append(nodes5454);
  subs__.addSub((mobl.ui.generic.group)(function(_, callback) {
    var root6261 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    webservices.Service.getPopularProjects(10, function(result__) {
      var tmp3454 = result__;
      var projects = mobl.ref(result__);
      
      var node1040 = mobl.loadingSpan();
      root6261.append(node1040);
      var list272;
      var listSubs272 = new mobl.CompSubscription();
      subs__.addSub(listSubs272);
      var renderList272 = function() {
        var subs__ = listSubs272;
        list272 = projects.get();
        list272.list(function(results272) {
          node1040.empty();
          for(var i358 = 0; i358 < results272.length; i358++) {
            (function() {
              var iternode272 = $("<span>");
              node1040.append(iternode272);
              var project;
              project = mobl.ref(mobl.ref(results272), i358);
              var result__ = function(event, callback) {
                               if(event && event.stopPropagation) event.stopPropagation();
                               mobl.call('Yellowgrassmobile.ShowProject', [project, mobl.ref(false), mobl.ref("slide"), mobl.ref(null)], function(result__) {
                               var tmp3455 = result__;
                               if(callback && callback.apply) callback(); return;
                               });
                             };
              var tmp3404 = mobl.ref(result__);
              
              var nodes5455 = $("<span>");
              iternode272.append(nodes5455);
              subs__.addSub((mobl.ui.generic.item)(mobl.ref(mobl.ui.generic.itemStyle), mobl.ref(mobl.ui.generic.itemPushedStyle), tmp3404, mobl.ref(null), mobl.ref(false), function(_, callback) {
                var root6262 = $("<span>");
                var subs__ = new mobl.CompSubscription();
                var nodes5456 = $("<span>");
                root6262.append(nodes5456);
                subs__.addSub((mobl.label)(mobl.ref(project, 'name'), mobl.ref(null), mobl.ref(null), function(_, callback) {
                  var root6263 = $("<span>");
                  var subs__ = new mobl.CompSubscription();
                  callback(root6263); return subs__;
                  return subs__;
                }, function(node) {
                  var oldNodes = nodes5456;
                  nodes5456 = node.contents();
                  oldNodes.replaceWith(nodes5456);
                }));
                callback(root6262); return subs__;
                
                return subs__;
              }, function(node) {
                var oldNodes = nodes5455;
                nodes5455 = node.contents();
                oldNodes.replaceWith(nodes5455);
              }));
              
              var oldNodes = iternode272;
              iternode272 = iternode272.contents();
              oldNodes.replaceWith(iternode272);
              
              
            }());
          }
          mobl.delayedUpdateScrollers();
          subs__.addSub(list272.addEventListener('change', function() { listSubs272.unsubscribe(); renderList272(true); }));
          subs__.addSub(projects.addEventListener('change', function() { listSubs272.unsubscribe(); renderList272(true); }));
        });
      };
      renderList272();
      
      callback(root6261); return subs__;
      
    });
    return subs__;
  }, function(node) {
    var oldNodes = nodes5454;
    nodes5454 = node.contents();
    oldNodes.replaceWith(nodes5454);
  }));
  callback(root6255); return subs__;
  
  
  return subs__;
};
Yellowgrassmobile.setProject = function(project) {
   var __this = this;
  Yellowgrassmobile.currentProject.set(project);
  Yellowgrassmobile.allProjects.get().add(project);
};

Yellowgrassmobile.setAllProjects = function(projects) {
   var __this = this;
  var coll205 = projects;
  var length54 = coll205.length;
  for(var i359 = 0; i359 < length54; i359++) {
    var project;
    project = coll205.get(i359);
    Yellowgrassmobile.allProjects.get().add(project);
  }
};


Yellowgrassmobile.ShowProject = function(project, callback, screenCallback) {
  var root6264 = $("<div>");
  var subs__ = new mobl.CompSubscription();
  webservices.Service.getProject(project.get().name, function(result__) {
    var tmp3457 = result__;
    var result__ = Yellowgrassmobile.setProject(tmp3457);
    var tmp3456 = result__;
    var result__ = [new mobl.Tuple("Info", "", Yellowgrassmobile.ShowProjectInfo), new mobl.Tuple("Issues", "", Yellowgrassmobile.ShowIssues)];
    var tmp3405 = mobl.ref(result__);
    subs__.addSub(mobl.ref(Yellowgrassmobile.ShowProjectInfo).addEventListener('change', function() {
      tmp3405.set([new mobl.Tuple("Info", "", Yellowgrassmobile.ShowProjectInfo), new mobl.Tuple("Issues", "", Yellowgrassmobile.ShowIssues)]);
    }));
    subs__.addSub(mobl.ref(Yellowgrassmobile.ShowIssues).addEventListener('change', function() {
      tmp3405.set([new mobl.Tuple("Info", "", Yellowgrassmobile.ShowProjectInfo), new mobl.Tuple("Issues", "", Yellowgrassmobile.ShowIssues)]);
    }));
    
    var nodes5457 = $("<span>");
    root6264.append(nodes5457);
    subs__.addSub((mobl.ui.generic.tabSet)(tmp3405, mobl.ref(null), mobl.ref("tabSetContext"), function(_, callback) {
      var root6265 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root6265); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes5457;
      nodes5457 = node.contents();
      oldNodes.replaceWith(nodes5457);
    }));
    callback(root6264); return subs__;
    
  });
  return subs__;
};

Yellowgrassmobile.ShowProjectInfo = function(elements, callback) {
  var root6266 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  var nodes5458 = $("<span>");
  root6266.append(nodes5458);
  subs__.addSub((mobl.ui.generic.header)(mobl.ref(Yellowgrassmobile.currentProject, 'name'), mobl.ref(false), mobl.ref(null), function(_, callback) {
    var root6267 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    var nodes5459 = $("<span>");
    root6267.append(nodes5459);
    subs__.addSub((lib.getHeaderImage)(mobl.ref(true), function(_, callback) {
      var root6268 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root6268); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes5459;
      nodes5459 = node.contents();
      oldNodes.replaceWith(nodes5459);
    }));
    var result__ = function(event, callback) {
                     if(event && event.stopPropagation) event.stopPropagation();
                     mobl.call('Yellowgrassmobile.showProjects', [mobl.ref(false), mobl.ref("slide"), mobl.ref("_top")], function(result__) {
                     var tmp3458 = result__;
                     var result__ = tmp3458;
                     if(callback && callback.apply) callback(result__);
                     return;
                     if(callback && callback.apply) callback(); return;
                     });
                   };
    var tmp3406 = mobl.ref(result__);
    
    var nodes5460 = $("<span>");
    root6267.append(nodes5460);
    subs__.addSub((mobl.ui.generic.button)(mobl.ref("back"), mobl.ref(mobl.ui.generic.buttonStyle), mobl.ref(mobl.ui.generic.buttonPushedStyle), tmp3406, function(_, callback) {
      var root6269 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root6269); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes5460;
      nodes5460 = node.contents();
      oldNodes.replaceWith(nodes5460);
    }));
    callback(root6267); return subs__;
    
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes5458;
    nodes5458 = node.contents();
    oldNodes.replaceWith(nodes5458);
  }));
  
  var List = mobl.ref(new persistence.LocalQueryCollection([new mobl.Tuple("Members", Yellowgrassmobile.currentProject.get().members), new mobl.Tuple("Followers", Yellowgrassmobile.currentProject.get().followers)]));
  var result__ = Yellowgrassmobile.currentProject.get().url != null;
  var tmp3408 = mobl.ref(result__);
  subs__.addSub(mobl.ref(Yellowgrassmobile.currentProject, 'url').addEventListener('change', function() {
    tmp3408.set(Yellowgrassmobile.currentProject.get().url != null);
  }));
  
  
  var node1041 = $("<span>");
  root6266.append(node1041);
  var condSubs644 = new mobl.CompSubscription();
  subs__.addSub(condSubs644);
  var oldValue644;
  var renderCond644 = function() {
    var value708 = tmp3408.get();
    if(oldValue644 === value708) return;
    oldValue644 = value708;
    var subs__ = condSubs644;
    subs__.unsubscribe();
    node1041.empty();
    if(value708) {
      var result__ = function(event, callback) {
                       if(event && event.stopPropagation) event.stopPropagation();
                       var result__ = mobl.openUrl(Yellowgrassmobile.currentProject.get().url);
                       if(callback && callback.apply) callback(); return;
                     };
      var tmp3407 = mobl.ref(result__);
      
      var nodes5461 = $("<span>");
      node1041.append(nodes5461);
      subs__.addSub((mobl.ui.generic.item)(mobl.ref(mobl.ui.generic.itemStyle), mobl.ref(mobl.ui.generic.itemPushedStyle), tmp3407, mobl.ref(null), mobl.ref(false), function(_, callback) {
        var root6270 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        var nodes5462 = $("<span>");
        root6270.append(nodes5462);
        subs__.addSub((mobl.label)(mobl.ref("Website"), mobl.ref(null), mobl.ref(null), function(_, callback) {
          var root6271 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root6271); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes5462;
          nodes5462 = node.contents();
          oldNodes.replaceWith(nodes5462);
        }));
        callback(root6270); return subs__;
        
        return subs__;
      }, function(node) {
        var oldNodes = nodes5461;
        nodes5461 = node.contents();
        oldNodes.replaceWith(nodes5461);
      }));
      
      
    } else {
      
    }
  };
  renderCond644();
  subs__.addSub(tmp3408.addEventListener('change', function() {
    renderCond644();
  }));
  
  var nodes5463 = $("<span>");
  root6266.append(nodes5463);
  subs__.addSub((mobl.ui.generic.group)(function(_, callback) {
    var root6272 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    var result__ = Yellowgrassmobile.currentProject.get().description != null;
    var tmp3410 = mobl.ref(result__);
    subs__.addSub(mobl.ref(Yellowgrassmobile.currentProject, 'description').addEventListener('change', function() {
      tmp3410.set(Yellowgrassmobile.currentProject.get().description != null);
    }));
    
    
    var node1042 = $("<span>");
    root6272.append(node1042);
    var condSubs645 = new mobl.CompSubscription();
    subs__.addSub(condSubs645);
    var oldValue645;
    var renderCond645 = function() {
      var value709 = tmp3410.get();
      if(oldValue645 === value709) return;
      oldValue645 = value709;
      var subs__ = condSubs645;
      subs__.unsubscribe();
      node1042.empty();
      if(value709) {
        var result__ = "<h4><font color=#334E33>Description</font></h4>" + Yellowgrassmobile.currentProject.get().description;
        var tmp3409 = mobl.ref(result__);
        subs__.addSub(mobl.ref(Yellowgrassmobile.currentProject, 'description').addEventListener('change', function() {
          tmp3409.set("<h4><font color=#334E33>Description</font></h4>" + Yellowgrassmobile.currentProject.get().description);
        }));
        
        var nodes5464 = $("<span>");
        node1042.append(nodes5464);
        subs__.addSub((mobl.html)(tmp3409, function(_, callback) {
          var root6273 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root6273); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes5464;
          nodes5464 = node.contents();
          oldNodes.replaceWith(nodes5464);
        }));
        
        
      } else {
        
      }
    };
    renderCond645();
    subs__.addSub(tmp3410.addEventListener('change', function() {
      renderCond645();
    }));
    
    callback(root6272); return subs__;
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes5463;
    nodes5463 = node.contents();
    oldNodes.replaceWith(nodes5463);
  }));
  var nodes5465 = $("<span>");
  root6266.append(nodes5465);
  subs__.addSub((mobl.ui.generic.group)(function(_, callback) {
    var root6274 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    var result__ = Yellowgrassmobile.currentProject.get().weeklyStatsGraph != null;
    var tmp3411 = mobl.ref(result__);
    subs__.addSub(mobl.ref(Yellowgrassmobile.currentProject, 'weeklyStatsGraph').addEventListener('change', function() {
      tmp3411.set(Yellowgrassmobile.currentProject.get().weeklyStatsGraph != null);
    }));
    
    
    var node1043 = $("<span>");
    root6274.append(node1043);
    var condSubs646 = new mobl.CompSubscription();
    subs__.addSub(condSubs646);
    var oldValue646;
    var renderCond646 = function() {
      var value710 = tmp3411.get();
      if(oldValue646 === value710) return;
      oldValue646 = value710;
      var subs__ = condSubs646;
      subs__.unsubscribe();
      node1043.empty();
      if(value710) {
        var nodes5466 = $("<span>");
        node1043.append(nodes5466);
        subs__.addSub((mobl.html)(mobl.ref("<h4><font color=#334E33>Weekly Issue Count</font></h4>"), function(_, callback) {
          var root6275 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root6275); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes5466;
          nodes5466 = node.contents();
          oldNodes.replaceWith(nodes5466);
        }));
        var nodes5467 = $("<span>");
        node1043.append(nodes5467);
        subs__.addSub((mobl.ui.generic.image)(mobl.ref(Yellowgrassmobile.currentProject, 'weeklyStatsGraph'), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref("center"), function(_, callback) {
          var root6276 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root6276); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes5467;
          nodes5467 = node.contents();
          oldNodes.replaceWith(nodes5467);
        }));
        
        
        
      } else {
        
      }
    };
    renderCond646();
    subs__.addSub(tmp3411.addEventListener('change', function() {
      renderCond646();
    }));
    
    callback(root6274); return subs__;
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes5465;
    nodes5465 = node.contents();
    oldNodes.replaceWith(nodes5465);
  }));
  var nodes5468 = $("<span>");
  root6266.append(nodes5468);
  subs__.addSub((mobl.ui.generic.zoomList)(List, mobl.ref(Yellowgrassmobile.ShowLabel), mobl.ref(Yellowgrassmobile.ShowUsers), function(_, callback) {
    var root6277 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    callback(root6277); return subs__;
    return subs__;
  }, function(node) {
    var oldNodes = nodes5468;
    nodes5468 = node.contents();
    oldNodes.replaceWith(nodes5468);
  }));
  callback(root6266); return subs__;
  
  
  
  
  
  return subs__;
};

Yellowgrassmobile.showPopulairIssues = function(callback, screenCallback) {
  var root6278 = $("<div>");
  var subs__ = new mobl.CompSubscription();
  var nodes5469 = $("<span>");
  root6278.append(nodes5469);
  subs__.addSub((mobl.ui.generic.header)(mobl.ref("Populair Issues"), mobl.ref(false), mobl.ref(null), function(_, callback) {
    var root6279 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    var nodes5470 = $("<span>");
    root6279.append(nodes5470);
    subs__.addSub((lib.getHeaderImage)(mobl.ref(true), function(_, callback) {
      var root6280 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root6280); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes5470;
      nodes5470 = node.contents();
      oldNodes.replaceWith(nodes5470);
    }));
    var result__ = function(event, callback) {
                     if(event && event.stopPropagation) event.stopPropagation();
                     mobl.call('Yellowgrassmobile.showProjects', [mobl.ref(false), mobl.ref("slide"), mobl.ref("_top")], function(result__) {
                     var tmp3459 = result__;
                     var result__ = tmp3459;
                     if(callback && callback.apply) callback(result__);
                     return;
                     if(callback && callback.apply) callback(); return;
                     });
                   };
    var tmp3412 = mobl.ref(result__);
    
    var nodes5471 = $("<span>");
    root6279.append(nodes5471);
    subs__.addSub((mobl.ui.generic.button)(mobl.ref("back"), mobl.ref(mobl.ui.generic.buttonStyle), mobl.ref(mobl.ui.generic.buttonPushedStyle), tmp3412, function(_, callback) {
      var root6281 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root6281); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes5471;
      nodes5471 = node.contents();
      oldNodes.replaceWith(nodes5471);
    }));
    callback(root6279); return subs__;
    
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes5469;
    nodes5469 = node.contents();
    oldNodes.replaceWith(nodes5469);
  }));
  
  var issues = mobl.ref(new persistence.LocalQueryCollection([]));
  var result__ = issues.get().addAll(Yellowgrassmobile.currentProject.get().issues);
  var nodes5472 = $("<span>");
  root6278.append(nodes5472);
  subs__.addSub((mobl.ui.generic.group)(function(_, callback) {
    var root6282 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    var nodes5473 = $("<span>");
    root6282.append(nodes5473);
    subs__.addSub((mobl.ui.generic.table)(mobl.ref(mobl.ui.generic.tableStyle), function(_, callback) {
      var root6283 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      var nodes5474 = $("<span>");
      root6283.append(nodes5474);
      subs__.addSub((mobl.ui.generic.row)(mobl.ref(mobl.ui.generic.trStyle), function(_, callback) {
        var root6284 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        var nodes5475 = $("<span>");
        root6284.append(nodes5475);
        subs__.addSub((mobl.ui.generic.headerCol)(mobl.ref(null), mobl.ref(mobl.ui.generic.tdStyle), function(_, callback) {
          var root6285 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          var nodes5476 = $("<span>");
          root6285.append(nodes5476);
          subs__.addSub((mobl.label)(mobl.ref("Number"), mobl.ref(null), mobl.ref(null), function(_, callback) {
            var root6286 = $("<span>");
            var subs__ = new mobl.CompSubscription();
            callback(root6286); return subs__;
            return subs__;
          }, function(node) {
            var oldNodes = nodes5476;
            nodes5476 = node.contents();
            oldNodes.replaceWith(nodes5476);
          }));
          callback(root6285); return subs__;
          
          return subs__;
        }, function(node) {
          var oldNodes = nodes5475;
          nodes5475 = node.contents();
          oldNodes.replaceWith(nodes5475);
        }));
        var nodes5477 = $("<span>");
        root6284.append(nodes5477);
        subs__.addSub((mobl.ui.generic.headerCol)(mobl.ref(null), mobl.ref(mobl.ui.generic.tdStyle), function(_, callback) {
          var root6287 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          var nodes5478 = $("<span>");
          root6287.append(nodes5478);
          subs__.addSub((mobl.label)(mobl.ref("Status"), mobl.ref(null), mobl.ref(null), function(_, callback) {
            var root6288 = $("<span>");
            var subs__ = new mobl.CompSubscription();
            callback(root6288); return subs__;
            return subs__;
          }, function(node) {
            var oldNodes = nodes5478;
            nodes5478 = node.contents();
            oldNodes.replaceWith(nodes5478);
          }));
          callback(root6287); return subs__;
          
          return subs__;
        }, function(node) {
          var oldNodes = nodes5477;
          nodes5477 = node.contents();
          oldNodes.replaceWith(nodes5477);
        }));
        var nodes5479 = $("<span>");
        root6284.append(nodes5479);
        subs__.addSub((mobl.ui.generic.headerCol)(mobl.ref(null), mobl.ref(mobl.ui.generic.tdStyle), function(_, callback) {
          var root6289 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          var nodes5480 = $("<span>");
          root6289.append(nodes5480);
          subs__.addSub((mobl.label)(mobl.ref("Date"), mobl.ref(null), mobl.ref(null), function(_, callback) {
            var root6290 = $("<span>");
            var subs__ = new mobl.CompSubscription();
            callback(root6290); return subs__;
            return subs__;
          }, function(node) {
            var oldNodes = nodes5480;
            nodes5480 = node.contents();
            oldNodes.replaceWith(nodes5480);
          }));
          callback(root6289); return subs__;
          
          return subs__;
        }, function(node) {
          var oldNodes = nodes5479;
          nodes5479 = node.contents();
          oldNodes.replaceWith(nodes5479);
        }));
        var nodes5481 = $("<span>");
        root6284.append(nodes5481);
        subs__.addSub((mobl.ui.generic.headerCol)(mobl.ref(null), mobl.ref(mobl.ui.generic.tdStyle), function(_, callback) {
          var root6291 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          var nodes5482 = $("<span>");
          root6291.append(nodes5482);
          subs__.addSub((mobl.label)(mobl.ref("Title"), mobl.ref(null), mobl.ref(null), function(_, callback) {
            var root6292 = $("<span>");
            var subs__ = new mobl.CompSubscription();
            callback(root6292); return subs__;
            return subs__;
          }, function(node) {
            var oldNodes = nodes5482;
            nodes5482 = node.contents();
            oldNodes.replaceWith(nodes5482);
          }));
          callback(root6291); return subs__;
          
          return subs__;
        }, function(node) {
          var oldNodes = nodes5481;
          nodes5481 = node.contents();
          oldNodes.replaceWith(nodes5481);
        }));
        callback(root6284); return subs__;
        
        
        
        
        return subs__;
      }, function(node) {
        var oldNodes = nodes5474;
        nodes5474 = node.contents();
        oldNodes.replaceWith(nodes5474);
      }));
      var result__ = issues.get().filter("open", "=", true).order("nrVotes", false).limit(10);
      var tmp3417 = mobl.ref(result__);
      subs__.addSub(mobl.ref(issues.get().filter("open", "=", true).order("nrVotes", false).limit(10)).addEventListener('change', function() {
        tmp3417.set(issues.get().filter("open", "=", true).order("nrVotes", false).limit(10));
      }));
      subs__.addSub(mobl.ref(issues.get().filter("open", "=", true).order("nrVotes", false)).addEventListener('change', function() {
        tmp3417.set(issues.get().filter("open", "=", true).order("nrVotes", false).limit(10));
      }));
      subs__.addSub(mobl.ref(issues.get().filter("open", "=", true)).addEventListener('change', function() {
        tmp3417.set(issues.get().filter("open", "=", true).order("nrVotes", false).limit(10));
      }));
      subs__.addSub(issues.addEventListener('change', function() {
        tmp3417.set(issues.get().filter("open", "=", true).order("nrVotes", false).limit(10));
      }));
      
      
      var node1044 = mobl.loadingSpan();
      root6283.append(node1044);
      var list273;
      var listSubs273 = new mobl.CompSubscription();
      subs__.addSub(listSubs273);
      var renderList273 = function() {
        var subs__ = listSubs273;
        list273 = tmp3417.get();
        list273.list(function(results273) {
          node1044.empty();
          for(var i360 = 0; i360 < results273.length; i360++) {
            (function() {
              var iternode273 = $("<span>");
              node1044.append(iternode273);
              var issue;
              issue = mobl.ref(mobl.ref(results273), i360);
              var nodes5483 = $("<span>");
              iternode273.append(nodes5483);
              subs__.addSub((mobl.ui.generic.row)(mobl.ref(mobl.ui.generic.trStyle), function(_, callback) {
                var root6293 = $("<span>");
                var subs__ = new mobl.CompSubscription();
                var nodes5484 = $("<span>");
                root6293.append(nodes5484);
                subs__.addSub((mobl.ui.generic.cell)(mobl.ref(null), mobl.ref(mobl.ui.generic.tdStyle), function(_, callback) {
                  var root6294 = $("<span>");
                  var subs__ = new mobl.CompSubscription();
                  var result__ = function(event, callback) {
                                   if(event && event.stopPropagation) event.stopPropagation();
                                   mobl.call('Yellowgrassmobile.ShowIssue', [issue, mobl.ref(false), mobl.ref("slide"), mobl.ref(null)], function(result__) {
                                   var tmp3460 = result__;
                                   if(callback && callback.apply) callback(); return;
                                   });
                                 };
                  var tmp3413 = mobl.ref(result__);
                  
                  var nodes5485 = $("<span>");
                  root6294.append(nodes5485);
                  subs__.addSub((mobl.label)(mobl.ref(issue, 'number'), mobl.ref(null), tmp3413, function(_, callback) {
                    var root6295 = $("<span>");
                    var subs__ = new mobl.CompSubscription();
                    callback(root6295); return subs__;
                    return subs__;
                  }, function(node) {
                    var oldNodes = nodes5485;
                    nodes5485 = node.contents();
                    oldNodes.replaceWith(nodes5485);
                  }));
                  callback(root6294); return subs__;
                  
                  return subs__;
                }, function(node) {
                  var oldNodes = nodes5484;
                  nodes5484 = node.contents();
                  oldNodes.replaceWith(nodes5484);
                }));
                var nodes5486 = $("<span>");
                root6293.append(nodes5486);
                subs__.addSub((mobl.ui.generic.cell)(mobl.ref(null), mobl.ref(mobl.ui.generic.tdStyle), function(_, callback) {
                  var root6296 = $("<span>");
                  var subs__ = new mobl.CompSubscription();
                  var result__ = !issue.get().open;
                  var tmp3414 = mobl.ref(result__);
                  subs__.addSub(mobl.ref(issue, 'open').addEventListener('change', function() {
                    tmp3414.set(!issue.get().open);
                  }));
                  
                  
                  var node1045 = $("<span>");
                  root6296.append(node1045);
                  var condSubs647 = new mobl.CompSubscription();
                  subs__.addSub(condSubs647);
                  var oldValue647;
                  var renderCond647 = function() {
                    var value711 = tmp3414.get();
                    if(oldValue647 === value711) return;
                    oldValue647 = value711;
                    var subs__ = condSubs647;
                    subs__.unsubscribe();
                    node1045.empty();
                    if(value711) {
                      var nodes5487 = $("<span>");
                      node1045.append(nodes5487);
                      subs__.addSub((mobl.ui.generic.image)(mobl.ref("./images/tick.png"), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref(null), function(_, callback) {
                        var root6297 = $("<span>");
                        var subs__ = new mobl.CompSubscription();
                        callback(root6297); return subs__;
                        return subs__;
                      }, function(node) {
                        var oldNodes = nodes5487;
                        nodes5487 = node.contents();
                        oldNodes.replaceWith(nodes5487);
                      }));
                      
                      
                    } else {
                      var nodes5488 = $("<span>");
                      node1045.append(nodes5488);
                      subs__.addSub((mobl.ui.generic.image)(mobl.ref("./images/question.gif"), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref(null), function(_, callback) {
                        var root6298 = $("<span>");
                        var subs__ = new mobl.CompSubscription();
                        callback(root6298); return subs__;
                        return subs__;
                      }, function(node) {
                        var oldNodes = nodes5488;
                        nodes5488 = node.contents();
                        oldNodes.replaceWith(nodes5488);
                      }));
                      
                      
                    }
                  };
                  renderCond647();
                  subs__.addSub(tmp3414.addEventListener('change', function() {
                    renderCond647();
                  }));
                  
                  callback(root6296); return subs__;
                  
                  return subs__;
                }, function(node) {
                  var oldNodes = nodes5486;
                  nodes5486 = node.contents();
                  oldNodes.replaceWith(nodes5486);
                }));
                var nodes5489 = $("<span>");
                root6293.append(nodes5489);
                subs__.addSub((mobl.ui.generic.cell)(mobl.ref(null), mobl.ref(mobl.ui.generic.tdStyle), function(_, callback) {
                  var root6299 = $("<span>");
                  var subs__ = new mobl.CompSubscription();
                  var result__ = mobl.DateTime.parse(issue.get().submitted.toString()).toString();
                  var tmp3415 = mobl.ref(result__);
                  subs__.addSub(mobl.ref(mobl.DateTime).addEventListener('change', function() {
                    tmp3415.set(mobl.DateTime.parse(issue.get().submitted.toString()).toString());
                  }));
                  subs__.addSub(mobl.ref(issue, 'submitted').addEventListener('change', function() {
                    tmp3415.set(mobl.DateTime.parse(issue.get().submitted.toString()).toString());
                  }));
                  
                  var nodes5490 = $("<span>");
                  root6299.append(nodes5490);
                  subs__.addSub((mobl.label)(tmp3415, mobl.ref(null), mobl.ref(null), function(_, callback) {
                    var root6300 = $("<span>");
                    var subs__ = new mobl.CompSubscription();
                    callback(root6300); return subs__;
                    return subs__;
                  }, function(node) {
                    var oldNodes = nodes5490;
                    nodes5490 = node.contents();
                    oldNodes.replaceWith(nodes5490);
                  }));
                  callback(root6299); return subs__;
                  
                  return subs__;
                }, function(node) {
                  var oldNodes = nodes5489;
                  nodes5489 = node.contents();
                  oldNodes.replaceWith(nodes5489);
                }));
                var nodes5491 = $("<span>");
                root6293.append(nodes5491);
                subs__.addSub((mobl.ui.generic.cell)(mobl.ref(null), mobl.ref(mobl.ui.generic.tdStyle), function(_, callback) {
                  var root6301 = $("<span>");
                  var subs__ = new mobl.CompSubscription();
                  var result__ = function(event, callback) {
                                   if(event && event.stopPropagation) event.stopPropagation();
                                   mobl.call('Yellowgrassmobile.ShowIssue', [issue, mobl.ref(false), mobl.ref("slide"), mobl.ref(null)], function(result__) {
                                   var tmp3461 = result__;
                                   if(callback && callback.apply) callback(); return;
                                   });
                                 };
                  var tmp3416 = mobl.ref(result__);
                  
                  var nodes5492 = $("<span>");
                  root6301.append(nodes5492);
                  subs__.addSub((mobl.label)(mobl.ref(issue, 'title'), mobl.ref(null), tmp3416, function(_, callback) {
                    var root6302 = $("<span>");
                    var subs__ = new mobl.CompSubscription();
                    callback(root6302); return subs__;
                    return subs__;
                  }, function(node) {
                    var oldNodes = nodes5492;
                    nodes5492 = node.contents();
                    oldNodes.replaceWith(nodes5492);
                  }));
                  callback(root6301); return subs__;
                  
                  return subs__;
                }, function(node) {
                  var oldNodes = nodes5491;
                  nodes5491 = node.contents();
                  oldNodes.replaceWith(nodes5491);
                }));
                var nodes5493 = $("<span>");
                root6293.append(nodes5493);
                subs__.addSub((mobl.ui.generic.cell)(mobl.ref(null), mobl.ref(mobl.ui.generic.tdStyle), function(_, callback) {
                  var root6303 = $("<span>");
                  var subs__ = new mobl.CompSubscription();
                  var nodes5494 = $("<span>");
                  root6303.append(nodes5494);
                  subs__.addSub((mobl.label)(mobl.ref(issue, 'nrVotes'), mobl.ref(null), mobl.ref(null), function(_, callback) {
                    var root6304 = $("<span>");
                    var subs__ = new mobl.CompSubscription();
                    callback(root6304); return subs__;
                    return subs__;
                  }, function(node) {
                    var oldNodes = nodes5494;
                    nodes5494 = node.contents();
                    oldNodes.replaceWith(nodes5494);
                  }));
                  callback(root6303); return subs__;
                  
                  return subs__;
                }, function(node) {
                  var oldNodes = nodes5493;
                  nodes5493 = node.contents();
                  oldNodes.replaceWith(nodes5493);
                }));
                callback(root6293); return subs__;
                
                
                
                
                
                return subs__;
              }, function(node) {
                var oldNodes = nodes5483;
                nodes5483 = node.contents();
                oldNodes.replaceWith(nodes5483);
              }));
              
              var oldNodes = iternode273;
              iternode273 = iternode273.contents();
              oldNodes.replaceWith(iternode273);
              
              
            }());
          }
          mobl.delayedUpdateScrollers();
          subs__.addSub(list273.addEventListener('change', function() { listSubs273.unsubscribe(); renderList273(true); }));
          subs__.addSub(tmp3417.addEventListener('change', function() { listSubs273.unsubscribe(); renderList273(true); }));
        });
      };
      renderList273();
      
      callback(root6283); return subs__;
      
      
      return subs__;
    }, function(node) {
      var oldNodes = nodes5473;
      nodes5473 = node.contents();
      oldNodes.replaceWith(nodes5473);
    }));
    callback(root6282); return subs__;
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes5472;
    nodes5472 = node.contents();
    oldNodes.replaceWith(nodes5472);
  }));
  callback(root6278); return subs__;
  
  
  return subs__;
};

Yellowgrassmobile.ShowIssues = function(elements, callback) {
  var root6305 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  var nodes5495 = $("<span>");
  root6305.append(nodes5495);
  subs__.addSub((mobl.ui.generic.header)(mobl.ref(Yellowgrassmobile.currentProject, 'name'), mobl.ref(false), mobl.ref(null), function(_, callback) {
    var root6306 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    var nodes5496 = $("<span>");
    root6306.append(nodes5496);
    subs__.addSub((lib.getHeaderImage)(mobl.ref(true), function(_, callback) {
      var root6307 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root6307); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes5496;
      nodes5496 = node.contents();
      oldNodes.replaceWith(nodes5496);
    }));
    var result__ = function(event, callback) {
                     if(event && event.stopPropagation) event.stopPropagation();
                     mobl.call('Yellowgrassmobile.showPopulairIssues', [mobl.ref(false), mobl.ref("slide"), mobl.ref(null)], function(result__) {
                     var tmp3463 = result__;
                     if(callback && callback.apply) callback(); return;
                     });
                   };
    var tmp3418 = mobl.ref(result__);
    
    var nodes5497 = $("<span>");
    root6306.append(nodes5497);
    subs__.addSub((mobl.ui.generic.button)(mobl.ref("Populair"), mobl.ref(mobl.ui.generic.buttonStyle), mobl.ref(mobl.ui.generic.buttonPushedStyle), tmp3418, function(_, callback) {
      var root6308 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root6308); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes5497;
      nodes5497 = node.contents();
      oldNodes.replaceWith(nodes5497);
    }));
    var result__ = function(event, callback) {
                     if(event && event.stopPropagation) event.stopPropagation();
                     mobl.call('Yellowgrassmobile.showProjects', [mobl.ref(false), mobl.ref("slide"), mobl.ref("_top")], function(result__) {
                     var tmp3462 = result__;
                     var result__ = tmp3462;
                     if(callback && callback.apply) callback(result__);
                     return;
                     if(callback && callback.apply) callback(); return;
                     });
                   };
    var tmp3419 = mobl.ref(result__);
    
    var nodes5498 = $("<span>");
    root6306.append(nodes5498);
    subs__.addSub((mobl.ui.generic.button)(mobl.ref("back"), mobl.ref(mobl.ui.generic.buttonStyle), mobl.ref(mobl.ui.generic.buttonPushedStyle), tmp3419, function(_, callback) {
      var root6309 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root6309); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes5498;
      nodes5498 = node.contents();
      oldNodes.replaceWith(nodes5498);
    }));
    callback(root6306); return subs__;
    
    
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes5495;
    nodes5495 = node.contents();
    oldNodes.replaceWith(nodes5495);
  }));
  
  var issues = mobl.ref(new persistence.LocalQueryCollection([]));
  var result__ = issues.get().addAll(Yellowgrassmobile.currentProject.get().issues);
  var nodes5499 = $("<span>");
  root6305.append(nodes5499);
  subs__.addSub((mobl.ui.generic.table)(mobl.ref(mobl.ui.generic.tableStyle), function(_, callback) {
    var root6310 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    var nodes5500 = $("<span>");
    root6310.append(nodes5500);
    subs__.addSub((mobl.ui.generic.row)(mobl.ref(mobl.ui.generic.trStyle), function(_, callback) {
      var root6311 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      var nodes5501 = $("<span>");
      root6311.append(nodes5501);
      subs__.addSub((mobl.ui.generic.headerCol)(mobl.ref(null), mobl.ref(mobl.ui.generic.tdStyle), function(_, callback) {
        var root6312 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        var nodes5502 = $("<span>");
        root6312.append(nodes5502);
        subs__.addSub((mobl.label)(mobl.ref("Number"), mobl.ref(null), mobl.ref(null), function(_, callback) {
          var root6313 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root6313); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes5502;
          nodes5502 = node.contents();
          oldNodes.replaceWith(nodes5502);
        }));
        callback(root6312); return subs__;
        
        return subs__;
      }, function(node) {
        var oldNodes = nodes5501;
        nodes5501 = node.contents();
        oldNodes.replaceWith(nodes5501);
      }));
      var nodes5503 = $("<span>");
      root6311.append(nodes5503);
      subs__.addSub((mobl.ui.generic.headerCol)(mobl.ref(null), mobl.ref(mobl.ui.generic.tdStyle), function(_, callback) {
        var root6314 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        var nodes5504 = $("<span>");
        root6314.append(nodes5504);
        subs__.addSub((mobl.label)(mobl.ref("Status"), mobl.ref(null), mobl.ref(null), function(_, callback) {
          var root6315 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root6315); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes5504;
          nodes5504 = node.contents();
          oldNodes.replaceWith(nodes5504);
        }));
        callback(root6314); return subs__;
        
        return subs__;
      }, function(node) {
        var oldNodes = nodes5503;
        nodes5503 = node.contents();
        oldNodes.replaceWith(nodes5503);
      }));
      var nodes5505 = $("<span>");
      root6311.append(nodes5505);
      subs__.addSub((mobl.ui.generic.headerCol)(mobl.ref(null), mobl.ref(mobl.ui.generic.tdStyle), function(_, callback) {
        var root6316 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        var nodes5506 = $("<span>");
        root6316.append(nodes5506);
        subs__.addSub((mobl.label)(mobl.ref("Date"), mobl.ref(null), mobl.ref(null), function(_, callback) {
          var root6317 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root6317); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes5506;
          nodes5506 = node.contents();
          oldNodes.replaceWith(nodes5506);
        }));
        callback(root6316); return subs__;
        
        return subs__;
      }, function(node) {
        var oldNodes = nodes5505;
        nodes5505 = node.contents();
        oldNodes.replaceWith(nodes5505);
      }));
      var nodes5507 = $("<span>");
      root6311.append(nodes5507);
      subs__.addSub((mobl.ui.generic.headerCol)(mobl.ref(null), mobl.ref(mobl.ui.generic.tdStyle), function(_, callback) {
        var root6318 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        var nodes5508 = $("<span>");
        root6318.append(nodes5508);
        subs__.addSub((mobl.label)(mobl.ref("Title"), mobl.ref(null), mobl.ref(null), function(_, callback) {
          var root6319 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root6319); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes5508;
          nodes5508 = node.contents();
          oldNodes.replaceWith(nodes5508);
        }));
        callback(root6318); return subs__;
        
        return subs__;
      }, function(node) {
        var oldNodes = nodes5507;
        nodes5507 = node.contents();
        oldNodes.replaceWith(nodes5507);
      }));
      callback(root6311); return subs__;
      
      
      
      
      return subs__;
    }, function(node) {
      var oldNodes = nodes5500;
      nodes5500 = node.contents();
      oldNodes.replaceWith(nodes5500);
    }));
    var result__ = issues.get().order("number", false);
    var tmp3420 = mobl.ref(result__);
    subs__.addSub(mobl.ref(issues.get().order("number", false)).addEventListener('change', function() {
      tmp3420.set(issues.get().order("number", false));
    }));
    subs__.addSub(issues.addEventListener('change', function() {
      tmp3420.set(issues.get().order("number", false));
    }));
    
    var result__ = mobl._("More", []);
    var tmp3421 = mobl.ref(result__);
    
    var nodes5509 = $("<span>");
    root6310.append(nodes5509);
    subs__.addSub((mobl.ui.generic.stagedList)(tmp3420, mobl.ref(Yellowgrassmobile.ShowIssueRow), mobl.ref(10), mobl.ref(10), tmp3421, mobl.ref(mobl.ui.generic.loadMoreStyle), function(_, callback) {
      var root6320 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root6320); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes5509;
      nodes5509 = node.contents();
      oldNodes.replaceWith(nodes5509);
    }));
    callback(root6310); return subs__;
    
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes5499;
    nodes5499 = node.contents();
    oldNodes.replaceWith(nodes5499);
  }));
  callback(root6305); return subs__;
  
  
  return subs__;
};

Yellowgrassmobile.ShowIssueRow = function(issue, elements, callback) {
  var root6321 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  var nodes5510 = $("<span>");
  root6321.append(nodes5510);
  subs__.addSub((mobl.ui.generic.row)(mobl.ref(mobl.ui.generic.trStyle), function(_, callback) {
    var root6322 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    var nodes5511 = $("<span>");
    root6322.append(nodes5511);
    subs__.addSub((mobl.ui.generic.cell)(mobl.ref(null), mobl.ref(mobl.ui.generic.tdStyle), function(_, callback) {
      var root6323 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      var result__ = function(event, callback) {
                       if(event && event.stopPropagation) event.stopPropagation();
                       mobl.call('Yellowgrassmobile.ShowIssue', [issue, mobl.ref(false), mobl.ref("slide"), mobl.ref(null)], function(result__) {
                       var tmp3464 = result__;
                       if(callback && callback.apply) callback(); return;
                       });
                     };
      var tmp3422 = mobl.ref(result__);
      
      var nodes5512 = $("<span>");
      root6323.append(nodes5512);
      subs__.addSub((mobl.label)(mobl.ref(issue, 'number'), mobl.ref(null), tmp3422, function(_, callback) {
        var root6324 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        callback(root6324); return subs__;
        return subs__;
      }, function(node) {
        var oldNodes = nodes5512;
        nodes5512 = node.contents();
        oldNodes.replaceWith(nodes5512);
      }));
      callback(root6323); return subs__;
      
      return subs__;
    }, function(node) {
      var oldNodes = nodes5511;
      nodes5511 = node.contents();
      oldNodes.replaceWith(nodes5511);
    }));
    var nodes5513 = $("<span>");
    root6322.append(nodes5513);
    subs__.addSub((mobl.ui.generic.cell)(mobl.ref(null), mobl.ref(mobl.ui.generic.tdStyle), function(_, callback) {
      var root6325 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      var result__ = !issue.get().open;
      var tmp3423 = mobl.ref(result__);
      subs__.addSub(mobl.ref(issue, 'open').addEventListener('change', function() {
        tmp3423.set(!issue.get().open);
      }));
      
      
      var node1046 = $("<span>");
      root6325.append(node1046);
      var condSubs648 = new mobl.CompSubscription();
      subs__.addSub(condSubs648);
      var oldValue648;
      var renderCond648 = function() {
        var value712 = tmp3423.get();
        if(oldValue648 === value712) return;
        oldValue648 = value712;
        var subs__ = condSubs648;
        subs__.unsubscribe();
        node1046.empty();
        if(value712) {
          var nodes5514 = $("<span>");
          node1046.append(nodes5514);
          subs__.addSub((mobl.ui.generic.image)(mobl.ref("./images/tick.png"), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref(null), function(_, callback) {
            var root6326 = $("<span>");
            var subs__ = new mobl.CompSubscription();
            callback(root6326); return subs__;
            return subs__;
          }, function(node) {
            var oldNodes = nodes5514;
            nodes5514 = node.contents();
            oldNodes.replaceWith(nodes5514);
          }));
          
          
        } else {
          var nodes5515 = $("<span>");
          node1046.append(nodes5515);
          subs__.addSub((mobl.ui.generic.image)(mobl.ref("./images/question.gif"), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref(null), function(_, callback) {
            var root6327 = $("<span>");
            var subs__ = new mobl.CompSubscription();
            callback(root6327); return subs__;
            return subs__;
          }, function(node) {
            var oldNodes = nodes5515;
            nodes5515 = node.contents();
            oldNodes.replaceWith(nodes5515);
          }));
          
          
        }
      };
      renderCond648();
      subs__.addSub(tmp3423.addEventListener('change', function() {
        renderCond648();
      }));
      
      callback(root6325); return subs__;
      
      return subs__;
    }, function(node) {
      var oldNodes = nodes5513;
      nodes5513 = node.contents();
      oldNodes.replaceWith(nodes5513);
    }));
    var nodes5516 = $("<span>");
    root6322.append(nodes5516);
    subs__.addSub((mobl.ui.generic.cell)(mobl.ref(null), mobl.ref(mobl.ui.generic.tdStyle), function(_, callback) {
      var root6328 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      var result__ = mobl.DateTime.parse(issue.get().submitted.toString()).toDateString();
      var tmp3424 = mobl.ref(result__);
      subs__.addSub(mobl.ref(mobl.DateTime).addEventListener('change', function() {
        tmp3424.set(mobl.DateTime.parse(issue.get().submitted.toString()).toDateString());
      }));
      subs__.addSub(mobl.ref(issue, 'submitted').addEventListener('change', function() {
        tmp3424.set(mobl.DateTime.parse(issue.get().submitted.toString()).toDateString());
      }));
      
      var nodes5517 = $("<span>");
      root6328.append(nodes5517);
      subs__.addSub((mobl.label)(tmp3424, mobl.ref(null), mobl.ref(null), function(_, callback) {
        var root6329 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        callback(root6329); return subs__;
        return subs__;
      }, function(node) {
        var oldNodes = nodes5517;
        nodes5517 = node.contents();
        oldNodes.replaceWith(nodes5517);
      }));
      callback(root6328); return subs__;
      
      return subs__;
    }, function(node) {
      var oldNodes = nodes5516;
      nodes5516 = node.contents();
      oldNodes.replaceWith(nodes5516);
    }));
    var nodes5518 = $("<span>");
    root6322.append(nodes5518);
    subs__.addSub((mobl.ui.generic.cell)(mobl.ref(null), mobl.ref(mobl.ui.generic.tdStyle), function(_, callback) {
      var root6330 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      var result__ = function(event, callback) {
                       if(event && event.stopPropagation) event.stopPropagation();
                       mobl.call('Yellowgrassmobile.ShowIssue', [issue, mobl.ref(false), mobl.ref("slide"), mobl.ref(null)], function(result__) {
                       var tmp3465 = result__;
                       if(callback && callback.apply) callback(); return;
                       });
                     };
      var tmp3425 = mobl.ref(result__);
      
      var nodes5519 = $("<span>");
      root6330.append(nodes5519);
      subs__.addSub((mobl.label)(mobl.ref(issue, 'title'), mobl.ref(null), tmp3425, function(_, callback) {
        var root6331 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        callback(root6331); return subs__;
        return subs__;
      }, function(node) {
        var oldNodes = nodes5519;
        nodes5519 = node.contents();
        oldNodes.replaceWith(nodes5519);
      }));
      callback(root6330); return subs__;
      
      return subs__;
    }, function(node) {
      var oldNodes = nodes5518;
      nodes5518 = node.contents();
      oldNodes.replaceWith(nodes5518);
    }));
    callback(root6322); return subs__;
    
    
    
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes5510;
    nodes5510 = node.contents();
    oldNodes.replaceWith(nodes5510);
  }));
  callback(root6321); return subs__;
  
  return subs__;
};

Yellowgrassmobile.ShowLabel = function(tuple, elements, callback) {
  var root6332 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  var nodes5520 = $("<span>");
  root6332.append(nodes5520);
  subs__.addSub((mobl.label)(mobl.ref(tuple, '_1'), mobl.ref(null), mobl.ref(null), function(_, callback) {
    var root6333 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    callback(root6333); return subs__;
    return subs__;
  }, function(node) {
    var oldNodes = nodes5520;
    nodes5520 = node.contents();
    oldNodes.replaceWith(nodes5520);
  }));
  callback(root6332); return subs__;
  
  return subs__;
};

Yellowgrassmobile.ShowUsers = function(tuple, elements, callback) {
  var root6334 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  var nodes5521 = $("<span>");
  root6334.append(nodes5521);
  subs__.addSub((mobl.label)(mobl.ref(tuple, '_1'), mobl.ref(null), mobl.ref(null), function(_, callback) {
    var root6335 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    callback(root6335); return subs__;
    return subs__;
  }, function(node) {
    var oldNodes = nodes5521;
    nodes5521 = node.contents();
    oldNodes.replaceWith(nodes5521);
  }));
  var nodes5522 = $("<span>");
  root6334.append(nodes5522);
  subs__.addSub((mobl.ui.generic.group)(function(_, callback) {
    var root6336 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    
    var node1047 = mobl.loadingSpan();
    root6336.append(node1047);
    var list274;
    var listSubs274 = new mobl.CompSubscription();
    subs__.addSub(listSubs274);
    var renderList274 = function() {
      var subs__ = listSubs274;
      list274 = tuple.get()._2;
      list274.list(function(results274) {
        node1047.empty();
        for(var i361 = 0; i361 < results274.length; i361++) {
          (function() {
            var iternode274 = $("<span>");
            node1047.append(iternode274);
            var user;
            user = mobl.ref(mobl.ref(results274), i361);
            var nodes5523 = $("<span>");
            iternode274.append(nodes5523);
            subs__.addSub((mobl.ui.generic.item)(mobl.ref(mobl.ui.generic.itemStyle), mobl.ref(mobl.ui.generic.itemPushedStyle), mobl.ref(null), mobl.ref(null), mobl.ref(false), function(_, callback) {
              var root6337 = $("<span>");
              var subs__ = new mobl.CompSubscription();
              var result__ = function(event, callback) {
                               if(event && event.stopPropagation) event.stopPropagation();
                               mobl.call('Yellowgrassmobile.ShowUser', [user, mobl.ref(false), mobl.ref("slide"), mobl.ref("_top")], function(result__) {
                               var tmp3466 = result__;
                               if(callback && callback.apply) callback(); return;
                               });
                             };
              var tmp3426 = mobl.ref(result__);
              
              var nodes5524 = $("<span>");
              root6337.append(nodes5524);
              subs__.addSub((mobl.label)(mobl.ref(user, 'name'), mobl.ref(null), tmp3426, function(_, callback) {
                var root6338 = $("<span>");
                var subs__ = new mobl.CompSubscription();
                callback(root6338); return subs__;
                return subs__;
              }, function(node) {
                var oldNodes = nodes5524;
                nodes5524 = node.contents();
                oldNodes.replaceWith(nodes5524);
              }));
              callback(root6337); return subs__;
              
              return subs__;
            }, function(node) {
              var oldNodes = nodes5523;
              nodes5523 = node.contents();
              oldNodes.replaceWith(nodes5523);
            }));
            
            var oldNodes = iternode274;
            iternode274 = iternode274.contents();
            oldNodes.replaceWith(iternode274);
            
            
          }());
        }
        mobl.delayedUpdateScrollers();
        subs__.addSub(list274.addEventListener('change', function() { listSubs274.unsubscribe(); renderList274(true); }));
        subs__.addSub(mobl.ref(tuple, '_2').addEventListener('change', function() { listSubs274.unsubscribe(); renderList274(true); }));
      });
    };
    renderList274();
    
    callback(root6336); return subs__;
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes5522;
    nodes5522 = node.contents();
    oldNodes.replaceWith(nodes5522);
  }));
  callback(root6334); return subs__;
  
  
  return subs__;
};

Yellowgrassmobile.ShowIssue = function(issue, callback, screenCallback) {
  var root6339 = $("<div>");
  var subs__ = new mobl.CompSubscription();
  var nodes5525 = $("<span>");
  root6339.append(nodes5525);
  subs__.addSub((mobl.ui.generic.header)(mobl.ref(Yellowgrassmobile.currentProject, 'name'), mobl.ref(false), mobl.ref(null), function(_, callback) {
    var root6340 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    var nodes5526 = $("<span>");
    root6340.append(nodes5526);
    subs__.addSub((lib.getHeaderImage)(mobl.ref(true), function(_, callback) {
      var root6341 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root6341); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes5526;
      nodes5526 = node.contents();
      oldNodes.replaceWith(nodes5526);
    }));
    var result__ = function(event, callback) {
                     if(event && event.stopPropagation) event.stopPropagation();
                     if(screenCallback) screenCallback();
                     return;
                     if(callback && callback.apply) callback(); return;
                   };
    var tmp3427 = mobl.ref(result__);
    
    var nodes5527 = $("<span>");
    root6340.append(nodes5527);
    subs__.addSub((mobl.ui.generic.button)(mobl.ref("back"), mobl.ref(mobl.ui.generic.buttonStyle), mobl.ref(mobl.ui.generic.buttonPushedStyle), tmp3427, function(_, callback) {
      var root6342 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root6342); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes5527;
      nodes5527 = node.contents();
      oldNodes.replaceWith(nodes5527);
    }));
    callback(root6340); return subs__;
    
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes5525;
    nodes5525 = node.contents();
    oldNodes.replaceWith(nodes5525);
  }));
  
  var logList = mobl.ref(new persistence.LocalQueryCollection([new mobl.Tuple("Log", issue.get().comments)]));
  
  var node1048 = $("<span>");
  root6339.append(node1048);
  var condSubs649 = new mobl.CompSubscription();
  subs__.addSub(condSubs649);
  var oldValue649;
  var renderCond649 = function() {
    var value713 = issue.get().reporter;
    if(oldValue649 === value713) return;
    oldValue649 = value713;
    var subs__ = condSubs649;
    subs__.unsubscribe();
    node1048.empty();
    if(value713) {
      var nodes5528 = $("<span>");
      node1048.append(nodes5528);
      subs__.addSub((mobl.ui.generic.group)(function(_, callback) {
        var root6343 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        var nodes5529 = $("<span>");
        root6343.append(nodes5529);
        subs__.addSub((mobl.html)(mobl.ref("<h4><font color=#334E33>Reporter</font></h4>"), function(_, callback) {
          var root6344 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root6344); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes5529;
          nodes5529 = node.contents();
          oldNodes.replaceWith(nodes5529);
        }));
        var result__ = function(event, callback) {
                         if(event && event.stopPropagation) event.stopPropagation();
                         mobl.call('Yellowgrassmobile.ShowUser', [mobl.ref(issue, 'reporter'), mobl.ref(false), mobl.ref("slide"), mobl.ref(null)], function(result__) {
                         var tmp3467 = result__;
                         if(callback && callback.apply) callback(); return;
                         });
                       };
        var tmp3428 = mobl.ref(result__);
        
        var nodes5530 = $("<span>");
        root6343.append(nodes5530);
        subs__.addSub((mobl.ui.generic.item)(mobl.ref(mobl.ui.generic.itemStyle), mobl.ref(mobl.ui.generic.itemPushedStyle), tmp3428, mobl.ref(null), mobl.ref(false), function(_, callback) {
          var root6345 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          var nodes5531 = $("<span>");
          root6345.append(nodes5531);
          subs__.addSub((mobl.label)(mobl.ref(mobl.ref(issue, 'reporter'), 'name'), mobl.ref(null), mobl.ref(null), function(_, callback) {
            var root6346 = $("<span>");
            var subs__ = new mobl.CompSubscription();
            callback(root6346); return subs__;
            return subs__;
          }, function(node) {
            var oldNodes = nodes5531;
            nodes5531 = node.contents();
            oldNodes.replaceWith(nodes5531);
          }));
          callback(root6345); return subs__;
          
          return subs__;
        }, function(node) {
          var oldNodes = nodes5530;
          nodes5530 = node.contents();
          oldNodes.replaceWith(nodes5530);
        }));
        callback(root6343); return subs__;
        
        
        return subs__;
      }, function(node) {
        var oldNodes = nodes5528;
        nodes5528 = node.contents();
        oldNodes.replaceWith(nodes5528);
      }));
      
      
    } else {
      
    }
  };
  renderCond649();
  subs__.addSub(mobl.ref(issue, 'reporter').addEventListener('change', function() {
    renderCond649();
  }));
  
  var result__ = !issue.get().open;
  var tmp3431 = mobl.ref(result__);
  subs__.addSub(mobl.ref(issue, 'open').addEventListener('change', function() {
    tmp3431.set(!issue.get().open);
  }));
  
  
  var node1049 = $("<span>");
  root6339.append(node1049);
  var condSubs650 = new mobl.CompSubscription();
  subs__.addSub(condSubs650);
  var oldValue650;
  var renderCond650 = function() {
    var value714 = tmp3431.get();
    if(oldValue650 === value714) return;
    oldValue650 = value714;
    var subs__ = condSubs650;
    subs__.unsubscribe();
    node1049.empty();
    if(value714) {
      var nodes5532 = $("<span>");
      node1049.append(nodes5532);
      subs__.addSub((mobl.ui.generic.image)(mobl.ref("./images/tick.png"), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref("right"), function(_, callback) {
        var root6347 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        callback(root6347); return subs__;
        return subs__;
      }, function(node) {
        var oldNodes = nodes5532;
        nodes5532 = node.contents();
        oldNodes.replaceWith(nodes5532);
      }));
      var result__ = "<h4><font> # " + issue.get().number + ": " + issue.get().title + "</font></h4>";
      var tmp3429 = mobl.ref(result__);
      subs__.addSub(mobl.ref(issue, 'number').addEventListener('change', function() {
        tmp3429.set("<h4><font> # " + issue.get().number + ": " + issue.get().title + "</font></h4>");
      }));
      subs__.addSub(mobl.ref(issue, 'title').addEventListener('change', function() {
        tmp3429.set("<h4><font> # " + issue.get().number + ": " + issue.get().title + "</font></h4>");
      }));
      
      var nodes5533 = $("<span>");
      node1049.append(nodes5533);
      subs__.addSub((mobl.html)(tmp3429, function(_, callback) {
        var root6348 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        callback(root6348); return subs__;
        return subs__;
      }, function(node) {
        var oldNodes = nodes5533;
        nodes5533 = node.contents();
        oldNodes.replaceWith(nodes5533);
      }));
      
      
      
    } else {
      var nodes5534 = $("<span>");
      node1049.append(nodes5534);
      subs__.addSub((mobl.ui.generic.image)(mobl.ref("./images/question.gif"), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref("right"), function(_, callback) {
        var root6349 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        callback(root6349); return subs__;
        return subs__;
      }, function(node) {
        var oldNodes = nodes5534;
        nodes5534 = node.contents();
        oldNodes.replaceWith(nodes5534);
      }));
      var result__ = "<h4><font> # " + issue.get().number + ": " + issue.get().title + "</font></h4>";
      var tmp3430 = mobl.ref(result__);
      subs__.addSub(mobl.ref(issue, 'number').addEventListener('change', function() {
        tmp3430.set("<h4><font> # " + issue.get().number + ": " + issue.get().title + "</font></h4>");
      }));
      subs__.addSub(mobl.ref(issue, 'title').addEventListener('change', function() {
        tmp3430.set("<h4><font> # " + issue.get().number + ": " + issue.get().title + "</font></h4>");
      }));
      
      var nodes5535 = $("<span>");
      node1049.append(nodes5535);
      subs__.addSub((mobl.html)(tmp3430, function(_, callback) {
        var root6350 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        callback(root6350); return subs__;
        return subs__;
      }, function(node) {
        var oldNodes = nodes5535;
        nodes5535 = node.contents();
        oldNodes.replaceWith(nodes5535);
      }));
      
      
      
    }
  };
  renderCond650();
  subs__.addSub(tmp3431.addEventListener('change', function() {
    renderCond650();
  }));
  
  var result__ = issue.get().description != null;
  var tmp3433 = mobl.ref(result__);
  subs__.addSub(mobl.ref(issue, 'description').addEventListener('change', function() {
    tmp3433.set(issue.get().description != null);
  }));
  
  
  var node1050 = $("<span>");
  root6339.append(node1050);
  var condSubs651 = new mobl.CompSubscription();
  subs__.addSub(condSubs651);
  var oldValue651;
  var renderCond651 = function() {
    var value715 = tmp3433.get();
    if(oldValue651 === value715) return;
    oldValue651 = value715;
    var subs__ = condSubs651;
    subs__.unsubscribe();
    node1050.empty();
    if(value715) {
      var result__ = "<h4><font color=#334E33>Description</font></h4>" + issue.get().description;
      var tmp3432 = mobl.ref(result__);
      subs__.addSub(mobl.ref(issue, 'description').addEventListener('change', function() {
        tmp3432.set("<h4><font color=#334E33>Description</font></h4>" + issue.get().description);
      }));
      
      var nodes5536 = $("<span>");
      node1050.append(nodes5536);
      subs__.addSub((mobl.html)(tmp3432, function(_, callback) {
        var root6351 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        callback(root6351); return subs__;
        return subs__;
      }, function(node) {
        var oldNodes = nodes5536;
        nodes5536 = node.contents();
        oldNodes.replaceWith(nodes5536);
      }));
      
      
    } else {
      
    }
  };
  renderCond651();
  subs__.addSub(tmp3433.addEventListener('change', function() {
    renderCond651();
  }));
  
  
  var node1051 = $("<span>");
  root6339.append(node1051);
  var condSubs652 = new mobl.CompSubscription();
  subs__.addSub(condSubs652);
  var oldValue652;
  var renderCond652 = function() {
    var value716 = issue.get().comments.length;
    if(oldValue652 === value716) return;
    oldValue652 = value716;
    var subs__ = condSubs652;
    subs__.unsubscribe();
    node1051.empty();
    if(value716) {
      var nodes5537 = $("<span>");
      node1051.append(nodes5537);
      subs__.addSub((mobl.ui.generic.zoomList)(logList, mobl.ref(Yellowgrassmobile.ShowHTMLHeaderLog), mobl.ref(Yellowgrassmobile.ShowLog), function(_, callback) {
        var root6352 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        callback(root6352); return subs__;
        return subs__;
      }, function(node) {
        var oldNodes = nodes5537;
        nodes5537 = node.contents();
        oldNodes.replaceWith(nodes5537);
      }));
      
      
    } else {
      
    }
  };
  renderCond652();
  subs__.addSub(mobl.ref(mobl.ref(issue, 'comments'), 'length').addEventListener('change', function() {
    renderCond652();
  }));
  
  callback(root6339); return subs__;
  
  
  
  
  
  return subs__;
};

Yellowgrassmobile.ShowUser = function(user, callback, screenCallback) {
  var root6353 = $("<div>");
  var subs__ = new mobl.CompSubscription();
  var nodes5538 = $("<span>");
  root6353.append(nodes5538);
  subs__.addSub((mobl.ui.generic.header)(mobl.ref("User"), mobl.ref(false), mobl.ref(null), function(_, callback) {
    var root6354 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    var nodes5539 = $("<span>");
    root6354.append(nodes5539);
    subs__.addSub((lib.getHeaderImage)(mobl.ref(true), function(_, callback) {
      var root6355 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root6355); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes5539;
      nodes5539 = node.contents();
      oldNodes.replaceWith(nodes5539);
    }));
    var result__ = function(event, callback) {
                     if(event && event.stopPropagation) event.stopPropagation();
                     if(screenCallback) screenCallback();
                     return;
                     if(callback && callback.apply) callback(); return;
                   };
    var tmp3434 = mobl.ref(result__);
    
    var nodes5540 = $("<span>");
    root6354.append(nodes5540);
    subs__.addSub((mobl.ui.generic.button)(mobl.ref("back"), mobl.ref(mobl.ui.generic.buttonStyle), mobl.ref(mobl.ui.generic.buttonPushedStyle), tmp3434, function(_, callback) {
      var root6356 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root6356); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes5540;
      nodes5540 = node.contents();
      oldNodes.replaceWith(nodes5540);
    }));
    callback(root6354); return subs__;
    
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes5538;
    nodes5538 = node.contents();
    oldNodes.replaceWith(nodes5538);
  }));
  
  var projectList = mobl.ref(new persistence.LocalQueryCollection([new mobl.Tuple("Projects", user.get().projects)]));
  var nodes5541 = $("<span>");
  root6353.append(nodes5541);
  subs__.addSub((mobl.ui.generic.group)(function(_, callback) {
    var root6357 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    var nodes5542 = $("<span>");
    root6357.append(nodes5542);
    subs__.addSub((mobl.html)(mobl.ref("<h4><font color=#334E33>Name</font></h4>"), function(_, callback) {
      var root6358 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root6358); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes5542;
      nodes5542 = node.contents();
      oldNodes.replaceWith(nodes5542);
    }));
    var nodes5543 = $("<span>");
    root6357.append(nodes5543);
    subs__.addSub((mobl.label)(mobl.ref(user, 'name'), mobl.ref(null), mobl.ref(null), function(_, callback) {
      var root6359 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root6359); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes5543;
      nodes5543 = node.contents();
      oldNodes.replaceWith(nodes5543);
    }));
    callback(root6357); return subs__;
    
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes5541;
    nodes5541 = node.contents();
    oldNodes.replaceWith(nodes5541);
  }));
  var nodes5544 = $("<span>");
  root6353.append(nodes5544);
  subs__.addSub((mobl.ui.generic.group)(function(_, callback) {
    var root6360 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    var nodes5545 = $("<span>");
    root6360.append(nodes5545);
    subs__.addSub((mobl.html)(mobl.ref("<h4><font color=#334E33>Tag</font></h4>"), function(_, callback) {
      var root6361 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root6361); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes5545;
      nodes5545 = node.contents();
      oldNodes.replaceWith(nodes5545);
    }));
    var result__ = user.get().tag != null;
    var tmp3435 = mobl.ref(result__);
    subs__.addSub(mobl.ref(user, 'tag').addEventListener('change', function() {
      tmp3435.set(user.get().tag != null);
    }));
    
    
    var node1052 = $("<span>");
    root6360.append(node1052);
    var condSubs653 = new mobl.CompSubscription();
    subs__.addSub(condSubs653);
    var oldValue653;
    var renderCond653 = function() {
      var value717 = tmp3435.get();
      if(oldValue653 === value717) return;
      oldValue653 = value717;
      var subs__ = condSubs653;
      subs__.unsubscribe();
      node1052.empty();
      if(value717) {
        var nodes5546 = $("<span>");
        node1052.append(nodes5546);
        subs__.addSub((mobl.label)(mobl.ref(user, 'tag'), mobl.ref(null), mobl.ref(null), function(_, callback) {
          var root6362 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root6362); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes5546;
          nodes5546 = node.contents();
          oldNodes.replaceWith(nodes5546);
        }));
        
        
      } else {
        var nodes5547 = $("<span>");
        node1052.append(nodes5547);
        subs__.addSub((mobl.label)(mobl.ref("User has no Tag"), mobl.ref(null), mobl.ref(null), function(_, callback) {
          var root6363 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root6363); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes5547;
          nodes5547 = node.contents();
          oldNodes.replaceWith(nodes5547);
        }));
        
        
      }
    };
    renderCond653();
    subs__.addSub(tmp3435.addEventListener('change', function() {
      renderCond653();
    }));
    
    callback(root6360); return subs__;
    
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes5544;
    nodes5544 = node.contents();
    oldNodes.replaceWith(nodes5544);
  }));
  var nodes5548 = $("<span>");
  root6353.append(nodes5548);
  subs__.addSub((mobl.ui.generic.group)(function(_, callback) {
    var root6364 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    var result__ = user.get().url != null && user.get().url != "";
    var tmp3437 = mobl.ref(result__);
    subs__.addSub(mobl.ref(user, 'url').addEventListener('change', function() {
      tmp3437.set(user.get().url != null && user.get().url != "");
    }));
    
    
    var node1053 = $("<span>");
    root6364.append(node1053);
    var condSubs654 = new mobl.CompSubscription();
    subs__.addSub(condSubs654);
    var oldValue654;
    var renderCond654 = function() {
      var value718 = tmp3437.get();
      if(oldValue654 === value718) return;
      oldValue654 = value718;
      var subs__ = condSubs654;
      subs__.unsubscribe();
      node1053.empty();
      if(value718) {
        var nodes5549 = $("<span>");
        node1053.append(nodes5549);
        subs__.addSub((mobl.html)(mobl.ref("<h4><font color=#334E33>Personal Site</font></h4>"), function(_, callback) {
          var root6365 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root6365); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes5549;
          nodes5549 = node.contents();
          oldNodes.replaceWith(nodes5549);
        }));
        var nodes5550 = $("<span>");
        node1053.append(nodes5550);
        subs__.addSub((mobl.ui.generic.item)(mobl.ref(mobl.ui.generic.itemStyle), mobl.ref(mobl.ui.generic.itemPushedStyle), mobl.ref(null), mobl.ref(null), mobl.ref(false), function(_, callback) {
          var root6366 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          var result__ = function(event, callback) {
                           if(event && event.stopPropagation) event.stopPropagation();
                           var result__ = mobl.openUrl(user.get().url);
                           if(callback && callback.apply) callback(); return;
                         };
          var tmp3436 = mobl.ref(result__);
          
          var nodes5551 = $("<span>");
          root6366.append(nodes5551);
          subs__.addSub((mobl.label)(mobl.ref(user, 'url'), mobl.ref(null), tmp3436, function(_, callback) {
            var root6367 = $("<span>");
            var subs__ = new mobl.CompSubscription();
            callback(root6367); return subs__;
            return subs__;
          }, function(node) {
            var oldNodes = nodes5551;
            nodes5551 = node.contents();
            oldNodes.replaceWith(nodes5551);
          }));
          callback(root6366); return subs__;
          
          return subs__;
        }, function(node) {
          var oldNodes = nodes5550;
          nodes5550 = node.contents();
          oldNodes.replaceWith(nodes5550);
        }));
        
        
        
      } else {
        
      }
    };
    renderCond654();
    subs__.addSub(tmp3437.addEventListener('change', function() {
      renderCond654();
    }));
    
    callback(root6364); return subs__;
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes5548;
    nodes5548 = node.contents();
    oldNodes.replaceWith(nodes5548);
  }));
  var nodes5552 = $("<span>");
  root6353.append(nodes5552);
  subs__.addSub((mobl.ui.generic.zoomList)(projectList, mobl.ref(Yellowgrassmobile.ShowHTMLHeader), mobl.ref(Yellowgrassmobile.ShowProjects), function(_, callback) {
    var root6368 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    callback(root6368); return subs__;
    return subs__;
  }, function(node) {
    var oldNodes = nodes5552;
    nodes5552 = node.contents();
    oldNodes.replaceWith(nodes5552);
  }));
  callback(root6353); return subs__;
  
  
  
  
  
  return subs__;
};

Yellowgrassmobile.ShowHTMLHeader = function(tuple, elements, callback) {
  var root6369 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  var result__ = "<h4><font color=#334E33>" + tuple.get()._1 + "</font></h4>";
  var tmp3438 = mobl.ref(result__);
  subs__.addSub(mobl.ref(tuple, '_1').addEventListener('change', function() {
    tmp3438.set("<h4><font color=#334E33>" + tuple.get()._1 + "</font></h4>");
  }));
  
  var nodes5553 = $("<span>");
  root6369.append(nodes5553);
  subs__.addSub((mobl.html)(tmp3438, function(_, callback) {
    var root6370 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    callback(root6370); return subs__;
    return subs__;
  }, function(node) {
    var oldNodes = nodes5553;
    nodes5553 = node.contents();
    oldNodes.replaceWith(nodes5553);
  }));
  callback(root6369); return subs__;
  
  return subs__;
};

Yellowgrassmobile.ShowProjects = function(tuple, elements, callback) {
  var root6371 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  var result__ = "<h4><font color=#334E33>" + tuple.get()._1 + "</font></h4>";
  var tmp3439 = mobl.ref(result__);
  subs__.addSub(mobl.ref(tuple, '_1').addEventListener('change', function() {
    tmp3439.set("<h4><font color=#334E33>" + tuple.get()._1 + "</font></h4>");
  }));
  
  var nodes5554 = $("<span>");
  root6371.append(nodes5554);
  subs__.addSub((mobl.html)(tmp3439, function(_, callback) {
    var root6372 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    callback(root6372); return subs__;
    return subs__;
  }, function(node) {
    var oldNodes = nodes5554;
    nodes5554 = node.contents();
    oldNodes.replaceWith(nodes5554);
  }));
  var nodes5555 = $("<span>");
  root6371.append(nodes5555);
  subs__.addSub((mobl.ui.generic.group)(function(_, callback) {
    var root6373 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    
    var node1054 = mobl.loadingSpan();
    root6373.append(node1054);
    var list275;
    var listSubs275 = new mobl.CompSubscription();
    subs__.addSub(listSubs275);
    var renderList275 = function() {
      var subs__ = listSubs275;
      list275 = tuple.get()._2;
      list275.list(function(results275) {
        node1054.empty();
        for(var i362 = 0; i362 < results275.length; i362++) {
          (function() {
            var iternode275 = $("<span>");
            node1054.append(iternode275);
            var project;
            project = mobl.ref(mobl.ref(results275), i362);
            var nodes5556 = $("<span>");
            iternode275.append(nodes5556);
            subs__.addSub((mobl.ui.generic.item)(mobl.ref(mobl.ui.generic.itemStyle), mobl.ref(mobl.ui.generic.itemPushedStyle), mobl.ref(null), mobl.ref(null), mobl.ref(false), function(_, callback) {
              var root6374 = $("<span>");
              var subs__ = new mobl.CompSubscription();
              var result__ = function(event, callback) {
                               if(event && event.stopPropagation) event.stopPropagation();
                               mobl.call('Yellowgrassmobile.ShowProject', [project, mobl.ref(false), mobl.ref("slide"), mobl.ref("_top")], function(result__) {
                               var tmp3468 = result__;
                               if(callback && callback.apply) callback(); return;
                               });
                             };
              var tmp3440 = mobl.ref(result__);
              
              var nodes5557 = $("<span>");
              root6374.append(nodes5557);
              subs__.addSub((mobl.label)(mobl.ref(project, 'name'), mobl.ref(null), tmp3440, function(_, callback) {
                var root6375 = $("<span>");
                var subs__ = new mobl.CompSubscription();
                callback(root6375); return subs__;
                return subs__;
              }, function(node) {
                var oldNodes = nodes5557;
                nodes5557 = node.contents();
                oldNodes.replaceWith(nodes5557);
              }));
              callback(root6374); return subs__;
              
              return subs__;
            }, function(node) {
              var oldNodes = nodes5556;
              nodes5556 = node.contents();
              oldNodes.replaceWith(nodes5556);
            }));
            
            var oldNodes = iternode275;
            iternode275 = iternode275.contents();
            oldNodes.replaceWith(iternode275);
            
            
          }());
        }
        mobl.delayedUpdateScrollers();
        subs__.addSub(list275.addEventListener('change', function() { listSubs275.unsubscribe(); renderList275(true); }));
        subs__.addSub(mobl.ref(tuple, '_2').addEventListener('change', function() { listSubs275.unsubscribe(); renderList275(true); }));
      });
    };
    renderList275();
    
    callback(root6373); return subs__;
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes5555;
    nodes5555 = node.contents();
    oldNodes.replaceWith(nodes5555);
  }));
  callback(root6371); return subs__;
  
  
  return subs__;
};

Yellowgrassmobile.ShowHTMLHeaderLog = function(tuple, elements, callback) {
  var root6376 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  var result__ = "<h4><font color=#334E33>" + tuple.get()._1 + "</font></h4>";
  var tmp3441 = mobl.ref(result__);
  subs__.addSub(mobl.ref(tuple, '_1').addEventListener('change', function() {
    tmp3441.set("<h4><font color=#334E33>" + tuple.get()._1 + "</font></h4>");
  }));
  
  var nodes5558 = $("<span>");
  root6376.append(nodes5558);
  subs__.addSub((mobl.html)(tmp3441, function(_, callback) {
    var root6377 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    callback(root6377); return subs__;
    return subs__;
  }, function(node) {
    var oldNodes = nodes5558;
    nodes5558 = node.contents();
    oldNodes.replaceWith(nodes5558);
  }));
  callback(root6376); return subs__;
  
  return subs__;
};

Yellowgrassmobile.ShowLog = function(tuple, elements, callback) {
  var root6378 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  var result__ = "<h4><font color=#334E33>" + tuple.get()._1 + "</font></h4>";
  var tmp3442 = mobl.ref(result__);
  subs__.addSub(mobl.ref(tuple, '_1').addEventListener('change', function() {
    tmp3442.set("<h4><font color=#334E33>" + tuple.get()._1 + "</font></h4>");
  }));
  
  var nodes5559 = $("<span>");
  root6378.append(nodes5559);
  subs__.addSub((mobl.html)(tmp3442, function(_, callback) {
    var root6379 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    callback(root6379); return subs__;
    return subs__;
  }, function(node) {
    var oldNodes = nodes5559;
    nodes5559 = node.contents();
    oldNodes.replaceWith(nodes5559);
  }));
  var nodes5560 = $("<span>");
  root6378.append(nodes5560);
  subs__.addSub((mobl.ui.generic.group)(function(_, callback) {
    var root6380 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    
    var node1055 = mobl.loadingSpan();
    root6380.append(node1055);
    var list276;
    var listSubs276 = new mobl.CompSubscription();
    subs__.addSub(listSubs276);
    var renderList276 = function() {
      var subs__ = listSubs276;
      list276 = tuple.get()._2;
      list276.list(function(results276) {
        node1055.empty();
        for(var i363 = 0; i363 < results276.length; i363++) {
          (function() {
            var iternode276 = $("<span>");
            node1055.append(iternode276);
            var comment;
            comment = mobl.ref(mobl.ref(results276), i363);
            var result__ = "<h6><font color=#334E33>On " + mobl.DateTime.parse(comment.get().submitted.toString()).toString() + " " + comment.get().author.name + " wrote:</font></h6>" + comment.get().text;
            var tmp3443 = mobl.ref(result__);
            subs__.addSub(mobl.ref(mobl.DateTime).addEventListener('change', function() {
              tmp3443.set("<h6><font color=#334E33>On " + mobl.DateTime.parse(comment.get().submitted.toString()).toString() + " " + comment.get().author.name + " wrote:</font></h6>" + comment.get().text);
            }));
            subs__.addSub(mobl.ref(comment, 'submitted').addEventListener('change', function() {
              tmp3443.set("<h6><font color=#334E33>On " + mobl.DateTime.parse(comment.get().submitted.toString()).toString() + " " + comment.get().author.name + " wrote:</font></h6>" + comment.get().text);
            }));
            subs__.addSub(mobl.ref(mobl.ref(comment, 'author'), 'name').addEventListener('change', function() {
              tmp3443.set("<h6><font color=#334E33>On " + mobl.DateTime.parse(comment.get().submitted.toString()).toString() + " " + comment.get().author.name + " wrote:</font></h6>" + comment.get().text);
            }));
            subs__.addSub(mobl.ref(comment, 'text').addEventListener('change', function() {
              tmp3443.set("<h6><font color=#334E33>On " + mobl.DateTime.parse(comment.get().submitted.toString()).toString() + " " + comment.get().author.name + " wrote:</font></h6>" + comment.get().text);
            }));
            
            var nodes5561 = $("<span>");
            iternode276.append(nodes5561);
            subs__.addSub((mobl.html)(tmp3443, function(_, callback) {
              var root6381 = $("<span>");
              var subs__ = new mobl.CompSubscription();
              callback(root6381); return subs__;
              return subs__;
            }, function(node) {
              var oldNodes = nodes5561;
              nodes5561 = node.contents();
              oldNodes.replaceWith(nodes5561);
            }));
            
            var oldNodes = iternode276;
            iternode276 = iternode276.contents();
            oldNodes.replaceWith(iternode276);
            
            
          }());
        }
        mobl.delayedUpdateScrollers();
        subs__.addSub(list276.addEventListener('change', function() { listSubs276.unsubscribe(); renderList276(true); }));
        subs__.addSub(mobl.ref(tuple, '_2').addEventListener('change', function() { listSubs276.unsubscribe(); renderList276(true); }));
      });
    };
    renderList276();
    
    callback(root6380); return subs__;
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes5560;
    nodes5560 = node.contents();
    oldNodes.replaceWith(nodes5560);
  }));
  callback(root6378); return subs__;
  
  
  return subs__;
};
