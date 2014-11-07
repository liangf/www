function sa_s4_getscript(e,t)
{
	var n;
	if(window.XDomainRequest) {
		n=new XDomainRequest;n.open("GET",e,true);
		n.onload=function(){
			var e=n.responseText;
			if(t&&typeof t==="function") {
				t(n.responseText)
			}
		};
		n.onprogress=function(){};
		n.ontimeout=function(){};
		n.onerror=function(){};
		setTimeout(function(){n.send()},0)
	}
	else {
		if(window.XMLHttpRequest){
			n=new XMLHttpRequest
		}
		else{
				n=new ActiveXObject("Microsoft.XMLHTTP")
			}
			n.onreadystatechange=function(){
				if(n.readyState==4&&n.status==200){
					if(t&&typeof t==="function"){
						t(n.responseText)
					}
				}
			};
			n.open("GET",e,true);
			n.onprogress=function(){};
			n.ontimeout=function(){};
			n.onerror=function(){};
			setTimeout(function(){n.send()},0)
	}
}


function sa_s4_split_var(e,t){
	var n=e.split(";");
	for(a in n){
		var r=n[a].search(t);
		if(r!=-1){
			var i=n[a].indexOf("=");
			var s=n[a].substr(0,i+1);
			var o="";
			var u="'";
			var f=n[a].replace(s,o);
			var l=f.replace(u,o);
			var c=l.replace(u,o);
			return c.replace(/^\s+|\s+$/g,"")
		}
	}
}

			
function sa_s4_split_css(e,t){
	var n=e.split("var");
	for(a in n){
		var r=n[a].search(t);
		if(r!=-1){
			var i=n[a].indexOf("=");
			var s=n[a].substr(0,i+1);
			var o="";
			var u='"';
			var f=n[a].replace(s,o);
			var l=f.replace(u,o);
			var c=l.replace(u,o);
			return c.replace(/^\s+|\s+$/g,"")
		}
	}
}
			
			
function sa_s4_split_data_url(e,t){
	var n=e.split("var");
	for(a in n){
		var r=n[a].search(t);
		if(r!=-1){
			var i=n[a].indexOf("=");
			var s=n[a].substr(0,i+1);
			var o="";
			var u='"';
			var f="";
			var l='"';
			var c=n[a].replace(s,o);
			var h=c.replace(u,o);
			var p=h.replace(u,o);
			var d=p.replace(/.$/,"");
			return d.replace(/^\s+|\s+$/g,"")
		}
	}
}
	
	
function sa_cb_served_click(e){}

function getIncLvl(e,t){
	t=t.replace(/[\[]/,"\\[").replace(/[\]]/,"\\]");
	var n="[\\?&]"+t+"=([^&#]*)";
	var r=new RegExp(n);
	var i=r.exec(e);
	if(i==null){return"0"}
	else{return i[1]}
}


function replaceCharShare(e,t,n){
	var r=new String(e);
	var i=r.indexOf(t);
	while(i>-1){
		r=r.replace(t,n);
		i=r.indexOf(t)
	}
	return r
}


function served_click_count(e,t,n,r,i){
	if(typeof i=="undefined"){i="0"}
	var s=""+saJsHost+"//c."+js_host+"/c-set-served-click.php?site_id="+e+"&service_id="+t+"&serve_type="+n+"&scrap_label="+r+"&incent="+i;
	sa_s4_getscript(s,sa_cb_served_click)
}

function sa_getScript(){
	var e=Math.floor(Math.random()*9e5)+1e5;
	var t=document.createElement("script");
	t.src=s_all_assync_url+"&rnd="+e;t.onload=sa_callback;
	t.onreadystatechange=function(){
		t.onload=null;
		if(this.readyState!="loading"){
			sa_callback()
		}
	};
	document.getElementsByTagName("head")[0].appendChild(t)
}
	
	
function sa_callback(){sa_cb_getresponce()}


function ShowIframeBoxWithoutJquery(e){
var t="
		<div id='sa_s4_popup_close'>
			<a href = 'javascript:void(0)' onclick=document.getElementById('sa_s4_popup').style.display='none';document.getElementById('sa_s4_popup_overlay').style.display='none';> <img src='"+saJsHost+"//cdn."+js_host+"/c/sabox/closelabel.png' alt='Close'>
			</a>
		</div>
		<iframe id='socialannex-frame' name='socialannex-frame-sas' frameborder='0' hspace='0' scrolling='no' src='"+saJsHost+"//c."+js_host+"/popup.php?"+e+"'>
		</iframe>
		<div id='sa_s4_branding'>"+get_link_popup+"</div>";
		document.getElementById("sa_s4_popup").innerHTML="";
		document.getElementById("sa_s4_popup").innerHTML=t;document.getElementById("sa_s4_popup_overlay").style.display="block";document.getElementById("sa_s4_popup").style.display="block"
}


