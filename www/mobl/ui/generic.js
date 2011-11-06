mobl.provides('mobl.ui.generic');
mobl.provides('mobl.ui.stylemixin');
mobl.provides('mobl.ui.generic');
mobl.provides('mobl');
mobl.provides('mobl.ui');
mobl.ui.generic.loadingStyle = 'mobl__ui__generic__loadingStyle';

mobl.ui.generic.whenLoaded = function(value, style, loadingMessage, elements, callback) {
  var root4843 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var node795 = $("<span>");
  root4843.append(node795);
  var condSubs492 = new mobl.CompSubscription();
  subs__.addSub(condSubs492);
  var oldValue492;
  var renderCond492 = function() {
    var value552 = value.get();
    if(oldValue492 === value552) return;
    oldValue492 = value552;
    var subs__ = condSubs492;
    subs__.unsubscribe();
    node795.empty();
    if(value552) {
      var nodes4217 = $("<span>");
      node795.append(nodes4217);
      subs__.addSub(mobl.ref(elements).addEventListener('change', function() {
        renderControl52();
      }));
      
      function renderControl52() {
        subs__.addSub((elements)(function(elements, callback) {
          var root4844 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root4844); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes4217;
          nodes4217 = node.contents();
          oldNodes.replaceWith(nodes4217);
        }));
      }
      renderControl52();
      
      
    } else {
      var nodes4218 = $("<span>");
      node795.append(nodes4218);
      subs__.addSub((mobl.block)(style, mobl.ref(null), mobl.ref(null), mobl.ref(null), function(_, callback) {
        var root4845 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        var nodes4219 = $("<span>");
        root4845.append(nodes4219);
        subs__.addSub((mobl.label)(loadingMessage, mobl.ref(null), mobl.ref(null), function(_, callback) {
          var root4846 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root4846); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes4219;
          nodes4219 = node.contents();
          oldNodes.replaceWith(nodes4219);
        }));
        var nodes4220 = $("<span>");
        root4845.append(nodes4220);
        subs__.addSub((mobl.ui.generic.image)(mobl.ref("data:image/gif;base64,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"), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref(null), mobl.ref("middle"), mobl.ref(null), function(_, callback) {
          var root4847 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root4847); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes4220;
          nodes4220 = node.contents();
          oldNodes.replaceWith(nodes4220);
        }));
        callback(root4845); return subs__;
        
        
        return subs__;
      }, function(node) {
        var oldNodes = nodes4218;
        nodes4218 = node.contents();
        oldNodes.replaceWith(nodes4218);
      }));
      
      
    }
  };
  renderCond492();
  subs__.addSub(value.addEventListener('change', function() {
    renderCond492();
  }));
  
  callback(root4843); return subs__;
  
  return subs__;
};
mobl.ui.generic.headerStyle = 'mobl__ui__generic__headerStyle';
mobl.ui.generic.headerContainerStyle = 'mobl__ui__generic__headerContainerStyle';
mobl.ui.generic.headerTextStyle = 'mobl__ui__generic__headerTextStyle';

mobl.ui.generic.header = function(text, fixedPosition, onclick, elements, callback) {
  var root4848 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var node796 = $("<div>");
  
  var ref176 = mobl.ref(mobl.ui.generic.headerStyle);
  if(ref176.get() !== null) {
    node796.attr('class', ref176.get());
    subs__.addSub(ref176.addEventListener('change', function(_, ref, val) {
      node796.attr('class', val);
    }));
    
  }
  subs__.addSub(ref176.rebind());
  
  var val74 = onclick.get();
  if(val74 !== null) {
    subs__.addSub(mobl.domBind(node796, 'tap', val74));
  }
  
  var ref177 = mobl.ref(fixedPosition.get() ? "position:fixed;" : null);
  if(ref177.get() !== null) {
    node796.attr('style', ref177.get());
    subs__.addSub(ref177.addEventListener('change', function(_, ref, val) {
      node796.attr('style', val);
    }));
    subs__.addSub(fixedPosition.addEventListener('change', function() {
      node796.attr('style', fixedPosition.get() ? "position:fixed;" : null);
    }));
    
  }
  subs__.addSub(ref177.rebind());
  
  
  var node799 = $("<div>");
  
  var ref175 = mobl.ref(mobl.ui.generic.headerContainerStyle);
  if(ref175.get() !== null) {
    node799.attr('class', ref175.get());
    subs__.addSub(ref175.addEventListener('change', function(_, ref, val) {
      node799.attr('class', val);
    }));
    
  }
  subs__.addSub(ref175.rebind());
  
  
  var node800 = $("<div>");
  
  var ref173 = text;
  node800.text(""+ref173.get());
  var ignore28 = false;
  subs__.addSub(ref173.addEventListener('change', function(_, ref, val) {
    if(ignore28) return;
    node800.text(""+val);
  }));
  subs__.addSub(ref173.rebind());
  
  
  var ref174 = mobl.ref(mobl.ui.generic.headerTextStyle);
  if(ref174.get() !== null) {
    node800.attr('class', ref174.get());
    subs__.addSub(ref174.addEventListener('change', function(_, ref, val) {
      node800.attr('class', val);
    }));
    
  }
  subs__.addSub(ref174.rebind());
  
  node799.append(node800);
  node796.append(node799);
  var nodes4221 = $("<span>");
  node796.append(nodes4221);
  subs__.addSub(mobl.ref(elements).addEventListener('change', function() {
    renderControl53();
  }));
  
  function renderControl53() {
    subs__.addSub((elements)(function(elements, callback) {
      var root4849 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root4849); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes4221;
      nodes4221 = node.contents();
      oldNodes.replaceWith(nodes4221);
    }));
  }
  renderControl53();
  root4848.append(node796);
  
  var node797 = $("<span>");
  root4848.append(node797);
  var condSubs493 = new mobl.CompSubscription();
  subs__.addSub(condSubs493);
  var oldValue493;
  var renderCond493 = function() {
    var value553 = fixedPosition.get();
    if(oldValue493 === value553) return;
    oldValue493 = value553;
    var subs__ = condSubs493;
    subs__.unsubscribe();
    node797.empty();
    if(value553) {
      
      var node798 = $("<div>");
      node798.attr('id', "hello");
      node798.attr('style', "height: 2.9em;");
      
      node797.append(node798);
      
      
    } else {
      
    }
  };
  renderCond493();
  subs__.addSub(fixedPosition.addEventListener('change', function() {
    renderCond493();
  }));
  
  callback(root4848); return subs__;
  
  
  
  
  
  return subs__;
};
mobl.ui.generic.buttonStyle = 'mobl__ui__generic__buttonStyle';
mobl.ui.generic.buttonPushedStyle = 'mobl__ui__generic__buttonPushedStyle';
mobl.ui.generic.buttonStyle = 'mobl__ui__generic__buttonStyle';
mobl.ui.generic.buttonPushedStyle = 'mobl__ui__generic__buttonPushedStyle';

mobl.ui.generic.button = function(text, style, pushedStyle, onclick, elements, callback) {
  var root4850 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var pushed = mobl.ref(false);
  
  var sp = $("<span>");
  
  var ref178 = mobl.ref(pushed.get() ? pushedStyle.get() : style.get());
  if(ref178.get() !== null) {
    sp.attr('class', ref178.get());
    subs__.addSub(ref178.addEventListener('change', function(_, ref, val) {
      sp.attr('class', val);
    }));
    subs__.addSub(pushed.addEventListener('change', function() {
      sp.attr('class', pushed.get() ? pushedStyle.get() : style.get());
    }));
    subs__.addSub(pushedStyle.addEventListener('change', function() {
      sp.attr('class', pushed.get() ? pushedStyle.get() : style.get());
    }));
    subs__.addSub(style.addEventListener('change', function() {
      sp.attr('class', pushed.get() ? pushedStyle.get() : style.get());
    }));
    
  }
  subs__.addSub(ref178.rebind());
  
  var val75 = function(event, callback) {
                if(event && event.stopPropagation) event.stopPropagation();
                var result__ = event.preventDefault();
                var result__ = true;
                pushed.set(result__);
                if(callback && callback.apply) callback(); return;
              };
  if(val75 !== null) {
    subs__.addSub(mobl.domBind(sp, 'touchdown', val75));
  }
  
  var val76 = function(event, callback) {
                if(event && event.stopPropagation) event.stopPropagation();
                var result__ = event.y < 0 || event.y > sp.outerHeight() || event.x < 0 || event.x > sp.outerWidth();
                if(result__) {
                  var result__ = false;
                  pushed.set(result__);
                  if(callback && callback.apply) callback(); return;
                } else {
                  {
                    if(callback && callback.apply) callback(); return;
                  }
                }
              };
  if(val76 !== null) {
    subs__.addSub(mobl.domBind(sp, 'touchdrag', val76));
  }
  
  var val77 = function(event, callback) {
                if(event && event.stopPropagation) event.stopPropagation();
                var result__ = pushed.get();
                if(result__) {
                  var result__ = false;
                  pushed.set(result__);
                  function after26(result__) {
                    var tmp2664 = result__;
                    if(callback && callback.apply) callback(); return;
                  }
                  var result__ = onclick.get()(event, after26);if(result__ !== undefined) after26(result__);
                } else {
                  {
                    if(callback && callback.apply) callback(); return;
                  }
                }
              };
  if(val77 !== null) {
    subs__.addSub(mobl.domBind(sp, 'touchup', val77));
  }
  
  var val78 = function(event, callback) {
                if(event && event.stopPropagation) event.stopPropagation();
                var result__ = pushed.get();
                if(result__) {
                  var result__ = false;
                  pushed.set(result__);
                  if(callback && callback.apply) callback(); return;
                } else {
                  {
                    if(callback && callback.apply) callback(); return;
                  }
                }
              };
  if(val78 !== null) {
    subs__.addSub(mobl.domBind(sp, 'mouseout', val78));
  }
  
  var ref179 = text;
  sp.text(""+ref179.get());
  var ignore29 = false;
  subs__.addSub(ref179.addEventListener('change', function(_, ref, val) {
    if(ignore29) return;
    sp.text(""+val);
  }));
  subs__.addSub(ref179.rebind());
  
  
  root4850.append(sp);
  callback(root4850); return subs__;
  
  return subs__;
};
mobl.ui.generic.sideButtonStyle = 'mobl__ui__generic__sideButtonStyle';
mobl.ui.generic.sideButtonPushedStyle = 'mobl__ui__generic__sideButtonPushedStyle';

mobl.ui.generic.sideButton = function(text, style, pushedStyle, onclick, elements, callback) {
  var root4851 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  var nodes4222 = $("<span>");
  root4851.append(nodes4222);
  subs__.addSub((mobl.ui.generic.button)(text, style, pushedStyle, onclick, function(_, callback) {
    var root4852 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    callback(root4852); return subs__;
    return subs__;
  }, function(node) {
    var oldNodes = nodes4222;
    nodes4222 = node.contents();
    oldNodes.replaceWith(nodes4222);
  }));
  callback(root4851); return subs__;
  
  return subs__;
};
mobl.ui.generic.backButtonStyle = 'mobl__ui__generic__backButtonStyle';
mobl.ui.generic.backButtonPushedStyle = 'mobl__ui__generic__backButtonPushedStyle';
mobl.ui.generic.backButtonStyle = 'mobl__ui__generic__backButtonStyle';
mobl.ui.generic.backButtonPushedStyle = 'mobl__ui__generic__backButtonPushedStyle';

mobl.ui.generic.backButton = function(text, style, pushedStyle, onclick, elements, callback) {
  var root4853 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  var nodes4223 = $("<span>");
  root4853.append(nodes4223);
  subs__.addSub((mobl.ui.generic.button)(text, style, pushedStyle, onclick, function(_, callback) {
    var root4854 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    callback(root4854); return subs__;
    return subs__;
  }, function(node) {
    var oldNodes = nodes4223;
    nodes4223 = node.contents();
    oldNodes.replaceWith(nodes4223);
  }));
  callback(root4853); return subs__;
  
  return subs__;
};
mobl.ui.generic.groupStyle = 'mobl__ui__generic__groupStyle';

mobl.ui.generic.group = function(elements, callback) {
  var root4855 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var node801 = $("<ul>");
  
  var ref180 = mobl.ref(mobl.ui.generic.groupStyle);
  if(ref180.get() !== null) {
    node801.attr('class', ref180.get());
    subs__.addSub(ref180.addEventListener('change', function(_, ref, val) {
      node801.attr('class', val);
    }));
    
  }
  subs__.addSub(ref180.rebind());
  
  var nodes4224 = $("<span>");
  node801.append(nodes4224);
  subs__.addSub(mobl.ref(elements).addEventListener('change', function() {
    renderControl54();
  }));
  
  function renderControl54() {
    subs__.addSub((elements)(function(elements, callback) {
      var root4856 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root4856); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes4224;
      nodes4224 = node.contents();
      oldNodes.replaceWith(nodes4224);
    }));
  }
  renderControl54();
  root4855.append(node801);
  callback(root4855); return subs__;
  
  
  return subs__;
};

mobl.ui.generic.image = function(url, width, height, onclick, style, valign, align, elements, callback) {
  var root4857 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var node802 = $("<img>");
  
  var ref181 = url;
  if(ref181.get() !== null) {
    node802.attr('src', ref181.get());
    subs__.addSub(ref181.addEventListener('change', function(_, ref, val) {
      node802.attr('src', val);
    }));
    
  }
  subs__.addSub(ref181.rebind());
  
  var ref182 = width;
  if(ref182.get() !== null) {
    node802.attr('width', ref182.get());
    subs__.addSub(ref182.addEventListener('change', function(_, ref, val) {
      node802.attr('width', val);
    }));
    
  }
  subs__.addSub(ref182.rebind());
  
  var ref183 = height;
  if(ref183.get() !== null) {
    node802.attr('height', ref183.get());
    subs__.addSub(ref183.addEventListener('change', function(_, ref, val) {
      node802.attr('height', val);
    }));
    
  }
  subs__.addSub(ref183.rebind());
  
  var ref184 = style;
  if(ref184.get() !== null) {
    node802.attr('class', ref184.get());
    subs__.addSub(ref184.addEventListener('change', function(_, ref, val) {
      node802.attr('class', val);
    }));
    
  }
  subs__.addSub(ref184.rebind());
  
  var val79 = onclick.get();
  if(val79 !== null) {
    subs__.addSub(mobl.domBind(node802, 'tap', val79));
  }
  
  var ref185 = valign;
  if(ref185.get() !== null) {
    node802.attr('valign', ref185.get());
    subs__.addSub(ref185.addEventListener('change', function(_, ref, val) {
      node802.attr('valign', val);
    }));
    
  }
  subs__.addSub(ref185.rebind());
  
  var ref186 = align;
  if(ref186.get() !== null) {
    node802.attr('align', ref186.get());
    subs__.addSub(ref186.addEventListener('change', function(_, ref, val) {
      node802.attr('align', val);
    }));
    
  }
  subs__.addSub(ref186.rebind());
  
  root4857.append(node802);
  callback(root4857); return subs__;
  
  return subs__;
};
mobl.ui.generic.itemStyle = 'mobl__ui__generic__itemStyle';
mobl.ui.generic.itemPushedStyle = 'mobl__ui__generic__itemPushedStyle';
mobl.ui.generic.itemArrowStyle = 'mobl__ui__generic__itemArrowStyle';
mobl.ui.generic.itemDownArrowStyle = 'mobl__ui__generic__itemDownArrowStyle';

