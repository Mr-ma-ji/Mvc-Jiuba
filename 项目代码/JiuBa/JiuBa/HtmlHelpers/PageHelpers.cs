using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Text;

namespace JiuBa.HtmlHelpers
{
    public static class PageHelpers
    {
        //分页辅助器
        public static MvcHtmlString PageLinks(this HtmlHelper html,int pageInfo,Func<int,string> pageUrl) {
            StringBuilder sb = new StringBuilder();
            for (int i = 1; i <= pageInfo; i++)
            {
                TagBuilder tb = new TagBuilder("a");
                tb.MergeAttribute("href",pageUrl(i));
                tb.InnerHtml = i.ToString();
                if (i==pageInfo)
                {
                    tb.AddCssClass("selected");
                    tb.AddCssClass("btn-primary");
                }
                tb.AddCssClass("btn btn-default pageInfo");
                sb.Append(tb);
            }
            return MvcHtmlString.Create(sb.ToString());

        }
    }
}