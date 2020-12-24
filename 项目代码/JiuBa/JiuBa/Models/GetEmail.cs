using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;

namespace JiuBa.Models
{
    public class GetEmail
    {
        //生成随机密码
        public int suijishu()
        {
            int a = new Random().Next(00000, 99999);
            return a;
        }
        //向邮箱发送验证码
        public void SendEmail(string maill, string center)
        {
            //设置要发送emial的账号
            string emailAccunt = "2236418809@qq.com";
            string password = "ygkvjmcivbtrdijf";//POP3/SMTP服务密码
            string smtpServer = "smtp.qq.com";//SMTP服务主机地址
            string subject = "玖吧网管理员";//邮箱头部信息
            SmtpClient client = new SmtpClient(smtpServer);
            client.Credentials = new System.Net.NetworkCredential(emailAccunt, password);//创建凭据包含用户名和密码
            //指定发送邮件的途径，通过网络发送到SMTP服务器
            client.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
            client.EnableSsl = true;//指定使用ssi安全链接发送
            //建立邮件对象：发送邮件账号，邮件发送地址，邮件主题，邮件正文
            MailMessage message = new MailMessage(emailAccunt, maill, subject, center);
            message.BodyEncoding = System.Text.Encoding.UTF8;//定义邮件正文的编码方式
            message.IsBodyHtml = true;//指示是否为html元素
            message.Priority = System.Net.Mail.MailPriority.High;//指定邮件优先级
            try
            {
                client.Send(message);//使用异步发送方法
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}