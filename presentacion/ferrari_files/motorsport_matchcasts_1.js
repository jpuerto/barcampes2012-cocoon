YAHOO.EU.widget.Countdown = {
 
 delay : 30,
 
 init : function(sID){
 if(YAHOO.util.Dom.get(sID)) {
 var a = YAHOO.util.Dom.get(sID).getElementsByTagName("span");
 var oTime = a[1];
 var oNow = a[3];
 this.oCountDown = a[2];
 YAHOO.util.Dom.setStyle(oNow, "display", "none");
 YAHOO.util.Dom.setStyle(oTime, "display", "inline");
 YAHOO.util.Dom.get(sID).getElementsByTagName("a")[0].onmouseover = 
 YAHOO.util.Dom.get(sID).getElementsByTagName("a")[0].onmouseout = function(e){
 e = e || window.event;
 if(this.tagName.toLowerCase() == "a"){
 YAHOO.util.Dom.setStyle(oNow, "display", (e.type == "mouseover") ? "inline" : "none");
 YAHOO.util.Dom.setStyle(oTime, "display", (e.type == "mouseover") ? "none" : "inline");
 YAHOO.util.Event.stopEvent(e);
 }
 }
 this.oUpdate = new YAHOO.util.CustomEvent("countdown");
 this.nCurrent = this.delay;
 window.setInterval(function(){
 YAHOO.EU.widget.Countdown.update();
 }, 1000);
 return true;
 }
 return false;
 },
 update : function(){
 this.nCurrent --;
 this.oCountDown.innerHTML = this.nCurrent;
 if(this.nCurrent == 0){
 this.oUpdate.fire();
 this.nCurrent = this.delay;
 }
 }
};
YAHOO.EU.widget.oLiveTrackers = function(){
 return {
 init : function(){
 var self = this;
 var oTest = YAHOO.util.Dom.get("yeug-tracker-live") || YAHOO.util.Dom.get("yeug-live-comments") || null;
 if(!oTest){
 return;
 }
 this.sType = (YAHOO.util.Dom.hasClass(oTest, "multi")) ? "multilive" : "";
 this.sSportID = (oTest && oTest.className.match(/\bs(\d*)\b/)) ? oTest.className.match(/\bs(\d*)\b/)[1] : "";
 this.sEventID = (oTest && oTest.className.match(/\be(\d*)\b/)) ? oTest.className.match(/\be(\d*)\b/)[1] : "";
 this.sMatchID = (oTest && oTest.className.match(/\bm(\d*)\b/)) ? oTest.className.match(/\bm(\d*)\b/)[1] : "";
 },
 
 update : function(){
 var oComments = YAHOO.util.Dom.get("yeug-live-comments");
 if(oComments){
 var aComments = oComments.getElementsByTagName("li");
 var nLatest = (aComments.length) ? aComments[0].id.replace("comment", "") : "";
 var sClass = (aComments.length) ? aComments[0].className.indexOf("alt") : "";
 }else{
 var nLatest = "";
 var sClass = "";
 }
 YAHOO.util.Connect.asyncRequest("GET", "/eurosport_livestreamer/streamermodule.php?property=" + YAHOO.EU.property + "&lastcomment=" + nLatest + "&class=" + sClass + "&sportid=" + this.sSportID + "&eventid=" + this.sEventID + "&type=" + this.sType + "&matchid=" + this.sMatchID + "&u=" + new Date().valueOf(), {
 success : this.updated,
 scope : this
 }
 );
 },
 
 updated : function(oResponse){
 try{
 var oReturn = eval( '(' + oResponse.responseText.replace(/\n/g, "").replace(/\r/g, "") + ')' );
 }catch(e){
 return;
 }
 if(oReturn.statusId && YAHOO.EU.matchCastStatusId != oReturn.statusId){
 var s = self.location + "";
 s = (s.indexOf("?")>-1) ? s.substring(0, s.indexOf("?")) : s;
 self.location = s + "?u=" + new Date().valueOf();
 }
 if(YAHOO.util.Dom.get("yeug-tracker-live")){
 YAHOO.util.Dom.get("yeug-tracker-live").innerHTML = oReturn.live;
 }
 if(oReturn.statusId != "1" && YAHOO.util.Dom.get("yeug-tracker-livestandings") && oReturn.live && YAHOO.util.Dom.get("yeug-tracker-livestandings").getElementsByTagName("table").length){
 YAHOO.util.Dom.get("yeug-tracker-livestandings").getElementsByTagName("table")[0].parentNode.innerHTML = oReturn.live;
 }
 if(!YAHOO.util.Dom.get("yeug-live-comments")){
 return;
 }
 var aComments = YAHOO.util.Dom.get("yeug-live-comments").getElementsByTagName("ol");
 var sComments = oReturn.comments;
 if(sComments.match(/[a-zA-Z]/)){
 if(!aComments.length){
 var ul = YAHOO.util.Dom.get("yeug-live-comments").getElementsByTagName("ul")[0];
 oComments = document.createElement("ol");
 ul.parentNode.appendChild(oComments);
 ul.parentNode.removeChild(ul);
 
 }else{
 oComments = aComments[0];
 }
 YAHOO.util.Dom.removeClass(oComments.getElementsByTagName("li")[0], "first");
 oComments.innerHTML = oReturn.comments + oComments.innerHTML;
 YAHOO.util.Dom.addClass(oComments.getElementsByTagName("li")[0], "first");
 this.aNew = YAHOO.util.Dom.getElementsByClassName("new", "li", oComments);
 var oAnim = new YAHOO.util.Anim(this.aNew, {opacity : {from:0,to:1}}, 0.5, YAHOO.util.Easing.easeOut);
 oAnim.onComplete.subscribe(this.unclass, this, true);
 oAnim.animate();
 }
 },
 
 unclass : function(){
 YAHOO.util.Dom.removeClass(this.aNew, "new");
 }
 }
}();
YAHOO.util.Event.on(window, "load", function(){
 if(document.getElementById("countdown")){
 YAHOO.EU.widget.Countdown.init("countdown");
 YAHOO.EU.widget.oLiveTrackers.init();
 YAHOO.EU.widget.Countdown.oUpdate.subscribe(function(){
 YAHOO.EU.widget.oLiveTrackers.update();
 if(YAHOO.util.Dom.get("yeug-live-comments").getElementsByTagName("ol").length){
 document.getElementById("countdown").style.display = "block";
 }
 });
 if(!YAHOO.util.Dom.get("yeug-live-comments").getElementsByTagName("ol").length){
 document.getElementById("countdown").style.display = "none";
 }
 }
});