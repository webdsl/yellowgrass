mobl.provides('lib');
mobl.provides('mobl.ui');
mobl.provides('mobl.ui.generic');
mobl.provides('lib');
mobl.provides('mobl');

lib.getHeaderImage = function(hasTitle, elements, callback) {
  var root4938 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  var result__ = (1 - hasTitle.get()) || (1 - lib.toSmall());
  var tmp2687 = mobl.ref(result__);
  subs__.addSub(hasTitle.addEventListener('change', function() {
    tmp2687.set((1 - hasTitle.get()) || (1 - lib.toSmall()));
  }));
  
  
  var node844 = $("<span>");
  root4938.append(node844);
  var condSubs504 = new mobl.CompSubscription();
  subs__.addSub(condSubs504);
  var oldValue504;
  var renderCond504 = function() {
    var value564 = tmp2687.get();
    if(oldValue504 === value564) return;
    oldValue504 = value564;
    var subs__ = condSubs504;
    subs__.unsubscribe();
    node844.empty();
    if(value564) {
      var nodes4280 = $("<span>");
      node844.append(nodes4280);
      subs__.addSub((mobl.ui.generic.image)(mobl.ref("./images/logo.png"), mobl.ref(null), mobl.ref(43), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref("left"), function(_, callback) {
        var root4939 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        callback(root4939); return subs__;
        return subs__;
      }, function(node) {
        var oldNodes = nodes4280;
        nodes4280 = node.contents();
        oldNodes.replaceWith(nodes4280);
      }));
      
      
    } else {
      
    }
  };
  renderCond504();
  subs__.addSub(tmp2687.addEventListener('change', function() {
    renderCond504();
  }));
  
  callback(root4938); return subs__;
  
  return subs__;
};

lib.getBackButton = function(elements, callback) {
  var root4940 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  var result__ = function(event, callback) {
                   if(event && event.stopPropagation) event.stopPropagation();
                   if(screenCallback) screenCallback();
                   return;
                   if(callback && callback.apply) callback(); return;
                 };
  var tmp2688 = mobl.ref(result__);
  
  var nodes4281 = $("<span>");
  root4940.append(nodes4281);
  subs__.addSub((mobl.ui.generic.button)(mobl.ref("back"), mobl.ref(mobl.ui.generic.buttonStyle), mobl.ref(mobl.ui.generic.buttonPushedStyle), tmp2688, function(_, callback) {
    var root4941 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    callback(root4941); return subs__;
    return subs__;
  }, function(node) {
    var oldNodes = nodes4281;
    nodes4281 = node.contents();
    oldNodes.replaceWith(nodes4281);
  }));
  callback(root4940); return subs__;
  
  return subs__;
};
lib.toSmall = function() {
   var __this = this;
  return (mobl.window.get().innerWidth <= 470);
};

servicemodel.Comment.hasOne('author', servicemodel.User);
servicemodel.Issue.hasOne('reporter', servicemodel.User);
servicemodel.Issue.hasOne('project', servicemodel.Project);
