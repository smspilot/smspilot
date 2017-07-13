var VERSION = '';
var APIKEY = '';
var EMAIL = '';
var BALANCE = '';
var PHONE = '';
var SENDER = '';
var SENDERS = '';
var MESSAGE = '';
var HISTORY = [];
var TAB = 'Send';
var sTimeout;
var BUSY = false;

function setPhone( p ) {
	TAB = 'Send';
	PHONE = p;
	chrome.storage.local.set({phone: p});
	updateUI();
}
function showProgress() {
	if ( BUSY ) {
		showError('Подождите...');
		return false;
	}
	BUSY = true;
	document.getElementById('divStatus').innerHTML = '<img src="progress_small.gif" />';

	return true;
}
function hideProgress() {
	BUSY = false;
	document.getElementById('divStatus').innerHTML = '';
	return true;
}
function showStatus( s ) {
	if (sTimeout) window.clearTimeout( sTimeout );
	sTimeout = window.setTimeout( function() { document.getElementById('divStatus').innerHTML = '&nbsp;'; }, 5000 );
	document.getElementById('divStatus').innerHTML = '<span style="color: green">'+s+'</span>';
}
function showError( e ) {
	if (sTimeout) window.clearTimeout( sTimeout );
	sTimeout = window.setTimeout( function() { document.getElementById('divStatus').innerHTML = '&nbsp;'; }, 5000 );
	document.getElementById('divStatus').innerHTML = '<span style="color: red;">'+e+'</span>';
}

function sendSMS() {
	if ( !showProgress() ) return false;
	PHONE = document.getElementById('phone').value;
	MESSAGE = document.getElementById('message').value;
	SENDER = document.getElementById('sender').value;
	chrome.storage.local.set({phone: PHONE,message: MESSAGE,sender: SENDER});
	var url = 'http://smspilot.ru/api.php';
	url += '?send=' + encodeURIComponent( MESSAGE );
	url += '&to=' + encodeURIComponent( PHONE );
	url += '&from=' + encodeURIComponent( SENDER );
	url += '&apikey=' + encodeURIComponent( APIKEY );
	url += '&source=10&format=json';
	
	var xhr = new XMLHttpRequest();
	
	xhr.open("GET", url, true);
	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4) {
			hideProgress();
			var j = JSON.parse( xhr.responseText );
			if ( j.error ) {
				showError( j.error.description_ru );
			} else {
				HISTORY[ HISTORY.length ] = {id: j.send[0].server_id, date: new Date().toString(), phone: PHONE, message: MESSAGE, sender: SENDER, status: j.send[0].status,error: j.send[0].error};
				if ( j.send[0].status >= 0 ) {
					showStatus('SMS на номер +'+PHONE+' за '+j.cost+' руб. успешно отправлено!');
				} else {
					showError('Что-то пошло не так при отправке SMS на номер +'+PHONE);
				}
				if ( HISTORY.length > 20 ) {
					HISTORY.shift();
				}
				chrome.storage.local.set({history: HISTORY});
			}
		}
	};
	xhr.onerror = function() { showError( this.status ); hideProgress(); };
	xhr.send();
}

function updateBalance() {
	if (!showProgress()) return false;
	var url = 'https://smspilot.ru/api.php?format=json&apikey='+encodeURIComponent( APIKEY );
	var xhr = new XMLHttpRequest();
	xhr.open("GET", url, true);
	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4) {
			hideProgress();
			var j = JSON.parse( xhr.responseText );
//			window.console.log( j );
			if ( j.error ) {
				showError( j.error.description_ru );
			} else {
				EMAIL = j.email;
				BALANCE = j.balance;
				//SENDER = j.default_sender;
				SENDERS = j.senders.split(',');
				chrome.storage.local.set({email: EMAIL,balance: BALANCE, sender: SENDER, senders: SENDERS});
				showStatus('Баланс обновлён');
				updateUI();
			}
		}
	};
	xhr.onerror = function() { showError( 'Ошибка ' + this.status ); hideProgress(); };
	xhr.send();
}