mobl.ui.generic.item = function(style, pushedStyle, onclick, onswipe, hideArrow, elements, callback) {
  var root4858 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var pushed = mobl.ref(false);
  
  var el = $("<li>");
  
  var ref187 = mobl.ref(mobl.ui.generic.itemStyle);
  if(ref187.get() !== null) {
    el.attr('class', ref187.get());
    subs__.addSub(ref187.addEventListener('change', function(_, ref, val) {
      el.attr('class', val);
    }));
    
  }
  subs__.addSub(ref187.rebind());
  
  var ref188 = mobl.ref(onclick.get() && hideArrow.get() == false ? mobl.mergeStyles([pushed.get() ? pushedStyle.get() : style.get(), mobl.ui.generic.itemArrowStyle]) : (pushed.get() ? pushedStyle.get() : style.get()));
  if(ref188.get() !== null) {
    el.attr('class', ref188.get());
    subs__.addSub(ref188.addEventListener('change', function(_, ref, val) {
      el.attr('class', val);
    }));
    subs__.addSub(onclick.addEventListener('change', function() {
      el.attr('class', onclick.get() && hideArrow.get() == false ? mobl.mergeStyles([pushed.get() ? pushedStyle.get() : style.get(), mobl.ui.generic.itemArrowStyle]) : (pushed.get() ? pushedStyle.get() : style.get()));
    }));
    subs__.addSub(hideArrow.addEventListener('change', function() {
      el.attr('class', onclick.get() && hideArrow.get() == false ? mobl.mergeStyles([pushed.get() ? pushedStyle.get() : style.get(), mobl.ui.generic.itemArrowStyle]) : (pushed.get() ? pushedStyle.get() : style.get()));
    }));
    subs__.addSub(mobl.ref(mobl.ui.generic.itemArrowStyle).addEventListener('change', function() {
      el.attr('class', onclick.get() && hideArrow.get() == false ? mobl.mergeStyles([pushed.get() ? pushedStyle.get() : style.get(), mobl.ui.generic.itemArrowStyle]) : (pushed.get() ? pushedStyle.get() : style.get()));
    }));
    subs__.addSub(pushed.addEventListener('change', function() {
      el.attr('class', onclick.get() && hideArrow.get() == false ? mobl.mergeStyles([pushed.get() ? pushedStyle.get() : style.get(), mobl.ui.generic.itemArrowStyle]) : (pushed.get() ? pushedStyle.get() : style.get()));
    }));
    subs__.addSub(pushedStyle.addEventListener('change', function() {
      el.attr('class', onclick.get() && hideArrow.get() == false ? mobl.mergeStyles([pushed.get() ? pushedStyle.get() : style.get(), mobl.ui.generic.itemArrowStyle]) : (pushed.get() ? pushedStyle.get() : style.get()));
    }));
    subs__.addSub(style.addEventListener('change', function() {
      el.attr('class', onclick.get() && hideArrow.get() == false ? mobl.mergeStyles([pushed.get() ? pushedStyle.get() : style.get(), mobl.ui.generic.itemArrowStyle]) : (pushed.get() ? pushedStyle.get() : style.get()));
    }));
    
  }
  subs__.addSub(ref188.rebind());
  
  var val80 = onswipe.get();
  if(val80 !== null) {
    subs__.addSub(mobl.domBind(el, 'swipe', val80));
  }
  
  var val81 = onclick.get() ? function(event, callback) {
                                         if(event && event.stopPropagation) event.stopPropagation();
                                         var result__ = true;
                                         pushed.set(result__);
                                         mobl.sleep(100, function(result__) {
                                           var tmp2665 = result__;
                                           function after27(result__) {
                                             var tmp2666 = result__;
                                             
                                           }
                                           var result__ = onclick.get()(event, after27);if(result__ !== undefined) after27(result__);
                                           mobl.sleep(200, function(result__) {
                                             var tmp2667 = result__;
                                             var result__ = false;
                                             pushed.set(result__);
                                             if(callback && callback.apply) callback(); return;
                                           });
                                           
                                         });
                                       } : null;
  if(val81 !== null) {
    subs__.addSub(mobl.domBind(el, 'tap', val81));
  }
  
  var nodes4225 = $("<span>");
  el.append(nodes4225);
  subs__.addSub(mobl.ref(elements).addEventListener('change', function() {
    renderControl55();
  }));
  
  function renderControl55() {
    subs__.addSub((elements)(function(elements, callback) {
      var root4859 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root4859); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes4225;
      nodes4225 = node.contents();
      oldNodes.replaceWith(nodes4225);
    }));
  }
  renderControl55();
  root4858.append(el);
  callback(root4858); return subs__;
  
  
  return subs__;
};

mobl.ui.generic.checkBox = function(b, label, onchange, elements, callback) {
  var root4860 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var node803 = $("<input>");
  node803.attr('type', "checkbox");
  
  var ref190 = b;
  node803.attr('checked', !!ref190.get());
  subs__.addSub(ref190.addEventListener('change', function(_, ref, val) {
    if(ref === ref190) node803.attr('checked', !!val);
  }));
  subs__.addSub(mobl.domBind(node803, 'change', function() {
    b.set(!!node803.attr('checked'));
  }));
  
  var val83 = function(event, callback) {
                if(event && event.stopPropagation) event.stopPropagation();
                if(callback && callback.apply) callback(); return;
              };
  if(val83 !== null) {
    subs__.addSub(mobl.domBind(node803, 'tap', val83));
  }
  
  var val84 = onchange.get();
  if(val84 !== null) {
    subs__.addSub(mobl.domBind(node803, 'change', val84));
  }
  
  root4860.append(node803);
  
  root4860.append(" ");
  
  var node804 = $("<span>");
  
  var ref189 = label;
  node804.text(""+ref189.get());
  var ignore30 = false;
  subs__.addSub(ref189.addEventListener('change', function(_, ref, val) {
    if(ignore30) return;
    node804.text(""+val);
  }));
  subs__.addSub(ref189.rebind());
  
  
  var val82 = function(event, callback) {
                if(event && event.stopPropagation) event.stopPropagation();
                var result__ = !b.get();
                b.set(result__);
                var result__ = onchange.get();
                if(result__) {
                  function after28(result__) {
                    var tmp2668 = result__;
                    if(callback && callback.apply) callback(); return;
                  }
                  var result__ = onchange.get()(null, after28);if(result__ !== undefined) after28(result__);
                } else {
                  {
                    if(callback && callback.apply) callback(); return;
                  }
                }
              };
  if(val82 !== null) {
    subs__.addSub(mobl.domBind(node804, 'tap', val82));
  }
  
  root4860.append(node804);
  callback(root4860); return subs__;
  
  
  return subs__;
};
mobl.ui.generic.textFieldStyle = 'mobl__ui__generic__textFieldStyle';
mobl.ui.generic.textFieldInvalidStyle = 'mobl__ui__generic__textFieldInvalidStyle';
mobl.ui.generic.textFieldLabelStyle = 'mobl__ui__generic__textFieldLabelStyle';
mobl.ui.generic.validationMessageStyle = 'mobl__ui__generic__validationMessageStyle';
mobl.ui.generic.alwaysOkValidator = function(s) {
   var __this = this;
  return "";
};


mobl.ui.generic.textField = function(s, placeholder, label, inputType, validator, style, invalidStyle, autofocus, autocorrect, autocapitalize, autocomplete, onchange, onkeyup, elements, callback) {
  var root4861 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var node805 = $("<span>");
  root4861.append(node805);
  var condSubs494 = new mobl.CompSubscription();
  subs__.addSub(condSubs494);
  var oldValue494;
  var renderCond494 = function() {
    var value554 = label.get();
    if(oldValue494 === value554) return;
    oldValue494 = value554;
    var subs__ = condSubs494;
    subs__.unsubscribe();
    node805.empty();
    if(value554) {
      var nodes4226 = $("<span>");
      node805.append(nodes4226);
      subs__.addSub((mobl.label)(label, mobl.ref(mobl.ui.generic.textFieldLabelStyle), mobl.ref(null), function(_, callback) {
        var root4862 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        callback(root4862); return subs__;
        return subs__;
      }, function(node) {
        var oldNodes = nodes4226;
        nodes4226 = node.contents();
        oldNodes.replaceWith(nodes4226);
      }));
      
      
    } else {
      
    }
  };
  renderCond494();
  subs__.addSub(label.addEventListener('change', function() {
    renderCond494();
  }));
  
  
  var node806 = $("<span>");
  root4861.append(node806);
  var condSubs495 = new mobl.CompSubscription();
  subs__.addSub(condSubs495);
  var oldValue495;
  var renderCond495 = function() {
    var value555 = validator.get();
    if(oldValue495 === value555) return;
    oldValue495 = value555;
    var subs__ = condSubs495;
    subs__.unsubscribe();
    node806.empty();
    if(value555) {
      
      var temp = mobl.ref(s.get());
      
      var identifier = mobl.ref(mobl.random(999));
      function after32(result__) {
        var tmp2669 = result__;
        var validationMessage = mobl.ref(result__);
        mobl.sleep(200, function(result__) {
          var tmp2670 = result__;
          var result__ = mobl.setValidationError(identifier.get(), !validationMessage.get());
          
        });
        
        var node807 = $("<input>");
        
        var ref191 = inputType;
        if(ref191.get() !== null) {
          node807.attr('type', ref191.get());
          subs__.addSub(ref191.addEventListener('change', function(_, ref, val) {
            node807.attr('type', val);
          }));
          
        }
        subs__.addSub(ref191.rebind());
        
        var ref192 = mobl.ref(validationMessage.get() ? invalidStyle.get() : style.get());
        if(ref192.get() !== null) {
          node807.attr('class', ref192.get());
          subs__.addSub(ref192.addEventListener('change', function(_, ref, val) {
            node807.attr('class', val);
          }));
          subs__.addSub(validationMessage.addEventListener('change', function() {
            node807.attr('class', validationMessage.get() ? invalidStyle.get() : style.get());
          }));
          subs__.addSub(invalidStyle.addEventListener('change', function() {
            node807.attr('class', validationMessage.get() ? invalidStyle.get() : style.get());
          }));
          subs__.addSub(style.addEventListener('change', function() {
            node807.attr('class', validationMessage.get() ? invalidStyle.get() : style.get());
          }));
          
        }
        subs__.addSub(ref192.rebind());
        
        var ref193 = placeholder;
        if(ref193.get() !== null) {
          node807.attr('placeholder', ref193.get());
          subs__.addSub(ref193.addEventListener('change', function(_, ref, val) {
            node807.attr('placeholder', val);
          }));
          
        }
        subs__.addSub(ref193.rebind());
        
        var ref194 = temp;
        node807.val(""+ref194.get());
        var ignore31 = false;
        subs__.addSub(ref194.addEventListener('change', function(_, ref, val) {
          if(ignore31) return;
          node807.val(""+val);
        }));
        subs__.addSub(ref194.rebind());
        
        subs__.addSub(mobl.domBind(node807, 'keyup change', function() {
          ignore31 = true;
          temp.set(mobl.stringTomobl__String(node807.val()));
          ignore31 = false;
        }));
        
        
        var val85 = onchange.get();
        if(val85 !== null) {
          subs__.addSub(mobl.domBind(node807, 'change', val85));
        }
        
        var val86 = function(event, callback) {
                      if(event && event.stopPropagation) event.stopPropagation();
                      var result__ = onkeyup.get();
                      if(result__) {
                        function after29(result__) {
                          var tmp2671 = result__;
                          function after30(result__) {
                            var tmp2672 = result__;
                            var result__ = tmp2672;
                            validationMessage.set(result__);
                            var result__ = !validationMessage.get();
                            if(result__) {
                              var result__ = temp.get();
                              s.set(result__);
                              var result__ = mobl.setValidationError(identifier.get(), !validationMessage.get());
                              if(callback && callback.apply) callback(); return;
                            } else {
                              {
                                var result__ = mobl.setValidationError(identifier.get(), !validationMessage.get());
                                if(callback && callback.apply) callback(); return;
                              }
                            }
                          }
                          var result__ = validator.get()(temp.get(), after30);if(result__ !== undefined) after30(result__);
                        }
                        var result__ = onkeyup.get()(event, after29);if(result__ !== undefined) after29(result__);
                      } else {
                        {
                          function after31(result__) {
                            var tmp2672 = result__;
                            var result__ = tmp2672;
                            validationMessage.set(result__);
                            var result__ = !validationMessage.get();
                            if(result__) {
                              var result__ = temp.get();
                              s.set(result__);
                              var result__ = mobl.setValidationError(identifier.get(), !validationMessage.get());
                              if(callback && callback.apply) callback(); return;
                            } else {
                              {
                                var result__ = mobl.setValidationError(identifier.get(), !validationMessage.get());
                                if(callback && callback.apply) callback(); return;
                              }
                            }
                          }
                          var result__ = validator.get()(temp.get(), after31);if(result__ !== undefined) after31(result__);
                        }
                      }
                    };
        if(val86 !== null) {
          subs__.addSub(mobl.domBind(node807, 'keyup', val86));
        }
        
        var ref195 = autofocus;
        if(ref195.get() !== null) {
          node807.attr('autofocus', ref195.get());
          subs__.addSub(ref195.addEventListener('change', function(_, ref, val) {
            node807.attr('autofocus', val);
          }));
          
        }
        subs__.addSub(ref195.rebind());
        
        var ref196 = autocorrect;
        if(ref196.get() !== null) {
          node807.attr('autocorrect', ref196.get());
          subs__.addSub(ref196.addEventListener('change', function(_, ref, val) {
            node807.attr('autocorrect', val);
          }));
          
        }
        subs__.addSub(ref196.rebind());
        
        var ref197 = autocapitalize;
        if(ref197.get() !== null) {
          node807.attr('autocapitalize', ref197.get());
          subs__.addSub(ref197.addEventListener('change', function(_, ref, val) {
            node807.attr('autocapitalize', val);
          }));
          
        }
        subs__.addSub(ref197.rebind());
        
        var ref198 = autocomplete;
        if(ref198.get() !== null) {
          node807.attr('autocomplete', ref198.get());
          subs__.addSub(ref198.addEventListener('change', function(_, ref, val) {
            node807.attr('autocomplete', val);
          }));
          
        }
        subs__.addSub(ref198.rebind());
        
        node806.append(node807);
        var nodes4227 = $("<span>");
        node806.append(nodes4227);
        subs__.addSub((mobl.label)(validationMessage, mobl.ref(mobl.ui.generic.validationMessageStyle), mobl.ref(null), function(_, callback) {
          var root4863 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root4863); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes4227;
          nodes4227 = node.contents();
          oldNodes.replaceWith(nodes4227);
        }));
        
        
        
        
      }
      var result__ = validator.get()(s.get(), after32);if(result__ !== undefined) after32(result__);
    } else {
      
      var node808 = $("<input>");
      
      var ref199 = inputType;
      if(ref199.get() !== null) {
        node808.attr('type', ref199.get());
        subs__.addSub(ref199.addEventListener('change', function(_, ref, val) {
          node808.attr('type', val);
        }));
        
      }
      subs__.addSub(ref199.rebind());
      
      var ref200 = style;
      if(ref200.get() !== null) {
        node808.attr('class', ref200.get());
        subs__.addSub(ref200.addEventListener('change', function(_, ref, val) {
          node808.attr('class', val);
        }));
        
      }
      subs__.addSub(ref200.rebind());
      
      var ref201 = placeholder;
      if(ref201.get() !== null) {
        node808.attr('placeholder', ref201.get());
        subs__.addSub(ref201.addEventListener('change', function(_, ref, val) {
          node808.attr('placeholder', val);
        }));
        
      }
      subs__.addSub(ref201.rebind());
      
      var ref202 = s;
      node808.val(""+ref202.get());
      var ignore32 = false;
      subs__.addSub(ref202.addEventListener('change', function(_, ref, val) {
        if(ignore32) return;
        node808.val(""+val);
      }));
      subs__.addSub(ref202.rebind());
      
      subs__.addSub(mobl.domBind(node808, 'keyup change', function() {
        ignore32 = true;
        s.set(mobl.stringTomobl__String(node808.val()));
        ignore32 = false;
      }));
      
      
      var val87 = onchange.get();
      if(val87 !== null) {
        subs__.addSub(mobl.domBind(node808, 'change', val87));
      }
      
      var val88 = onkeyup.get();
      if(val88 !== null) {
        subs__.addSub(mobl.domBind(node808, 'keyup', val88));
      }
      
      var ref203 = autofocus;
      if(ref203.get() !== null) {
        node808.attr('autofocus', ref203.get());
        subs__.addSub(ref203.addEventListener('change', function(_, ref, val) {
          node808.attr('autofocus', val);
        }));
        
      }
      subs__.addSub(ref203.rebind());
      
      var ref204 = autocorrect;
      if(ref204.get() !== null) {
        node808.attr('autocorrect', ref204.get());
        subs__.addSub(ref204.addEventListener('change', function(_, ref, val) {
          node808.attr('autocorrect', val);
        }));
        
      }
      subs__.addSub(ref204.rebind());
      
      var ref205 = autocapitalize;
      if(ref205.get() !== null) {
        node808.attr('autocapitalize', ref205.get());
        subs__.addSub(ref205.addEventListener('change', function(_, ref, val) {
          node808.attr('autocapitalize', val);
        }));
        
      }
      subs__.addSub(ref205.rebind());
      
      var ref206 = autocomplete;
      if(ref206.get() !== null) {
        node808.attr('autocomplete', ref206.get());
        subs__.addSub(ref206.addEventListener('change', function(_, ref, val) {
          node808.attr('autocomplete', val);
        }));
        
      }
      subs__.addSub(ref206.rebind());
      
      node806.append(node808);
      
      
    }
  };
  renderCond495();
  subs__.addSub(validator.addEventListener('change', function() {
    renderCond495();
  }));
  
  callback(root4861); return subs__;
  
  
  return subs__;
};

