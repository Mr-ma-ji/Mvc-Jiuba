﻿//------------------------------------------------------------------------------
// <auto-generated>
//     此代码已从模板生成。
//
//     手动更改此文件可能导致应用程序出现意外的行为。
//     如果重新生成代码，将覆盖对此文件的手动更改。
// </auto-generated>
//------------------------------------------------------------------------------

namespace JiuBa.Models
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class JiuBaEntities : DbContext
    {
        public JiuBaEntities()
            : base("name=JiuBaEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Admins> Admins { get; set; }
        public virtual DbSet<Model> Model { get; set; }
        public virtual DbSet<Post> Post { get; set; }
        public virtual DbSet<PostBrowse> PostBrowse { get; set; }
        public virtual DbSet<PostCollection> PostCollection { get; set; }
        public virtual DbSet<PostComments> PostComments { get; set; }
        public virtual DbSet<PostCommentsLikes> PostCommentsLikes { get; set; }
        public virtual DbSet<PostImg> PostImg { get; set; }
        public virtual DbSet<PostLikes> PostLikes { get; set; }
        public virtual DbSet<Users> Users { get; set; }
    }
}
