using JiuBa.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Mvc;
namespace JiuBa.Controllers
{
    public class User_indexController : Controller
    {
        JiuBaEntities db = new JiuBaEntities();
        //用户首页
        // GET: User_index
        public ActionResult Index()
        {
            return View();
        }
        //用户登录
        public ActionResult UserLogin()
        {
            return View();
        }
        [HttpPost]
        //用户登录
        public ActionResult UserLogin(Users users)
        {
            Users u1 = db.Users.FirstOrDefault(x=>x.UserAccount==users.UserAccount);
            if (u1!=null)
            {
                Users u2 = db.Users.FirstOrDefault(x => x.UserAccount == users.UserAccount&&x.UserPwd==users.UserPwd);
                if (u2!=null)
                {
                    Session["user"] = u2;
                    Session["userimg"] = u2.UserImg;
                    Session["username"] = u2.UserName;
                    return Content("true");
                }
                else
                {
                    return Content("账号密码不匹配");
                }
            }
            else
            {
                return Content("账号不存在");
            }
          
        }
        //用户退出
        public ActionResult UserExit()
        {
            Session.Clear();
            return RedirectToAction("Index");
        }
        //用户个人中心
        public ActionResult Usergeren()
        {
            Users u = Session["user"] as Users;
            //Users u =db.Users.FirstOrDefault(x=>x.UserId==24);
            return View(u) ;
        }
        //用户个人中心更换头像
        public ActionResult updateImg(HttpPostedFileBase file)
        {
            string img = DateTime.Now.ToString("D") + file.FileName;
            file.SaveAs(Server.MapPath("~/img/"+img));
            Users u1 = Session["user"] as Users;
            Users u = db.Users.FirstOrDefault(x=>x.UserId==u1.UserId);
            //Users u = db.Users.FirstOrDefault(x => x.UserId == 24);
            u.UserImg = img;
            if (db.SaveChanges()>0)
            {
                Session["user"] = u;
                return Content(img);
            }
            else
            {
                return Content("上传失败");
            }
        }
        //用户个人中心修改自己信息
        public ActionResult updatexinxi()
        {
            Users u = Session["user"] as Users;
            //Users u =db.Users.FirstOrDefault(x=>x.UserId==24);
            return View(u);
        }
        [HttpPost]
        //用户个人中心修改自己信息
        public ActionResult updatexinxi(Users users)
        {
            //获取用户
            Users u= Session["user"] as Users;
            Users u2 = db.Users.FirstOrDefault(x=>x.UserId==u.UserId);
            u2.UserName = users.UserName;
            u2.UserSex = users.UserSex;
            if (db.SaveChanges()>0)
            {//更新session
                Session["user"] = u2;
                Session["userimg"] = u2.UserImg;
                Session["username"] = u2.UserName;
                return Content("true");
            }
            else
            {
                return Content("修改失败");
            }
        }
        //投稿视图页面
        public ActionResult getgaozi()
        {
            List<Model> md = db.Model.Where(x => x.ModelState == 1).ToList();
            List<SelectListItem> item = new List<SelectListItem>();
            SelectList se = new SelectList(md, "ModelId", "ModelName");
            item.AddRange(se);
            ViewBag.selectitem = item;
            return View();
        }
        [HttpPost]
        //上传稿子内容
        public ActionResult gaozitext(Post post)
        {
            post.PostTime = DateTime.Now.ToString();
            post.UserId = (Session["user"] as Users).UserId;
            post.PostCount = 0;
            db.Post.Add(post);
            if (db.SaveChanges()>0)
            {
                return Content(post.PostTime);
            }
            else
            {
                return Content("上传失败");
            }
        }
        ////上传稿子图片
        //public ActionResult gaoziimg(HttpPostedFileBase flie,string time)
        //{
        //    if (flie!=null)
        //    {
        //        string imgname = DateTime.Now.ToString("D") + flie.FileName;
        //        flie.SaveAs(Server.MapPath("~/img/" + imgname));
        //        //实例化图片表对象
        //        PostImg pm = new PostImg();
        //        //获取用户id
        //        Users u = Session["user"] as Users;
        //        pm.PostImgImages = imgname;
        //        pm.PostId = (db.Post.FirstOrDefault(x => x.UserId == u.UserId && x.PostTime == time) as Post).PostId;
        //        db.PostImg.Add(pm);
        //        if (db.SaveChanges() > 0)
        //        {
        //            return Content("");
        //        }
        //        else
        //        {
        //            return Content("上传图片失败");
        //        }
        //    }
        //    else
        //    {
        //        return Content("上传图片失败");
        //    }


        //}
        //上传稿子图片二
        public ActionResult gaoziimg(List<HttpPostedFileBase> flie, string time)
        {
            int index = 0;
            foreach (HttpPostedFileBase f in flie)
            {
                //图片上传服务器
                string imgname = DateTime.Now.ToString("D") + f.FileName;
                f.SaveAs(Server.MapPath("~/img/" + imgname));
                //实例化图片表对象
                PostImg pm = new PostImg();
                //获取用户id
                Users u = Session["user"] as Users;
                pm.PostImgImages = imgname;
                pm.PostId = (db.Post.FirstOrDefault(x => x.UserId == u.UserId && x.PostTime == time) as Post).PostId;
                //存入数据库
                db.PostImg.Add(pm);
                try
                {
                    if (db.SaveChanges() > 0)
                    {
                        index += 1;
                    }
                }
                catch (Exception)
                {

                    throw;
                }
            }
            if (index== flie.Count())
            {
                return Content("");
            }
            else
            {
                return Content("上传图片失败");
            }
          

        }

    }
}