using JiuBa.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace JiuBa.Controllers
{
    public class AdminController : Controller
    {
        //数据库操作对象
        JiuBaEntities db = new JiuBaEntities();
        //类型分页数量
        public int pageSize = 5;
        //用户分页数量
        public int usertableindex = 8;
        //登录页
        [HttpGet]
        // GET: Admin
        public ActionResult Login()
        {

            return View();
        }
        //登录验证
        [HttpPost]
        // GET: Admin
        public ActionResult Login(Admins ad)
        {
            if (ModelState.IsValid)
            {
                Admins a = db.Admins.FirstOrDefault(x => x.AdminAccount == ad.AdminAccount && x.AdminPwd == ad.AdminPwd);
                if (a != null)
                {
                    Session["Admin"] = a;
                    Session["AdminName"] = a.AdminName;
                    Session["AdminType"] = a.AdminType;
                    return RedirectToAction("Index");
                }
                else
                {
                    ViewBag.mess = "账号或者密码不匹配";
                }
            }
            return View();
        }
        //管理员首页
        public ActionResult Index()
        {
            if (Session["Admin"] == null)
            {
                return RedirectToAction("Login");
            }
            return View();
        }
        //退出
        public ActionResult TuiChu()
        {
            Session.Clear();
            return RedirectToAction("Login");
        }
        //Admin模块管理
        public ActionResult AdminModel(int pageinfo = 1)
        {
            Session["pageinfo"] = pageinfo;
            //判断管理员权限
            if (Session["AdminType"] == null || int.Parse(Session["AdminType"].ToString()) == 1)
            {
                return RedirectToAction("Login");
            }
            //获取分类模型
            AdminModelsList modelsList = new AdminModelsList();
            //获取全部的分类
            modelsList.models = db.Model.OrderByDescending(x => x.ModelTime).Skip((pageinfo - 1) * pageSize).Take(pageSize).ToList();
            //计算页数
            modelsList.index = (int)Math.Ceiling((double)db.Model.ToList().Count() / pageSize);
            return View(modelsList);
        }
        //管理员删除一条数据
        public ActionResult DeleteById(int id)
        {
            //获取帖子集合
            List<Post> p = db.Post.Where(x=>x.ModelId==id).ToList();
            if (p.Count>0)
            {
                foreach (var x in p)
                {
                    RemovePost.Delpost(x.PostId);
                }
            }
            Model m = db.Model.FirstOrDefault(x => x.ModelId == id);
            if (m!=null)
            {
                db.Model.Remove(m);
                if (db.SaveChanges() > 0)
                {
                    return Content("删除成功");
                }
            }
            return Content("");
        }
        //管理员添加模块
        public ActionResult InsertModel(Model m, HttpPostedFileBase Img)
        {
            string img = DateTime.Now.ToString("D") + Img.FileName;
            Img.SaveAs(Server.MapPath("~/img/" + img));
            m.ModelTime = DateTime.Now.ToString();
            m.ModelImg = img;
            db.Model.Add(m);
            db.SaveChanges();
            return RedirectToAction("AdminModel", new { pageinfo = int.Parse(Session["pageinfo"].ToString()) });
        }
        //管理员修改模块状态
        public ActionResult UpdateModelStateById(Model model)
        {
            Model m = db.Model.FirstOrDefault(x => x.ModelId == model.ModelId);

            if (m != null)
            {
                m.ModelState = model.ModelState;
                if (db.SaveChanges() > 0)
                {
                    return Content("修改成功");
                }
            }
            return Content("");

        }
        //管理员账号分配页面
        public ActionResult AddAdmin()
        {
            //判断管理员权限
            if (Session["AdminType"] == null || int.Parse(Session["AdminType"].ToString()) == 1)
            {
                return RedirectToAction("Login");
            }

            return View();
        }
        [HttpPost]
        //管理员账号添加操作
        public ActionResult AddAdmin(Admins ad)
        {
            if (ModelState.IsValid)
            {
                Admins a = db.Admins.FirstOrDefault(x=>x.AdminAccount==ad.AdminAccount);
                if (a==null)
                {
                    ad.AdminName = "普通管理员";
                    ad.AdminType = 1;
                    db.Admins.Add(ad);
                    db.SaveChanges();
                }
                else
                {
                    ViewBag.AddAdmin = "账号已存在";
                }
           
            }
            return View();
        }
        //分部视图渲染管理员账号表格
        public ActionResult GetAdminTable()
        {
            //判断管理员权限
            if (Session["AdminType"] == null || int.Parse(Session["AdminType"].ToString()) == 1)
            {
                return RedirectToAction("Login");
            }
            List<Admins> ad = db.Admins.Where(x => x.AdminType == 1).ToList();
            return View(ad);
        }
        //管理员账号删除
        public ActionResult delAdminById(int id)
        {
            Admins admins = db.Admins.FirstOrDefault(x=>x.AdminId==id);
            if (admins!=null)
            {
                db.Admins.Remove(admins);
                if (db.SaveChanges()>0)
                {
                    return Content("删除成功");
                }
                else
                {
                    return Content("删除失败");
                }
            }
            else
            {
                return Content("账号不存在");
            }
           
        }
        //用户管理
        public ActionResult AdminUser(int userpageinfo=1)
        {
            //存入当前的页码
            Session["userpageinfo"] = userpageinfo;
            //判断管理员权限
            if (Session["AdminType"] == null || int.Parse(Session["AdminType"].ToString()) == 1)
            {
                return RedirectToAction("Login");
            }
            //获取模型
            UsersListView ul = new UsersListView();
            ul.users = db.Users.OrderByDescending(x=>x.UserId).Skip(usertableindex*(userpageinfo-1)).Take(usertableindex).ToList();
            ul.usersinfo = (int)Math.Ceiling((double)db.Users.ToList().Count()/ usertableindex);
            return View(ul);
        }
        //修改用户状态
        public ActionResult AdminUpdateUser(Users users)
        {
            Users u = db.Users.FirstOrDefault(x=>x.UserId==users.UserId);
            if (u!=null)
            {
                u.UsersEmail = users.UsersEmail;
                if (db.SaveChanges()>0)
                {
                    return Content("修改成功");
                }
                else
                {
                    return Content("修改失败");
                }
            }
            else
            {
                return Content("账号不存在");
            }
               
         
        }
        //定义分页条数
        public int pageindex = 3;
        //管理员渲染全部的帖子视图
        public ActionResult AdminGetPostALL()
        {
            //初始化index
            Session["AdminGetPostALL"] = 0;
            int index = int.Parse(Session["AdminGetPostALL"].ToString());
            //获取所有帖子
            List<Post> p = db.Post.ToList();
            //获取正常状态的模型
            List<Model> m = db.Model.Where(x => x.ModelState == 1).ToList();
            //获取正常状态的用户
            List<Users> u = db.Users.Where(x => x.UsersEmail == "0").ToList();
            //做分页
            List<Post> pl = (from v1 in p join v2 in m on v1.ModelId equals v2.ModelId join v3 in u on v1.UserId equals v3.UserId select new Post { PostId = v1.PostId, PostText = v1.PostText, PostTime = v1.PostTime, UserId = v1.UserId, ModelId = v1.ModelId, PostCount = v1.PostCount }).OrderByDescending(x => x.PostTime).Skip(index * pageindex).Take(pageindex).ToList();
            return View(pl);
        }
        //懒加载渲染全部的帖子视图
        public ActionResult AdminGetPostALLLan()
        {
            int index = int.Parse(Session["AdminGetPostALL"].ToString()) + 1;
            Session["AdminGetPostALL"] = index;
            //获取所有帖子
            List<Post> p = db.Post.ToList();
            //获取正常状态的模型
            List<Model> m = db.Model.Where(x => x.ModelState == 1).ToList();
            //获取正常状态的用户
            List<Users> u = db.Users.Where(x => x.UsersEmail == "0").ToList();
            //做分页
            List<Post> pl = (from v1 in p join v2 in m on v1.ModelId equals v2.ModelId join v3 in u on v1.UserId equals v3.UserId select new Post { PostId = v1.PostId, PostText = v1.PostText, PostTime = v1.PostTime, UserId = v1.UserId, ModelId = v1.ModelId, PostCount = v1.PostCount }).OrderByDescending(x => x.PostTime).Skip(index * pageindex).Take(pageindex).ToList();
            if (pl.Count() > 0)
            {
                return View(pl);
            }
            else
            {
                return Content("false");
            }

        }
        //管理员查看帖子详情
        public ActionResult AdminGetPostxiangqing(int id)
        {
            //获取帖子
            Post p = db.Post.FirstOrDefault(x=>x.PostId==id);
            return View(p);
        } 
    }
}