mobl.ui.generic.emailField = function(s, placeholder, label, validator, style, invalidStyle, autofocus, onchange, onkeyup, elements, callback) {
  var root4864 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  var nodes4228 = $("<span>");
  root4864.append(nodes4228);
  subs__.addSub((mobl.ui.generic.textField)(s, placeholder, label, mobl.ref("email"), validator, style, invalidStyle, autofocus, mobl.ref(false), mobl.ref(false), mobl.ref(false), onchange, onkeyup, function(_, callback) {
    var root4865 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    callback(root4865); return subs__;
    return subs__;
  }, function(node) {
    var oldNodes = nodes4228;
    nodes4228 = node.contents();
    oldNodes.replaceWith(nodes4228);
  }));
  callback(root4864); return subs__;
  
  return subs__;
};

mobl.ui.generic.telField = function(phoneNumber, placeholder, label, validator, style, invalidStyle, autofocus, onchange, onkeyup, elements, callback) {
  var root4866 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  var nodes4229 = $("<span>");
  root4866.append(nodes4229);
  subs__.addSub((mobl.ui.generic.textField)(phoneNumber, placeholder, label, mobl.ref("tel"), validator, style, invalidStyle, autofocus, mobl.ref(false), mobl.ref(false), mobl.ref(false), onchange, onkeyup, function(_, callback) {
    var root4867 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    callback(root4867); return subs__;
    return subs__;
  }, function(node) {
    var oldNodes = nodes4229;
    nodes4229 = node.contents();
    oldNodes.replaceWith(nodes4229);
  }));
  callback(root4866); return subs__;
  
  return subs__;
};

mobl.ui.generic.rangeField = function(n, min, max, step, placeholder, label, onchange, onkeyup, elements, callback) {
  var root4868 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var node809 = $("<span>");
  root4868.append(node809);
  var condSubs496 = new mobl.CompSubscription();
  subs__.addSub(condSubs496);
  var oldValue496;
  var renderCond496 = function() {
    var value556 = label.get();
    if(oldValue496 === value556) return;
    oldValue496 = value556;
    var subs__ = condSubs496;
    subs__.unsubscribe();
    node809.empty();
    if(value556) {
      var nodes4230 = $("<span>");
      node809.append(nodes4230);
      subs__.addSub((mobl.label)(label, mobl.ref(mobl.ui.generic.textFieldLabelStyle), mobl.ref(null), function(_, callback) {
        var root4869 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        callback(root4869); return subs__;
        return subs__;
      }, function(node) {
        var oldNodes = nodes4230;
        nodes4230 = node.contents();
        oldNodes.replaceWith(nodes4230);
      }));
      
      
    } else {
      
    }
  };
  renderCond496();
  subs__.addSub(label.addEventListener('change', function() {
    renderCond496();
  }));
  
  
  var node810 = $("<input>");
  node810.attr('type', "range");
  
  var ref207 = n;
  node810.val(""+ref207.get());
  var ignore33 = false;
  subs__.addSub(ref207.addEventListener('change', function(_, ref, val) {
    if(ignore33) return;
    node810.val(""+val);
  }));
  subs__.addSub(ref207.rebind());
  
  subs__.addSub(mobl.domBind(node810, 'keyup change', function() {
    ignore33 = true;
    n.set(mobl.stringTomobl__Num(node810.val()));
    ignore33 = false;
  }));
  
  
  var ref208 = min;
  if(ref208.get() !== null) {
    node810.attr('min', ref208.get());
    subs__.addSub(ref208.addEventListener('change', function(_, ref, val) {
      node810.attr('min', val);
    }));
    
  }
  subs__.addSub(ref208.rebind());
  
  var ref209 = max;
  if(ref209.get() !== null) {
    node810.attr('max', ref209.get());
    subs__.addSub(ref209.addEventListener('change', function(_, ref, val) {
      node810.attr('max', val);
    }));
    
  }
  subs__.addSub(ref209.rebind());
  
  var ref210 = step;
  if(ref210.get() !== null) {
    node810.attr('step', ref210.get());
    subs__.addSub(ref210.addEventListener('change', function(_, ref, val) {
      node810.attr('step', val);
    }));
    
  }
  subs__.addSub(ref210.rebind());
  node810.attr('style', "width: 99%;");
  
  var val89 = onchange.get();
  if(val89 !== null) {
    subs__.addSub(mobl.domBind(node810, 'change', val89));
  }
  
  var val90 = onkeyup.get();
  if(val90 !== null) {
    subs__.addSub(mobl.domBind(node810, 'keyup', val90));
  }
  
  var ref211 = placeholder;
  if(ref211.get() !== null) {
    node810.attr('placeholder', ref211.get());
    subs__.addSub(ref211.addEventListener('change', function(_, ref, val) {
      node810.attr('placeholder', val);
    }));
    
  }
  subs__.addSub(ref211.rebind());
  
  root4868.append(node810);
  callback(root4868); return subs__;
  
  
  return subs__;
};

mobl.ui.generic.numField = function(n, label, placeholder, validator, style, invalidStyle, autofocus, step, min, max, onchange, onkeyup, elements, callback) {
  var root4870 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var validateNum = function(n) {
     var __this = this;
    if(mobl.Math.isNaN(n)) {
      return mobl._("Not a valid numeric value", []);
    } else if(max.get() != null && n > max.get()) {
      return mobl._("Number is too high, maximum is: %%", [max.get()]);
    } else if(min.get() != null && n < min.get()) {
      return mobl._("Number is too low, minimum is: %%", [min.get()]);
    } else {
      return "";
    }
  };
  
  
  var result__ = validator.get() == null;
  if(result__) {
    var result__ = validateNum;
    validator.set(result__);
    function after35(result__) {
      var tmp2673 = result__;
      var validationMessage = mobl.ref(result__);
      
      var node811 = $("<span>");
      root4870.append(node811);
      var condSubs497 = new mobl.CompSubscription();
      subs__.addSub(condSubs497);
      var oldValue497;
      var renderCond497 = function() {
        var value557 = label.get();
        if(oldValue497 === value557) return;
        oldValue497 = value557;
        var subs__ = condSubs497;
        subs__.unsubscribe();
        node811.empty();
        if(value557) {
          var nodes4231 = $("<span>");
          node811.append(nodes4231);
          subs__.addSub((mobl.label)(label, mobl.ref(mobl.ui.generic.textFieldLabelStyle), mobl.ref(null), function(_, callback) {
            var root4871 = $("<span>");
            var subs__ = new mobl.CompSubscription();
            callback(root4871); return subs__;
            return subs__;
          }, function(node) {
            var oldNodes = nodes4231;
            nodes4231 = node.contents();
            oldNodes.replaceWith(nodes4231);
          }));
          
          
        } else {
          
        }
      };
      renderCond497();
      subs__.addSub(label.addEventListener('change', function() {
        renderCond497();
      }));
      
      
      var node812 = $("<input>");
      node812.attr('type', "number");
      
      var ref212 = mobl.ref(validationMessage.get() ? invalidStyle.get() : style.get());
      if(ref212.get() !== null) {
        node812.attr('class', ref212.get());
        subs__.addSub(ref212.addEventListener('change', function(_, ref, val) {
          node812.attr('class', val);
        }));
        subs__.addSub(validationMessage.addEventListener('change', function() {
          node812.attr('class', validationMessage.get() ? invalidStyle.get() : style.get());
        }));
        subs__.addSub(invalidStyle.addEventListener('change', function() {
          node812.attr('class', validationMessage.get() ? invalidStyle.get() : style.get());
        }));
        subs__.addSub(style.addEventListener('change', function() {
          node812.attr('class', validationMessage.get() ? invalidStyle.get() : style.get());
        }));
        
      }
      subs__.addSub(ref212.rebind());
      
      var ref213 = placeholder;
      if(ref213.get() !== null) {
        node812.attr('placeholder', ref213.get());
        subs__.addSub(ref213.addEventListener('change', function(_, ref, val) {
          node812.attr('placeholder', val);
        }));
        
      }
      subs__.addSub(ref213.rebind());
      
      var ref214 = n;
      node812.val(""+ref214.get());
      var ignore34 = false;
      subs__.addSub(ref214.addEventListener('change', function(_, ref, val) {
        if(ignore34) return;
        node812.val(""+val);
      }));
      subs__.addSub(ref214.rebind());
      
      subs__.addSub(mobl.domBind(node812, 'keyup change', function() {
        ignore34 = true;
        n.set(mobl.stringTomobl__Num(node812.val()));
        ignore34 = false;
      }));
      
      
      var val91 = onchange.get();
      if(val91 !== null) {
        subs__.addSub(mobl.domBind(node812, 'change', val91));
      }
      
      var val92 = function(event, callback) {
                    if(event && event.stopPropagation) event.stopPropagation();
                    function after33(result__) {
                      var tmp2674 = result__;
                      var result__ = tmp2674;
                      validationMessage.set(result__);
                      var result__ = onkeyup.get();
                      if(result__) {
                        function after34(result__) {
                          var tmp2675 = result__;
                          if(callback && callback.apply) callback(); return;
                        }
                        var result__ = onkeyup.get()(event, after34);if(result__ !== undefined) after34(result__);
                      } else {
                        {
                          if(callback && callback.apply) callback(); return;
                        }
                      }
                    }
                    var result__ = validator.get()(n.get(), after33);if(result__ !== undefined) after33(result__);
                  };
      if(val92 !== null) {
        subs__.addSub(mobl.domBind(node812, 'keyup', val92));
      }
      
      var ref215 = autofocus;
      if(ref215.get() !== null) {
        node812.attr('autofocus', ref215.get());
        subs__.addSub(ref215.addEventListener('change', function(_, ref, val) {
          node812.attr('autofocus', val);
        }));
        
      }
      subs__.addSub(ref215.rebind());
      
      var ref216 = step;
      if(ref216.get() !== null) {
        node812.attr('step', ref216.get());
        subs__.addSub(ref216.addEventListener('change', function(_, ref, val) {
          node812.attr('step', val);
        }));
        
      }
      subs__.addSub(ref216.rebind());
      
      var ref217 = min;
      if(ref217.get() !== null) {
        node812.attr('min', ref217.get());
        subs__.addSub(ref217.addEventListener('change', function(_, ref, val) {
          node812.attr('min', val);
        }));
        
      }
      subs__.addSub(ref217.rebind());
      
      var ref218 = max;
      if(ref218.get() !== null) {
        node812.attr('max', ref218.get());
        subs__.addSub(ref218.addEventListener('change', function(_, ref, val) {
          node812.attr('max', val);
        }));
        
      }
      subs__.addSub(ref218.rebind());
      
      root4870.append(node812);
      var nodes4232 = $("<span>");
      root4870.append(nodes4232);
      subs__.addSub((mobl.label)(validationMessage, mobl.ref(mobl.ui.generic.validationMessageStyle), mobl.ref(null), function(_, callback) {
        var root4872 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        callback(root4872); return subs__;
        return subs__;
      }, function(node) {
        var oldNodes = nodes4232;
        nodes4232 = node.contents();
        oldNodes.replaceWith(nodes4232);
      }));
      callback(root4870); return subs__;
      
      
      
    }
    var result__ = validator.get()(n.get(), after35);if(result__ !== undefined) after35(result__);
  } else {
    {
      function after35(result__) {
        var tmp2673 = result__;
        var validationMessage = mobl.ref(result__);
        
        var node811 = $("<span>");
        root4870.append(node811);
        var condSubs497 = new mobl.CompSubscription();
        subs__.addSub(condSubs497);
        var oldValue497;
        var renderCond497 = function() {
          var value557 = label.get();
          if(oldValue497 === value557) return;
          oldValue497 = value557;
          var subs__ = condSubs497;
          subs__.unsubscribe();
          node811.empty();
          if(value557) {
            var nodes4231 = $("<span>");
            node811.append(nodes4231);
            subs__.addSub((mobl.label)(label, mobl.ref(mobl.ui.generic.textFieldLabelStyle), mobl.ref(null), function(_, callback) {
              var root4871 = $("<span>");
              var subs__ = new mobl.CompSubscription();
              callback(root4871); return subs__;
              return subs__;
            }, function(node) {
              var oldNodes = nodes4231;
              nodes4231 = node.contents();
              oldNodes.replaceWith(nodes4231);
            }));
            
            
          } else {
            
          }
        };
        renderCond497();
        subs__.addSub(label.addEventListener('change', function() {
          renderCond497();
        }));
        
        
        var node812 = $("<input>");
        node812.attr('type', "number");
        
        var ref212 = mobl.ref(validationMessage.get() ? invalidStyle.get() : style.get());
        if(ref212.get() !== null) {
          node812.attr('class', ref212.get());
          subs__.addSub(ref212.addEventListener('change', function(_, ref, val) {
            node812.attr('class', val);
          }));
          subs__.addSub(validationMessage.addEventListener('change', function() {
            node812.attr('class', validationMessage.get() ? invalidStyle.get() : style.get());
          }));
          subs__.addSub(invalidStyle.addEventListener('change', function() {
            node812.attr('class', validationMessage.get() ? invalidStyle.get() : style.get());
          }));
          subs__.addSub(style.addEventListener('change', function() {
            node812.attr('class', validationMessage.get() ? invalidStyle.get() : style.get());
          }));
          
        }
        subs__.addSub(ref212.rebind());
        
        var ref213 = placeholder;
        if(ref213.get() !== null) {
          node812.attr('placeholder', ref213.get());
          subs__.addSub(ref213.addEventListener('change', function(_, ref, val) {
            node812.attr('placeholder', val);
          }));
          
        }
        subs__.addSub(ref213.rebind());
        
        var ref214 = n;
        node812.val(""+ref214.get());
        var ignore34 = false;
        subs__.addSub(ref214.addEventListener('change', function(_, ref, val) {
          if(ignore34) return;
          node812.val(""+val);
        }));
        subs__.addSub(ref214.rebind());
        
        subs__.addSub(mobl.domBind(node812, 'keyup change', function() {
          ignore34 = true;
          n.set(mobl.stringTomobl__Num(node812.val()));
          ignore34 = false;
        }));
        
        
        var val91 = onchange.get();
        if(val91 !== null) {
          subs__.addSub(mobl.domBind(node812, 'change', val91));
        }
        
        var val92 = function(event, callback) {
                      if(event && event.stopPropagation) event.stopPropagation();
                      function after33(result__) {
                        var tmp2674 = result__;
                        var result__ = tmp2674;
                        validationMessage.set(result__);
                        var result__ = onkeyup.get();
                        if(result__) {
                          function after34(result__) {
                            var tmp2675 = result__;
                            if(callback && callback.apply) callback(); return;
                          }
                          var result__ = onkeyup.get()(event, after34);if(result__ !== undefined) after34(result__);
                        } else {
                          {
                            if(callback && callback.apply) callback(); return;
                          }
                        }
                      }
                      var result__ = validator.get()(n.get(), after33);if(result__ !== undefined) after33(result__);
                    };
        if(val92 !== null) {
          subs__.addSub(mobl.domBind(node812, 'keyup', val92));
        }
        
        var ref215 = autofocus;
        if(ref215.get() !== null) {
          node812.attr('autofocus', ref215.get());
          subs__.addSub(ref215.addEventListener('change', function(_, ref, val) {
            node812.attr('autofocus', val);
          }));
          
        }
        subs__.addSub(ref215.rebind());
        
        var ref216 = step;
        if(ref216.get() !== null) {
          node812.attr('step', ref216.get());
          subs__.addSub(ref216.addEventListener('change', function(_, ref, val) {
            node812.attr('step', val);
          }));
          
        }
        subs__.addSub(ref216.rebind());
        
        var ref217 = min;
        if(ref217.get() !== null) {
          node812.attr('min', ref217.get());
          subs__.addSub(ref217.addEventListener('change', function(_, ref, val) {
            node812.attr('min', val);
          }));
          
        }
        subs__.addSub(ref217.rebind());
        
        var ref218 = max;
        if(ref218.get() !== null) {
          node812.attr('max', ref218.get());
          subs__.addSub(ref218.addEventListener('change', function(_, ref, val) {
            node812.attr('max', val);
          }));
          
        }
        subs__.addSub(ref218.rebind());
        
        root4870.append(node812);
        var nodes4232 = $("<span>");
        root4870.append(nodes4232);
        subs__.addSub((mobl.label)(validationMessage, mobl.ref(mobl.ui.generic.validationMessageStyle), mobl.ref(null), function(_, callback) {
          var root4872 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root4872); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes4232;
          nodes4232 = node.contents();
          oldNodes.replaceWith(nodes4232);
        }));
        callback(root4870); return subs__;
        
        
        
      }
      var result__ = validator.get()(n.get(), after35);if(result__ !== undefined) after35(result__);
    }
  }
  return subs__;
};

