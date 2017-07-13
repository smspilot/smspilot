var _W;
function W() {
	if ( _W && !_W.closed ) {
		_W.focus();
	} else {
		var w = 740, h = 600;
		var left = (screen.width/2)-(w/2);
		var top = (screen.height/2)-(h/2);
		_W = window.open(chrome.extension.getURL('popup.html'), 'SMSPILOT.RU for Chrome', 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
	}
	return _W;
}
chrome.contextMenus.create({
	title: "Отправить SMS на %s",
	contexts:["selection"],
	onclick: function(info, tab) {
		var w = W(), p = info.selectionText.replace(/\D/, '');
		if (w.setPhone) {
			w.setPhone( p );
		} else {
			w.onload = function() {
				w.setPhone( p );
			}
		}
	}
});
chrome.browserAction.onClicked.addListener( W );