using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Xml.Linq;

namespace JiuBa.Models
{
    public class RemovePost
    {

        //根据id删除帖子
        public static void Delpost(int id) {
            //数据库实例
            JiuBaEntities db = new JiuBaEntities();
            //删除用户对该帖子的浏览记录
            string sql1 = string.Format("delete PostBrowse where PostId={0}",id);
            db.Database.ExecuteSqlCommand(sql1);
            //删除收藏
            string sql2 = string.Format("delete PostCollection where PostId={0}", id);
            db.Database.ExecuteSqlCommand(sql2);
            //删除图片
            string sql3 = string.Format("delete PostImg where PostId={0}", id);
            db.Database.ExecuteSqlCommand(sql3);
            //删除评论
            string sql4 = string.Format("delete PostComments where PostId={0}", id);
            db.Database.ExecuteSqlCommand(sql4);
            //删除帖子
            string sql5 = string.Format("delete Post where PostId={0}", id);
            db.Database.ExecuteSqlCommand(sql5);
            db.SaveChanges();

        }
    }
}