mobl.ui.generic.passwordField = function(s, placeholder, label, style, onchange, onkeyup, elements, callback) {
  var root4873 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var node813 = $("<span>");
  root4873.append(node813);
  var condSubs498 = new mobl.CompSubscription();
  subs__.addSub(condSubs498);
  var oldValue498;
  var renderCond498 = function() {
    var value558 = label.get();
    if(oldValue498 === value558) return;
    oldValue498 = value558;
    var subs__ = condSubs498;
    subs__.unsubscribe();
    node813.empty();
    if(value558) {
      
      var node814 = $("<span>");
      node814.attr('style', "float: left; margin-top: 0.2em; width: 5em; color: #666;");
      
      var ref222 = label;
      node814.text(""+ref222.get());
      var ignore36 = false;
      subs__.addSub(ref222.addEventListener('change', function(_, ref, val) {
        if(ignore36) return;
        node814.text(""+val);
      }));
      subs__.addSub(ref222.rebind());
      
      
      node813.append(node814);
      
      var node815 = $("<span>");
      node815.attr('style', "float: left");
      
      
      var node816 = $("<input>");
      node816.attr('type', "password");
      
      var ref219 = style;
      if(ref219.get() !== null) {
        node816.attr('class', ref219.get());
        subs__.addSub(ref219.addEventListener('change', function(_, ref, val) {
          node816.attr('class', val);
        }));
        
      }
      subs__.addSub(ref219.rebind());
      
      var ref220 = placeholder;
      if(ref220.get() !== null) {
        node816.attr('placeholder', ref220.get());
        subs__.addSub(ref220.addEventListener('change', function(_, ref, val) {
          node816.attr('placeholder', val);
        }));
        
      }
      subs__.addSub(ref220.rebind());
      
      var ref221 = s;
      node816.val(""+ref221.get());
      var ignore35 = false;
      subs__.addSub(ref221.addEventListener('change', function(_, ref, val) {
        if(ignore35) return;
        node816.val(""+val);
      }));
      subs__.addSub(ref221.rebind());
      
      subs__.addSub(mobl.domBind(node816, 'keyup change', function() {
        ignore35 = true;
        s.set(mobl.stringTomobl__String(node816.val()));
        ignore35 = false;
      }));
      
      
      var val93 = onchange.get();
      if(val93 !== null) {
        subs__.addSub(mobl.domBind(node816, 'change', val93));
      }
      
      var val94 = onkeyup.get();
      if(val94 !== null) {
        subs__.addSub(mobl.domBind(node816, 'keyup', val94));
      }
      
      var val95 = function(event, callback) {
                    if(event && event.stopPropagation) event.stopPropagation();
                    var result__ = mobl.ui.generic.scrollUp();
                    if(callback && callback.apply) callback(); return;
                  };
      if(val95 !== null) {
        subs__.addSub(mobl.domBind(node816, 'blur', val95));
      }
      
      node815.append(node816);
      node813.append(node815);
      
      
      
      
    } else {
      
      var node817 = $("<input>");
      node817.attr('type', "password");
      
      var ref223 = style;
      if(ref223.get() !== null) {
        node817.attr('class', ref223.get());
        subs__.addSub(ref223.addEventListener('change', function(_, ref, val) {
          node817.attr('class', val);
        }));
        
      }
      subs__.addSub(ref223.rebind());
      
      var ref224 = placeholder;
      if(ref224.get() !== null) {
        node817.attr('placeholder', ref224.get());
        subs__.addSub(ref224.addEventListener('change', function(_, ref, val) {
          node817.attr('placeholder', val);
        }));
        
      }
      subs__.addSub(ref224.rebind());
      
      var ref225 = s;
      node817.val(""+ref225.get());
      var ignore37 = false;
      subs__.addSub(ref225.addEventListener('change', function(_, ref, val) {
        if(ignore37) return;
        node817.val(""+val);
      }));
      subs__.addSub(ref225.rebind());
      
      subs__.addSub(mobl.domBind(node817, 'keyup change', function() {
        ignore37 = true;
        s.set(mobl.stringTomobl__String(node817.val()));
        ignore37 = false;
      }));
      
      
      var val96 = onchange.get();
      if(val96 !== null) {
        subs__.addSub(mobl.domBind(node817, 'change', val96));
      }
      
      var val97 = onkeyup.get();
      if(val97 !== null) {
        subs__.addSub(mobl.domBind(node817, 'keyup', val97));
      }
      
      var val98 = function(event, callback) {
                    if(event && event.stopPropagation) event.stopPropagation();
                    var result__ = mobl.ui.generic.scrollUp();
                    if(callback && callback.apply) callback(); return;
                  };
      if(val98 !== null) {
        subs__.addSub(mobl.domBind(node817, 'blur', val98));
      }
      
      node813.append(node817);
      
      
    }
  };
  renderCond498();
  subs__.addSub(label.addEventListener('change', function() {
    renderCond498();
  }));
  
  callback(root4873); return subs__;
  
  return subs__;
};
mobl.ui.generic.selectFieldStyle = 'mobl__ui__generic__selectFieldStyle';

mobl.ui.generic.selectField = function(value, options, onchange, style, optionStyle, elements, callback) {
  var root4874 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var sel = $("<select>");
  
  var ref230 = style;
  if(ref230.get() !== null) {
    sel.attr('class', ref230.get());
    subs__.addSub(ref230.addEventListener('change', function(_, ref, val) {
      sel.attr('class', val);
    }));
    
  }
  subs__.addSub(ref230.rebind());
  
  var val99 = function(event, callback) {
                if(event && event.stopPropagation) event.stopPropagation();
                var result__ = sel.val();
                value.set(result__);
                var result__ = onchange.get();
                if(result__) {
                  function after36(result__) {
                    var tmp2677 = result__;
                    if(callback && callback.apply) callback(); return;
                  }
                  var result__ = onchange.get()(event, after36);if(result__ !== undefined) after36(result__);
                } else {
                  {
                    if(callback && callback.apply) callback(); return;
                  }
                }
              };
  if(val99 !== null) {
    subs__.addSub(mobl.domBind(sel, 'change', val99));
  }
  
  
  var node818 = mobl.loadingSpan();
  sel.append(node818);
  var list208;
  var listSubs208 = new mobl.CompSubscription();
  subs__.addSub(listSubs208);
  var renderList208 = function() {
    var subs__ = listSubs208;
    list208 = options.get();
    list208.list(function(results208) {
      node818.empty();
      for(var i285 = 0; i285 < results208.length; i285++) {
        (function() {
          var iternode208 = $("<span>");
          node818.append(iternode208);
          var optionValue;var optionDescription;
          optionValue = mobl.ref(mobl.ref(mobl.ref(results208), i285), "_1");optionDescription = mobl.ref(mobl.ref(mobl.ref(results208), i285), "_2");
          
          var node819 = $("<option>");
          
          var ref226 = optionDescription;
          node819.text(""+ref226.get());
          var ignore38 = false;
          subs__.addSub(ref226.addEventListener('change', function(_, ref, val) {
            if(ignore38) return;
            node819.text(""+val);
          }));
          subs__.addSub(ref226.rebind());
          
          
          var ref227 = optionStyle;
          if(ref227.get() !== null) {
            node819.attr('class', ref227.get());
            subs__.addSub(ref227.addEventListener('change', function(_, ref, val) {
              node819.attr('class', val);
            }));
            
          }
          subs__.addSub(ref227.rebind());
          
          var ref228 = optionValue;
          if(ref228.get() !== null) {
            node819.attr('value', ref228.get());
            subs__.addSub(ref228.addEventListener('change', function(_, ref, val) {
              node819.attr('value', val);
            }));
            
          }
          subs__.addSub(ref228.rebind());
          
          var ref229 = mobl.ref(value.get() == optionValue.get() ? "selected" : "");
          if(ref229.get() !== null) {
            node819.attr('selected', ref229.get());
            subs__.addSub(ref229.addEventListener('change', function(_, ref, val) {
              node819.attr('selected', val);
            }));
            subs__.addSub(value.addEventListener('change', function() {
              node819.attr('selected', value.get() == optionValue.get() ? "selected" : "");
            }));
            subs__.addSub(optionValue.addEventListener('change', function() {
              node819.attr('selected', value.get() == optionValue.get() ? "selected" : "");
            }));
            
          }
          subs__.addSub(ref229.rebind());
          
          iternode208.append(node819);
          
          var oldNodes = iternode208;
          iternode208 = iternode208.contents();
          oldNodes.replaceWith(iternode208);
          
          
        }());
      }
      mobl.delayedUpdateScrollers();
      subs__.addSub(list208.addEventListener('change', function() { listSubs208.unsubscribe(); renderList208(true); }));
      subs__.addSub(options.addEventListener('change', function() { listSubs208.unsubscribe(); renderList208(true); }));
    });
  };
  renderList208();
  
  root4874.append(sel);
  var result__ = sel.append(sel.children().eq(0).children());
  callback(root4874); return subs__;
  
  
  return subs__;
};
mobl.ui.generic.tabbarStyle = 'mobl__ui__generic__tabbarStyle';
mobl.ui.generic.inActiveTabButtonStyle = 'mobl__ui__generic__inActiveTabButtonStyle';
mobl.ui.generic.activeTabButtonStyle = 'mobl__ui__generic__activeTabButtonStyle';
mobl.ui.generic.inActiveTabStyle = 'mobl__ui__generic__inActiveTabStyle';
mobl.ui.generic.activeTabStyle = 'mobl__ui__generic__activeTabStyle';