function updateStat() {
	var ids = [], h;
	for( var i = 0, len = HISTORY.length; i < len; i++ ) {
		h = HISTORY[i];
		if ( ( parseInt( h.status) === 0) || ( parseInt( h.status) === 1)) {
			ids[ ids.length ] = h.id;
		}
	}
	if ( ids.length === 0 ) { showStatus('Статусы уже проверены'); return false; }
	if ( !showProgress() ) { return false; }
	
	var url = 'http://smspilot.ru/api.php';
	url += '?check=' + encodeURIComponent( ids.join(',') );
	url += '&apikey=' + encodeURIComponent( APIKEY );
	url += '&fields=server_id,status,message&format=json';
	
	var xhr = new XMLHttpRequest();
	
	xhr.open("GET", url, true);
	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4) {
			hideProgress();
			var j = JSON.parse( xhr.responseText );
//			window.console.log( j );
			if ( j.error ) {
				showError( j.error.description_ru );
			} else {
				var changes = 0, js, hs, i, k, len, len2;
				for( i = 0, len = j.check.length; i < len; i++ ) {
					js = j.check[i];
					for( k = 0, len2 = HISTORY.length; k < len2; k++ ) {
						hs = HISTORY[k];
						if ( parseInt( hs.id ) === parseInt( js.server_id ) ) {
							if ( parseInt( hs.status ) !== parseInt( js.status ) ) {
								HISTORY[k].status = js.status;
								window.console.log( js );
								if (hs.message === 'HLR' ) {
									HISTORY[k].message = js.message;
								}
								changes++;
							}
							break;
						}
					}
				}
				if ( changes > 0 ) {
					showStatus('Изменились статусы: '+changes );
					chrome.storage.local.set({history: HISTORY});
					updateUI();
				} else {
					showStatus('Изменений нет');
				}
			}
		}
	};
	xhr.onerror = function() { showError( this.status ); hideProgress(); };
	xhr.send();

}


function saveSettings() {
	APIKEY = document.getElementById('apikey').value;
	
	chrome.storage.sync.set( {apikey: APIKEY}, function() {
		updateBalance();
	});
//	document.getElementById('
}
function openTab( name ) {
	TAB = name;
	updateUI();
}

function copySMS( id ) {
	var s;
	for( var i = 0, len = HISTORY.length; i < len; i++) {
		s = HISTORY[i];
		if ( parseInt( s.id) === parseInt( id ) ) {
			PHONE = s.phone;
			MESSAGE = s.message;
			SENDER = s.sender;
			TAB = 'Send';
			updateUI();
			return;
		}
	}
}

function updateUI() {
	var i = len = 0;
	//
	//alert( BALANCE );
//	document.getElementById('sVersion').innerHTML = VERSION;
	document.getElementById('apikey').value = APIKEY;
	document.getElementById('phone').value = PHONE;
	document.getElementById('message').value = MESSAGE;
	document.getElementById('sBalance').innerHTML = EMAIL+': '+BALANCE;
	
	var $s = document.getElementById('sender');
	while( $s.remove(0) === 0 ) {}

	for( i = 0, len = SENDERS.length; i < len; i++ ) {
		var option = document.createElement("option");
		option.text = option.value = SENDERS[i];
		$s.add(option);
	}
	$s.value = SENDER;

	document.getElementById('dtSend').className = '';
	document.getElementById('ddSend').className = '';
	document.getElementById('dtHistory').className = '';
	document.getElementById('ddHistory').className = '';
	document.getElementById('dtSettings').className = '';
	document.getElementById('ddSettings').className = '';

	document.getElementById('dt'+TAB ).className = 'selected';
	document.getElementById('dd'+TAB ).className = 'selected';
	
	
	if (TAB === 'History' ) {
		var s;
		var $t = document.getElementById('tblHistory');
		for ( i = 1, len = $t.rows.length; i < len; i++) {
			$t.deleteRow(1);
		}

		var dt,d,m,y,mi,se, st, istatus, $r, $c, $a;
		for ( i = 0, len = HISTORY.length; i < len; i++ ) {
			s = HISTORY[i];
			dt = new Date( s.date );
			d = dt.getDate();
			d = (d < 10) ? '0'+d : d;
			m = dt.getMonth() + 1;
			m = (m<10) ? '0'+m : m;
			y = dt.getFullYear();
			mi = dt.getMinutes();
			mi = (mi < 10) ? '0'+mi : mi;
			se = dt.getSeconds();
			se = (se < 10) ? '0'+se : se;
			
			d = d+'.'+m+'.'+y+' '+mi+':'+se;

			istatus = parseInt( s.status );
			if ( istatus === -2 ) {
				st = '<span style="color: red">Ошибка</span> (<a href="https://smspilot.ru/apikey.php#err" target="_blank">'+s.error+'</a>)';
			} else if ( istatus === -1 ) {
				st = '<span style="color: red">Не доставлено</span> (<a href="https://smspilot.ru/faq.php#q65" target="_blank">?</a>)';
			} else if ( istatus === 0 ) {
				st = 'В очереди';
			} else if ( istatus === 1 ) {
				st = 'У оператора';
			} else if ( istatus === 2 ) {
				st = '<span style="color: green">Доставлено</span>';
			}
			
			$r = $t.insertRow(1);
			$c = $r.insertCell(0);
			$c.innerHTML = d;
			$c.style.whiteSpace = 'nowrap';
			$c.style.verticalAlign = 'top';
			
			$c = $r.insertCell(1);
			$c.innerHTML = s.phone;
			$c.style.verticalAlign = 'top';
			
			$r.insertCell(2).innerHTML = '<b>'+s.sender+'</b><br/><small><pre style="margin: 0">'+s.message+'</pre></small>';
			
			$c = $r.insertCell(3);
			$c.innerHTML = st;
			$c.style.whiteSpace = 'nowrap';
			$c.style.verticalAlign = 'top';
			
			$a = document.createElement("a");
			$a.href = '#';
			$a.text = 'Копировать';
			$a.id = 'ah'+s.id;
			$a.addEventListener('click', function() { copySMS( this.id.substr(2) ); });
			$c = $r.insertCell(4);
			$c.appendChild( $a );
			$c.style.verticalAlign = 'top';
		}
	}
}

