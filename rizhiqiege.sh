vi logrotate.conf
#使用绝对路径
/**/*/access.log
{
	daily
	create
	rotate 30
}