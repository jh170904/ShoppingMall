<%@page import="com.codi.dto.MemberDTO"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="../layout/storeNav.jsp"  %>

<script type="text/javascript">


$(function(){
	
	
	$(".goodButton").click(function(){


		var superProduct = $(this).attr('value');


        var info = '<%=(MemberDTO)session.getAttribute("customInfo")%>';
        
        if(info=="" || info==null){
        	alert("ㅅㅂ로그인이 필요합니다.");
           	alert(id);
        	return;
        }
        
        
        
        $.ajax({
            async: true,
            type : 'POST',
            data : superProduct,
            url : "good.action",
            dataType : "json",
            contentType: "application/json; charset=UTF-8",
            success : function(data) {
            	if(data.cnt > 0) {
            		$(".goodDiv" + superProduct).html('♡');
                } else {
            		$(".goodDiv" + superProduct).html('♥');
                }
                
            },
            error : function(error) {
            	alert("로그인이 필요합니다.");
            }
        });
			
	});
	
});



</script>


<style>
#order{
    color: #757575;
    width:150px;
    border: solid 1px #ededed;
    background-color: #fafafa;
    cursor: pointer;
    padding: 0 4px 0 8px;
    height: 30px;
    font-size: 14px;
    line-height: 1;
    border-radius: 0;
}
</style>

<div id="ap_container" class="ap_container">

	<div class="page_title_area">
		<div class="page_title" style="border-top-color: black;">
			<h3 class="h_title page">ALL</h3>
			<p class="text font_lg"></p>
		</div>
	</div>
	
	
	<div class="ap_contents prd_list">
		<div class="prd_category">
			<ul>
				<li><a href="<%=cp %>/pr/listNew.action" class="on">ALL</a></li>
					<% 
						String arrCategory3[] = {"OUTER","TOP","BOTTOM","DRESS","SHOES","BAG","ACC"};
					
						for(String s:arrCategory3 ){
							
							String category = URLEncoder.encode(s, "UTF-8");
							out.println("<li><a href="+cp+"/pr/listCategory.action?productCategory="+category+">");
							out.println(s+"</a></li>");
						}
					%>
			</ul>
		</div>
		
		
		<div class="item_list column2" style="height: 70px;">
			<div style="padding: 20px; float: right;">
				<select id="order" name="order">
					<option onclick="javascript:location.href='${listUrl}';">신제품순</option>
					<!-- amount -->
					<option onclick="javascript:location.href='${listUrl}?order=amount desc';">판매량순</option>
					<option onclick="javascript:location.href='${listUrl}?order=price desc';">가격이 높은 순</option>
					<option onclick="javascript:location.href='${listUrl}?order=price asc';">가격이 낮은 순</option>
					<!-- 하트 많이 받은 순 -->
					<option>인기순</option>
					<option>리뷰 순</option>
					<option>평점 순</option>
				</select>
			</div>
		</div>
		
		
		<div class="item_list column2">
			<div class="panel notice etu_find_store_none no_result"
				style="display: none;">
				<i class="ico"></i>
				<p class="text font_lg">
					<span class="tit_1">상품이 존재하지 않습니다.</span>
				</p>
			</div>
			
			<table style="width: 1200">
				<c:set var="i" value="0" />
				<c:forEach var="dto" items="${lists }">

					<c:if test="${i==0 }">
					
						<tr height="30px"></tr>
						<tr>
						<c:set var="j" value="0" />
					</c:if>



					<td align="center">
					
						<table width="400">
							<tr>
								<a href="<%=cp%>/pr/detail.action?superProduct=${dto.superProduct}">
								<img style="background-color: #f5f5f5; width: 268px; height: 268px; margin-left : 10px; margin-right: 10px" alt="" src="../upload/list/${dto.originalName}" />
								</a>
							</tr>
							<tr>
								<a href="${dto.storeUrl }" >
								<p align="left" style="font-size: 11pt; margin-bottom: 10px; margin-left: 62px;">${dto.storeName }</p>
								</a>
							</tr>
							<tr height="16px">
								<p align="left" style="font-size: 13pt; margin-bottom: 10px; margin-left: 62px;">${dto.productName }</p>
							</tr>
							<tr height="25px">
								<p align="left" style="font-size: 17pt; margin-bottom: 10px; margin-left: 62px; color: black;">${dto.price}원</p>
							</tr>
							<tr>
								<p align="left" style="margin: 0px 10px 10px 62px; height: 20px">
								<span style="font-size: 14pt;  color: #8080FF" >★</span>
								<span>평점 ${dto.reviewRate}</span>
								<span>&nbsp;&nbsp;&nbsp;리뷰&nbsp;${dto.reviewCount}</span>
								
								<span style="font-size: 14pt;  color: #8080FF; margin-left: 112px;">
									<input type="hidden" id="superProduct" value="${dto.superProduct}" >
									<button class="goodButton" value="${dto.superProduct}">
										<div class="goodDiv${dto.superProduct}">
											<c:set var="k" value="0" />
											<c:forEach var="good" items="${good }">
												<c:if test="${dto.superProduct eq good}">
													♥
													<c:set var="k" value="1" />
												</c:if>
											</c:forEach>
											<c:if test="${k==0 }">
												♡
											</c:if>
										</div>
									</button>
								</span>
								
								</p>
							</tr>
						</table>
						
						
						<c:set var="j" value="${j+1 }" /> 
						<c:set var="i" value="1" />

					</td>

					<c:if test="${j==3 }">
						</tr>
						<c:set var="j" value="0" />
						<c:set var="i" value="0" />
					</c:if>

				</c:forEach>



				<c:if test="${j!=3 }">
					<c:forEach begin="${j }" end="2" step="1">
						<td width="400"></td>
						<c:set var="j" value="${j+1 }" />
					</c:forEach>
					</tr>
				</c:if>
				

				<tr height="100">
					<td align="center" colspan="3">
						<c:if test="${dataCount!=0 }">
							<font style="font-size: 20px">${pageIndexList}</font>
						</c:if> 
						<c:if test="${dataCount==0 }">
							등록된 게시물이 없습니다.
						</c:if>
					</td>
				</tr>
			</table>
		</div>
	</div>


</div>


<%@include file="../layout/footer.jsp"  %>