mobl.ui.generic.tabSet = function(tabs, activeTab, screenContextId, elements, callback) {
  var root4875 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  var result__ = activeTab.get() == null;
  if(result__) {
    var result__ = tabs.get().get(0)._1;
    activeTab.set(result__);
    
    var s = mobl.ref("");
    var nodes4233 = $("<span>");
    root4875.append(nodes4233);
    subs__.addSub((mobl.block)(mobl.ref(mobl.ui.generic.tabbarStyle), mobl.ref(null), mobl.ref(null), mobl.ref(null), function(_, callback) {
      var root4876 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      
      var node820 = mobl.loadingSpan();
      root4876.append(node820);
      var list209;
      var listSubs209 = new mobl.CompSubscription();
      subs__.addSub(listSubs209);
      var renderList209 = function() {
        var subs__ = listSubs209;
        list209 = tabs.get();
        list209.list(function(results209) {
          node820.empty();
          for(var i286 = 0; i286 < results209.length; i286++) {
            (function() {
              var iternode209 = $("<span>");
              node820.append(iternode209);
              var tabName;var tabIcon;var tabControl;
              tabName = mobl.ref(mobl.ref(mobl.ref(results209), i286), "_1");tabIcon = mobl.ref(mobl.ref(mobl.ref(results209), i286), "_2");tabControl = mobl.ref(mobl.ref(mobl.ref(results209), i286), "_3");
              var result__ = activeTab.get() == tabName.get() ? mobl.ui.generic.activeTabButtonStyle : mobl.ui.generic.inActiveTabButtonStyle;
              var tmp2642 = mobl.ref(result__);
              subs__.addSub(activeTab.addEventListener('change', function() {
                tmp2642.set(activeTab.get() == tabName.get() ? mobl.ui.generic.activeTabButtonStyle : mobl.ui.generic.inActiveTabButtonStyle);
              }));
              subs__.addSub(tabName.addEventListener('change', function() {
                tmp2642.set(activeTab.get() == tabName.get() ? mobl.ui.generic.activeTabButtonStyle : mobl.ui.generic.inActiveTabButtonStyle);
              }));
              subs__.addSub(mobl.ref(mobl.ui.generic.activeTabButtonStyle).addEventListener('change', function() {
                tmp2642.set(activeTab.get() == tabName.get() ? mobl.ui.generic.activeTabButtonStyle : mobl.ui.generic.inActiveTabButtonStyle);
              }));
              subs__.addSub(mobl.ref(mobl.ui.generic.inActiveTabButtonStyle).addEventListener('change', function() {
                tmp2642.set(activeTab.get() == tabName.get() ? mobl.ui.generic.activeTabButtonStyle : mobl.ui.generic.inActiveTabButtonStyle);
              }));
              
              var result__ = function(event, callback) {
                               if(event && event.stopPropagation) event.stopPropagation();
                               var result__ = tabName.get();
                               activeTab.set(result__);
                               if(callback && callback.apply) callback(); return;
                             };
              var tmp2641 = mobl.ref(result__);
              
              var nodes4234 = $("<span>");
              iternode209.append(nodes4234);
              subs__.addSub((mobl.span)(tmp2642, mobl.ref(null), tmp2641, mobl.ref(null), function(_, callback) {
                var root4877 = $("<span>");
                var subs__ = new mobl.CompSubscription();
                var nodes4235 = $("<span>");
                root4877.append(nodes4235);
                subs__.addSub((mobl.label)(tabName, mobl.ref(null), mobl.ref(null), function(_, callback) {
                  var root4878 = $("<span>");
                  var subs__ = new mobl.CompSubscription();
                  callback(root4878); return subs__;
                  return subs__;
                }, function(node) {
                  var oldNodes = nodes4235;
                  nodes4235 = node.contents();
                  oldNodes.replaceWith(nodes4235);
                }));
                callback(root4877); return subs__;
                
                return subs__;
              }, function(node) {
                var oldNodes = nodes4234;
                nodes4234 = node.contents();
                oldNodes.replaceWith(nodes4234);
              }));
              
              var oldNodes = iternode209;
              iternode209 = iternode209.contents();
              oldNodes.replaceWith(iternode209);
              
              
            }());
          }
          mobl.delayedUpdateScrollers();
          subs__.addSub(list209.addEventListener('change', function() { listSubs209.unsubscribe(); renderList209(true); }));
          subs__.addSub(tabs.addEventListener('change', function() { listSubs209.unsubscribe(); renderList209(true); }));
        });
      };
      renderList209();
      
      callback(root4876); return subs__;
      
      return subs__;
    }, function(node) {
      var oldNodes = nodes4233;
      nodes4233 = node.contents();
      oldNodes.replaceWith(nodes4233);
    }));
    
    var node821 = mobl.loadingSpan();
    root4875.append(node821);
    var list210;
    var listSubs210 = new mobl.CompSubscription();
    subs__.addSub(listSubs210);
    var renderList210 = function() {
      var subs__ = listSubs210;
      list210 = tabs.get();
      list210.list(function(results210) {
        node821.empty();
        for(var i287 = 0; i287 < results210.length; i287++) {
          (function() {
            var iternode210 = $("<span>");
            node821.append(iternode210);
            var tabName;var tabIcon;var tabControl;
            tabName = mobl.ref(mobl.ref(mobl.ref(results210), i287), "_1");tabIcon = mobl.ref(mobl.ref(mobl.ref(results210), i287), "_2");tabControl = mobl.ref(mobl.ref(mobl.ref(results210), i287), "_3");
            var result__ = activeTab.get() == tabName.get() ? mobl.ui.generic.activeTabStyle : mobl.ui.generic.inActiveTabStyle;
            var tmp2643 = mobl.ref(result__);
            subs__.addSub(activeTab.addEventListener('change', function() {
              tmp2643.set(activeTab.get() == tabName.get() ? mobl.ui.generic.activeTabStyle : mobl.ui.generic.inActiveTabStyle);
            }));
            subs__.addSub(tabName.addEventListener('change', function() {
              tmp2643.set(activeTab.get() == tabName.get() ? mobl.ui.generic.activeTabStyle : mobl.ui.generic.inActiveTabStyle);
            }));
            subs__.addSub(mobl.ref(mobl.ui.generic.activeTabStyle).addEventListener('change', function() {
              tmp2643.set(activeTab.get() == tabName.get() ? mobl.ui.generic.activeTabStyle : mobl.ui.generic.inActiveTabStyle);
            }));
            subs__.addSub(mobl.ref(mobl.ui.generic.inActiveTabStyle).addEventListener('change', function() {
              tmp2643.set(activeTab.get() == tabName.get() ? mobl.ui.generic.activeTabStyle : mobl.ui.generic.inActiveTabStyle);
            }));
            
            var nodes4236 = $("<span>");
            iternode210.append(nodes4236);
            subs__.addSub((mobl.block)(tmp2643, mobl.ref(null), mobl.ref(null), mobl.ref(null), function(_, callback) {
              var root4879 = $("<span>");
              var subs__ = new mobl.CompSubscription();
              var nodes4237 = $("<span>");
              root4879.append(nodes4237);
              subs__.addSub((mobl.screenContext)(screenContextId, function(_, callback) {
                var root4880 = $("<span>");
                var subs__ = new mobl.CompSubscription();
                var nodes4238 = $("<span>");
                root4880.append(nodes4238);
                subs__.addSub(tabControl.addEventListener('change', function() {
                  renderControl56();
                }));
                
                function renderControl56() {
                  subs__.addSub((tabControl.get())(function(elements, callback) {
                    var root4881 = $("<span>");
                    var subs__ = new mobl.CompSubscription();
                    callback(root4881); return subs__;
                    return subs__;
                  }, function(node) {
                    var oldNodes = nodes4238;
                    nodes4238 = node.contents();
                    oldNodes.replaceWith(nodes4238);
                  }));
                }
                renderControl56();
                callback(root4880); return subs__;
                
                return subs__;
              }, function(node) {
                var oldNodes = nodes4237;
                nodes4237 = node.contents();
                oldNodes.replaceWith(nodes4237);
              }));
              callback(root4879); return subs__;
              
              return subs__;
            }, function(node) {
              var oldNodes = nodes4236;
              nodes4236 = node.contents();
              oldNodes.replaceWith(nodes4236);
            }));
            
            var oldNodes = iternode210;
            iternode210 = iternode210.contents();
            oldNodes.replaceWith(iternode210);
            
            
          }());
        }
        mobl.delayedUpdateScrollers();
        subs__.addSub(list210.addEventListener('change', function() { listSubs210.unsubscribe(); renderList210(true); }));
        subs__.addSub(tabs.addEventListener('change', function() { listSubs210.unsubscribe(); renderList210(true); }));
      });
    };
    renderList210();
    
    callback(root4875); return subs__;
    
    
  } else {
    {
      
      var s = mobl.ref("");
      var nodes4233 = $("<span>");
      root4875.append(nodes4233);
      subs__.addSub((mobl.block)(mobl.ref(mobl.ui.generic.tabbarStyle), mobl.ref(null), mobl.ref(null), mobl.ref(null), function(_, callback) {
        var root4876 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        
        var node820 = mobl.loadingSpan();
        root4876.append(node820);
        var list209;
        var listSubs209 = new mobl.CompSubscription();
        subs__.addSub(listSubs209);
        var renderList209 = function() {
          var subs__ = listSubs209;
          list209 = tabs.get();
          list209.list(function(results209) {
            node820.empty();
            for(var i286 = 0; i286 < results209.length; i286++) {
              (function() {
                var iternode209 = $("<span>");
                node820.append(iternode209);
                var tabName;var tabIcon;var tabControl;
                tabName = mobl.ref(mobl.ref(mobl.ref(results209), i286), "_1");tabIcon = mobl.ref(mobl.ref(mobl.ref(results209), i286), "_2");tabControl = mobl.ref(mobl.ref(mobl.ref(results209), i286), "_3");
                var result__ = activeTab.get() == tabName.get() ? mobl.ui.generic.activeTabButtonStyle : mobl.ui.generic.inActiveTabButtonStyle;
                var tmp2642 = mobl.ref(result__);
                subs__.addSub(activeTab.addEventListener('change', function() {
                  tmp2642.set(activeTab.get() == tabName.get() ? mobl.ui.generic.activeTabButtonStyle : mobl.ui.generic.inActiveTabButtonStyle);
                }));
                subs__.addSub(tabName.addEventListener('change', function() {
                  tmp2642.set(activeTab.get() == tabName.get() ? mobl.ui.generic.activeTabButtonStyle : mobl.ui.generic.inActiveTabButtonStyle);
                }));
                subs__.addSub(mobl.ref(mobl.ui.generic.activeTabButtonStyle).addEventListener('change', function() {
                  tmp2642.set(activeTab.get() == tabName.get() ? mobl.ui.generic.activeTabButtonStyle : mobl.ui.generic.inActiveTabButtonStyle);
                }));
                subs__.addSub(mobl.ref(mobl.ui.generic.inActiveTabButtonStyle).addEventListener('change', function() {
                  tmp2642.set(activeTab.get() == tabName.get() ? mobl.ui.generic.activeTabButtonStyle : mobl.ui.generic.inActiveTabButtonStyle);
                }));
                
                var result__ = function(event, callback) {
                                 if(event && event.stopPropagation) event.stopPropagation();
                                 var result__ = tabName.get();
                                 activeTab.set(result__);
                                 if(callback && callback.apply) callback(); return;
                               };
                var tmp2641 = mobl.ref(result__);
                
                var nodes4234 = $("<span>");
                iternode209.append(nodes4234);
                subs__.addSub((mobl.span)(tmp2642, mobl.ref(null), tmp2641, mobl.ref(null), function(_, callback) {
                  var root4877 = $("<span>");
                  var subs__ = new mobl.CompSubscription();
                  var nodes4235 = $("<span>");
                  root4877.append(nodes4235);
                  subs__.addSub((mobl.label)(tabName, mobl.ref(null), mobl.ref(null), function(_, callback) {
                    var root4878 = $("<span>");
                    var subs__ = new mobl.CompSubscription();
                    callback(root4878); return subs__;
                    return subs__;
                  }, function(node) {
                    var oldNodes = nodes4235;
                    nodes4235 = node.contents();
                    oldNodes.replaceWith(nodes4235);
                  }));
                  callback(root4877); return subs__;
                  
                  return subs__;
                }, function(node) {
                  var oldNodes = nodes4234;
                  nodes4234 = node.contents();
                  oldNodes.replaceWith(nodes4234);
                }));
                
                var oldNodes = iternode209;
                iternode209 = iternode209.contents();
                oldNodes.replaceWith(iternode209);
                
                
              }());
            }
            mobl.delayedUpdateScrollers();
            subs__.addSub(list209.addEventListener('change', function() { listSubs209.unsubscribe(); renderList209(true); }));
            subs__.addSub(tabs.addEventListener('change', function() { listSubs209.unsubscribe(); renderList209(true); }));
          });
        };
        renderList209();
        
        callback(root4876); return subs__;
        
        return subs__;
      }, function(node) {
        var oldNodes = nodes4233;
        nodes4233 = node.contents();
        oldNodes.replaceWith(nodes4233);
      }));
      
      var node821 = mobl.loadingSpan();
      root4875.append(node821);
      var list210;
      var listSubs210 = new mobl.CompSubscription();
      subs__.addSub(listSubs210);
      var renderList210 = function() {
        var subs__ = listSubs210;
        list210 = tabs.get();
        list210.list(function(results210) {
          node821.empty();
          for(var i287 = 0; i287 < results210.length; i287++) {
            (function() {
              var iternode210 = $("<span>");
              node821.append(iternode210);
              var tabName;var tabIcon;var tabControl;
              tabName = mobl.ref(mobl.ref(mobl.ref(results210), i287), "_1");tabIcon = mobl.ref(mobl.ref(mobl.ref(results210), i287), "_2");tabControl = mobl.ref(mobl.ref(mobl.ref(results210), i287), "_3");
              var result__ = activeTab.get() == tabName.get() ? mobl.ui.generic.activeTabStyle : mobl.ui.generic.inActiveTabStyle;
              var tmp2643 = mobl.ref(result__);
              subs__.addSub(activeTab.addEventListener('change', function() {
                tmp2643.set(activeTab.get() == tabName.get() ? mobl.ui.generic.activeTabStyle : mobl.ui.generic.inActiveTabStyle);
              }));
              subs__.addSub(tabName.addEventListener('change', function() {
                tmp2643.set(activeTab.get() == tabName.get() ? mobl.ui.generic.activeTabStyle : mobl.ui.generic.inActiveTabStyle);
              }));
              subs__.addSub(mobl.ref(mobl.ui.generic.activeTabStyle).addEventListener('change', function() {
                tmp2643.set(activeTab.get() == tabName.get() ? mobl.ui.generic.activeTabStyle : mobl.ui.generic.inActiveTabStyle);
              }));
              subs__.addSub(mobl.ref(mobl.ui.generic.inActiveTabStyle).addEventListener('change', function() {
                tmp2643.set(activeTab.get() == tabName.get() ? mobl.ui.generic.activeTabStyle : mobl.ui.generic.inActiveTabStyle);
              }));
              
              var nodes4236 = $("<span>");
              iternode210.append(nodes4236);
              subs__.addSub((mobl.block)(tmp2643, mobl.ref(null), mobl.ref(null), mobl.ref(null), function(_, callback) {
                var root4879 = $("<span>");
                var subs__ = new mobl.CompSubscription();
                var nodes4237 = $("<span>");
                root4879.append(nodes4237);
                subs__.addSub((mobl.screenContext)(screenContextId, function(_, callback) {
                  var root4880 = $("<span>");
                  var subs__ = new mobl.CompSubscription();
                  var nodes4238 = $("<span>");
                  root4880.append(nodes4238);
                  subs__.addSub(tabControl.addEventListener('change', function() {
                    renderControl56();
                  }));
                  
                  function renderControl56() {
                    subs__.addSub((tabControl.get())(function(elements, callback) {
                      var root4881 = $("<span>");
                      var subs__ = new mobl.CompSubscription();
                      callback(root4881); return subs__;
                      return subs__;
                    }, function(node) {
                      var oldNodes = nodes4238;
                      nodes4238 = node.contents();
                      oldNodes.replaceWith(nodes4238);
                    }));
                  }
                  renderControl56();
                  callback(root4880); return subs__;
                  
                  return subs__;
                }, function(node) {
                  var oldNodes = nodes4237;
                  nodes4237 = node.contents();
                  oldNodes.replaceWith(nodes4237);
                }));
                callback(root4879); return subs__;
                
                return subs__;
              }, function(node) {
                var oldNodes = nodes4236;
                nodes4236 = node.contents();
                oldNodes.replaceWith(nodes4236);
              }));
              
              var oldNodes = iternode210;
              iternode210 = iternode210.contents();
              oldNodes.replaceWith(iternode210);
              
              
            }());
          }
          mobl.delayedUpdateScrollers();
          subs__.addSub(list210.addEventListener('change', function() { listSubs210.unsubscribe(); renderList210(true); }));
          subs__.addSub(tabs.addEventListener('change', function() { listSubs210.unsubscribe(); renderList210(true); }));
        });
      };
      renderList210();
      
      callback(root4875); return subs__;
      
      
    }
  }
  return subs__;
};
mobl.ui.generic.searchboxStyle = 'mobl__ui__generic__searchboxStyle';
mobl.ui.generic.searchBoxInputStyle = 'mobl__ui__generic__searchBoxInputStyle';

mobl.ui.generic.searchBox = function(s, placeholder, onsearch, onkeyup, elements, callback) {
  var root4882 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var node822 = $("<div>");
  
  var ref234 = mobl.ref(mobl.ui.generic.searchboxStyle);
  if(ref234.get() !== null) {
    node822.attr('class', ref234.get());
    subs__.addSub(ref234.addEventListener('change', function(_, ref, val) {
      node822.attr('class', val);
    }));
    
  }
  subs__.addSub(ref234.rebind());
  
  
  var node823 = $("<input>");
  node823.attr('type', "search");
  
  var ref231 = mobl.ref(mobl.ui.generic.searchBoxInputStyle);
  if(ref231.get() !== null) {
    node823.attr('class', ref231.get());
    subs__.addSub(ref231.addEventListener('change', function(_, ref, val) {
      node823.attr('class', val);
    }));
    
  }
  subs__.addSub(ref231.rebind());
  
  var ref232 = placeholder;
  if(ref232.get() !== null) {
    node823.attr('placeholder', ref232.get());
    subs__.addSub(ref232.addEventListener('change', function(_, ref, val) {
      node823.attr('placeholder', val);
    }));
    
  }
  subs__.addSub(ref232.rebind());
  
  var ref233 = s;
  node823.val(""+ref233.get());
  var ignore39 = false;
  subs__.addSub(ref233.addEventListener('change', function(_, ref, val) {
    if(ignore39) return;
    node823.val(""+val);
  }));
  subs__.addSub(ref233.rebind());
  
  subs__.addSub(mobl.domBind(node823, 'keyup change', function() {
    ignore39 = true;
    s.set(mobl.stringTomobl__String(node823.val()));
    ignore39 = false;
  }));
  
  
  var val100 = onsearch.get();
  if(val100 !== null) {
    subs__.addSub(mobl.domBind(node823, 'change', val100));
  }
  
  var val101 = onkeyup.get();
  if(val101 !== null) {
    subs__.addSub(mobl.domBind(node823, 'keyup', val101));
  }
  node823.attr('autocorrect', false);
  node823.attr('autocapitalize', false);
  node823.attr('autocomplete', false);
  
  node822.append(node823);
  root4882.append(node822);
  callback(root4882); return subs__;
  
  
  return subs__;
};
mobl.ui.generic.contextMenuStyle = 'mobl__ui__generic__contextMenuStyle';
mobl.ui.generic.buttonStyle = 'mobl__ui__generic__buttonStyle';
mobl.ui.generic.buttonPushedStyle = 'mobl__ui__generic__buttonPushedStyle';

mobl.ui.generic.contextMenu = function(elements, callback) {
  var root4883 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var menu = $("<div>");
  
  var ref235 = mobl.ref(mobl.ui.generic.contextMenuStyle);
  if(ref235.get() !== null) {
    menu.attr('class', ref235.get());
    subs__.addSub(ref235.addEventListener('change', function(_, ref, val) {
      menu.attr('class', val);
    }));
    
  }
  subs__.addSub(ref235.rebind());
  
  var nodes4239 = $("<span>");
  menu.append(nodes4239);
  subs__.addSub(mobl.ref(elements).addEventListener('change', function() {
    renderControl57();
  }));
  
  function renderControl57() {
    subs__.addSub((elements)(function(elements, callback) {
      var root4884 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root4884); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes4239;
      nodes4239 = node.contents();
      oldNodes.replaceWith(nodes4239);
    }));
  }
  renderControl57();
  root4883.append(menu);
  var result__ = menu.hide();
  
  var img = $("<img>");
  img.attr('src', "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAA0AAAANABeWPPlAAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAAEuSURBVDiNrdSrTkNBEMbx35aLIhUNEl4CsCSkmgfBoOoJz0B4BhSSBEcQSMA3GBJE34Br6CA6heWUA4huMuLszvc/c9stEaG5Sil97GADm7l9g1tcRsTFjCgiPg09nCDSxhimjav9E/S+aSvINkbpeIU+utV5N/eu0meE7W+gjGSEFwzQqf/WiLqTPi+p6dWgaTqDNsAPwME0zWmd+1U6rZG0RDZNs9/J7sBBRIxnutGy0vcgP3cWTVocuC6lLGD9H5z3iHjAdWo3ZMGGVchHvtrcZnuV/zAZM6CCUzz9AHjGYaNWn6Azk2GrZ2YJlw3YI44bkG5qzzomY1+wVRXyDbu4w2sCz7HfqNVWam/5pf1YxX2eLf/W/j8HEmtY+XMg53pF5nZp5/GMlHk9bB8Ws56C3JDK8wAAAABJRU5ErkJggg==");
  img.attr('style', "float: right;");
  
  var val102 = function(event, callback) {
                if(event && event.stopPropagation) event.stopPropagation();
                var result__ = img.parent();
                var target = result__;
                var result__ = target.css("position", "relative");
                var result__ = img.hide();
                var result__ = menu.css("right", "5px");
                var result__ = menu.css("top", "5px");
                var result__ = menu.show();
                mobl.sleep(500, function(result__) {
                  var tmp2680 = result__;
                  var result__ = mobl.$("body").bind("tap", removeMenu);
                  if(callback && callback.apply) callback(); return;
                });
              };
  if(val102 !== null) {
    subs__.addSub(mobl.domBind(img, 'tap', val102));
  }
  
  root4883.append(img);
  
  var removeMenu = function(evt) {
     var __this = this;
    menu.hide();
    img.show();
    mobl.$("body").unbind("tap", removeMenu);
  };
  
  
  callback(root4883); return subs__;
  
  
  
  return subs__;
};

