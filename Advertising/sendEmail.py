#!/usr/bin/env python3
#coding: utf-8

# sendEmail title content
import sys
import smtplib
from email.mime.text import MIMEText
from email.MIMEBase import MIMEBase
from email.mime.multipart import MIMEMultipart
from email.header import Header
from email import encoders

sender = 'dqksoftware@163.com'
smtpserver = 'smtp.office365.com'

username = sender
password = 'dqk333***'
#  title: 邮件标题
#  content: 邮件内容
#  filePath: 文件路径
#  filename: 文件名
#  receiver: 接受者
def send_mail(title, content,filePath, filename,receiver):

    try:
        # 邮件对象:
        msg = MIMEMultipart()
        if not isinstance(title,unicode):
            title = unicode(title, 'utf-8')
        msg['Subject'] = title
        msg['From'] = sender
        msg['To'] = receiver
        msg["Accept-Language"]="zh-CN"
        msg["Accept-Charset"]="ISO-8859-1,utf-8"
        # 邮件正文是MIMEText
        msg.attach(MIMEText(content,'plain','utf-8'))
        if len(filePath) > 0 :
            #构造附件
            attachment = open(filePath, "rb")
            att = MIMEBase('application', 'zip')
            att.set_payload((attachment).read())
            encoders.encode_base64(att)
            att.add_header('Content-Disposition', "attachment; filename= %s" % filename)
            # att["Content-Type"] = 'application/octet-stream'
            # # 这里的filename可以任意写，写什么名字，邮件中显示什么名字
            att["Content-Disposition"] = 'attachment; filename=%s' % filename
            msg.attach(att)


        smtp = smtplib.SMTP(smtpserver,587)
        smtp.starttls()
        smtp.login(username, password)
        smtp.sendmail(sender, receiver, msg.as_string())
        smtp.quit()
        return True
    except Exception, e:
        print str(e)
        return False

if send_mail(sys.argv[1], sys.argv[2], sys.argv[3],sys.argv[4], sys.argv[5]):
    print "done!"
else:
    print "failed!"