function clearHistory() {
	HISTORY.length = 0;
	chrome.storage.local.set({history: HISTORY}, function() {
		updateUI();
	});
}
document.addEventListener('DOMContentLoaded', function() {
//	document.getElementById('aClose').addEventListener('click', function() { window.close(); });
	document.getElementById('btnClearMessage').addEventListener('click', function() { document.getElementById('message').value = ''; });
	document.getElementById('btnTest').addEventListener('click', function() { document.getElementById('message').value = 'проверка'; });
	document.getElementById('btnHLR').addEventListener('click', function() { document.getElementById('message').value = 'HLR'; });
	document.getElementById('btnPING').addEventListener('click', function() { document.getElementById('message').value = 'PING'; });
	document.getElementById('btnSend').addEventListener('click', sendSMS );
	document.getElementById('btnSaveSettings').addEventListener('click', saveSettings );
	document.getElementById('aUpdateBalance').addEventListener('click', updateBalance );
	document.getElementById('btnUpdateStat').addEventListener('click', updateStat );
	document.getElementById('aClearHistory').addEventListener('click', clearHistory );
	
	document.getElementById('phone').addEventListener('blur', function() {
		PHONE = this.value.replace(/\D+/,'');
		this.value = PHONE;
		chrome.storage.local.set({phone: PHONE});
	});
	document.getElementById('message').addEventListener('blur', function() {
		MESSAGE = this.value.replace(/^\s+/,'');
		MESSAGE = MESSAGE.replace(/\s+$/, '');
		this.value = MESSAGE;
		chrome.storage.local.set({message: MESSAGE});
	});
	document.getElementById('sender').addEventListener('change', function() {
		SENDER = this.value;
		chrome.storage.local.set({sender: SENDER});
	});


	
	var manifest = chrome.runtime.getManifest();
	VERSION = manifest.version;
		
	chrome.storage.sync.get('apikey', function( r ) {
		if ( r.apikey ) {
			APIKEY = r.apikey;
		} else {
			TAB = 'Settings';
		}
		chrome.storage.local.get(['phone','message','sender','senders','history','email','balance'], function(r) {
//			window.console.log(r);
			PHONE = (r.phone) ? r.phone : '';
			MESSAGE = (r.message) ? r.message : 'проверка';
			SENDER = (r.sender) ? r.sender : 'INFORM';
			SENDERS = (r.senders) ? r.senders : ['INFORM'];
			HISTORY = (r.history) ? r.history : [];
			EMAIL = (r.email) ? r.email : '';
			BALANCE = (r.balance) ? r.balance : '';
			updateUI();
		});
	});

	document.getElementById('dtSend').addEventListener('click', function() { openTab('Send'); });
	document.getElementById('dtHistory').addEventListener('click', function() { openTab('History'); });
	document.getElementById('dtSettings').addEventListener('click', function() { openTab('Settings'); });

});