mobl.ui.generic.masterDetail = function(items, masterItem, detail, elements, callback) {
  var root4885 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  var result__ = mobl.window.get().innerWidth > 500;
  var tmp2663 = mobl.ref(result__);
  subs__.addSub(mobl.ref(mobl.window, 'innerWidth').addEventListener('change', function() {
    tmp2663.set(mobl.window.get().innerWidth > 500);
  }));
  
  
  var node824 = $("<span>");
  root4885.append(node824);
  var condSubs499 = new mobl.CompSubscription();
  subs__.addSub(condSubs499);
  var oldValue499;
  var renderCond499 = function() {
    var value559 = tmp2663.get();
    if(oldValue499 === value559) return;
    oldValue499 = value559;
    var subs__ = condSubs499;
    subs__.unsubscribe();
    node824.empty();
    if(value559) {
      items.get().one(function(result__) {
        var tmp2681 = result__;
        var current = mobl.ref(result__);
        
        var node825 = $("<div>");
        node825.attr('width', "100%");
        
        
        var node826 = $("<div>");
        node826.attr('style', "float:left; width:33%; position:relative; border-right: solid 1px #cccccc;");
        
        var nodes4242 = $("<span>");
        node826.append(nodes4242);
        subs__.addSub((mobl.ui.generic.group)(function(_, callback) {
          var root4888 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          
          var node829 = mobl.loadingSpan();
          root4888.append(node829);
          var list211;
          var listSubs211 = new mobl.CompSubscription();
          subs__.addSub(listSubs211);
          var renderList211 = function() {
            var subs__ = listSubs211;
            list211 = items.get();
            list211.list(function(results211) {
              node829.empty();
              for(var i288 = 0; i288 < results211.length; i288++) {
                (function() {
                  var iternode211 = $("<span>");
                  node829.append(iternode211);
                  var it;
                  it = mobl.ref(mobl.ref(results211), i288);
                  var result__ = it.get() == current.get();
                  var tmp2649 = mobl.ref(result__);
                  subs__.addSub(it.addEventListener('change', function() {
                    tmp2649.set(it.get() == current.get());
                  }));
                  subs__.addSub(current.addEventListener('change', function() {
                    tmp2649.set(it.get() == current.get());
                  }));
                  
                  
                  var node830 = $("<span>");
                  iternode211.append(node830);
                  var condSubs501 = new mobl.CompSubscription();
                  subs__.addSub(condSubs501);
                  var oldValue501;
                  var renderCond501 = function() {
                    var value561 = tmp2649.get();
                    if(oldValue501 === value561) return;
                    oldValue501 = value561;
                    var subs__ = condSubs501;
                    subs__.unsubscribe();
                    node830.empty();
                    if(value561) {
                      var nodes4243 = $("<span>");
                      node830.append(nodes4243);
                      subs__.addSub((mobl.ui.generic.item)(mobl.ref(mobl.ui.generic.selectedItemStyle), mobl.ref(mobl.ui.generic.itemPushedStyle), mobl.ref(null), mobl.ref(null), mobl.ref(false), function(_, callback) {
                        var root4889 = $("<span>");
                        var subs__ = new mobl.CompSubscription();
                        var nodes4244 = $("<span>");
                        root4889.append(nodes4244);
                        subs__.addSub(masterItem.addEventListener('change', function() {
                          renderControl59();
                        }));
                        
                        function renderControl59() {
                          subs__.addSub((masterItem.get())(it, function(elements, callback) {
                            var root4890 = $("<span>");
                            var subs__ = new mobl.CompSubscription();
                            callback(root4890); return subs__;
                            return subs__;
                          }, function(node) {
                            var oldNodes = nodes4244;
                            nodes4244 = node.contents();
                            oldNodes.replaceWith(nodes4244);
                          }));
                        }
                        renderControl59();
                        callback(root4889); return subs__;
                        
                        return subs__;
                      }, function(node) {
                        var oldNodes = nodes4243;
                        nodes4243 = node.contents();
                        oldNodes.replaceWith(nodes4243);
                      }));
                      
                      
                    } else {
                      var result__ = function(event, callback) {
                                       if(event && event.stopPropagation) event.stopPropagation();
                                       var result__ = it.get();
                                       current.set(result__);
                                       var result__ = mobl.ui.generic.scrollUp();
                                       if(callback && callback.apply) callback(); return;
                                     };
                      var tmp2648 = mobl.ref(result__);
                      
                      var nodes4245 = $("<span>");
                      node830.append(nodes4245);
                      subs__.addSub((mobl.ui.generic.item)(mobl.ref(mobl.ui.generic.itemStyle), mobl.ref(mobl.ui.generic.itemPushedStyle), tmp2648, mobl.ref(null), mobl.ref(true), function(_, callback) {
                        var root4891 = $("<span>");
                        var subs__ = new mobl.CompSubscription();
                        var nodes4246 = $("<span>");
                        root4891.append(nodes4246);
                        subs__.addSub(masterItem.addEventListener('change', function() {
                          renderControl60();
                        }));
                        
                        function renderControl60() {
                          subs__.addSub((masterItem.get())(it, function(elements, callback) {
                            var root4892 = $("<span>");
                            var subs__ = new mobl.CompSubscription();
                            callback(root4892); return subs__;
                            return subs__;
                          }, function(node) {
                            var oldNodes = nodes4246;
                            nodes4246 = node.contents();
                            oldNodes.replaceWith(nodes4246);
                          }));
                        }
                        renderControl60();
                        callback(root4891); return subs__;
                        
                        return subs__;
                      }, function(node) {
                        var oldNodes = nodes4245;
                        nodes4245 = node.contents();
                        oldNodes.replaceWith(nodes4245);
                      }));
                      
                      
                    }
                  };
                  renderCond501();
                  subs__.addSub(tmp2649.addEventListener('change', function() {
                    renderCond501();
                  }));
                  
                  
                  var oldNodes = iternode211;
                  iternode211 = iternode211.contents();
                  oldNodes.replaceWith(iternode211);
                  
                  
                }());
              }
              mobl.delayedUpdateScrollers();
              subs__.addSub(list211.addEventListener('change', function() { listSubs211.unsubscribe(); renderList211(true); }));
              subs__.addSub(items.addEventListener('change', function() { listSubs211.unsubscribe(); renderList211(true); }));
            });
          };
          renderList211();
          
          callback(root4888); return subs__;
          
          return subs__;
        }, function(node) {
          var oldNodes = nodes4242;
          nodes4242 = node.contents();
          oldNodes.replaceWith(nodes4242);
        }));
        node825.append(node826);
        
        var node827 = $("<div>");
        node827.attr('style', "float:left; width:66.5%; position:relative; margin-left: 0.5%;");
        
        
        var node828 = $("<span>");
        node827.append(node828);
        var condSubs500 = new mobl.CompSubscription();
        subs__.addSub(condSubs500);
        var oldValue500;
        var renderCond500 = function() {
          var value560 = current.get();
          if(oldValue500 === value560) return;
          oldValue500 = value560;
          var subs__ = condSubs500;
          subs__.unsubscribe();
          node828.empty();
          if(value560) {
            var nodes4240 = $("<span>");
            node828.append(nodes4240);
            subs__.addSub(detail.addEventListener('change', function() {
              renderControl58();
            }));
            
            function renderControl58() {
              subs__.addSub((detail.get())(current, function(elements, callback) {
                var root4886 = $("<span>");
                var subs__ = new mobl.CompSubscription();
                callback(root4886); return subs__;
                return subs__;
              }, function(node) {
                var oldNodes = nodes4240;
                nodes4240 = node.contents();
                oldNodes.replaceWith(nodes4240);
              }));
            }
            renderControl58();
            
            
          } else {
            var result__ = mobl._("Select an item on the left", []);
            var tmp2650 = mobl.ref(result__);
            
            var nodes4241 = $("<span>");
            node828.append(nodes4241);
            subs__.addSub((mobl.label)(tmp2650, mobl.ref(null), mobl.ref(null), function(_, callback) {
              var root4887 = $("<span>");
              var subs__ = new mobl.CompSubscription();
              callback(root4887); return subs__;
              return subs__;
            }, function(node) {
              var oldNodes = nodes4241;
              nodes4241 = node.contents();
              oldNodes.replaceWith(nodes4241);
            }));
            
            
          }
        };
        renderCond500();
        subs__.addSub(current.addEventListener('change', function() {
          renderCond500();
        }));
        
        node825.append(node827);
        node824.append(node825);
        
        
        
        
        
        
      });
    } else {
      var nodes4247 = $("<span>");
      node824.append(nodes4247);
      subs__.addSub((mobl.ui.generic.group)(function(_, callback) {
        var root4893 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        
        var node831 = mobl.loadingSpan();
        root4893.append(node831);
        var list212;
        var listSubs212 = new mobl.CompSubscription();
        subs__.addSub(listSubs212);
        var renderList212 = function() {
          var subs__ = listSubs212;
          list212 = items.get();
          list212.list(function(results212) {
            node831.empty();
            for(var i289 = 0; i289 < results212.length; i289++) {
              (function() {
                var iternode212 = $("<span>");
                node831.append(iternode212);
                var it;
                it = mobl.ref(mobl.ref(results212), i289);
                var result__ = function(event, callback) {
                                 if(event && event.stopPropagation) event.stopPropagation();
                                 mobl.call('mobl.ui.generic.detailScreen', [it, detail, mobl.ref(false), mobl.ref("slide"), mobl.ref(null)], function(result__) {
                                 var tmp2682 = result__;
                                 if(callback && callback.apply) callback(); return;
                                 });
                               };
                var tmp2644 = mobl.ref(result__);
                
                var nodes4248 = $("<span>");
                iternode212.append(nodes4248);
                subs__.addSub((mobl.ui.generic.item)(mobl.ref(mobl.ui.generic.itemStyle), mobl.ref(mobl.ui.generic.itemPushedStyle), tmp2644, mobl.ref(null), mobl.ref(false), function(_, callback) {
                  var root4894 = $("<span>");
                  var subs__ = new mobl.CompSubscription();
                  var nodes4249 = $("<span>");
                  root4894.append(nodes4249);
                  subs__.addSub(masterItem.addEventListener('change', function() {
                    renderControl61();
                  }));
                  
                  function renderControl61() {
                    subs__.addSub((masterItem.get())(it, function(elements, callback) {
                      var root4895 = $("<span>");
                      var subs__ = new mobl.CompSubscription();
                      callback(root4895); return subs__;
                      return subs__;
                    }, function(node) {
                      var oldNodes = nodes4249;
                      nodes4249 = node.contents();
                      oldNodes.replaceWith(nodes4249);
                    }));
                  }
                  renderControl61();
                  callback(root4894); return subs__;
                  
                  return subs__;
                }, function(node) {
                  var oldNodes = nodes4248;
                  nodes4248 = node.contents();
                  oldNodes.replaceWith(nodes4248);
                }));
                
                var oldNodes = iternode212;
                iternode212 = iternode212.contents();
                oldNodes.replaceWith(iternode212);
                
                
              }());
            }
            mobl.delayedUpdateScrollers();
            subs__.addSub(list212.addEventListener('change', function() { listSubs212.unsubscribe(); renderList212(true); }));
            subs__.addSub(items.addEventListener('change', function() { listSubs212.unsubscribe(); renderList212(true); }));
          });
        };
        renderList212();
        
        callback(root4893); return subs__;
        
        return subs__;
      }, function(node) {
        var oldNodes = nodes4247;
        nodes4247 = node.contents();
        oldNodes.replaceWith(nodes4247);
      }));
      
      
    }
  };
  renderCond499();
  subs__.addSub(tmp2663.addEventListener('change', function() {
    renderCond499();
  }));
  
  callback(root4885); return subs__;
  
  return subs__;
};

mobl.ui.generic.detailScreen = function(it, detail, callback, screenCallback) {
  var root4896 = $("<div>");
  var subs__ = new mobl.CompSubscription();
  var result__ = mobl._("Detail", []);
  var tmp2647 = mobl.ref(result__);
  
  var nodes4250 = $("<span>");
  root4896.append(nodes4250);
  subs__.addSub((mobl.ui.generic.header)(tmp2647, mobl.ref(false), mobl.ref(null), function(_, callback) {
    var root4897 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    var result__ = function(event, callback) {
                     if(event && event.stopPropagation) event.stopPropagation();
                     if(screenCallback) screenCallback();
                     return;
                     if(callback && callback.apply) callback(); return;
                   };
    var tmp2646 = mobl.ref(result__);
    
    var result__ = mobl._("Back", []);
    var tmp2645 = mobl.ref(result__);
    
    var nodes4251 = $("<span>");
    root4897.append(nodes4251);
    subs__.addSub((mobl.ui.generic.backButton)(tmp2645, mobl.ref(mobl.ui.generic.backButtonStyle), mobl.ref(mobl.ui.generic.backButtonPushedStyle), tmp2646, function(_, callback) {
      var root4898 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root4898); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes4251;
      nodes4251 = node.contents();
      oldNodes.replaceWith(nodes4251);
    }));
    callback(root4897); return subs__;
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes4250;
    nodes4250 = node.contents();
    oldNodes.replaceWith(nodes4250);
  }));
  var nodes4252 = $("<span>");
  root4896.append(nodes4252);
  subs__.addSub(detail.addEventListener('change', function() {
    renderControl62();
  }));
  
  function renderControl62() {
    subs__.addSub((detail.get())(it, function(elements, callback) {
      var root4899 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root4899); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes4252;
      nodes4252 = node.contents();
      oldNodes.replaceWith(nodes4252);
    }));
  }
  renderControl62();
  callback(root4896); return subs__;
  
  
  return subs__;
};
mobl.ui.generic.selectedItemStyle = 'mobl__ui__generic__selectedItemStyle';

mobl.ui.generic.zoomList = function(coll, listCtrl, zoomCtrl, elements, callback) {
  var root4900 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var selected = mobl.ref(null);
  var nodes4253 = $("<span>");
  root4900.append(nodes4253);
  subs__.addSub((mobl.ui.generic.group)(function(_, callback) {
    var root4901 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    
    var node832 = mobl.loadingSpan();
    root4901.append(node832);
    var list213;
    var listSubs213 = new mobl.CompSubscription();
    subs__.addSub(listSubs213);
    var renderList213 = function() {
      var subs__ = listSubs213;
      list213 = coll.get();
      list213.list(function(results213) {
        node832.empty();
        for(var i290 = 0; i290 < results213.length; i290++) {
          (function() {
            var iternode213 = $("<span>");
            node832.append(iternode213);
            var it;
            it = mobl.ref(mobl.ref(results213), i290);
            var result__ = it.get() == selected.get();
            var tmp2652 = mobl.ref(result__);
            subs__.addSub(it.addEventListener('change', function() {
              tmp2652.set(it.get() == selected.get());
            }));
            subs__.addSub(selected.addEventListener('change', function() {
              tmp2652.set(it.get() == selected.get());
            }));
            
            
            var node833 = $("<span>");
            iternode213.append(node833);
            var condSubs502 = new mobl.CompSubscription();
            subs__.addSub(condSubs502);
            var oldValue502;
            var renderCond502 = function() {
              var value562 = tmp2652.get();
              if(oldValue502 === value562) return;
              oldValue502 = value562;
              var subs__ = condSubs502;
              subs__.unsubscribe();
              node833.empty();
              if(value562) {
                var nodes4254 = $("<span>");
                node833.append(nodes4254);
                subs__.addSub((mobl.ui.generic.item)(mobl.ref(mobl.ui.generic.itemStyle), mobl.ref(mobl.ui.generic.itemPushedStyle), mobl.ref(null), mobl.ref(null), mobl.ref(false), function(_, callback) {
                  var root4902 = $("<span>");
                  var subs__ = new mobl.CompSubscription();
                  var nodes4255 = $("<span>");
                  root4902.append(nodes4255);
                  subs__.addSub(zoomCtrl.addEventListener('change', function() {
                    renderControl63();
                  }));
                  
                  function renderControl63() {
                    subs__.addSub((zoomCtrl.get())(it, function(elements, callback) {
                      var root4903 = $("<span>");
                      var subs__ = new mobl.CompSubscription();
                      callback(root4903); return subs__;
                      return subs__;
                    }, function(node) {
                      var oldNodes = nodes4255;
                      nodes4255 = node.contents();
                      oldNodes.replaceWith(nodes4255);
                    }));
                  }
                  renderControl63();
                  callback(root4902); return subs__;
                  
                  return subs__;
                }, function(node) {
                  var oldNodes = nodes4254;
                  nodes4254 = node.contents();
                  oldNodes.replaceWith(nodes4254);
                }));
                
                
              } else {
                var result__ = function(event, callback) {
                                 if(event && event.stopPropagation) event.stopPropagation();
                                 var result__ = it.get();
                                 selected.set(result__);
                                 if(callback && callback.apply) callback(); return;
                               };
                var tmp2651 = mobl.ref(result__);
                
                var nodes4256 = $("<span>");
                node833.append(nodes4256);
                subs__.addSub((mobl.ui.generic.item)(mobl.ref(mobl.ui.generic.itemStyle), mobl.ref(mobl.ui.generic.itemPushedStyle), tmp2651, mobl.ref(null), mobl.ref(true), function(_, callback) {
                  var root4904 = $("<span>");
                  var subs__ = new mobl.CompSubscription();
                  var nodes4257 = $("<span>");
                  root4904.append(nodes4257);
                  subs__.addSub(listCtrl.addEventListener('change', function() {
                    renderControl64();
                  }));
                  
                  function renderControl64() {
                    subs__.addSub((listCtrl.get())(it, function(elements, callback) {
                      var root4905 = $("<span>");
                      var subs__ = new mobl.CompSubscription();
                      callback(root4905); return subs__;
                      return subs__;
                    }, function(node) {
                      var oldNodes = nodes4257;
                      nodes4257 = node.contents();
                      oldNodes.replaceWith(nodes4257);
                    }));
                  }
                  renderControl64();
                  callback(root4904); return subs__;
                  
                  return subs__;
                }, function(node) {
                  var oldNodes = nodes4256;
                  nodes4256 = node.contents();
                  oldNodes.replaceWith(nodes4256);
                }));
                
                
              }
            };
            renderCond502();
            subs__.addSub(tmp2652.addEventListener('change', function() {
              renderCond502();
            }));
            
            
            var oldNodes = iternode213;
            iternode213 = iternode213.contents();
            oldNodes.replaceWith(iternode213);
            
            
          }());
        }
        mobl.delayedUpdateScrollers();
        subs__.addSub(list213.addEventListener('change', function() { listSubs213.unsubscribe(); renderList213(true); }));
        subs__.addSub(coll.addEventListener('change', function() { listSubs213.unsubscribe(); renderList213(true); }));
      });
    };
    renderList213();
    
    callback(root4901); return subs__;
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes4253;
    nodes4253 = node.contents();
    oldNodes.replaceWith(nodes4253);
  }));
  callback(root4900); return subs__;
  
  return subs__;
};
mobl.ui.generic.loadMoreStyle = 'mobl__ui__generic__loadMoreStyle';