function ShowForDirectCpCd(e){
	var t="
			<div id='sa_s4_popup_close'>
				<a href = 'javascript:void(0)' onclick =document.getElementById('sa_s4_popup').style.display='none';document.getElementById('sa_s4_popup_overlay').style.display='none';> 
					<img src='"+saJsHost+"//cdn."+js_host+"/c/sabox/closelabel.png' alt='Close'>
				</a>
			</div>
			<iframe id='socialannex-frame' name='socialannex-frame-sas' frameborder='0' hspace='0' scrolling='no' src='"+saJsHost+"//s4."+js_host+"/s4-direct-cp-cd-popup.php?"+e+"'>
			</iframe>
			<div id='sa_s4_branding'>"+get_link_popup+"</div>";
			document.getElementById("sa_s4_popup").innerHTML="";document.getElementById("sa_s4_popup").innerHTML=t;document.getElementById("sa_s4_popup_overlay").style.display="block";document.getElementById("sa_s4_popup").style.display="block"
}
			
			
function sa_cb_getresponce(e){
	if(typeof sa_siteid!="undefined"){
		siteid=sa_siteid}o="socialannex.com";
		inc_ck_val=nifrm_ck;
		var t=1;
		if(t==1){
			var n=1;
			var r="";
			var i=document.location.protocol;
			var s=new Array;
			var o=o;
			var u=0;
			function a(e){
				var t="";
				var n=window.location.href;
				if(n.indexOf("?")>-1){
					var r=n.substr(n.indexOf("?"));
					var i=r.split("&");
					for(var s=0;s<i.length;s++){
						if(i[s].indexOf(e+"=")>-1){
							var o=i[s].split("=");t=o[1];
							return t;break
					}
				}
			}
		}				
		function f(e){
			var t=window.document.URL.toString();
			if(t.indexOf("?")>0){
				var n=t.split("?");
				var r=n[1].split("&");
				var i=new Array(r.length);
				var s=new Array(r.length);
				var o=0;
				for(o=0;o<r.length;o++){
					var u=r[o].split("=");
					i[o]=u[0];
					if(u[1]!="")s[o]=unescape(u[1]);
					else s[o]="No Value"
				}
				for(o=0;o<r.length;o++){if(i[o]==e){
					return s[o]
				}
			}
			return"No Parameters Found"
		}
	}
	function l(e,t,n){
		function a(e){
			var t=sa_s4_split_var(e,"landing_content");
			var n=t.length;if(n>10){
				var u=sa_s4_split_var(e,"incentive_data");
				var a;var l=new String(t);
				var c="@nocoupon@";
				var p=l.indexOf(c);
				if(p>-1){
					a=l.replace("@nocoupon@","<a href='#' onclick=show_coupon_on_view_link('"+r+"','"+s+"','"+u+"');>Click here to view coupon</a>");
					h(a,s,r)
				}
				else{
					function d(e){
						var t=f("cdata");
						var n=e.replace("var coupon_code_receiver ='","");
						var i=n.replace("';","");a=i;h(a,s,r)
					}
					var v=""+i+"//c."+o+"/c-read-receiver-coupon.php?cpdata="+u+"&click_status=0";sa_s4_getscript(v,d)
				}
			}
			var r;
			var s;
			var u="share";
			var l=f("cdata");
			var c=""+i+"//c."+o+"/c-get_cookie_value.php?site_id="+e+"&order_id=0&sale_amount=0&cookie_data="+l;
			sa_s4_getscript(c,a)
		}
		
		function c(e,t,n){
			var r=new String(e);
			var i=r.indexOf(t);
			while(i>-1){
				r=r.replace(t,n);
				i=r.indexOf(t)
			}
			return r
		}
	
		function h(e,t,n){
			var r="http:";
			e=e.replace(new RegExp(r,"g"),i);
			var s=e.length;
			if(s>10){
				var a="
						<span id='social_sc_10'>></span>
						<a id='various_share' href='#share' title='titletest'></a>";
				var f='<div id="sa_s4_coupon_code_outer">'+e+"</div>";
				var l="
						<div id='sa_s4_cpcd_popup_overlay' class='sa_s4_cpcd_popup_overlay_popup_css' style='display: block;'></div>
						<div id='sa_coupon_code' class='sa_s4_coupon_popup'  style='display: block;'>
							<div style='float:right;' id='sa_s4_popup_close'>
								<a href = 'javascript:void(0)' onclick =document.getElementById('sa_coupon_code').style.display='none';document.getElementById('sa_s4_cpcd_popup_overlay').style.display='none';> 
									<img src='"+i+"//cdn."+o+"/c/sabox/closelabel.png' alt='Close'>
								</a>
							</div>
							<div id='share' style='overflow:auto;'> "+f+"</div>
						</div>";
				if(u=="1"||u==1){
					var c=document.getElementsByTagName("body")[0];
					var h=document.createElement("div");
					h.id="sa_s4_wl_popup";
					c.appendChild(h);
					document.getElementById("sa_s4_wl_popup").innerHTML=l
				}
				else if(u=="0"||u==0){
					var c=document.getElementsByTagName("body")[0];
					var h=document.createElement("div");
					h.id="sa_s4_wl_popup";
					c.appendChild(h);
					document.getElementById("sa_s4_wl_popup").innerHTML=l
				}
			}
		}
								
		function p(e,t,n){
			function s(e){
				r=sa_s4_split_var(e,"coupon_code_receiver");
				var t='
					<table width="95%" border="0" cellspacing="2" cellpadding="2" align="left">'+"<tr>"+"<td>"+"</td>"+"</tr>"+"<tr>"+"<td>"+r+"</td>"+"</tr>"+"</table>";
				var n="
						<div  id='sa_coupon_code' class='sa_s4_coupon_popup' style='display: block;'>
							<div style='float:right;' >
								<a href = 'javascript:void(0)' onclick =document.getElementById('sa_coupon_code').style.display='none';> 
									<img src='"+i+"//cdn."+o+"/c/sabox/closelabel.png' alt='Close'>
								</a>
							</div>"+'
							<div id="share" style="overflow:auto;">'+t+"</div>"+"
						</div>";
				if(u=="1"||u==1){
					document.body.innerHTML=n+document.body.innerHTML
				}
				else if(u=="0"||u==0){
					document.body.innerHTML=n+document.body.innerHTML
				}
			}
			var r;
			e=parseInt(e);
			t=parseInt(t);
			var a=""+i+"//c."+o+"/c-read-receiver-coupon.php?cpdata="+n+"&click_status=1";
			sa_s4_getscript(a,sa_cb_popup_width)
		}
		
		var i=document.location.protocol;navigator.sayswho=function(){
			var e=navigator.appName,t=navigator.userAgent,n;
			var r=t.match(/(opera|chrome|safari|firefox|msie)\/?\s*(\.?\d+(\.\d+)*)/i);
			if(r&&(n=t.match(/version\/([\.\d]+)/i))!=null) r[2]=n[1];
			r=r?[r[1]]:[e,navigator.appVersion,"-?"];
			return r
		}();
			
		function d(e,t,n){
			var r=new String(e);
			var i=r.indexOf(t);
			while(i>-1){
				r=r.replace(t,n);
				i=r.indexOf(t)}return r
			}
			function v(){
				var e="0";
				if(document.all&&!document.addEventListener){e="1"}
				return e
			}
			var m="";var g="";var y="";var b="";var w=lb_flag;
			var E=client_fb_app_id;var S="";var x="";var T="";
			var N=0;var r=0;var C=Math.floor(Math.random()*9e5)+1e5;
			var k=php_site_manage_id;var L=s4_email_share;var A=display_branding;
			var O=s4_is_regular_popup;var M="";var _="";var D=new Array;var P=document.domain;
			var H=P.replace(".","_");var B=php_fb_api_key;var j=exit_popup_message;var F;var I=new Array;
			var q=new Array;var R=new Array;var U=new Array;var z=new Array;var W=new Array;var X=new Array;
			var V;var J;var K;var Q="";var G=s4_inc_btn;var Y=s4_inc_id;var Z="";
			if(A=="1"){
				if(local_tc=="0"){
					if(!/iPhone/.test(navigator.userAgent)&&!/iPad/.test(navigator.userAgent)&&!/Android/.test(navigator.userAgent)){
						if(local_s4_branding_lang=="0"){
							if(local_s4_already_like!="1"){
								Z='
									<div style="width:100%;padding:5px 0;height:auto;float:left;">
										<ul style="padding:0px;margin:0px;">'+'
											<li style="list-style:none;width:33%;padding:0px;margin:0px;display:inline-block;float:left;text-align:left;">'+'
												<img src="'+i+'//cdn.socialannex.com/images/blank.png" border="0" />
											</li>'+'
											<li style="list-style:none;width:33%;padding:0px;margin:0px;display:inline-block;float:left;text-align:center;">'+'
												<a href="http://socialannex.com" target="_blank">
													<img src="'+i+'//cdn.socialannex.com/images/power_by.jpg" alt="Powered by Social Annex" border="0" />
												</a>
											</li>'+'
											<li style="list-style:none;width:33%;padding:0px;margin:0px;display:inline-block;float:left;text-align:right;">'+'
												<img src="'+i+'//cdn.socialannex.com/images/safe_lock.jpg" alt="Safe and Secure lock" border="0" />
											</li>
										</ul>
									</div>'
							}
							else{
								Z='
									<div style="width:100%;padding:5px 0;height:auto;float:left;">
										<ul style="padding:0px;margin:0px;">'+'
											<li style="list-style:none;width:33%;padding:0px;margin:0px;display:inline-block;float:left;text-align:left;">'+'
												<a href="javascript:void(0);"  onclick="sa_s4_already_like();"> '+local_s4_already_like_txt+" </a>
											</li>"+'
											<li style="list-style:none;width:33%;padding:0px;margin:0px;display:inline-block;float:left;text-align:center;">'+'
												<a href="http://socialannex.com" target="_blank">
													<img src="'+i+'//cdn.socialannex.com/images/power_by.jpg" alt="Powered by Social Annex" border="0" />
												</a>
											</li>'+'
											<li style="list-style:none;width:33%;padding:0px;margin:0px;display:inline-block;float:left;text-align:right;">'+'
												<img src="'+i+'//cdn.socialannex.com/images/safe_lock.jpg" alt="Safe and Secure lock" border="0" />
											</li>
										</ul>
									</div>'
							}
						}
						else{
							Z='
								<div style="width:100%;padding:5px 0;height:auto;float:left;">
									<ul style="padding:0px;margin:0px;">'+'
										<li style="list-style:none;width:33%;padding:0px;margin:0px;display:inline-block;float:left;text-align:left;">'+'
											<img src="'+i+'//cdn.socialannex.com/images/blank.png" border="0" /></li>'+'
										<li style="list-style:none;width:33%;padding:0px;margin:0px;display:inline-block;float:left;text-align:center;">'+'
											<a href="http://socialannex.com" target="_blank">
												<img src="'+i+'//cdn.socialannex.com/images/power_by.jpg" alt="Powered by Social Annex" border="0" />
											</a>
										</li>'+'
										<li style="list-style:none;width:33%;padding:0px;margin:0px;display:inline-block;float:left;text-align:right;">'+'
											<img src="'+i+'//cdn.socialannex.com/images/safe_lock.jpg" alt="Safe and Secure lock" border="0" />
										</li>
									</ul>
								</div>'
						}
					}
					else{
						Z='
							<div style="width:100%;padding:5px 0;height:auto;float:left;">
								<ul style="padding:0px;margin:0px;">'+'
									<li style="list-style:none;width:33%;padding:0px;margin:0px;display:inline-block;float:left;text-align:left;">'+'
										<img src="'+i+'//cdn.socialannex.com/images/blank.png" border="0" />
									</li>'+'
									<li style="list-style:none;width:33%;padding:0px;margin:0px;display:inline-block;float:left;text-align:center;">'+'
										<a href="http://socialannex.com" target="_blank">
											<img src="'+i+'//cdn.socialannex.com/images/power_by.jpg" alt="Powered by Social Annex" border="0" />
										</a>
									</li>'+'
									<li style="list-style:none;width:33%;padding:0px;margin:0px;display:inline-block;float:left;text-align:right;">'+'
										<img src="'+i+'//cdn.socialannex.com/images/safe_lock.jpg" alt="Safe and Secure lock" border="0" />
									</li>
								</ul>
							</div>'
					}
				}
				else{
					if(!/iPhone/.test(navigator.userAgent)&&!/iPad/.test(navigator.userAgent)&&!/Android/.test(navigator.userAgent)){
						Z='
							<div style="width:100%;padding:5px 0;height:auto;float:left;">
								<ul style="padding:0px;margin:0px;">'+'
									<li style="list-style:none;width:33%;padding:0px;margin:0px;display:inline-block;float:left;text-align:left;">'+'
										<a href="'+local_tc_url+'"  target="_blank">
											<img src="'+i+'//cdn.socialannex.com/images/t_c.png" alt="Terms & Conditions" border="0" />
										</a>
									</li>'+'
									<li style="list-style:none;width:33%;padding:0px;margin:0px;display:inline-block;float:left;text-align:center;">'+'
										<a href="http://socialannex.com" target="_blank">
											<img src="'+i+'//cdn.socialannex.com/images/power_by.jpg" alt="Powered by Social Annex" border="0" />
										</a>
									</li>'+'
									<li style="list-style:none;width:33%;padding:0px;margin:0px;display:inline-block;float:left;text-align:right;">'+'
										<img src="'+i+'//cdn.socialannex.com/images/safe_lock.jpg" alt="Safe and Secure lock" border="0" />
									</li>
								</ul>
							</div>'
					}
					else{
						Z='
							<div style="width:100%;padding:5px 0;height:auto;float:left;">
								<ul style="padding:0px;margin:0px;">'+'
									<li style="list-style:none;width:33%;padding:0px;margin:0px;display:inline-block;float:left;text-align:left;">'+'
										<a href="'+local_tc_url+'"  target="_blank">
											<img src="'+i+'//cdn.socialannex.com/images/sor.png" alt="Terms & Conditions" border="0" />
										</a>
									</li>'+'
									<li style="list-style:none;width:33%;padding:0px;margin:0px;display:inline-block;float:left;text-align:center;">'+'
										<img src="'+i+'//cdn.socialannex.com/images/blank.png" border="0" />
									</li>'+'
									<li style="list-style:none;width:33%;padding:0px;margin:0px;display:inline-block;float:left;text-align:right;">'+'
										<img src="'+i+'//cdn.socialannex.com/images/blank.png" border="0" />
									</li>
								</ul>
							</div>'
					}
				}
			}
			get_link_popup=Z;
			var et;var tt="";var nt="";var rt="";var it="";var st="";var ot="";var ut="";var at=fancy_exist;
			var ft=image_align;var lt=prd_div_name;var ct=prd_div_present;var ht=scrape_file;var pt=s4_direct_cp_cd;
			var dt=Math.floor(Math.random()*9e5)+1e5;
			var vt=Math.floor(Math.random()*9e5)+1e5;
			var mt=/Safari/.test(navigator.userAgent);if(navigator.sayswho!="Safari"){dt="1"}
			var gt;var yt;var bt;var wt;var Et="";var St="";var xt="";var Tt="";var Nt;var Ct;
			var kt=/Safari/.test(navigator.userAgent);var Lt=0;var At=0;var Ot;var Mt="0";
			if(typeof sa_siteid!="undefined"){siteid=sa_siteid}
			if(serve_unique=="1"){served_click_count(siteid,4,0,w,Y);Mt="0"}
			if(serve_unique=="0"){served_click_count(siteid,4,1,w,Y);Mt="1"}
			
			function _t(e){
				window.open(e,"SocialAnnex","status = 1, height = 400, width = 600, resizable=1")
			}
			function Dt(e){
				function s(e){
					function N(e,t,n){
						var r=new Date;r.setFullYear(r.getFullYear()+2);
						var i=escape(t)+(n==null?"":";
						expires="+r.toGMTString());
						document.cookie=e+"="+i
					}
					function C(e){
						var t=document.cookie;
						var n=t.indexOf(" "+e+"=");
						if(n==-1){n=t.indexOf(e+"=")
					}
					if(n==-1){t="null"}
					else{
						n=t.indexOf("=",n)+1;
						var r=t.indexOf(";",n);
						if(r==-1){r=t.length}
						t=unescape(t.substring(n,r))
					}
					return t
				}
				var n=sa_s4_split_var(e,"cookie_name");
				var r=sa_s4_split_var(e,"output1");
				var s=sa_s4_split_var(e,"output2");
				var u=sa_s4_split_var(e,"output3");
				var f=sa_s4_split_var(e,"output4");
				var c=sa_s4_split_var(e,"output5");
				var h=sa_s4_split_var(e,"output6");
				var p=sa_s4_split_var(e,"output7");
				var d=sa_s4_split_var(e,"output8");
				var d=sa_s4_split_var(e,"output8");
				var v=sa_s4_split_var(e,"inc_ck_val");
				var m=sa_s4_split_var(e,"site_id");
				if(siteid==0){siteid=m}
				if(typeof sa_siteid!="undefined"){siteid=sa_siteid}
				var g=sa_s4_split_var(e,"sa_s4_widget_visit");
				var y=sa_s4_split_data_url(e,"sa_s4_widget_data_uri");
				var b=sa_s4_split_css(e,"sa_s4_get_css");
				var S=document.getElementsByTagName("head")[0];
				var x=document.createElement("style");
				x.setAttribute("type","text/css");
				if(x.styleSheet){
					S.appendChild(x);
					x.styleSheet.cssText=b
				}
				else{
					x.appendChild(document.createTextNode(b));
					S.appendChild(x)
				}
				yt=sa_s4_split_var(e,"show_arrow_button");
				Nt=sa_s4_split_var(e,"sa_left_arrow_img");
				Ct=sa_s4_split_var(e,"sa_right_arrow_img");
				bt=sa_s4_split_var(e,"s4_screen_resolution");
				var S=document.getElementsByTagName("head")[0];
				var T=document.createElement("script");
				T.src=""+i+"//c."+o+"/c-set-iframe-cookie.php?cookie_name="+n+"&output1="+r+"&output2="+s+"&output3="+u+"&output4="+f+"&output5="+c+"&output6="+h+"&output7="+p+"&output8="+d+"&inc_ck_val="+v+"&site_id="+m;S.appendChild(T);
				S.appendChild(T);
				if(g!="0"){
					var k=new Date;
					var L=k.getFullYear()+"/"+(k.getMonth()+1)+"/"+k.getDate()+" "+k.getHours()+":"+k.getMinutes()+":"+k.getSeconds();
					var A;
					var M;
					sa_user_visit=C(siteid+"_user_visit");
					var _=sa_user_visit.split("^");
					if(sa_user_visit=="null"){
						A="1"+"^"+L
					}else{var D=new Date(_[1]);
					var P=new Date(L);
					var H=parseInt(P.getTime()-D.getTime());
					var B=parseInt(Math.round(H/6e4));
					var j=P+" > "+D+" > "+B;
					if(B>=30){
						M="1";A=parseInt(_[0])+1;A=A+"^"+L
					}
					else{
						A=sa_user_visit;M="0"
					}
				}
				N(siteid+"_user_visit",A,"730")
			}
			var F=1;if(g>0){
				var I=A.split("^");A=I[0];
				if(A>=g){F=1}else{F=0}
			}
			var V=0;var $=a("sacpn");
			if($=="SARCWDTR"||$=="SARCWDTR"){V=1}if(g!="0"&&V==1&&F==0){popup_auto_flag="0";l(siteid,4,w)}
			if(F){var J="0";if(i=="https:"){J="1"}
			build_param="site_id="+siteid+"&service_id=4&lb_flag="+w+"&sf="+dt+"&ssl="+J+"&ck="+vt+"&publish_status="+sa_s4_publish_status;et=z+"^^"+R+"^^"+X+"^^"+W+"^^"+U+"^^"+t;
			var K=1;var Q="";var Z=sa_get_random();
			if(typeof show_arrow_button!="undefined")yt=show_arrow_button;
			if(typeof sa_left_arrow_img!="undefined")Nt=sa_left_arrow_img;
			if(typeof sa_right_arrow_img!="undefined")Ct=sa_right_arrow_img;
			if(typeof s4_screen_resolution!="undefined")bt=s4_screen_resolution;
			if(typeof s4_ban_resolution!="undefined")wt=s4_ban_resolution;
			if(typeof sa_s4_targeted_offer!="undefined")local_s4_target_offer=sa_s4_targeted_offer;
			if(G!=""){if(i=="https:"){var tt="http:";var nt="https:";G=G.replace(tt,nt)}
			if(O=="0"||O==""){
				if(pt=="0"){
					if(local_s4_target_offer=="0"){
						if(s4_is_cust_img=="0"){
							if(siteid!="9912021"){
								Q+="<a id='share5'>"+"
										<img style='cursor: pointer;' title='Share with Friends' id='sa_s4_widget_image' onclick=served_click_count('"+siteid+"',4,2,'"+w+"','"+Y+"');ShowIframeBoxWithoutJquery('"+build_param+"'); src='"+G+"' border='0'/>"+
									"</a>";
								Q+="<div id='sa_s4_popup_overlay' class='sa_s4_overlay_popup_css'></div>
									<div id='sa_s4_popup' class='sa_s4_popup_css'></div>"
							}
							else{
								Q+="<a id='share5'>"+"
										<img style='cursor: pointer;'  id='sa_s4_widget_image' onclick=served_click_count('"+siteid+"',4,2,'"+w+"','"+Y+"');ShowIframeBoxWithoutJquery('"+build_param+"'); src='"+y+"' border='0'/>"+
									"</a>";
								Q+="<div id='sa_s4_popup_overlay' class='sa_s4_overlay_popup_css'></div>
									<div id='sa_s4_popup' class='sa_s4_popup_css'></div>"
							}
						}
					}
					else{
						Q+="<div id='sa_s4_target_main'  class='sa_s4_target_sliding_div'>
								<iframe class='sa_s4_iframe_class'  id='socialannex-frame' name='socialannex-frame-sas' frameborder='0' hspace='0' allowtransparency='true' scrolling='no' src='"+i+"//s4."+o+"/sa_s4_target_offer.php?"+build_param+"&inc_id="+sa_s4_target_incentive_id+"'>
								</iframe>
								<div id='sa_s4_target_branding'>
									<a target='_blank' href='http://socialannex.com'>
										<img border='0' alt='Powered by Social Annex' src='"+i+"//cdn.socialannex.com/images/to_powerdby.png'>
									</a>
								</div>
								<div id='sa_s4_in_out_div'>
									<img id='sa_s4_out_arrow' onClick='sa_s4_to_right_slideIn()' class='sa_s4_image_out' src='"+sa_s4_to_out_arrow+"' />
								</div>
							</div>"
						}
					}
					else{
						Q+="<a id='share5'>"+"<img style='cursor: pointer;'  id='sa_s4_widget_image' onclick=served_click_count('"+siteid+"',4,2,'"+w+"','"+Y+"');
						ShowForDirectCpCd('"+build_param+"');
						src='"+G+"' border='0'/>"+"</a>";
						Q+="<div id='sa_s4_popup_overlay' class='sa_s4_overlay_popup_css'></div>
						<div id='sa_s4_popup' class='sa_s4_popup_css'></div>"
					}
				}
			}
			var rt=navigator.appName;
			if(typeof s15_widget_all!="undefined"){
				var it;var st;st=sa_get_random();
				if(typeof s15_reward_img!="undefined"){
					it=s15_reward_img;var ot=build_param+"&via_s15=1";
					Q="<a id='share5'>"+"
						<img  style='cursor: pointer;'  id='sa_s4_widget_image' onclick=served_click_count('"+siteid+"',4,2,'"+w+"','"+Y+"');ShowIframeBoxWithoutJquery('"+ot+"'); src='"+it+"' border='0'/>"+"
					</a>";
					Q+="<div id='sa_s4_popup_overlay' class='sa_s4_overlay_popup_css'></div>
						<div id='sa_s4_popup' class='sa_s4_popup_css'></div>";
					if(sa_share_version=="2i"){
						document.getElementById("s15-button-product").innerHTML=Q
					}
					else if(sa_share_version=="3i"){
						document.getElementById("s15-button-category").innerHTML=Q
					}
					else{
						document.getElementById("s15-button").innerHTML=Q
					}
				}
			}
			else{
				if(local_s4_target_offer=="0"){
					if(ft=="0"){
						if(yt=="1"||yt=="2"){
							Pt(Q,ft,w,Nt,Ct,yt)
						}
					}
					else if(ft=="1"){
						if(yt=="1"||yt=="2"){
							Pt(Q,ft,w,Nt,Ct,yt)
						}
					}
					else if(ct=="0"&&lt!=""&&ft=="2"){
						if(prd_div_attribute=="1"){
							var ut=document.createElement("div");
							ut.id="s4-button";
							var at=document.getElementById(lt);
							at.parentNode.insertBefore(ut,at.nextSibling)
						}
						var ht='window.fbAsyncInit = function() {
							FB.init({appId:"'+E+'",status:true,cookie:true,xfbml:true});
					};(function() {
						var e = document.createElement("script");
						e.async = true;
						e.src = "'+i+'//connect.facebook.net/en_US/all.js";
						document.getElementById("fb-root").appendChild(e);
					}());';var mt=document.getElementsByTagName("body")[0];var gt=document.createElement("div");gt.id="fb-root";mt.appendChild(gt);var T=document.createElement("script");T.text=ht;document.body.appendChild(T);document.getElementById("s4-button").innerHTML=Q}else{document.getElementById("s4-button").innerHTML=Q}}else{var Et=document.getElementsByTagName("body")[0];var St=document.createElement("div");St.id="s4-targeted-button";St.className="s4_targeted_btn_style";Et.appendChild(St);setTimeout(function(){document.getElementById("s4-targeted-button").innerHTML=Q;sa_s4_to_right_slideOut()},1e3)}var xt=a("sacpn");var Tt;var kt=a("service");if((xt=="SARCWDTR"||xt=="SARCWDTR")&&kt=="4"){popup_auto_flag="0";l(siteid,4,w);if(local_s4_slideout=="1"){sa_s4_slide_open(local_s4_slideout)}}}if(popup_manual_flag=="1"){var Lt=a("saopen");var At=a("sacpn");if(Lt=="share"){var Ot=new String(q);var Mt=Ot.split("=share");if(Mt[1]==""||typeof At=="undefined"){if(typeof s15_widget_all!="undefined")var _t=build_param+"&via_s15=1";else var _t=build_param;setTimeout(function(){Bt(_t)},2500)}}}if(popup_auto_flag=="1"){if(typeof s15_widget_all!="undefined")var _t=build_param+"&via_s15=1";else var _t=build_param;setTimeout(function(){Bt(_t)},2500)}if(local_sa_s4_onclick==1){setTimeout(function(){ShowIframeBoxWithoutJquery(build_param);document.getElementById("sas_loading").innerHTML=""},2500)}}}z=e["code"];R=e["name"];W=e["price"];U=e["image"];U=d(U,"'","");U=replaceSpecialChar(U,"/","|");U=replaceSpecialChar(U,"?","*");U=replaceSpecialChar(U,"&","^");q=e["url"];q=d(q,"'","");var t=q;t=replaceSpecialChar(t,"/","|");t=replaceSpecialChar(t,"?","*");t=replaceSpecialChar(t,"&","^");t=replaceSpecialChar(t,"#","sa_hash");X=e["description"];ss_incentive_btn=e["ss_btn"];ut=e["custom_var"];ut=replaceSpecialChar(ut,"/","|");ut=replaceSpecialChar(ut,"?","*");ut=replaceSpecialChar(ut,"&","^");ut=replaceSpecialChar(ut,"#","sa_hash");Et=e["custom_var1"];Et=replaceSpecialChar(Et,"/","|");Et=replaceSpecialChar(Et,"?","*");Et=replaceSpecialChar(Et,"&","^");St=e["custom_var2"];xt=e["custom_var3"];Tt=e["custom_var4"];if(typeof sa_siteid!="undefined"){siteid=sa_siteid}build_param="ck="+vt+"&site_id="+siteid+"&lb_flag="+w+"&inc_id="+Y+"&service_id=4"+"&site_manage_id="+k+"&show_email_opt="+L+"&scrape_file_name="+ht+"&custom_var="+ut;var n=build_param+"&p_code="+z+"&p_name="+R+"&p_url="+t+"&p_price="+W+"&p_img_url="+U+"&p_desc="+X+"&sf="+dt+"&custom_var1="+Et+"&custom_var2="+St+"&custom_var3="+xt+"&custom_var4="+Tt+"&ck="+vt+"&serve_unique="+Mt+"&sa_s4_data_url="+G+"&inc_ck_val="+inc_ck_val;var r=""+i+"//c."+o+"/c-set-iframe-data-v3.php?"+n;sa_s4_getscript(r,s)}function Pt(e,t,n,r,s,u){var a=document.getElementsByTagName("body")[0];var f=document.createElement("div");f.id="s4-button";f.className="s4_btn_style";a.appendChild(f);if((r=="0"||s=="0")&&t==0){var l="<img src='"+i+"//cdn."+o+"/images/left_arrow.png' border='0' />";var c="<img src='"+i+"//cdn."+o+"/images/right_arrow.png' border='0' />"}else if((r=="0"||s=="0")&&t==1){var c="<img src='"+i+"//cdn."+o+"/images/left_arrow.png' border='0' />";var l="<img src='"+i+"//cdn."+o+"/images/right_arrow.png' border='0' />"}else{var l="<img src='"+r+"' border='0' />";var c="<img src='"+s+"' border='0' />"}if(t==1){var h="<div id='s4-widget' class='s4_widget_pos'>"+e+"</div><div id='s4-widget-arrow1' class='s4_widget_pos' onclick='sa_move_in_left("+u+");'>"+c+"</div><div id='s4-widget-arrow2' class='s4_widget_pos' onclick='sa_move_out_left("+u+");' style='display:none;'>"+l+"</div>"}else{var h="<div id='s4-widget' class='s4_widget_pos'>"+e+"</div><div id='s4-widget-arrow1' class='s4_widget_pos' onclick='sa_move_in_right("+u+");'>"+c+"</div><div id='s4-widget-arrow2' class='s4_widget_pos' onclick='sa_move_out_right("+u+");' style='display:none;'>"+l+"</div>"}document.getElementById("s4-button").innerHTML=h;var p=siteid+"_POS";var d=getCookie(p);if(d==1&&t==0){var v=document.getElementById("s4-widget").offsetWidth;var m=Math.round(v);var g=v/2;var y=Math.round(g);if(u==1){document.getElementById("s4-widget").style.left=y+"px";document.getElementById("s4-widget-arrow1").style.left=y+"px";document.getElementById("s4-widget-arrow2").style.display="block";document.getElementById("s4-widget-arrow1").style.display="none"}else{var b=new Image;b.onload=function(){document.getElementById("s4-widget").style.left=this.width+"px";document.getElementById("s4-widget-arrow1").style.left=this.width+"px"};b.src=G;document.getElementById("s4-widget-arrow2").style.display="block";document.getElementById("s4-widget-arrow1").style.display="none"}}if(d==1&&t==1){var v=document.getElementById("s4-widget").offsetWidth;var m=Math.round(v);var g=v/2;var y=Math.round(g);if(u==1){document.getElementById("s4-widget").style.left=-y+"px";document.getElementById("s4-widget-arrow1").style.left=-y+"px";document.getElementById("s4-widget-arrow2").style.display="block";document.getElementById("s4-widget-arrow1").style.display="none"}else{document.getElementById("s4-widget").style.left=-m+"px";document.getElementById("s4-widget-arrow1").style.left=-m+"px";document.getElementById("s4-widget-arrow2").style.display="block";document.getElementById("s4-widget-arrow1").style.display="none"}}}function Ht(){if(s4_cust_img_attribute==0){var e=$("."+s4_cust_img_attribute_name).attr("src");var t=s4_cust_img_find;var n=s4_cust_img_replace;var r=e.replace(t,n);return r}else{var e=$("#"+s4_cust_img_attribute_name).attr("src");var t=s4_cust_img_find;var n=s4_cust_img_replace;var r=e.replace(t,n);return r}}function Bt(e){var t="<div id='sa_s4_popup_close' class='sa_s4_close'><a href = 'javascript:void(0)' onclick =document.getElementById('sa_s4_popup').style.display='none';document.getElementById('sa_s4_popup_overlay').style.display='none';> <img src='"+i+"//cdn."+o+"/c/sabox/closelabel.png' alt='Close'></a></div><iframe id='socialannex-frame' name='socialannex-frame-sas' frameborder='0' hspace='0' scrolling='no' src='"+i+"//c."+o+"/popup.php?"+e+"'></iframe><div id='sa_s4_branding'>"+get_link_popup+"</div>";document.getElementById("sa_s4_popup").innerHTML="";document.getElementById("sa_s4_popup").innerHTML=t;document.getElementById("sa_s4_popup_overlay").style.display="block";document.getElementById("sa_s4_popup").style.display="block"}var jt="";var i=document.location.protocol;var Ft=replaceCharShare(location.href,"/","*");var It;var qt;It=new String(Ft);qt=It.indexOf("?");if(qt!=-1){Ft=replaceCharShare(Ft,"?","|")}It=new String(Ft);qt=It.indexOf("&");if(qt!=-1){Ft=replaceCharShare(Ft,"&","^")}var Rt=1;var Ut=siteid;var zt=scrape_file;var Wt="";var ut="";var Xt="";var Vt="";var $t=s4_inc_id;var Jt=parameter;if(Rt==1){function Kt(e){loca=sa_s4_split_var(e,"loca");Xt=loca;scrp_product_name=sa_s4_split_var(e,"scrp_product_name");scrp_product_desc=sa_s4_split_var(e,"scrp_product_desc");scrp_product_image=sa_s4_split_var(e,"scrp_product_image");scrp_product_price=sa_s4_split_var(e,"scrp_product_price");scrp_product_id=sa_s4_split_var(e,"scrp_product_id");scrp_landing_url=sa_s4_split_var(e,"scrp_landing_url");js_scrp_product_price=sa_s4_split_var(e,"js_scrp_product_price");ut=Xt;if(Xt=="document.location.href"){ut=document.location.href}var t="";var n="";var r="";var i="";var s="";var o="1";if(typeof scrp_product_name!="undefined"){t=scrp_product_name}if(typeof scrp_product_image!="undefined"){n=scrp_product_image}if(typeof scrp_product_price!="undefined"){r=scrp_product_price}if(typeof scrp_product_id!="undefined"){i=scrp_product_id}if(i=="noproductinfo"){Vt="noproductinfo"}else{Vt=Vt}if(typeof scrp_product_desc!="undefined"){s=scrp_product_desc}var u="";var a="";var f="";var l="";if(typeof scrp_custom_var1!="undefined")u=scrp_custom_var1;if(typeof scrp_custom_var2!="undefined")a=scrp_custom_var2;if(typeof scrp_custom_var3!="undefined")f=scrp_custom_var3;if(typeof scrp_custom_var4!="undefined")l=scrp_custom_var4;if(typeof js_scrp_product_price!="undefined"){o=js_scrp_product_price}var c=window.location;Dt({name:t,image:n,price:r,url:c,code:i,description:s,custom_var:ut,scrp_show_info:Vt,custom_var1:u,custom_var2:a,custom_var3:f,custom_var4:l});Rt=2}var Qt="0";var Gt=""+i+"//scraper."+o+"/"+zt+"?loc="+Ft;if(Qt=="1"){sa_s4_getscript(Gt,Kt)}else{Kt("var loca = document.location.href;var scrp_custom_var= loca;var scrp_product_name='';var scrp_product_desc='';var scrp_product_image='';var scrp_product_price='';var scrp_product_id	='';var scrp_landing_url='';var js_scrp_product_price='1';")}}}}function sa_move_in_right(e){function u(){o++;document.getElementById("s4-widget").style.left=o+"px";document.getElementById("s4-widget-arrow1").style.left=o+"px";if(o==s)clearInterval(a);document.getElementById("s4-widget-arrow2").style.display="block";document.getElementById("s4-widget-arrow1").style.display="none"}var t=siteid+"_POS";setCookie(t,"1",1);var n=document.getElementById("s4-widget").offsetWidth;var r=n/2;var i=Math.round(n);if(e==1){var s=Math.round(r)}else{var s=i}var o=0;var a=setInterval(u,10)}function sa_move_out_right(e){function u(){o--;document.getElementById("s4-widget").style.left=o+"px";document.getElementById("s4-widget-arrow1").style.left=o+"px";if(o==0)clearInterval(a);document.getElementById("s4-widget-arrow2").style.display="none";document.getElementById("s4-widget-arrow1").style.display="block"}var t=siteid+"_POS";setCookie(t,"2",1);var n=document.getElementById("s4-widget").offsetWidth;var r=n/2;var i=Math.round(n);if(e==1){var s=Math.round(r);var o=s}else{var o=i}var a=setInterval(u,10)}function sa_move_in_left(e){function u(){o--;document.getElementById("s4-widget").style.left=o+"px";document.getElementById("s4-widget-arrow1").style.left=o+"px";if(o==-s)clearInterval(a);document.getElementById("s4-widget-arrow2").style.display="block";document.getElementById("s4-widget-arrow1").style.display="none"}var t=siteid+"_POS";setCookie(t,"1",1);var n=document.getElementById("s4-widget").offsetWidth;var r=n/2;var i=Math.round(n);if(e==1){var s=Math.round(r)}else{var s=i}var o=0;var a=setInterval(u,10)}function sa_move_out_left(e){function u(){o++;document.getElementById("s4-widget").style.left=o+"px";document.getElementById("s4-widget-arrow1").style.left=o+"px";if(o==0)clearInterval(a);document.getElementById("s4-widget-arrow2").style.display="none";document.getElementById("s4-widget-arrow1").style.display="block"}var t=siteid+"_POS";setCookie(t,"2",1);var n=document.getElementById("s4-widget").offsetWidth;var r=n/2;var i=Math.round(n);if(e==1){var s=Math.round(r);var o=-s}else{var o=-i}var a=setInterval(u,10)}function sa_s4_to_right_slideOut(){function r(){n++;document.getElementById("sa_s4_target_main").style.right=n+"px";if(n==t)clearInterval(i)}var e=document.getElementById("sa_s4_target_main").offsetWidth;var t=0;document.getElementById("sa_s4_in_out_div").innerHTML='<img id="sa_s4_in_arrow"  onClick="sa_s4_to_right_slideIn()" src='+sa_s4_to_in_arrow+' class="sa_s4_image_in"/>';var n=-e;var i=setInterval(r,5)}function sa_s4_to_right_slideIn(){function r(){n--;document.getElementById("sa_s4_target_main").style.right=n+"px";if(n==t)clearInterval(i)}var e=document.getElementById("sa_s4_target_main").offsetWidth;var t=-e;document.getElementById("sa_s4_in_out_div").innerHTML='<img id="sa_s4_out_arrow"  onClick="sa_s4_to_right_slideOut()"  src='+sa_s4_to_out_arrow+' class="sa_s4_image_out"/>';var n=0;var i=setInterval(r,5)}function setCookie(e,t,n){var r=new Date;r.setDate(r.getDate()+n);var i=escape(t)+(n==null?"":"; expires="+r.toUTCString());document.cookie=e+"="+i+";path=/"}function getCookie(e){var t=document.cookie;var n=t.indexOf(" "+e+"=");if(n==-1){n=t.indexOf(e+"=")}if(n==-1){t=null}else{n=t.indexOf("=",n)+1;var r=t.indexOf(";",n);if(r==-1){r=t.length}t=unescape(t.substring(n,r))}return t}function sa_get_random(){var e=Math.ceil(Math.random()*10)+"";var t=Math.ceil(Math.random()*10)+"";var n=Math.ceil(Math.random()*10)+"";var r=Math.ceil(Math.random()*10)+"";var i=e+t+n+r;return i}function addslashes(e){e=e.replace(/\\/g,"\\\\");e=e.replace(/\'/g,"\\'");e=e.replace(/\"/g,'\\"');e=e.replace(/\0/g,"\\0");return e}function stripslashes(e){e=e.replace(/\\'/g,"'");e=e.replace(/\\"/g,'"');e=e.replace(/\\0/g,"\0");e=e.replace(/\\\\/g,"\\");return e}function trim_share(e){return e.replace(/^\s+|\s+$/g,"")}function replaceSpecialChar(e,t,n){var r=new String(e);var i=r.indexOf(t);while(i>-1){r=r.replace(t,n);i=r.indexOf(t)}return r}var siteid;var service_label;var site_jquery="0";var local_highzindex=0;var local_sacommonjs=1;var local_safancybox=1;var local_safancyboxcss=1;var local_sajquery=1;var local_sajquery2=1;var local_saeasing=0;var local_sas4_jq_noconflict=1;var local_tc=0;var local_tc_url=0;var local_sa_box=0;var local_sa_lightbox_css=0;var local_sa_lightbox_js=0;var local_sa_auto_noconflict=1;var is_siteid_get=0;var local_s4_branding_lang=0;var local_s4_lang_name=0;var local_s4_slideout=0;var local_s4_already_like=0;var local_s4_already_like_txt="Already Liked It?";var local_sa_s4_responsive=0;var get_link_popup;var local_sa_s4_onclick="0";var sa_s4_currentPageUrl="";var sa_s4_publish_status=1;var sa_s4_saopen_value="";if(typeof this.href==="undefined"){sa_s4_currentPageUrl=document.location.toString().toLowerCase()}else{sa_s4_currentPageUrl=this.href.toString().toLowerCase()}var sa_s4_get_saopen=sa_s4_currentPageUrl.split("saopen");if(sa_s4_get_saopen.length>1){sa_s4_saopen_value=sa_s4_get_saopen[1].substr(1);if(sa_s4_saopen_value=="test"){sa_s4_publish_status=0}}if(typeof sa_siteid!="undefined"){siteid=sa_siteid;is_siteid_get=1}if(typeof sa_s4_auto_noconflict!="undefined"){local_sa_auto_noconflict=sa_s4_auto_noconflict}if(typeof sa_s4_tc!="undefined"){local_tc=sa_s4_tc;local_tc_url=sa_s4_tc_url}if(typeof sa_s4_branding_lang!="undefined"){local_s4_branding_lang=sa_s4_branding_lang}if(typeof sa_s4_lang_name!="undefined"){local_s4_lang_name=sa_s4_lang_name}if(typeof sa_s4_slideout!="undefined"){local_s4_slideout=sa_s4_slideout}if(typeof sa_s4_already_like!="undefined"){local_s4_already_like=sa_s4_already_like}if(typeof sa_s4_already_like_txt!="undefined"){local_s4_already_like_txt=sa_s4_already_like_txt}if(typeof sa_s4_responsive!="undefined"){local_sa_s4_responsive=sa_s4_responsive}if(typeof sa_s4_onclick!="undefined"){local_sa_s4_onclick=sa_s4_onclick}var saJsHost=document.location.protocol;var js_host="socialannex.com";var mydomain=window.location.hostname;mydomain="http-"+mydomain;var FullURL=document.location.href;var inc_key=getIncLvl(FullURL,"sakey");siteid=sa_siteid;service_label=sa_label;var c_api_url="";switch(service_label){case"0":c_api_url=saJsHost+"//c."+js_host+"/c-apikey/"+siteid+"/4/"+mydomain+"?inc_lvl="+inc_key;break;case"1":c_api_url=saJsHost+"//c."+js_host+"/c-apikey/"+siteid+"/4a/"+mydomain+"?inc_lvl="+inc_key;break;case"2":c_api_url=saJsHost+"//c."+js_host+"/c-apikey/"+siteid+"/4b/"+mydomain+"?inc_lvl="+inc_key;break;case"3":c_api_url=saJsHost+"//c."+js_host+"/c-apikey/"+siteid+"/4c/"+mydomain+"?inc_lvl="+inc_key;break;case"4":c_api_url=saJsHost+"//c."+js_host+"/c-apikey/"+siteid+"/4d/"+mydomain+"?inc_lvl="+inc_key;break;case"5":c_api_url=saJsHost+"//c."+js_host+"/c-apikey/"+siteid+"/4e/"+mydomain+"?inc_lvl="+inc_key;break;case"2i":c_api_url=saJsHost+"//c."+js_host+"/c-apikey/"+siteid+"/4b/"+mydomain+"?inc_lvl="+inc_key;break;case"3i":c_api_url=saJsHost+"//c."+js_host+"/c-apikey/"+siteid+"/4c/"+mydomain+"?inc_lvl="+inc_key;break;case"4i":c_api_url=saJsHost+"//c."+js_host+"/c-apikey/"+siteid+"/4d/"+mydomain+"?inc_lvl="+inc_key;break;case"5i":c_api_url=saJsHost+"//c."+js_host+"/c-apikey/"+siteid+"/4e/"+mydomain+"?inc_lvl="+inc_key;break;case"6i":c_api_url=saJsHost+"//c."+js_host+"/c-apikey/"+siteid+"/4f/"+mydomain+"?inc_lvl="+inc_key;break;case"7i":c_api_url=saJsHost+"//c."+js_host+"/c-apikey/"+siteid+"/4g/"+mydomain+"?inc_lvl="+inc_key;break;case"8i":c_api_url=saJsHost+"//c."+js_host+"/c-apikey/"+siteid+"/4h/"+mydomain+"?inc_lvl="+inc_key;break;case"9i":c_api_url=saJsHost+"//c."+js_host+"/c-apikey/"+siteid+"/4i/"+mydomain+"?inc_lvl="+inc_key;break;case"10i":c_api_url=saJsHost+"//c."+js_host+"/c-apikey/"+siteid+"/4j/"+mydomain+"?inc_lvl="+inc_key;break}var s_all_assync_url=c_api_url;var inc_ck_val;var local_s4_target_offer=0;var build_param;sa_getScript()
