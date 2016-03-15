<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>


<!--Hidden elements - excluded from jPanel Menu on mobile-->
<div class="hidden-elements jpanel-menu-exclude">

   <!--@modal - signup modal-->
   <div class="modal fade" id="signup-modal" tabindex="-1" role="dialog"
      aria-hidden="true">
      <div class="modal-dialog">
         <div class="modal-content">
            <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal"
                  aria-hidden="true">&times;</button>
                  <h4 class="modal-title">Sign Up</h4>
            </div>
            <div class="modal-body">
               <form action="signup.htm" role="form">
                  <h5>이메일 인증</h5>
                  <div class="form-group">
                     <label class="sr-only" for="signup-first-name">이메일 입력</label> 
                     <input type="text" class="form-control" id="receiver1"> 
                     <input type="hidden" name="receiver" id="receiver"> 
                     
                     <input type="text" class="form-control" id="receiver2" value="@gmail.com">
                  </div>

                  <button class="btn btn-primary" type="button" id="authBtn"onclick="emailAuth()" data-dismiss="modal">인 증</button>

               </form>
            </div>

            <div class="modal-footer"></div>
         </div>
         <!-- /.modal-content -->
      </div>
      <!-- /.modal-dialog -->
   </div>
   <!-- /.modal -->


   <!--@modal - passwordSearch modal-->
   <div class="modal fade" id="pwdSearch-modal" tabindex="-1"
      role="dialog" aria-hidden="true">
      <div class="modal-dialog">
         <div class="modal-content">
            <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal"
                  aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
               <form action="signup.htm" role="form" id="pwdSearchForm">
                  <h5>비밀번호 찾기</h5>
                  <div class="form-group">
                     <table>
                        <tr>
                           <td>ID</td>
                           <td><input type="text" class="form-control" id="sId"
                              name="sId"></td>
                        </tr>
                        <tr>
                           <td><input type="hidden" name="searchId" id="searchId">
                           </td>
                        </tr>
                        <tr>
                           <td>E-MAIL</td>
                           <td><input type="text" class="form-control" id="sEmail1"
                              name="sEmail1"></td>

                           <td><input type="text" class="form-control" id="sEmail2"
                              name="sEmail2" value="@gmail.com" readonly="readonly">
                           </td>
                        </tr>

                        <tr>
                           <td><input type="hidden" name="sReceiver" id="sReceiver"></td>
                        </tr>
                     </table>
                  </div>
                  <button class="btn btn-primary" data-dismiss="modal" type="button" id="searchBtn">비밀번호
                     전송</button>
               </form>
            </div>
      
         </div>
         <!-- /.modal-content -->
      </div>
      <!-- /.modal-dialog -->
   </div>
   <!-- /.modal -->




   <!--@modal - login modal-->

   <div class="modal fade" id="login-modal" tabindex="-1" role="dialog"
      aria-hidden="true">
      <div class="modal-dialog">
         <div class="modal-content">
            <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal"
                  aria-hidden="true">&times;</button>
               <h4 class="modal-title">Login</h4>
            </div>
            <div class="modal-body">
               <form action="login.htm" role="form" id="loginForm">
                  <div class="form-group">
                     <label class="sr-only" for="login-email">ID</label> <input
                        type="text" id="id" name="id" value="ghter5331"
                        class="form-control email" placeholder="ID">
                  </div>

                  <div class="form-group">
                     <label class="sr-only" for="login-password">Password</label> <input
                        type="password" id="pwd" name="pwd" value="qweqwe1"
                        class="form-control password" placeholder="Password">
                  </div>
                  <button type="button" class="btn btn-primary" data-dismiss="modal" id="logBtn">Login</button>
               </form>
            </div>
         
         </div>
         <!-- /.modal-content -->
      </div>
      <!-- /.modal-dialog -->
   </div>
   <!-- /.modal -->

</div>