mobl.ui.generic.stagedList = function(coll, listCtrl, initialItems, step, moreLabel, moreStyle, elements, callback) {
  var root4906 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var n = mobl.ref(initialItems.get());
  coll.get().count(function(result__) {
    var tmp2683 = result__;
    var total = mobl.ref(result__);
    var result__ = coll.get().limit(n.get());
    var tmp2653 = mobl.ref(result__);
    subs__.addSub(mobl.ref(coll.get().limit(n.get())).addEventListener('change', function() {
      tmp2653.set(coll.get().limit(n.get()));
    }));
    subs__.addSub(coll.addEventListener('change', function() {
      tmp2653.set(coll.get().limit(n.get()));
    }));
    subs__.addSub(n.addEventListener('change', function() {
      tmp2653.set(coll.get().limit(n.get()));
    }));
    
    
    var node834 = mobl.loadingSpan();
    root4906.append(node834);
    var list214;
    var listSubs214 = new mobl.CompSubscription();
    subs__.addSub(listSubs214);
    var renderList214 = function() {
      var subs__ = listSubs214;
      list214 = tmp2653.get();
      list214.list(function(results214) {
        node834.empty();
        for(var i291 = 0; i291 < results214.length; i291++) {
          (function() {
            var iternode214 = $("<span>");
            node834.append(iternode214);
            var it;
            it = mobl.ref(mobl.ref(results214), i291);
            var nodes4258 = $("<span>");
            iternode214.append(nodes4258);
            subs__.addSub(listCtrl.addEventListener('change', function() {
              renderControl65();
            }));
            
            function renderControl65() {
              subs__.addSub((listCtrl.get())(it, function(elements, callback) {
                var root4907 = $("<span>");
                var subs__ = new mobl.CompSubscription();
                callback(root4907); return subs__;
                return subs__;
              }, function(node) {
                var oldNodes = nodes4258;
                nodes4258 = node.contents();
                oldNodes.replaceWith(nodes4258);
              }));
            }
            renderControl65();
            
            var oldNodes = iternode214;
            iternode214 = iternode214.contents();
            oldNodes.replaceWith(iternode214);
            
            
          }());
        }
        mobl.delayedUpdateScrollers();
        subs__.addSub(list214.addEventListener('change', function() { listSubs214.unsubscribe(); renderList214(true); }));
        subs__.addSub(tmp2653.addEventListener('change', function() { listSubs214.unsubscribe(); renderList214(true); }));
      });
    };
    renderList214();
    
    var result__ = n.get() < total.get();
    var tmp2655 = mobl.ref(result__);
    subs__.addSub(n.addEventListener('change', function() {
      tmp2655.set(n.get() < total.get());
    }));
    subs__.addSub(total.addEventListener('change', function() {
      tmp2655.set(n.get() < total.get());
    }));
    
    
    var node835 = $("<span>");
    root4906.append(node835);
    var condSubs503 = new mobl.CompSubscription();
    subs__.addSub(condSubs503);
    var oldValue503;
    var renderCond503 = function() {
      var value563 = tmp2655.get();
      if(oldValue503 === value563) return;
      oldValue503 = value563;
      var subs__ = condSubs503;
      subs__.unsubscribe();
      node835.empty();
      if(value563) {
        var result__ = function(event, callback) {
                         if(event && event.stopPropagation) event.stopPropagation();
                         var result__ = n.get() + step.get();
                         n.set(result__);
                         if(callback && callback.apply) callback(); return;
                       };
        var tmp2654 = mobl.ref(result__);
        
        var nodes4259 = $("<span>");
        node835.append(nodes4259);
        subs__.addSub((mobl.block)(moreStyle, mobl.ref(null), tmp2654, mobl.ref(null), function(_, callback) {
          var root4908 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          var nodes4260 = $("<span>");
          root4908.append(nodes4260);
          subs__.addSub((mobl.label)(moreLabel, mobl.ref(null), mobl.ref(null), function(_, callback) {
            var root4909 = $("<span>");
            var subs__ = new mobl.CompSubscription();
            callback(root4909); return subs__;
            return subs__;
          }, function(node) {
            var oldNodes = nodes4260;
            nodes4260 = node.contents();
            oldNodes.replaceWith(nodes4260);
          }));
          callback(root4908); return subs__;
          
          return subs__;
        }, function(node) {
          var oldNodes = nodes4259;
          nodes4259 = node.contents();
          oldNodes.replaceWith(nodes4259);
        }));
        
        
      } else {
        
      }
    };
    renderCond503();
    subs__.addSub(tmp2655.addEventListener('change', function() {
      renderCond503();
    }));
    
    callback(root4906); return subs__;
    
    
  });
  return subs__;
};

mobl.ui.generic.markableList = function(items, elements, callback) {
  var root4910 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  var nodes4261 = $("<span>");
  root4910.append(nodes4261);
  subs__.addSub((mobl.ui.generic.group)(function(_, callback) {
    var root4911 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    
    var node836 = mobl.loadingSpan();
    root4911.append(node836);
    var list215;
    var listSubs215 = new mobl.CompSubscription();
    subs__.addSub(listSubs215);
    var renderList215 = function() {
      var subs__ = listSubs215;
      list215 = items.get();
      list215.list(function(results215) {
        node836.empty();
        for(var i292 = 0; i292 < results215.length; i292++) {
          (function() {
            var iternode215 = $("<span>");
            node836.append(iternode215);
            var checked;var it;
            checked = mobl.ref(mobl.ref(mobl.ref(results215), i292), "_1");it = mobl.ref(mobl.ref(mobl.ref(results215), i292), "_2");
            var nodes4262 = $("<span>");
            iternode215.append(nodes4262);
            subs__.addSub((mobl.ui.generic.item)(mobl.ref(mobl.ui.generic.itemStyle), mobl.ref(mobl.ui.generic.itemPushedStyle), mobl.ref(null), mobl.ref(null), mobl.ref(false), function(_, callback) {
              var root4912 = $("<span>");
              var subs__ = new mobl.CompSubscription();
              var nodes4263 = $("<span>");
              root4912.append(nodes4263);
              subs__.addSub((mobl.ui.generic.checkBox)(checked, it, mobl.ref(null), function(_, callback) {
                var root4913 = $("<span>");
                var subs__ = new mobl.CompSubscription();
                callback(root4913); return subs__;
                return subs__;
              }, function(node) {
                var oldNodes = nodes4263;
                nodes4263 = node.contents();
                oldNodes.replaceWith(nodes4263);
              }));
              callback(root4912); return subs__;
              
              return subs__;
            }, function(node) {
              var oldNodes = nodes4262;
              nodes4262 = node.contents();
              oldNodes.replaceWith(nodes4262);
            }));
            
            var oldNodes = iternode215;
            iternode215 = iternode215.contents();
            oldNodes.replaceWith(iternode215);
            
            
          }());
        }
        mobl.delayedUpdateScrollers();
        subs__.addSub(list215.addEventListener('change', function() { listSubs215.unsubscribe(); renderList215(true); }));
        subs__.addSub(items.addEventListener('change', function() { listSubs215.unsubscribe(); renderList215(true); }));
      });
    };
    renderList215();
    
    callback(root4911); return subs__;
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes4261;
    nodes4261 = node.contents();
    oldNodes.replaceWith(nodes4261);
  }));
  callback(root4910); return subs__;
  
  return subs__;
};

mobl.ui.generic.selectList = function(title, coll, doneButtonLabel, callback, screenCallback) {
  var root4914 = $("<div>");
  var subs__ = new mobl.CompSubscription();
  
  var items = mobl.ref([]);
  var result__ = coll.get();
  coll.get().list(function(coll189) {
    coll189 = coll189.reverse();
    function processOne7() {
      var it;
      it = coll189.pop();
      var result__ = items.get().push(new mobl.Tuple(false, it));
      
      if(coll189.length > 0) processOne7(); else rest8();
      
    }
    function rest8() {
      var nodes4264 = $("<span>");
      root4914.append(nodes4264);
      subs__.addSub((mobl.ui.generic.header)(title, mobl.ref(false), mobl.ref(null), function(_, callback) {
        var root4915 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        var result__ = function(event, callback) {
                         if(event && event.stopPropagation) event.stopPropagation();
                         var result__ = null;
                         if(callback && callback.apply) callback(result__);
                         return;
                         if(callback && callback.apply) callback(); return;
                       };
        var tmp2656 = mobl.ref(result__);
        
        var result__ = mobl._("Back", []);
        var tmp2657 = mobl.ref(result__);
        
        var nodes4265 = $("<span>");
        root4915.append(nodes4265);
        subs__.addSub((mobl.ui.generic.backButton)(tmp2657, mobl.ref(mobl.ui.generic.backButtonStyle), mobl.ref(mobl.ui.generic.backButtonPushedStyle), tmp2656, function(_, callback) {
          var root4916 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root4916); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes4265;
          nodes4265 = node.contents();
          oldNodes.replaceWith(nodes4265);
        }));
        var result__ = function(event, callback) {
                         if(event && event.stopPropagation) event.stopPropagation();
                         var result__ = [];
                         var selected = result__;
                         var result__ = items.get();
                         items.get().list(function(coll188) {
                           coll188 = coll188.reverse();
                           function processOne6() {
                             var checked;var it;
                             var tmp2685 = coll188.pop();
                             checked = tmp2685._1;it = tmp2685._2;
                             var result__ = checked;
                             if(result__) {
                               var result__ = selected.push(it);
                               
                               if(coll188.length > 0) processOne6(); else rest7();
                               
                             } else {
                               {
                                 
                                 if(coll188.length > 0) processOne6(); else rest7();
                                 
                               }
                             }
                           }
                           function rest7() {
                             var result__ = selected;
                             if(screenCallback) screenCallback(result__);
                             return;
                             if(callback && callback.apply) callback(); return;
                           }
                           if(coll188.length > 0) processOne6(); else rest7();
                         });
                         
                       };
        var tmp2658 = mobl.ref(result__);
        
        var nodes4266 = $("<span>");
        root4915.append(nodes4266);
        subs__.addSub((mobl.ui.generic.button)(doneButtonLabel, mobl.ref(mobl.ui.generic.buttonStyle), mobl.ref(mobl.ui.generic.buttonPushedStyle), tmp2658, function(_, callback) {
          var root4917 = $("<span>");
          var subs__ = new mobl.CompSubscription();
          callback(root4917); return subs__;
          return subs__;
        }, function(node) {
          var oldNodes = nodes4266;
          nodes4266 = node.contents();
          oldNodes.replaceWith(nodes4266);
        }));
        callback(root4915); return subs__;
        
        
        return subs__;
      }, function(node) {
        var oldNodes = nodes4264;
        nodes4264 = node.contents();
        oldNodes.replaceWith(nodes4264);
      }));
      var nodes4267 = $("<span>");
      root4914.append(nodes4267);
      subs__.addSub((mobl.ui.generic.markableList)(items, function(_, callback) {
        var root4918 = $("<span>");
        var subs__ = new mobl.CompSubscription();
        callback(root4918); return subs__;
        return subs__;
      }, function(node) {
        var oldNodes = nodes4267;
        nodes4267 = node.contents();
        oldNodes.replaceWith(nodes4267);
      }));
      callback(root4914); return subs__;
      
      
    }
    if(coll189.length > 0) processOne7(); else rest8();
  });
  
  return subs__;
};

mobl.ui.generic.searchList = function(Ent, masterItem, detailItem, resultLimit, searchTermPlaceholder, elements, callback) {
  var root4919 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var phrase = mobl.ref("");
  var nodes4268 = $("<span>");
  root4919.append(nodes4268);
  subs__.addSub((mobl.ui.generic.searchBox)(phrase, searchTermPlaceholder, mobl.ref(null), mobl.ref(null), function(_, callback) {
    var root4920 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    callback(root4920); return subs__;
    return subs__;
  }, function(node) {
    var oldNodes = nodes4268;
    nodes4268 = node.contents();
    oldNodes.replaceWith(nodes4268);
  }));
  var result__ = Ent.get().searchPrefix(phrase.get()).limit(resultLimit.get());
  var tmp2659 = mobl.ref(result__);
  subs__.addSub(mobl.ref(Ent.get().searchPrefix(phrase.get()).limit(resultLimit.get())).addEventListener('change', function() {
    tmp2659.set(Ent.get().searchPrefix(phrase.get()).limit(resultLimit.get()));
  }));
  subs__.addSub(mobl.ref(Ent.get().searchPrefix(phrase.get())).addEventListener('change', function() {
    tmp2659.set(Ent.get().searchPrefix(phrase.get()).limit(resultLimit.get()));
  }));
  subs__.addSub(Ent.addEventListener('change', function() {
    tmp2659.set(Ent.get().searchPrefix(phrase.get()).limit(resultLimit.get()));
  }));
  subs__.addSub(phrase.addEventListener('change', function() {
    tmp2659.set(Ent.get().searchPrefix(phrase.get()).limit(resultLimit.get()));
  }));
  subs__.addSub(resultLimit.addEventListener('change', function() {
    tmp2659.set(Ent.get().searchPrefix(phrase.get()).limit(resultLimit.get()));
  }));
  
  var nodes4269 = $("<span>");
  root4919.append(nodes4269);
  subs__.addSub((mobl.ui.generic.masterDetail)(tmp2659, masterItem, detailItem, function(_, callback) {
    var root4921 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    callback(root4921); return subs__;
    return subs__;
  }, function(node) {
    var oldNodes = nodes4269;
    nodes4269 = node.contents();
    oldNodes.replaceWith(nodes4269);
  }));
  callback(root4919); return subs__;
  
  
  return subs__;
};
mobl.ui.generic.progressStyle = 'mobl__ui__generic__progressStyle';
mobl.ui.generic.startLoading = function(loadingMessage, style) {
   var __this = this;
  var loading = mobl.$("<div id='progress' class='" + style + "'>" + loadingMessage + "</div>");
  
  mobl.$("body").prepend(loading);
};

mobl.ui.generic.endLoading = function() {
   var __this = this;
  mobl.$("#progress").remove();
};

