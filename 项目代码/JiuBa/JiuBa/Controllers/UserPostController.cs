using JiuBa.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace JiuBa.Controllers
{
    public class UserPostController : Controller
    {
        //数据库实例
        JiuBaEntities db = new JiuBaEntities();
        //定义分页条数
        public int pageindex = 3;
        //渲染全部的帖子视图
        public ActionResult GetPostALL()
        {
            //初始化index
            Session["GetPostALL"] = 0;
            int index = int.Parse(Session["GetPostALL"].ToString());
            //获取所有帖子
            List<Post> p = db.Post.ToList();
            //获取正常状态的模型
            List<Model> m = db.Model.Where(x=>x.ModelState==1).ToList();
            //获取正常状态的用户
            List<Users> u = db.Users.Where(x=>x.UsersEmail=="0").ToList();
            //做分页
            List<Post> pl = (from v1 in p join v2 in m on v1.ModelId equals v2.ModelId join v3 in u on v1.UserId equals v3.UserId select new Post {PostId=v1.PostId,PostText=v1.PostText, PostTime=v1.PostTime, UserId =v1.UserId , ModelId =v1.ModelId , PostCount =v1.PostCount }).OrderByDescending(x => x.PostTime).Skip(index* pageindex).Take(pageindex).ToList();
            return View(pl);
        }
        //懒加载渲染全部的帖子视图
        public ActionResult GetPostLanALL()
        {
            int index = int.Parse(Session["GetPostALL"].ToString())+1;
            Session["GetPostALL"] = index;
            //获取所有帖子
            List<Post> p = db.Post.ToList();
            //获取正常状态的模型
            List<Model> m = db.Model.Where(x => x.ModelState == 1).ToList();
            //获取正常状态的用户
            List<Users> u = db.Users.Where(x => x.UsersEmail == "0").ToList();
            //做分页
            List<Post> pl = (from v1 in p join v2 in m on v1.ModelId equals v2.ModelId join v3 in u on v1.UserId equals v3.UserId select new Post { PostId = v1.PostId, PostText = v1.PostText, PostTime = v1.PostTime, UserId = v1.UserId, ModelId = v1.ModelId, PostCount = v1.PostCount }).OrderByDescending(x => x.PostTime).Skip(index * pageindex).Take(pageindex).ToList();
            if (pl.Count()>0)
            {
                return View(pl);
            }
            else
            {
                return Content("false");
            }
           
        }
        //获取分类名
        public ActionResult GetModelById(int id)
        {
            //获取类型名
            Model m = db.Model.FirstOrDefault(x=>x.ModelId==id);
            return Content(m.ModelName);
        }
        //获取评论数量
        public ActionResult GetPostCommentsById(int id)
        {
            //获取类型名
            List<PostComments> p = db.PostComments.Where(x=>x.PostId==id).ToList();
            return Content(p.Count().ToString());
        }
        //渲染发帖人信息
        public ActionResult GetUsersById(int id)
        {
            Users u = db.Users.FirstOrDefault(x=>x.UserId==id);
            return View(u);
        }
        //渲染帖子图片
        public ActionResult GetPostImgById(int id)
        {
            List<PostImg> im = db.PostImg.Where(x=>x.PostId==id).ToList();
            return View(im);
        }
        //帖子详情页
        public ActionResult GetPostXaingQingById(int id)
        {
            //获取帖子内容
            Post post = db.Post.FirstOrDefault(x=>x.PostId==id);
            //浏览量+1
            post.PostCount = post.PostCount + 1;
            db.SaveChanges();
            //判断账号是否登录
            if (Session["user"]!=null)
            {
                //给账号加一个浏览记录
                PostBrowse pb = new PostBrowse();
                pb.UserId = (Session["user"] as Users).UserId;
                pb.PostBrowseTime = DateTime.Now.ToString();
                pb.PostId = id;
                PostBrowse p2 = db.PostBrowse.FirstOrDefault(x=>x.PostId==id);
                if (p2!=null)
                {
                    db.PostBrowse.Add(pb);
                    db.SaveChanges();
                }
            

            }
            return View(post);
        }
        //添加评论
        public ActionResult AddPostBrowse(PostComments pc)
        {
            if (Session["user"]!=null)
            {
                pc.UserId = (Session["user"] as Users).UserId;
                pc.PostCommentsTime = DateTime.Now.ToString();
                db.PostComments.Add(pc);
                if (db.SaveChanges()>0)
                {
                    return Content("true");
                }
                else
                {
                    return Content("评论失败请联系管理员！");
                }
            }
            else
            {
                return Content("请先登录");
            }
        }
        //首次加载评论
        public ActionResult GetPostCommentsAll(int id)
        {
            int index = 0;
            Session["GetPostCommentsAll"] = index;
            //获取改帖子所有评论
            List<PostComments> p = db.PostComments.Where(x=>x.PostId==id).ToList();
            //获取正常状态的用户
            List<Users> u = db.Users.Where(x => x.UsersEmail == "0").ToList();
            //做分页
            List<PostComments> pc = (from v1 in p join v3 in u on v1.UserId equals v3.UserId select new PostComments { PostCommentsId=v1.PostCommentsId, PostCommentsText=v1.PostCommentsText, PostCommentsTime=v1.PostCommentsTime, UserId=v1.UserId, PostId=v1.PostId }).OrderByDescending(x => x.PostCommentsTime).Skip(index * pageindex).Take(pageindex).ToList();
                return View(pc);
           
        }
        //懒加载评论
        public ActionResult LanGetPostCommentsAll(int id)
        {
            int index =int.Parse(Session["GetPostCommentsAll"].ToString())+1;
            Session["GetPostCommentsAll"] = index;
            //获取改帖子所有评论
            List<PostComments> p = db.PostComments.Where(x => x.PostId == id).ToList();
            //获取正常状态的用户
            List<Users> u = db.Users.Where(x => x.UsersEmail == "0").ToList();
            //做分页
            List<PostComments> pc = (from v1 in p join v3 in u on v1.UserId equals v3.UserId select new PostComments { PostCommentsId = v1.PostCommentsId, PostCommentsText = v1.PostCommentsText, PostCommentsTime = v1.PostCommentsTime, UserId = v1.UserId, PostId = v1.PostId }).OrderByDescending(x => x.PostCommentsTime).Skip(index * pageindex).Take(pageindex).ToList();
            if (pc.Count()>0)
            {
                return View(pc);

            }
            else
            {
                return Content("false");

            }

        }
        //渲染用户全部的帖子视图
        public ActionResult UserGetPostALL(int id)
        {
            //传递用户id
            ViewBag.id = id;
            //初始化index
            Session["UserGetPostALL"] = 0;
            int index = int.Parse(Session["UserGetPostALL"].ToString());
            //获取所有帖子
            List<Post> p = db.Post.ToList();
            //获取正常状态的模型
            List<Model> m = db.Model.Where(x => x.ModelState == 1).ToList();
            //获取正常状态的用户
            List<Users> u = db.Users.Where(x => x.UserId == id).ToList();
            //做分页
            List<Post> pl = (from v1 in p join v2 in m on v1.ModelId equals v2.ModelId join v3 in u on v1.UserId equals v3.UserId select new Post { PostId = v1.PostId, PostText = v1.PostText, PostTime = v1.PostTime, UserId = v1.UserId, ModelId = v1.ModelId, PostCount = v1.PostCount }).OrderByDescending(x => x.PostTime).Skip(index * pageindex).Take(pageindex).ToList();
            return View(pl);
        }
        //懒加载渲染用户全部的帖子视图
        public ActionResult UserGetPostLanALL(int id)
        {
            //传递用户id
            ViewBag.id = id;
            int index = int.Parse(Session["UserGetPostALL"].ToString()) + 1;
            Session["UserGetPostALL"] = index;
            //获取所有帖子
            List<Post> p = db.Post.ToList();
            //获取正常状态的模型
            List<Model> m = db.Model.Where(x => x.ModelState == 1).ToList();
            //获取正常状态的用户
            List<Users> u = db.Users.Where(x => x.UserId == id).ToList();
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
        //用户添加收藏
        public ActionResult user_shouchang(int id)
        {
            if (Session["user"] != null)
            {
                //实例化收藏
                PostCollection pc = new PostCollection();
                pc.PostId = id;
                pc.UserId = (Session["user"] as Users).UserId;
                PostCollection p1 = db.PostCollection.FirstOrDefault(x=>x.UserId==pc.UserId&&x.PostId==pc.PostId);
                if (p1==null)
                {
                    pc.PostCollectionTime = DateTime.Now.ToString();
                    db.PostCollection.Add(pc);
                    if (db.SaveChanges()>0)
                    {
                        return Content("添加成功");
                    }
                    else
                    {
                        return Content("添加失败");
                    }
                }
                else
                {
                    return Content("已经添加收藏");
                }
             
            }
            else
            {
                return Content("请先登录");
            }

        }
        //渲染用户收藏的帖子
        public ActionResult UserShouCangPostALL()
        {
            //初始化index
            Session["UserShouCangPostALL"] = 0;
            int id = (Session["user"] as Users).UserId;
            int index = int.Parse(Session["UserShouCangPostALL"].ToString());

            //获取正常状态的模型
            List<PostCollection> pc = db.PostCollection.Where(x => x.UserId == id).OrderByDescending(x => x.PostCollectionTime).Skip(index * pageindex).Take(pageindex).ToList();
            return View(pc);
        }
        //懒加载渲染用户收藏的帖子
        public ActionResult UserShouCangPostALLLan()
        {
            //初始化index
            int index=int.Parse(Session["UserShouCangPostALL"].ToString())+1;
            int id = (Session["user"] as Users).UserId;
            Session["UserShouCangPostALL"] = index;
            //获取正常状态的模型 
            List<PostCollection> pc = db.PostCollection.Where(x => x.UserId == id).OrderByDescending(x => x.PostCollectionTime).Skip(index * pageindex).Take(pageindex).ToList();
            if (pc.Count()>0)
            {
                return View(pc);
            }
            else
            {
                return Content("false");
            }
         
        }
        //渲染用户收藏的帖子模块
        public ActionResult UserShouCangPostShow(int id) {
            //获取帖子
            Post pc = db.Post.FirstOrDefault(x => x.PostId == id);
            return View(pc);
        }
        //用户取消收藏的帖子
        public ActionResult UserReomveShouCang(int id)
        {
            int uid = (Session["user"] as Users).UserId;
            PostCollection pc = db.PostCollection.FirstOrDefault(x=>x.PostId==id&&x.UserId==uid);
            if (pc!=null)
            {
                db.PostCollection.Remove(pc);
                if (db.SaveChanges()>0)
                {
                    return Content("true");
                }
                else
                {
                    return Content("移除失败");

                }
            }
            else
            {
                return Content("true");
            }
          
        }
        //用户取消收藏的帖子
        public ActionResult PostModel()
        {
            //获取所有的状态正常的模块
            List<Model> m = db.Model.Where(x=>x.ModelState==1).ToList();
            return View(m);

        }
        //根据模板id渲染全部的帖子视图
        public ActionResult GetPostALLByModelId(int id)
        {
            Session["modelid"] = id;
            //初始化index
            Session["GetPostALLByModelId"] = 0;
            int index = int.Parse(Session["GetPostALLByModelId"].ToString());
            //获取所有帖子
            List<Post> p = db.Post.ToList();
            //获取正常状态的模型
            List<Model> m = db.Model.Where(x => x.ModelId == id).ToList();
            //获取正常状态的用户
            List<Users> u = db.Users.Where(x => x.UsersEmail == "0").ToList();
            //做分页
            List<Post> pl = (from v1 in p join v2 in m on v1.ModelId equals v2.ModelId join v3 in u on v1.UserId equals v3.UserId select new Post { PostId = v1.PostId, PostText = v1.PostText, PostTime = v1.PostTime, UserId = v1.UserId, ModelId = v1.ModelId, PostCount = v1.PostCount }).OrderByDescending(x => x.PostTime).Skip(index * pageindex).Take(pageindex).ToList();
            return View(pl);
        }
        //懒加载根据模板id渲染全部的帖子视图
        public ActionResult GetPostALLByModelIdLan()
        {
            int id = int.Parse(Session["modelid"].ToString());
            int index = int.Parse(Session["GetPostALLByModelId"].ToString()) + 1;
            Session["GetPostALLByModelId"] = index;
            //获取所有帖子
            List<Post> p = db.Post.ToList();
            //获取指定的模型
            List<Model> m = db.Model.Where(x => x.ModelId == id).ToList();
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
        //根据用户id渲染全部的帖子视图
        public ActionResult GetPostALLByUserId()
        {
            int id = (Session["user"] as Users).UserId;
            //初始化index
            Session["GetPostALLByUserId"] = 0;
            int index = int.Parse(Session["GetPostALLByUserId"].ToString());
            //获取所有帖子
            List<Post> p = db.Post.ToList();
            //获取正常状态的模型
            List<Model> m = db.Model.Where(x => x.ModelState == 1).ToList();
            //获取正常状态的用户
            List<Users> u = db.Users.Where(x => x.UserId == id).ToList();
            //做分页
            List<Post> pl = (from v1 in p join v2 in m on v1.ModelId equals v2.ModelId join v3 in u on v1.UserId equals v3.UserId select new Post { PostId = v1.PostId, PostText = v1.PostText, PostTime = v1.PostTime, UserId = v1.UserId, ModelId = v1.ModelId, PostCount = v1.PostCount }).OrderByDescending(x => x.PostTime).Skip(index * pageindex).Take(pageindex).ToList();
            return View(pl);
        }
        //懒加载根据用户id渲染全部的帖子视图
        public ActionResult GetPostALLByUserIdLan()
        {
            int id =(Session["user"] as Users).UserId;
            int index = int.Parse(Session["GetPostALLByUserId"].ToString()) + 1;
            Session["GetPostALLByUserId"] = index;
            //获取所有帖子
            List<Post> p = db.Post.ToList();
            //获取正常状态的模型
            List<Model> m = db.Model.Where(x => x.ModelState == 1).ToList();
            //获取正常状态的用户
            List<Users> u = db.Users.Where(x => x.UserId == id).ToList();
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
        //根据帖子id删除帖子
        public ActionResult DelPostByPostId(int id)
        {
            //获取帖子
            Post p = db.Post.FirstOrDefault(x=>x.PostId==id);
            if (p!=null)
            {
                RemovePost.Delpost(id);
            }
            return Content("true");

        }
    }
}