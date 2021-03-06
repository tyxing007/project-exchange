		<!-- begin导航框架 -->
		<#escape x as (x)!""> 
		<div class="menuzone">
			<div class="mainmenu">
				<ul class="main-nav fl">
					<li class="top">
						<a href="${base}/index.htm" class="current"><span class="down">站点首页</span> </a>
					</li>
					<li class="top">
						<a href="${base}/index.htm" class="top_link"><span class="down">今日团购</span> </a>
						<ul class="sub">
						<#if Session??>
						<#if Session["allCount"]??>
							<li>
								<a href="${base}/index.htm">全部团购<span class="ft10">(${Session.allCount})</span> </a>
							</li>
						<#else>
						<a href="${base}/index.htm">全部团购<span class="ft10">(0)</span> </a>
						</#if>
						</#if>
							<#if cates??>
							<#list cates as c>
							<li>
								<a href="${base}/listCate.htm?teamCate.id=${c.id}">${c.name}<span class="ft10">(${Session.cateAndCountMap["${c.name}"]})</span> </a>
							</li>
							</#list>
							<#else>
							</#if>
						</ul>
					</li>
					<li class="top">
						<a href="#" class="top_link"><span class="down">团购导航</span> </a>
					</li>
					<li class="top">
						<a href="#" class="top_link"><span class="down">团购地图</span> </a>
					</li>
					<li class="top">
						<a href="${base}/userCenter_enter_action" class="top_link"><span class="down">个人中心</span> </a>
					</li>
					<li class="top">
						<a href="#" class="top_link"><span class="down">积分兑换</span> </a>

					</li>
				</ul>
				<form name="searchForm" action="${base}/search.htm" method="post">
				<div class="right_header">
					<div class="fl white mar_t3">
						搜索资源
					</div>
					<div class="fl picture-input mar_l5">
						<input type="text" id="searchInput" name="searchKeyword" class="search gray" onfocus="if(this.value==this.defaultValue)this.value=''" onblur="if(this.value=='')this.value=this.defaultValue" value="--请输入关键字--" />
					</div>
					<div class="fl">
						<input class="hledat" type="image" src="${base}/Themes/images/search-button.gif" name="" value="Search" alt="Search" onclick="searchResource();" />
					</div>
				</div>
				</form>
			</div>
		</div>
		</#escape> 
		<!-- end导航框架 -->