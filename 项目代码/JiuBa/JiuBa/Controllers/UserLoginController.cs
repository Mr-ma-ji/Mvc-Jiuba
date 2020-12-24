using JiuBa.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;

namespace JiuBa.Controllers
{
    public class UserLoginController : Controller
    {
        //数据库实例
        JiuBaEntities db = new JiuBaEntities();
        //账号注册首页
        // GET: UserLogin
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        //添加用户页面
        public ActionResult Login(Users users,string Text1)
        {
            //判断账号是否存在
            if (Session["usermail"]!=null)
            {
                if (Session["yan"].ToString()== Text1)
                {
                    string us = Session["usermail"].ToString();
                    Users u = db.Users.FirstOrDefault(x => x.UserAccount == us);
                    if (u == null)
                    {
                        users.UsersTime = DateTime.Now.ToString();//注册时间
                        users.UsersEmail = "0";//账号状态
                        users.UserImg = "私人的-1.jpg";
                        users.UserName = "玖吧用户";
                        db.Users.Add(users);
                        if (db.SaveChanges()>0)
                        {
                            //发送邮件
                            GetEmail get = new GetEmail();
                            //清除Session
                            Session.Remove("yan");
                            Session.Remove("usermail");
                            string center = string.Format("玖吧用户注册成功，你的账户为：{0}，您的密码为{1}！", users.UserAccount,users.UserPwd);
                            get.SendEmail(users.UserAccount, center);
                            ViewBag.mes = "注册成功尝试登录吧";
                        }
                        else
                        {
                            ViewBag.mes = "注册失败";
                        }
                        
                    }
                    else
                    {
                        ViewBag.mes = "账号已经存在了";
                    }
                }
                else
                {
                    ViewBag.mes = "验证码有误";
                }
                
            }
            else
            {
                ViewBag.mes = "请先发送邮件";
            }
           
            return View();
        }
        //发送验证码
        public ActionResult sendMail(string email)
        {
            //判断账号是否存在
            Users users = db.Users.FirstOrDefault(x=>x.UserAccount==email);
            if (users==null)
            {
                //存入用户邮箱
                Session["usermail"] = email;
                //定义邮箱验证规则
                string reg = @"^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]+$";
                Regex regex = new Regex(reg);
                //判断格式
                if (regex.IsMatch(email))
                {
                    //发送邮件
                    GetEmail get = new GetEmail();
                    int yan = get.suijishu();
                    Session["yan"] = yan;
                    string center = string.Format("您的验证码为{0}，请及时填写！", yan);
                    get.SendEmail(email, center);
                    return Content("格式可用");
                }
                else
                {
                    return Content("邮箱格式有误");
                }
            }
            else
            {
                return Content("已经注册过账号了，请尝试密码找回吧！");
            } 
            
        }
        //密码修改首页
        public ActionResult UpdatePwd()
        {
            return View();
        }
        [HttpPost]
        //密码修改操作
        public ActionResult UpdatePwd(Users users,string Text1)
        {    //判断账号是否存在
            if (Session["usermail"] != null)
            {
                if (Session["yan"].ToString() == Text1)
                {
                    string us = Session["usermail"].ToString();
                    Users u = db.Users.FirstOrDefault(x => x.UserAccount == us);
                    if (u!= null)
                    {
                        u.UserPwd = users.UserPwd;
                        if (db.SaveChanges() > 0)
                        {
                            //发送邮件
                            GetEmail get = new GetEmail();
                            //清除Session
                            Session.Remove("yan");
                            Session.Remove("usermail");
                            string center = string.Format("密码修改成功，你的账户为：{0}，您的密码为{1}！", users.UserAccount, users.UserPwd);
                            get.SendEmail(users.UserAccount, center);
                            ViewBag.mes = "密码修改成功尝试登录吧";
                        }
                        else
                        {
                            ViewBag.mes = "添加失败";
                        }

                    }
                    else
                    {
                        ViewBag.mes = "账号还没注册，先去注册吧";
                    }
                }
                else
                {
                    ViewBag.mes = "验证码有误";
                }

            }
            else
            {
                ViewBag.mes = "请先发送邮件";
            }

            return View();
        }
        //修改密码发送验证码
        public ActionResult UpdatePwdsendMail(string email)
        {
            //判断账号是否存在
            Users users = db.Users.FirstOrDefault(x => x.UserAccount == email);
            if (users != null)
            {
                //存入用户邮箱
                Session["usermail"] = email;
                //定义邮箱验证规则
                string reg = @"^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]+$";
                Regex regex = new Regex(reg);
                //判断格式
                if (regex.IsMatch(email))
                {
                    //发送邮件
                    GetEmail get = new GetEmail();
                    int yan = get.suijishu();
                    Session["yan"] = yan;
                    string center = string.Format("您的验证码为{0}，请及时填写！", yan);
                    get.SendEmail(email, center);
                    return Content("格式可用");
                }
                else
                {
                    return Content("邮箱格式有误!");
                }
            }
            else
            {
                return Content("账号还没注册，先去注册吧");
            }

        }

    }
}