(function(__ns) {
__ns.floatBox = function(top, right, bottom, left, elements, callback) {
                  var root928 = $("<span>");
                  var node280 = $("<div style=\"position: absolute;\">");
                  var nodes681 = $("<span>");
                  node280.append(nodes681);
                  mobl.ref(elements).addEventListener('change', function() {
                                                                  renderControl102();
                                                                });
                  function renderControl102 ( ) {
                    (elements)(function(elements, callback) {
                                 var root929 = $("<span>");
                                 callback(root929);
                                 return;
                               }, function(node) {
                                    var oldNodes = nodes681;
                                    nodes681 = node.contents();
                                    oldNodes.replaceWith(nodes681);
                                  });
                  }
                  renderControl102();
                  root928.append(node280);
                  var box = node280;
                  if(top.get() !== null)
                  box.css("top", "" + top.get() + "px");
                  if(right.get() !== null)
                  box.css("right", "" + right.get() + "px");
                  if(bottom.get() !== null)
                  box.css("top", "" + ( window.pageYOffset + window.innerHeight - box.outerHeight() - bottom.get() ) + "px");
                  if(left.get() !== null)
                  box.css("left", "" + left.get() + "px");
                  function updateLocation ( ) {
                    if(top.get() !== null)
                    {
                      box.css("top", "" + ( window.pageYOffset + top.get() ) + "px");
                    }
                    if(bottom.get() !== null)
                    {
                      box.css("top", "" + ( window.pageYOffset + window.innerHeight - box.outerHeight() - bottom.get() ) + "px");
                    }
                  }
                  $(window).bind('scroll', updateLocation);
                  $(window).bind('resize', updateLocation);
                  callback(root928);
                  return;
                };
}(mobl.ui.generic));mobl.ui.generic.accordionStyle = 'mobl__ui__generic__accordionStyle';
mobl.ui.generic.activeSectionHeaderStyle = 'mobl__ui__generic__activeSectionHeaderStyle';
mobl.ui.generic.inActiveSectionHeaderStyle = 'mobl__ui__generic__inActiveSectionHeaderStyle';
mobl.ui.generic.activeSectionHeaderStyle = 'mobl__ui__generic__activeSectionHeaderStyle';
mobl.ui.generic.inActiveSectionHeaderStyle = 'mobl__ui__generic__inActiveSectionHeaderStyle';
mobl.ui.generic.inActiveSectionStyle = 'mobl__ui__generic__inActiveSectionStyle';
mobl.ui.generic.activeSectionStyle = 'mobl__ui__generic__activeSectionStyle';

mobl.ui.generic.accordion = function(sections, activeSection, elements, callback) {
  var root4922 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var activeSection = mobl.ref(activeSection.get() ? activeSection.get() : sections.get().get(0)._1);
  var nodes4270 = $("<span>");
  root4922.append(nodes4270);
  subs__.addSub((mobl.block)(mobl.ref(mobl.ui.generic.accordionStyle), mobl.ref(null), mobl.ref(null), mobl.ref(null), function(_, callback) {
    var root4923 = $("<span>");
    var subs__ = new mobl.CompSubscription();
    
    var node837 = mobl.loadingSpan();
    root4923.append(node837);
    var list216;
    var listSubs216 = new mobl.CompSubscription();
    subs__.addSub(listSubs216);
    var renderList216 = function() {
      var subs__ = listSubs216;
      list216 = sections.get();
      list216.list(function(results216) {
        node837.empty();
        for(var i293 = 0; i293 < results216.length; i293++) {
          (function() {
            var iternode216 = $("<span>");
            node837.append(iternode216);
            var sectionName;var sectionControl;
            sectionName = mobl.ref(mobl.ref(mobl.ref(results216), i293), "_1");sectionControl = mobl.ref(mobl.ref(mobl.ref(results216), i293), "_2");
            var result__ = activeSection.get() == sectionName.get() ? mobl.ui.generic.activeSectionHeaderStyle : mobl.ui.generic.inActiveSectionHeaderStyle;
            var tmp2661 = mobl.ref(result__);
            subs__.addSub(activeSection.addEventListener('change', function() {
              tmp2661.set(activeSection.get() == sectionName.get() ? mobl.ui.generic.activeSectionHeaderStyle : mobl.ui.generic.inActiveSectionHeaderStyle);
            }));
            subs__.addSub(sectionName.addEventListener('change', function() {
              tmp2661.set(activeSection.get() == sectionName.get() ? mobl.ui.generic.activeSectionHeaderStyle : mobl.ui.generic.inActiveSectionHeaderStyle);
            }));
            subs__.addSub(mobl.ref(mobl.ui.generic.activeSectionHeaderStyle).addEventListener('change', function() {
              tmp2661.set(activeSection.get() == sectionName.get() ? mobl.ui.generic.activeSectionHeaderStyle : mobl.ui.generic.inActiveSectionHeaderStyle);
            }));
            subs__.addSub(mobl.ref(mobl.ui.generic.inActiveSectionHeaderStyle).addEventListener('change', function() {
              tmp2661.set(activeSection.get() == sectionName.get() ? mobl.ui.generic.activeSectionHeaderStyle : mobl.ui.generic.inActiveSectionHeaderStyle);
            }));
            
            var result__ = function(event, callback) {
                             if(event && event.stopPropagation) event.stopPropagation();
                             var result__ = sectionName.get();
                             activeSection.set(result__);
                             if(callback && callback.apply) callback(); return;
                           };
            var tmp2660 = mobl.ref(result__);
            
            var nodes4271 = $("<span>");
            iternode216.append(nodes4271);
            subs__.addSub((mobl.span)(tmp2661, mobl.ref(null), tmp2660, mobl.ref(null), function(_, callback) {
              var root4924 = $("<span>");
              var subs__ = new mobl.CompSubscription();
              var nodes4272 = $("<span>");
              root4924.append(nodes4272);
              subs__.addSub((mobl.label)(sectionName, mobl.ref(null), mobl.ref(null), function(_, callback) {
                var root4925 = $("<span>");
                var subs__ = new mobl.CompSubscription();
                callback(root4925); return subs__;
                return subs__;
              }, function(node) {
                var oldNodes = nodes4272;
                nodes4272 = node.contents();
                oldNodes.replaceWith(nodes4272);
              }));
              callback(root4924); return subs__;
              
              return subs__;
            }, function(node) {
              var oldNodes = nodes4271;
              nodes4271 = node.contents();
              oldNodes.replaceWith(nodes4271);
            }));
            var result__ = activeSection.get() == sectionName.get() ? mobl.ui.generic.activeSectionStyle : mobl.ui.generic.inActiveSectionStyle;
            var tmp2662 = mobl.ref(result__);
            subs__.addSub(activeSection.addEventListener('change', function() {
              tmp2662.set(activeSection.get() == sectionName.get() ? mobl.ui.generic.activeSectionStyle : mobl.ui.generic.inActiveSectionStyle);
            }));
            subs__.addSub(sectionName.addEventListener('change', function() {
              tmp2662.set(activeSection.get() == sectionName.get() ? mobl.ui.generic.activeSectionStyle : mobl.ui.generic.inActiveSectionStyle);
            }));
            subs__.addSub(mobl.ref(mobl.ui.generic.activeSectionStyle).addEventListener('change', function() {
              tmp2662.set(activeSection.get() == sectionName.get() ? mobl.ui.generic.activeSectionStyle : mobl.ui.generic.inActiveSectionStyle);
            }));
            subs__.addSub(mobl.ref(mobl.ui.generic.inActiveSectionStyle).addEventListener('change', function() {
              tmp2662.set(activeSection.get() == sectionName.get() ? mobl.ui.generic.activeSectionStyle : mobl.ui.generic.inActiveSectionStyle);
            }));
            
            var nodes4273 = $("<span>");
            iternode216.append(nodes4273);
            subs__.addSub((mobl.block)(tmp2662, mobl.ref(null), mobl.ref(null), mobl.ref(null), function(_, callback) {
              var root4926 = $("<span>");
              var subs__ = new mobl.CompSubscription();
              var nodes4274 = $("<span>");
              root4926.append(nodes4274);
              subs__.addSub(sectionControl.addEventListener('change', function() {
                renderControl66();
              }));
              
              function renderControl66() {
                subs__.addSub((sectionControl.get())(function(elements, callback) {
                  var root4927 = $("<span>");
                  var subs__ = new mobl.CompSubscription();
                  callback(root4927); return subs__;
                  return subs__;
                }, function(node) {
                  var oldNodes = nodes4274;
                  nodes4274 = node.contents();
                  oldNodes.replaceWith(nodes4274);
                }));
              }
              renderControl66();
              callback(root4926); return subs__;
              
              return subs__;
            }, function(node) {
              var oldNodes = nodes4273;
              nodes4273 = node.contents();
              oldNodes.replaceWith(nodes4273);
            }));
            
            var oldNodes = iternode216;
            iternode216 = iternode216.contents();
            oldNodes.replaceWith(iternode216);
            
            
            
          }());
        }
        mobl.delayedUpdateScrollers();
        subs__.addSub(list216.addEventListener('change', function() { listSubs216.unsubscribe(); renderList216(true); }));
        subs__.addSub(sections.addEventListener('change', function() { listSubs216.unsubscribe(); renderList216(true); }));
      });
    };
    renderList216();
    
    callback(root4923); return subs__;
    
    return subs__;
  }, function(node) {
    var oldNodes = nodes4270;
    nodes4270 = node.contents();
    oldNodes.replaceWith(nodes4270);
  }));
  callback(root4922); return subs__;
  
  return subs__;
};
mobl.ui.generic.tableStyle = 'mobl__ui__generic__tableStyle';
mobl.ui.generic.tdStyle = 'mobl__ui__generic__tdStyle';
mobl.ui.generic.trStyle = 'mobl__ui__generic__trStyle';
mobl.ui.generic.trStyle = 'mobl__ui__generic__trStyle';
mobl.ui.generic.trStyle = 'mobl__ui__generic__trStyle';
mobl.ui.generic.tdStyle = 'mobl__ui__generic__tdStyle';
mobl.ui.generic.tdStyle = 'mobl__ui__generic__tdStyle';
mobl.ui.generic.tdStyle = 'mobl__ui__generic__tdStyle';
mobl.ui.generic.tdStyle = 'mobl__ui__generic__tdStyle';
mobl.ui.generic.tdStyle = 'mobl__ui__generic__tdStyle';
mobl.ui.generic.tdStyle = 'mobl__ui__generic__tdStyle';
mobl.ui.generic.tdStyle = 'mobl__ui__generic__tdStyle';
mobl.ui.generic.tdStyle = 'mobl__ui__generic__tdStyle';

mobl.ui.generic.table = function(style, elements, callback) {
  var root4928 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var node838 = $("<table>");
  
  var ref236 = style;
  if(ref236.get() !== null) {
    node838.attr('class', ref236.get());
    subs__.addSub(ref236.addEventListener('change', function(_, ref, val) {
      node838.attr('class', val);
    }));
    
  }
  subs__.addSub(ref236.rebind());
  
  var nodes4275 = $("<span>");
  node838.append(nodes4275);
  subs__.addSub(mobl.ref(elements).addEventListener('change', function() {
    renderControl67();
  }));
  
  function renderControl67() {
    subs__.addSub((elements)(function(elements, callback) {
      var root4929 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root4929); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes4275;
      nodes4275 = node.contents();
      oldNodes.replaceWith(nodes4275);
    }));
  }
  renderControl67();
  root4928.append(node838);
  callback(root4928); return subs__;
  
  
  return subs__;
};

mobl.ui.generic.row = function(style, elements, callback) {
  var root4930 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var node839 = $("<tr>");
  
  var ref237 = style;
  if(ref237.get() !== null) {
    node839.attr('class', ref237.get());
    subs__.addSub(ref237.addEventListener('change', function(_, ref, val) {
      node839.attr('class', val);
    }));
    
  }
  subs__.addSub(ref237.rebind());
  
  var nodes4276 = $("<span>");
  node839.append(nodes4276);
  subs__.addSub(mobl.ref(elements).addEventListener('change', function() {
    renderControl68();
  }));
  
  function renderControl68() {
    subs__.addSub((elements)(function(elements, callback) {
      var root4931 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root4931); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes4276;
      nodes4276 = node.contents();
      oldNodes.replaceWith(nodes4276);
    }));
  }
  renderControl68();
  root4930.append(node839);
  callback(root4930); return subs__;
  
  
  return subs__;
};

mobl.ui.generic.cell = function(width, style, elements, callback) {
  var root4932 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var node840 = $("<td>");
  
  var ref238 = width;
  if(ref238.get() !== null) {
    node840.attr('width', ref238.get());
    subs__.addSub(ref238.addEventListener('change', function(_, ref, val) {
      node840.attr('width', val);
    }));
    
  }
  subs__.addSub(ref238.rebind());
  
  var ref239 = style;
  if(ref239.get() !== null) {
    node840.attr('class', ref239.get());
    subs__.addSub(ref239.addEventListener('change', function(_, ref, val) {
      node840.attr('class', val);
    }));
    
  }
  subs__.addSub(ref239.rebind());
  
  var nodes4277 = $("<span>");
  node840.append(nodes4277);
  subs__.addSub(mobl.ref(elements).addEventListener('change', function() {
    renderControl69();
  }));
  
  function renderControl69() {
    subs__.addSub((elements)(function(elements, callback) {
      var root4933 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root4933); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes4277;
      nodes4277 = node.contents();
      oldNodes.replaceWith(nodes4277);
    }));
  }
  renderControl69();
  root4932.append(node840);
  callback(root4932); return subs__;
  
  
  return subs__;
};

mobl.ui.generic.col = function(width, style, elements, callback) {
  var root4934 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var node841 = $("<td>");
  
  var ref240 = width;
  if(ref240.get() !== null) {
    node841.attr('width', ref240.get());
    subs__.addSub(ref240.addEventListener('change', function(_, ref, val) {
      node841.attr('width', val);
    }));
    
  }
  subs__.addSub(ref240.rebind());
  
  var ref241 = style;
  if(ref241.get() !== null) {
    node841.attr('class', ref241.get());
    subs__.addSub(ref241.addEventListener('change', function(_, ref, val) {
      node841.attr('class', val);
    }));
    
  }
  subs__.addSub(ref241.rebind());
  
  var nodes4278 = $("<span>");
  node841.append(nodes4278);
  subs__.addSub(mobl.ref(elements).addEventListener('change', function() {
    renderControl70();
  }));
  
  function renderControl70() {
    subs__.addSub((elements)(function(elements, callback) {
      var root4935 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root4935); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes4278;
      nodes4278 = node.contents();
      oldNodes.replaceWith(nodes4278);
    }));
  }
  renderControl70();
  root4934.append(node841);
  callback(root4934); return subs__;
  
  
  return subs__;
};

mobl.ui.generic.headerCol = function(width, style, elements, callback) {
  var root4936 = $("<span>");
  var subs__ = new mobl.CompSubscription();
  
  var node842 = $("<td>");
  
  var ref242 = width;
  if(ref242.get() !== null) {
    node842.attr('width', ref242.get());
    subs__.addSub(ref242.addEventListener('change', function(_, ref, val) {
      node842.attr('width', val);
    }));
    
  }
  subs__.addSub(ref242.rebind());
  
  var ref243 = style;
  if(ref243.get() !== null) {
    node842.attr('class', ref243.get());
    subs__.addSub(ref243.addEventListener('change', function(_, ref, val) {
      node842.attr('class', val);
    }));
    
  }
  subs__.addSub(ref243.rebind());
  
  
  var node843 = $("<strong>");
  
  var nodes4279 = $("<span>");
  node843.append(nodes4279);
  subs__.addSub(mobl.ref(elements).addEventListener('change', function() {
    renderControl71();
  }));
  
  function renderControl71() {
    subs__.addSub((elements)(function(elements, callback) {
      var root4937 = $("<span>");
      var subs__ = new mobl.CompSubscription();
      callback(root4937); return subs__;
      return subs__;
    }, function(node) {
      var oldNodes = nodes4279;
      nodes4279 = node.contents();
      oldNodes.replaceWith(nodes4279);
    }));
  }
  renderControl71();
  node842.append(node843);
  root4936.append(node842);
  callback(root4936); return subs__;
  
  
  
  return subs__;
};
(function(__ns) {
setTimeout(function() {
             scrollTo(0, -1);
           }, 250);
__ns.scrollUp = function() {
                  scrollTo(0, 0);
                };
__ns.setupScrollers = function() {
                        setTimeout(function() {
                                     var allScrollers = $("div.scroller");
                                     for(var i = 0; i < allScrollers.length; i++)
                                     {
                                       var scroller = allScrollers.eq(i);
                                       if(!scroller.data("scroller"))
                                       {
                                         scroller.data("scroller", new TouchScroll(scroller[0],{
                                                                                                 elastic: true
                                                                                               }));
                                       }
                                     }
                                   }, 250);
                      };
}(mobl.ui.generic));